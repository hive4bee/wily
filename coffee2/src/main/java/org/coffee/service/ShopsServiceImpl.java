package org.coffee.service;

import java.util.List;

import org.coffee.domain.ShopsDTO;
import org.coffee.mapper.ShopsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ShopsServiceImpl implements ShopsService {
	@Setter(onMethod_ = @Autowired)
	private ShopsMapper mapper;
	
	@Override
	public List<ShopsDTO> getShopsList(String key) {
		return mapper.getShopsList(key);
	}
	
	@Override
	public String getAddress(String snum) {
		return mapper.getAddress(snum);
	}
}
