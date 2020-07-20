package org.coffee.service;

import java.util.List;

import org.coffee.domain.BoardsDTO;
import org.coffee.domain.StartDTO;
import org.coffee.mapper.BoardsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardsServiceImpl implements BoardsService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardsMapper mapper;
	
	@Override
	public List<BoardsDTO> getList(StartDTO st) {
		List<BoardsDTO> list = mapper.getList(st);
		return list;
	}
	
	@Override
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	
	@Override
	public void write(BoardsDTO dto) {
		mapper.write(dto);
	}
	
	@Override
	public BoardsDTO read(String fno) {
		BoardsDTO dto = mapper.read(fno);
		return dto;
	}
	
	@Override
	public void update(BoardsDTO dto) {
		mapper.update(dto);
	}
	
	@Override
	public void delete(int fno) {
		mapper.delete(fno);
	}
	
	@Override
	public void updateReplyCnt(Long fno, int num) {
		mapper.updateReplyCnt(fno, num);
	}
}
