package org.wily.mapper;

import java.util.List;

import org.wily.domain.QuestionBoardDTO;
import org.wily.domain.StartDTO;

public interface QuestionBoardMapper {

	List<QuestionBoardDTO> getQuestionList(StartDTO startDTO);

	int getQuestionTotal();

	int addQuestion(QuestionBoardDTO questionBoardDTO);

	QuestionBoardDTO showDetailQuestion(String qno);

	int deleteQuestion(String qno);

	int modifyQuestion(QuestionBoardDTO questionBoardDTO);
	
}
