package org.coffee.controller;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.coffee.domain.IdPwdVO;
import org.coffee.domain.Imsi2VO;
import org.coffee.domain.MembersDTO;
import org.coffee.service.MembersServiceImpl;
import org.coffee.service.ProductsService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/members/*")
@AllArgsConstructor
public class MembersController {
	
	private MembersServiceImpl service;
	
	private ProductsService productsService;
	
	@GetMapping("/index")
	public void index() {
		
	}
	
	@GetMapping(value="/register")
	public void register() {
		
	}
	
	@PostMapping(value="/register")
	public String register(MembersDTO dto, Model model) {
		log.info("==================================");
		log.info("register: " + dto);
		log.info("==================================");
		
		//service.register(dto);
		//return "redirect:/";
		String host = "smtp.naver.com";
		final String user="eprot@naver.com";
		final String password="Ythfeb94!#";
		
		String to_email = dto.getMemail();
		
		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.starttls.enable", "true");
		
		//인증 번호 생성기
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = user;
			String pwd = password;
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pwd);
			}
		});
		
		//email전송
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "IMSI"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

			//硫붿씪 �젣紐�
			msg.setSubject("안녕하세요  인증 메일입니다.");
			//硫붿씪 �궡�슜
			msg.setText("인증 번호 : " + temp);

			Transport.send(msg);
			System.out.println("�이메일 전송");

		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("AuthenticationKey", AuthenticationKey);
		return "members/mail";
	}
	
	@PostMapping("/confirmId")
	@ResponseBody
	public ResponseEntity<String> confirmId(String mid) {
		int check = service.confirmId(mid);
		String chk = "";
		log.info("=================");
		log.info("mid : " + mid + " / check : " + check);
		log.info("=================");
		if(check==0) {
			chk="y";
		}else {
			chk="n";
		}
		return new ResponseEntity<>(chk, HttpStatus.OK);
	}
	
	@PostMapping("/inputKey")
	public String mail(MembersDTO dto) {
		log.info("==================================");
		log.info("register: " + dto);
		log.info("==================================");
		service.register(dto);
		return "redirect:/";
	}
	
	@GetMapping("loginForm")
	public void loginForm(HttpServletRequest request) {
//		String referrer = request.getHeader("Referer");
//		request.getSession().setAttribute("prevPage", referrer);
//		log.info("hahaha : " + request.getRequestURI());
//		log.info("hahaha2 : " + request.getRequestURL());
		
	}

	
	@PostMapping("/confirmLogin")
	@ResponseBody
	public ResponseEntity<String> confirmLogin(String mid, String mpw){
		int check = service.confirmLogin(mid, mpw);
		String chk = "";
		log.info("====================================");
		log.info("mid : " + mid + " / mpw : " + mpw +" / check : " + check);
		log.info("====================================");
		if(check == 1) {
			chk = "y"; 
		}else {
			chk="n";
		}
		return new ResponseEntity<>(chk, HttpStatus.OK);
		
	}
	
	@PostMapping("/loginPro")
	public String loginPro(String mid, HttpServletRequest request) {
		HttpSession session = request.getSession();
		log.info("==================================");
		String redirectUrl = (String) session.getAttribute("prevPage");
		log.info(redirectUrl);
		log.info("==================================");
		String url="";
		if(redirectUrl !=null) {
			session.removeAttribute("prevPage");
			url=redirectUrl;
		}else {
			url="/";
		}
		session.setAttribute("mid", mid);
		
		return "redirect:"+url;
	}
	@GetMapping("/logOut")
	public String logOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/viewMyRecord")
	public void viewMyRecord(String mid, Model model) {
		log.info("===================================");
		log.info("mid : " + mid);
		log.info("===================================");
		model.addAttribute("list", productsService.getOrderDetailList2(mid));
	}
	@GetMapping("/findId")
	public void findId() {
		
	}
	
	@PostMapping("/confirmUser")
	@ResponseBody
	public ResponseEntity<String> confirmUser(String mname, String mpn){
		log.info("==================================");
		log.info("mname : " + mname + " mpn : " + mpn);
		log.info("==================================");
		int check = service.confirmUser(mname, mpn);
		return check==1 ?
				new ResponseEntity("exist", HttpStatus.OK) :
					new ResponseEntity("no", HttpStatus.OK);
	}
	
	@PostMapping("/findIdPro")
	public void findIdPro(String mname, String mpn, Model model) {
		log.info("==================================");
		log.info("mname : " + mname + " mpn : " + mpn);
		log.info("==================================");
		String id = service.findId(mname, mpn);
		int len=id.length();
		String imsi=id.substring(0, len-3);
		String mid=imsi+"***";
		
		model.addAttribute("mid", mid);
	}
	
	@GetMapping("/findPwd")
	public void findPwd() {
		
	}
	
	//@PostMapping(value="/confirmUser2", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@PostMapping(value="/confirmUser2", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> confirmUser2(@RequestBody Imsi2VO vo){
		String mname = vo.getMname();
		String mid = vo.getMid();
		String memail = vo.getMemail();
		
		int check = service.confirmUser2(vo);
		return check==1?
				new ResponseEntity<>("exist", HttpStatus.OK) :
					new ResponseEntity<>("no", HttpStatus.OK);
	}
	
	@PostMapping("/findPwdPro")
	public void findPwdPro(String mname, String mid, String memail, Model model) {
		String host = "smtp.naver.com";
		final String user="eprot@naver.com";
		final String password="Ythfeb94!#";
		
		String to_email = memail;
		
		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.starttls.enable", "true");
		
		//인증 번호 생성기
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = user;
			String pwd = password;
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pwd);
			}
		});
		
		//email 전송
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "IMSI"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

			//메일 제목
			msg.setSubject("안녕하세요  인증 메일입니다.");
			//메일 내용
			msg.setText("인증 번호는 : " + temp);

			Transport.send(msg);
			System.out.println("이메일 전송");

		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		model.addAttribute("AuthenticationKey", AuthenticationKey);
		model.addAttribute("mid", mid);
	}
	
	@PostMapping("/changePwd")
	@ResponseBody
	public ResponseEntity<String> changePwd(@RequestBody IdPwdVO vo){
		int check = service.changePwd(vo);
		return check==1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>("fail", HttpStatus.OK);
	}
}
