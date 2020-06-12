package org.coffee.service;

import java.util.List;

import org.coffee.domain.ShopsDTO;

public interface ShopsService {
	public List<ShopsDTO> getShopsList(String key);

	public String getAddress(String snum);
}
