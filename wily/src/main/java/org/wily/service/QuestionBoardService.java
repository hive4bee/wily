package org.wily.service;

import org.wily.domain.QuestionBoardDTO;
import org.wily.domain.QuestionBoardPageDTO;
import org.wily.domain.StartDTO;

public interface QuestionBoardService {

	QuestionBoardPageDTO getQuestion(StartDTO startDTO);

	int addQuestion(QuestionBoardDTO questionBoardDTO);

	QuestionBoardDTO showDetailQuestion(String qno);

	int deleteQuestion(String qno);

	int modifyQuestion(QuestionBoardDTO questionBoardDTO);
	
	
}
