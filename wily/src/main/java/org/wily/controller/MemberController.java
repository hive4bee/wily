package org.wily.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.wily.domain.EmailVO;
import org.wily.domain.IdPwdVO;
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
	 * method	: get
	 * action	: 회원가입폼을 불러온다.
	 * URI		: /wily/member/register
	 */
	@GetMapping("/register")
	public void register() {
		
	}
	
	/*
	 * method	: post
	 * action	: 회원가입처리한다.
	 * URI		: /wily/member/signUp
	 */
	@PostMapping("/signUp")
	public String signUp(MemberDTO memberDTO, Model model) {
		
		log.info("memberDTO: " + memberDTO);
		
		String authKey = new TempKey(20, false).getKey();
		memberService.signUp(memberDTO, authKey);
		model.addAttribute("email", memberDTO.getMemail());
		model.addAttribute("authKey", authKey);
		
		return "/member/mail";
	}
	
	/*
	 * method	: post
	 * action	: 회원상태를 변경한다.
	 * URI		: /wily/member/confirmAuthKey
	 */
	@ResponseBody
	@PostMapping("/confirmAuthKey")
	public ResponseEntity<String> confirmAuthKey(@RequestBody EmailVO vo){
		log.info("email: "+vo.getEmail());
		return memberService.modifyStatus(vo.getEmail())==1?
			new ResponseEntity<>("success",HttpStatus.OK):
				new ResponseEntity<>("fail",HttpStatus.OK);
	}
	
	/*
	 * method	: get
	 * action	: 로그인폼을 가져온다.
	 * URI		: /wily/member/loginForm
	 */
	@GetMapping("/loginForm")
	public void loginForm(HttpServletRequest request) {
		log.info("getRequestURI(): "+request.getRequestURI());
	}
	
	/*
	 * method	: post
	 * action	: 로그인처리(security처리로 더 이상 사용하지 않는다)
	 * URI		: /wily/member/loginPro
	 */
	@ResponseBody
	@PostMapping("/loginPro")
	public ResponseEntity<String> loginPro(@RequestBody IdPwdVO vo){
		log.info("mid: "+vo.getMid()+" / mpw: "+vo.getMpw());
		return memberService.checkUser(vo) == 1?
				new ResponseEntity<>("success",HttpStatus.OK):
					new ResponseEntity<>("fail",HttpStatus.OK);
	}
	
	/*
	 * method	: get
	 * action	: 권한이 부족한 사용자를 막는다.
	 * URI		:/wily/member/accessError
	 */
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied...."+auth);
		model.addAttribute("msg","Access Denied....");
	}
	
	/*
	 * action : 더 이상 사용하지 않는다.
	 */
	@GetMapping("/logoutForm")
	public void logout() {
		
	}
}
