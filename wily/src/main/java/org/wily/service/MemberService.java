package org.wily.service;

import org.wily.domain.IdPwdVO;
import org.wily.domain.MemberDTO;

public interface MemberService {

	public void signUp(MemberDTO memberDTO, String authKey);

	public int modifyStatus(String email);

	public int checkUser(IdPwdVO vo);
	
}
