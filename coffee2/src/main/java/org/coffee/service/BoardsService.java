package org.coffee.service;

import java.util.List;

import org.coffee.domain.BoardsDTO;
import org.coffee.domain.StartDTO;

public interface BoardsService {
	public List<BoardsDTO> getList(StartDTO st);
	
	public int getTotalCount();
	
	public void write(BoardsDTO dto);
	
	public BoardsDTO read(String fno);
	
	public void update(BoardsDTO dto);
	
	public void delete(int fno);

	public void updateReplyCnt(Long fno, int num);
}
