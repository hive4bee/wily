package org.coffee.domain;

import lombok.Data;

@Data
public class CartProductDTO {
	private Long cnum;
	private Long cqty;
	private Long pnum;
	private String pname;
	private Long pprice;
}
