package org.wily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.wily.domain.RepliesDTO;
import org.wily.domain.StartDTO;

public interface RepliesMapper {
	
	//public List<RepliesDTO> getList(Long bno);
	public List<RepliesDTO> getList(@Param("startDTO") StartDTO startDTO, @Param("bno") Long bno);
	public int getTotalCount(Long bno);
	
	public int addReply(RepliesDTO repliesDTO);
	
	public int deleteReply(Long rno);
	
	public int modifyReply(RepliesDTO repliesDTO);
	
	public void updateRerepliesCnt(@Param("rno") Long rno, @Param("rNum") int rNum);
	
	public int addRereply(RepliesDTO repliesDTO);
	
	public List<RepliesDTO> getReList(Long rno);
	
}
