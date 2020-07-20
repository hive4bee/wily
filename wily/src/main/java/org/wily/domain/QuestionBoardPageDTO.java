package org.wily.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class QuestionBoardPageDTO {
	private int cnt;
	private List<QuestionBoardDTO> list;
}
