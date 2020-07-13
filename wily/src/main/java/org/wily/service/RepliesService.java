package org.wily.service;

import org.wily.domain.RepliesDTO;
import org.wily.domain.RepliesPageDTO;
import org.wily.domain.StartDTO;

public interface RepliesService {
	
	//public List<RepliesDTO> getList(Long bno);
	public RepliesPageDTO getList(StartDTO startDTO, Long bno);

	public int addReply(RepliesDTO repliesDTO);

	public int deleteReply(Long bno, Long rno);

	public int modifyReply(RepliesDTO repliesDTO);
	
}
