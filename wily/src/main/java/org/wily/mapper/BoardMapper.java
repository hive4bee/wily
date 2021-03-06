package org.wily.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.wily.domain.BoardDTO;
import org.wily.domain.StartDTO;

public interface BoardMapper {
	
	public List<BoardDTO> list(StartDTO startDTO);

	public int totalRecord(StartDTO startDTO);

	public void write(BoardDTO boardDTO);

	public BoardDTO viewDetail(String bno);

	public void delete(String bno);

	public BoardDTO getModifyForm(String bno);

	public void modifyPro(BoardDTO boardDTO);

	public void updateRepliesCnt(@Param("bno") Long bno, @Param("rNum") int rNum);

	public void increaseHit(String bno);
	
}
