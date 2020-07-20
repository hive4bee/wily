package org.wily.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.wily.domain.QuestionBoardDTO;
import org.wily.domain.QuestionBoardPageDTO;
import org.wily.domain.StartDTO;
import org.wily.mapper.QuestionBoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class QuestionBoardServiceImpl implements QuestionBoardService {
	
	@Setter(onMethod_=@Autowired)
	private QuestionBoardMapper questionBoardMapper;
	
	@Transactional
	@Override
	public QuestionBoardPageDTO getQuestion(StartDTO startDTO) {
		List<QuestionBoardDTO> list=questionBoardMapper.getQuestionList(startDTO);
		int cnt=questionBoardMapper.getQuestionTotal();
		QuestionBoardPageDTO questionBoardPageDTO=new QuestionBoardPageDTO(cnt, list);
		
		return questionBoardPageDTO;
	}
	
	@Override
	public int addQuestion(QuestionBoardDTO questionBoardDTO) {
		return questionBoardMapper.addQuestion(questionBoardDTO);
	}
	
	@Override
	public QuestionBoardDTO showDetailQuestion(String qno) {
		return questionBoardMapper.showDetailQuestion(qno);
	}
	
	@Override
	public int deleteQuestion(String qno) {
		return questionBoardMapper.deleteQuestion(qno);
	}
	
	@Override
	public int modifyQuestion(QuestionBoardDTO questionBoardDTO) {
		return questionBoardMapper.modifyQuestion(questionBoardDTO);
	}
	
}
