package org.coffee.mapper;

import java.util.List;

import org.coffee.domain.ShopsDTO;

public interface ShopsMapper {
	public List<ShopsDTO> getShopsList(String key);

	public String getAddress(String snum);
}
