package org.coffee.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserMessageDTO {
	private Long u_no;
	private String mid;
	private String u_sub;
	private String u_msg;
	private String u_from;
	private String u_status;
	private Date u_reg;
}
