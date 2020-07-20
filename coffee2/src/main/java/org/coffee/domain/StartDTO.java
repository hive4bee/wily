package org.coffee.domain;

import lombok.Data;

@Data
public class StartDTO {
	private int page;
	private int startRecord;
	public StartDTO() {
		this(1);
	}
	public StartDTO(int page) {
		this.page=page;
		this.startRecord=(page-1)*10;
	}
	
}
