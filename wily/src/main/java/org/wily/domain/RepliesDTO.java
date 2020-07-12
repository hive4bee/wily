package org.wily.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RepliesDTO {
	private Long rno;
	private Long bno;
	private String mid;
	private String rcontent;
	private Date rregdate;
	private int rstatus;
	private Long rgroup;
	private Long rstep;
	private String rsup;
	private Long rcnt;
}
