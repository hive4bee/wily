package org.wily.service;

import java.util.List;

import org.wily.domain.RepliesDTO;

public interface RepliesService {
	
	public List<RepliesDTO> getList(Long bno);
	
}
