package org.coffee.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ProductsDTO {
	private int pnum;
	private String pcode;
	private String pname;
	private Long pprice;
	private String pcategory;
	private String pcomment;
	private Date pregdate;
	private String phide;
}
