package org.wily.service;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wily.domain.MemberDTO;
import org.wily.mail.MailUtils;
import org.wily.mail.TempKey;
import org.wily.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	@Transactional
	public void signUp(MemberDTO memberDTO, String authKey) {
		memberMapper.signUp(memberDTO);
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
	
}
