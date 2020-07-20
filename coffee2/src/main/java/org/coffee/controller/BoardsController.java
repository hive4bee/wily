package org.coffee.controller;

import org.coffee.domain.BoardsDTO;
import org.coffee.domain.PageDTO;
import org.coffee.domain.StartDTO;
import org.coffee.service.BoardsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/boards/*")
@AllArgsConstructor
public class BoardsController {
	@Setter(onMethod_ = @Autowired)
	private BoardsService service;

	
	@GetMapping("/list")
	public void list(StartDTO st, Model model) {
		log.info("======"+st.getPage());
		st.setStartRecord((st.getPage()-1)*10+1);
		log.info("=============="+st.getStartRecord());
		model.addAttribute("list", service.getList(st));
		
		int total = service.getTotalCount();
		model.addAttribute("pageMaker", new PageDTO(st, total));
	}
	
	@GetMapping("/write")
	public void write() {
		
	}
	
	@PostMapping("/writePro")
	public String writePro(BoardsDTO dto) {
		log.info("======================================");
		log.info(dto);
		log.info("======================================");
		service.write(dto);
		return "redirect:/boards/list";
	}
	
	@GetMapping("/get")
	public void read(String fno, Model model) {
		model.addAttribute("dto", service.read(fno));
	}
	
	@GetMapping("/modifyForm")
	public void modifyForm(BoardsDTO dto, Model model) {
		log.info("======================================");
		log.info(dto);
		log.info("======================================");
		model.addAttribute("dto", service.read(dto.getFno()+""));
		
	}
	@GetMapping("/modifyPro")
	public String modifyPro(BoardsDTO dto, Model model) {
		log.info("======================================");
		log.info(dto);
		log.info("======================================");
		service.update(dto);
		return "redirect:/boards/list";
	}
	
	@GetMapping("/delete")
	public String delete(int fno) {
		log.info("========================================");
		log.info("fno : " + fno);
		log.info("========================================");
		service.delete(fno);
		return "redirect:/boards/list";
	}
	

}
