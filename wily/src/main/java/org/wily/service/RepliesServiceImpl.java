package org.wily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.wily.domain.RepliesDTO;
import org.wily.mapper.RepliesMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class RepliesServiceImpl implements RepliesService {
	
	@Setter(onMethod_ = @Autowired)
	private RepliesMapper repliesMapper;
	
	@Override
	public List<RepliesDTO> getList(Long bno) {
		return repliesMapper.getList(bno);
	}
	
}
