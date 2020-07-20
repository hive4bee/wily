package org.coffee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.coffee.domain.BoardsDTO;
import org.coffee.domain.StartDTO;

public interface BoardsMapper {
	public List<BoardsDTO> getList(StartDTO st);
	
	public int getTotalCount();
	
	public void write(BoardsDTO dto);
	
	public BoardsDTO read(String fno);
	
	public void update(BoardsDTO dto);
	
	public void delete(int fno);
	
	public void updateReplyCnt(@Param("fno") Long fno, @Param("num") int num);
}
