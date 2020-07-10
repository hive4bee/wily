package org.wily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.wily.domain.BoardDTO;
import org.wily.domain.StartDTO;
import org.wily.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
	@Override
	public List<BoardDTO> list(StartDTO startDTO) {
		List<BoardDTO> list = boardMapper.list(startDTO);
		log.info("service list: " + list);
		return list;
	}
	
	@Override
	public int totalRecord(StartDTO startDTO) {
		return boardMapper.totalRecord(startDTO);
	}
	
	@Override
	public void write(BoardDTO boardDTO) {
		boardMapper.write(boardDTO);
	}
}
