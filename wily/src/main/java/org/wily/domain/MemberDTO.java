package org.wily.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {
	private Long mno;
	private String mid;
	private String mpw;
	private String mfname;
	private String mlname;
	private String memail;
	private Date mregdate;
	private String mstatus;
	private List<AuthVO> authList;
}
