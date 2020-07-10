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
	
	@GetMapping("/viewDetail")
	public void viewDetail(String bno, StartDTO startDTO, Model model) {
		log.info("bno: "+bno);
		log.info("startDTO: "+startDTO);
		BoardDTO boardDTO = boardService.viewDetail(bno);
		model.addAttribute("startDTO", startDTO);
		model.addAttribute("boardDTO", boardDTO);
	}
	
	@PostMapping("/deletePro")
	public String deletePro(String bno, StartDTO startDTO, Model model) {
		log.info("=========================");
		log.info("bno: "+bno);
		log.info("startDTO: "+startDTO);
		log.info("=========================");
		boardService.delete(bno);
		model.addAttribute("list", boardService.list(startDTO));
		model.addAttribute("pageMaker", new PageDTO(startDTO, boardService.totalRecord(startDTO)));
		return "redirect:/board/list";
	}
	
	@GetMapping("/modifyForm")
	public void modifyForm(String bno, StartDTO startDTO, Model model) {
		log.info("=========================");
		log.info("bno: "+bno);
		log.info("startDTO: "+startDTO);
		log.info("=========================");
		BoardDTO boardDTO=boardService.getModifyForm(bno);
		model.addAttribute("startDTO", startDTO);
		model.addAttribute("boardDTO", boardDTO);
	}
	
	@PostMapping("/modifyPro")
	public String modifyPro(BoardDTO boardDTO, StartDTO startDTO, Model model) {
		log.info("=========================");
		log.info("boardDTO: "+boardDTO);
		log.info("startDTO: "+startDTO);
		log.info("=========================");
		boardService.modifyPro(boardDTO);
		model.addAttribute("startDTO", startDTO);
		return "redirect:/board/list";
	}
}
