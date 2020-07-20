package org.coffee.service;

import java.util.List;

import org.coffee.domain.RepliesDTO;
import org.coffee.domain.RepliesPageDTO;
import org.coffee.domain.StartDTO;

public interface RepliesService {
	public int register(RepliesDTO dto);
	
	public RepliesPageDTO getList(StartDTO startDTO, Long fno);

	public int remove(Long rno);

	public int modify(RepliesDTO dto);

	public List<RepliesDTO> getReList(Long rno);

	public int register2(RepliesDTO dto);

	public void updateReReplyCnt(Long rno, int num);
}
