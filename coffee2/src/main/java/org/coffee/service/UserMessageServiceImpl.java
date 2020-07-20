package org.coffee.service;

import java.util.List;

import org.coffee.domain.StartDTO;
import org.coffee.domain.UserMessageDTO;
import org.coffee.mapper.UserMessageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Service
@Log4j
public class UserMessageServiceImpl implements UserMessageService {
	@Setter(onMethod_ = @Autowired)
	private UserMessageMapper mapper;
	
	@Override
	public void insertMessage(UserMessageDTO userMessageDTO) {
		mapper.insertMessage(userMessageDTO);
	}
	
	@Override
	public int checkMessageQ(String mid) {
		return mapper.checkMessageQ(mid);
	}
	
	@Override
	public List<UserMessageDTO> getMessageL(String mid) {
		return mapper.getMessageL(mid);
	}
	
	@Override
	public List<UserMessageDTO> getUserMessageList(StartDTO startDTO, String mid) {
		return mapper.getUserMessageList(startDTO, mid);
	}
	
	@Override
	public int getTotalCount(String mid) {
		return mapper.getTotalCount(mid);
	}
	
	@Override
	public UserMessageDTO read(String u_no) {
		return mapper.read(u_no);
	}
	
	@Override
	public String checkReadStatus(String mid, String u_no) {
		return mapper.checkReadStatus(mid, u_no);
	}
	
	@Override
	public void changeStatus(String mid, String u_no) {
		mapper.changeStatus(mid, u_no);
	}
	
	@Override
	public void delete(String u_no) {
		mapper.delete(u_no);
	}
}
