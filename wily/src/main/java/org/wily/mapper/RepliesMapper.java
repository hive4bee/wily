package org.wily.mapper;

import java.util.List;

import org.wily.domain.RepliesDTO;

public interface RepliesMapper {
	
	public List<RepliesDTO> getList(Long bno);
	
}
