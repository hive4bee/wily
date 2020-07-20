package org.coffee.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MembersDTO {
	private int mno;
	private String mid;
	private String mpw;
	private String mname;
	private String memail;
	private String mpn;
	private Date indate;
}
