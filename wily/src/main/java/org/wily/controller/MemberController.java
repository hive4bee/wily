package org.wily.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.wily.domain.MemberDTO;
import org.wily.mail.TempKey;
import org.wily.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	/*
	 * register() : 회원가입 폼 
	 */
	@GetMapping("/register")
	public void register() {
		
	}
	
	/*
	 * signUp() : 회원가입 절차
	 */
	@PostMapping("/signUp")
	public String signUp(MemberDTO memberDTO, Model model) {
		
		log.info("memberDTO: " + memberDTO);
		
		String authKey = new TempKey(20, false).getKey();
		memberService.signUp(memberDTO, authKey);
		
		model.addAttribute("authKey", authKey);
		
		return "/member/mail";
	}
	
//	@PostMapping("/confirmRegisterKey")
//	public void confirmRegisterKey(String authKey, Model model) {
//		model.addAttribute("authKey", authKey);
//	}
//	
}
