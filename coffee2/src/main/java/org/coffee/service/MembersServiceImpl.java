package org.coffee.service;

import org.coffee.domain.IdPwdVO;
import org.coffee.domain.Imsi2VO;
import org.coffee.domain.MembersDTO;
import org.coffee.mapper.MembersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MembersServiceImpl implements MembersService {
	@Setter(onMethod_ = @Autowired)
	private MembersMapper mapper;
	
	@Override
	public void register(MembersDTO dto) {
		log.info("register................");
		mapper.register(dto);
	}

	public int confirmId(String mid) {
		int check = mapper.confirmId(mid);
		
		return check;
	}

	public int confirmLogin(String mid, String mpw) {
		int check = mapper.confirmLogin(mid, mpw);
		return check;
	}
	
	@Override
	public MembersDTO getUserInfo(String mid) {
		return mapper.getUserInfo(mid);
	}

	@Override
	public int confirmUser(String mname, String mpn) {
		return mapper.confirmUser(mname, mpn);
	}
	
	@Override
	public String findId(String mname, String mpn) {
		return mapper.findId(mname, mpn);
	}
	
	@Override
	public int confirmUser2(Imsi2VO vo) {
		return mapper.confirmUser2(vo);
	}

	@Override
	public int changePwd(IdPwdVO vo) {
		return mapper.changePwd(vo);
	}
}
