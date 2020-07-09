package org.wily.service;

import java.util.List;

import org.wily.domain.BoardDTO;
import org.wily.domain.StartDTO;

public interface BoardService {
	
	public List<BoardDTO> list(StartDTO startDTO);

	public int totalRecord(StartDTO startDTO);

	public void write(BoardDTO boardDTO);
}
