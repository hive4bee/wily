package org.wily.mapper;

import org.apache.ibatis.annotations.Param;
import org.wily.domain.IdPwdVO;
import org.wily.domain.MemberDTO;

public interface MemberMapper {
	
	public void signUp(MemberDTO memberDTO);

	public void createAuthKey(@Param("receiver") String receiver, @Param("authKey") String authKey);

	public int modifyStatus(String email);

	public int checkUser(IdPwdVO vo);

	public void createAuthentication(String mid);

	public MemberDTO read(String userid);
	
}
