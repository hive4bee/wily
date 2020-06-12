package org.coffee.controller;

import java.util.List;

import org.coffee.domain.PageDTO;
import org.coffee.domain.StartDTO;
import org.coffee.domain.UserMessageDTO;
import org.coffee.service.UserMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/message/*")
@AllArgsConstructor
public class UserMessageController {
	@Setter(onMethod_ = @Autowired)
	private UserMessageService service;
	
	@GetMapping("/checkMessageQ")
	@ResponseBody
	public ResponseEntity<String> checkMessageQ(String mid) {
		log.info("======================================");
		log.info("mid : " + mid);
		log.info("======================================");
		int check = service.checkMessageQ(mid);
		
		return new ResponseEntity<>(check+"", HttpStatus.OK);
	}
	
	@GetMapping("/mid/{mid}")
	public ResponseEntity<List<UserMessageDTO>> getMessageL(@PathVariable("mid") String mid){
		log.info("======================================");
		log.info("mid : " + mid);
		log.info("======================================");
		List<UserMessageDTO> list = service.getMessageL(mid);
		list.forEach(a -> log.info(a));
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/showAllMessage")
	public void showAllMessage(@RequestParam("mid") String mid, StartDTO startDTO, Model model){
		log.info("======================================");
		log.info("mid : " + mid);
		log.info("======================================");
		startDTO.setStartRecord((startDTO.getPage()-1)*10+1);
		List<UserMessageDTO> list = service.getUserMessageList(startDTO, mid);
		model.addAttribute("list", list);
		int total = service.getTotalCount(mid);
		model.addAttribute("pageMaker", new PageDTO(startDTO, total));
	}
	
	@GetMapping("/get")
	public void get(String u_no, Model model) {
		log.info("=====================================");
		log.info("u_no : " + u_no);
		log.info("=====================================");
		model.addAttribute("dto", service.read(u_no));		
	}
	
	@GetMapping("/checkReadStatus")
	@ResponseBody
	public ResponseEntity<String> checkReadStatus(String mid, String u_no){
		log.info("===========================================");
		log.info("mid : " + mid + " u_no : " + u_no);
		log.info("===========================================");
		String check = service.checkReadStatus(mid, u_no);
		log.info("=========================================");
		log.info("check : " + check);
		log.info("=========================================");
		String result="no";
		if(check.equals("n")) {
			service.changeStatus(mid, u_no);
			result="changed";
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@GetMapping("/delete")
	public String delete(String u_no, String mid) {
		log.info("=================================");
		log.info("u_no : " + u_no +" mid : " + mid);
		log.info("=================================");
		service.delete(u_no);
		
		return "redirect:/message/showAllMessage?mid="+mid;
	}
}
