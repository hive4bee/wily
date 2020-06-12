package org.coffee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.coffee.domain.RepliesDTO;
import org.coffee.domain.StartDTO;

public interface RepliesMapper {
	public int register(RepliesDTO dto);
	
	public int getTotalCount(Long fno);
	
	public List<RepliesDTO> getList(@Param("startDTO") StartDTO startDTO, @Param("fno") Long fno);

	public int remove(Long rno);

	public int modify(RepliesDTO dto);

	public List<RepliesDTO> getReList(Long rno);

	public int register2(RepliesDTO dto);

	public void updateReReplyCnt(@Param("rno") Long rno, @Param("num") int num);
}
