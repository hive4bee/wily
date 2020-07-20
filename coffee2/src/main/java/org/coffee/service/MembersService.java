package org.coffee.service;

import org.coffee.domain.IdPwdVO;
import org.coffee.domain.Imsi2VO;
import org.coffee.domain.MembersDTO;

public interface MembersService {
	public void register(MembersDTO dto);
	
	public int confirmId(String mid);
	
	public int confirmLogin(String mid, String mpw);

	public MembersDTO getUserInfo(String mid);
	
	public int confirmUser(String mname, String mpn);
	
	public String findId(String mname, String mpn);
	
	public int confirmUser2(Imsi2VO vo);
	
	public int changePwd(IdPwdVO vo);
}
