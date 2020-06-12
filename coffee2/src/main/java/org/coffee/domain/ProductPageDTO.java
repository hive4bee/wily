package org.coffee.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductPageDTO {
	private int startPage;
	  private int endPage;
	  private boolean prev, next;

	  private int total;
	  private StartDTO st;
	  public ProductPageDTO(StartDTO st, int total) {
		this.st = st;
	    this.total = total;
	    
	    this.endPage = (int) (Math.ceil(st.getPage() / 10.0)) * 10;

	    this.startPage = this.endPage - 9;

	    int realEnd = (int) (Math.ceil((total * 1.0) / 8));

	    if (realEnd <= this.endPage) {
	      this.endPage = realEnd;
	    }

	    this.prev = this.startPage > 1;

	    this.next = this.endPage < realEnd;
	  }
}
