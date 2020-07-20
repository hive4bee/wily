package org.wily.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QuestionBoardDTO {
	private Long qno;
	private String mid;
	private String qsubject;
	private String qcontent;
	private Date qregdate;
	private Long qhit;
	private int qstatus;
	private Long qcnt;
}
