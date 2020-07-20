package org.coffee.domain;

import lombok.Data;

@Data
public class CartDTO {
	private Long cnum;
	private String mid;
	private Long pnum;
	private String pname;
	private Long pprice;
	private Long cqty;
	private String uuid;
	private String uploadpath;
	private String filename;
}
