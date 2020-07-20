package org.coffee.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderProductDTO {
	private Long pnum;
	private String pname;
	private Long pprice;
	private String uuid;
	private String uploadpath;
	private String filename;
	private String onum;
	private Long oqty;
	private String odate;
	private String otime;
	private Date oregdate;
	private String oaddr;
	private String ostatus;
	private String mid;
}
