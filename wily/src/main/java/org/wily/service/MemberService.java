package org.wily.service;

import org.wily.domain.MemberDTO;

public interface MemberService {

	public void signUp(MemberDTO memberDTO, String authKey);
	
	
}
