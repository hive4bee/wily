package org.wily.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private StartDTO st;
	
	public PageDTO(StartDTO st, int total) {
		this.st=st;
		this.total=total;
		
		this.endPage=(int)(Math.ceil((double)st.getPage()/(double)st.getAmount()) * 10);
		this.startPage=this.endPage-9;
		
		int realEnd=(int)(Math.ceil((total*1.0)/st.getAmount()));
		
		if(realEnd<=this.endPage) {
			this.endPage=realEnd;
		}
		
		this.prev=this.startPage >1;
		this.next=this.endPage < realEnd;
	}
}
