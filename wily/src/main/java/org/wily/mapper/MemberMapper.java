package org.wily.mapper;

import org.apache.ibatis.annotations.Param;
import org.wily.domain.MemberDTO;

public interface MemberMapper {
	
	public void signUp(MemberDTO memberDTO);

	public void createAuthKey(@Param("receiver") String receiver, @Param("authKey") String authKey);
	
}
