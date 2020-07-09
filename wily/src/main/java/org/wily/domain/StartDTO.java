package org.wily.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class StartDTO {
	private int page;
	private int amount;
	private int startRecord;
	
	private String keyfield;
	private String keyword;
	
	public StartDTO() {
		this(1,10);
	}
	
	public StartDTO(int page, int amount) {
		this.page=page;
		this.amount=amount;
		this.startRecord=(page-1)*amount;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("page", this.page)
				.queryParam("amount", this.getAmount())
				.queryParam("keyfield", this.getKeyfield())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
