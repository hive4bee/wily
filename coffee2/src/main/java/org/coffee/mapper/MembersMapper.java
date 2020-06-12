package org.coffee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.coffee.domain.IdPwdVO;
import org.coffee.domain.Imsi2VO;
import org.coffee.domain.MembersDTO;

public interface MembersMapper {
	public void register(MembersDTO dto);
	
	public int confirmId(String mid);

	public int confirmLogin(@Param("mid") String mid, @Param("mpw") String mpw);

	public MembersDTO getUserInfo(String mid);

	public int confirmUser(@Param("mname") String mname, @Param("mpn") String mpn);

	public String findId(@Param("mname") String mname, @Param("mpn") String mpn);

	public int confirmUser2(Imsi2VO vo);

	public int changePwd(IdPwdVO vo);
}
