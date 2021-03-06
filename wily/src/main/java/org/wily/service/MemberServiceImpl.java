package org.wily.service;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wily.domain.IdPwdVO;
import org.wily.domain.MemberDTO;
import org.wily.mail.MailUtils;
import org.wily.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;
	
	@Override
	@Transactional
	public void signUp(MemberDTO memberDTO, String authKey) {
		
		memberDTO.setMpw(pwencoder.encode(memberDTO.getMpw()));
		memberMapper.signUp(memberDTO);
		memberMapper.createAuthentication(memberDTO.getMid());
		
		String receiver=memberDTO.getMemail();
		
		memberMapper.createAuthKey(receiver, authKey);
		MailUtils sendMail;
		try {
			sendMail = new MailUtils(mailSender);
			sendMail.setSubject("안녕하세요 인증 메일입니다.");
			sendMail.setText("인증번호는 "+authKey+" 입니다.");
			sendMail.setTo(receiver);
			sendMail.send();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int modifyStatus(String email) {
		return memberMapper.modifyStatus(email);
	}
	
	@Override
	public int checkUser(IdPwdVO vo) {
		return memberMapper.checkUser(vo);
	}
}
