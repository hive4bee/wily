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
	
	/*
	 * method	: get
	 * action	: 리스트를 불러온다.
	 * URI		: /wily/board/list
	 */
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
	
	/*
	 * method	: get
	 * action	: 입력폼을 불러온다.
	 * URI		: /wily/board/writeForm
	 */
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/writeForm")
	public void writeForm() {
		
	}
	
	/*
	 * method	: post
	 * action	: DB입력
	 * URI		: /wily/board/writePro
	 */
	@PostMapping("/writePro")
	public String writePro(BoardDTO boardDTO) {
		boardService.write(boardDTO);
		return "redirect:/board/list";
	}
	
	/*
	 * method	: get
	 * action	: 글 열람
	 * URI		: /wily/board/viewDetail
	 */
	@GetMapping("/viewDetail")
	public void viewDetail(String bno, StartDTO startDTO, Model model) {
		log.info("bno: "+bno);
		log.info("startDTO: "+startDTO);
		BoardDTO boardDTO = boardService.viewDetail(bno);
		model.addAttribute("startDTO", startDTO);
		model.addAttribute("boardDTO", boardDTO);
	}
	
	/*
	 * method	: post
	 * action	: 글 삭제
	 * URI		: /wily/board/deletePro
	 */
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
	
	/*
	 * method	: get
	 * action	: 수정폼을 불러온다.
	 * URI		: /wily/board/modifyForm
	 */
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
	
	/*
	 * method	: post
	 * action	: 글을 수정한다.
	 * URI		: /wily/board/modifyPro
	 */
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
