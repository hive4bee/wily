package org.coffee.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RepliesDTO {
	private Long rno;
	private Long fno;
	private String reply;
	private String mid;
	private Date replyDate;
	private Long rgroup;
	private Long rstep;
	private Long rtotal;
}
