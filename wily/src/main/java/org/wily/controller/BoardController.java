package org.wily.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.wily.domain.BoardDTO;
import org.wily.domain.PageDTO;
import org.wily.domain.StartDTO;
import org.wily.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {
	@Setter(onMethod_=@Autowired)
	private BoardService boardService;
	
	@GetMapping("/list")
	public void list(StartDTO startDTO, Model model){
		log.info("=========================================");
		log.info("startDTO: "+startDTO);
		List<BoardDTO> list = boardService.list(startDTO);
		log.info("list: " + list);
		list.forEach(record->log.info(record));
		int total=boardService.totalRecord(startDTO);
		log.info("total: " + total);
		log.info("=========================================");
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(startDTO, total));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/writeForm")
	public void writeForm() {
		
	}
	
	@PostMapping("/writePro")
	public String writePro(BoardDTO boardDTO) {
		boardService.write(boardDTO);
		return "redirect:/board/list";
	}
}
