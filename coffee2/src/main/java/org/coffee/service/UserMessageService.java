package org.coffee.service;

import java.util.List;

import org.coffee.domain.StartDTO;
import org.coffee.domain.UserMessageDTO;

public interface UserMessageService {
	public void insertMessage(UserMessageDTO userMessageDTO);

	public int checkMessageQ(String mid);

	public List<UserMessageDTO> getMessageL(String mid);

	public List<UserMessageDTO> getUserMessageList(StartDTO startDTO, String mid);

	public int getTotalCount(String mid);

	public UserMessageDTO read(String u_no);

	public String checkReadStatus(String mid, String u_no);

	public void changeStatus(String mid, String u_no);

	public void delete(String u_no);
}
