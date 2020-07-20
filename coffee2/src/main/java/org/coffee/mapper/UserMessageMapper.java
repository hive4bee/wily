package org.coffee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.coffee.domain.StartDTO;
import org.coffee.domain.UserMessageDTO;

public interface UserMessageMapper {

	void insertMessage(UserMessageDTO userMessageDTO);

	int checkMessageQ(String mid);

	List<UserMessageDTO> getMessageL(String mid);

	List<UserMessageDTO> getUserMessageList(@Param("startDTO") StartDTO startDTO, @Param("mid") String mid);

	int getTotalCount(String mid);

	UserMessageDTO read(String u_no);

	String checkReadStatus(@Param("mid") String mid, @Param("u_no") String u_no);

	void changeStatus(@Param("mid") String mid, @Param("u_no") String u_no);

	void delete(String u_no);

}
