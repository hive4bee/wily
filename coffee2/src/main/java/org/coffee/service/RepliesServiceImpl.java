package org.coffee.service;

import java.util.List;

import org.coffee.domain.RepliesDTO;
import org.coffee.domain.RepliesPageDTO;
import org.coffee.domain.StartDTO;
import org.coffee.mapper.BoardsMapper;
import org.coffee.mapper.RepliesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class RepliesServiceImpl implements RepliesService {
	@Setter(onMethod_ = @Autowired)
	private RepliesMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardsMapper boardsMapper;
	
	@Override
	public int register(RepliesDTO dto) {
		return mapper.register(dto);
	}
	
	@Override
	public int register2(RepliesDTO dto) {
		return mapper.register2(dto);
	}
	
	@Override
	public RepliesPageDTO getList(StartDTO startDTO, Long fno) {
		log.info("--" + startDTO.getStartRecord());
		return new RepliesPageDTO(mapper.getTotalCount(fno), mapper.getList(startDTO, fno));
	}
	
	@Override
	public int remove(Long rno) {
		
		return mapper.remove(rno);
	}
	@Override
	public int modify(RepliesDTO dto) {
		return mapper.modify(dto);
	}
	
	@Override
	public List<RepliesDTO> getReList(Long rno) {
		return mapper.getReList(rno);
	}
	
	@Override
	public void updateReReplyCnt(Long rno, int num) {
		mapper.updateReReplyCnt(rno, num);
	}
}
