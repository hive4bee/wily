package org.coffee.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RepliesPageDTO {
	private int cnt;
	private List<RepliesDTO> list;
	
}
