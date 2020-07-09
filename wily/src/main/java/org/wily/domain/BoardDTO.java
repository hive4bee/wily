package org.wily.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private Long bno;
	private String mid;
	private String bsubject;
	private String bcontent;
	private Date bregdate;
	private Long bhit;
	private int bstatus;
	private Long breplycnt;
}
