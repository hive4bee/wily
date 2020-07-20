package org.wily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wily.domain.RepliesDTO;
import org.wily.domain.RepliesPageDTO;
import org.wily.domain.StartDTO;
import org.wily.mapper.BoardMapper;
import org.wily.mapper.RepliesMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class RepliesServiceImpl implements RepliesService {
	
	@Setter(onMethod_ = @Autowired)
	private RepliesMapper repliesMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
//	@Override
//	public List<RepliesDTO> getList(Long bno) {
//		return repliesMapper.getList(bno);
//	}
	@Transactional
	@Override
	public RepliesPageDTO getList(StartDTO startDTO, Long bno) {
		
		int cnt = repliesMapper.getTotalCount(bno);
		List<RepliesDTO> list = repliesMapper.getList(startDTO, bno);
		RepliesPageDTO repliesPageDTO = new RepliesPageDTO(cnt, list);		
		
		return repliesPageDTO;
	}
	
	@Transactional
	@Override
	public int addReply(RepliesDTO repliesDTO) {
		Long bno = repliesDTO.getBno();
		int rNum = 1;
		boardMapper.updateRepliesCnt(bno, rNum);
		return repliesMapper.addReply(repliesDTO);
	}
	
	@Transactional
	@Override
	public int deleteReply(Long bno, Long rno) {
		int rNum=-1;
		boardMapper.updateRepliesCnt(bno, rNum);
		return repliesMapper.deleteReply(rno);
	}
	
	@Override
	public int modifyReply(RepliesDTO repliesDTO) {
		return repliesMapper.modifyReply(repliesDTO);
	}
	
	@Transactional
	@Override
	public int addRereply(RepliesDTO repliesDTO) {
		Long rno=repliesDTO.getRno();
		int rNum=1;
		repliesMapper.updateRerepliesCnt(rno, rNum);
		return repliesMapper.addRereply(repliesDTO);
	}
	
	@Override
	public List<RepliesDTO> getReList(Long rno) {
		return repliesMapper.getReList(rno);
	}
	
	@Transactional
	@Override
	public int deleteRereply(Long rgroup, Long rno) {
		int rNum=-1;
		
		repliesMapper.updateRerepliesCnt(rgroup, rNum);
		return repliesMapper.deleteRereply(rno);
	}
}
