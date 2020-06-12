package org.coffee.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.coffee.domain.ShopsDTO;
import org.coffee.service.ShopsService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/shops/")
@RestController
@Log4j
@AllArgsConstructor
public class ShopsController {
	
	private ShopsService service;
	
	@GetMapping(value="/key/{key}")
	public ResponseEntity<List<ShopsDTO>> getShopsList(@PathVariable("key") String key){
		log.info("getReList ......");
		return new ResponseEntity<>(service.getShopsList(key), HttpStatus.OK);
	}
	
	@GetMapping(value="/getAddr")
	public ResponseEntity<String> getAddr(String snum){
		log.info("===============================");
		log.info("snum : " + snum);
		log.info("===============================");
		return new ResponseEntity<>(service.getAddress(snum), HttpStatus.OK);
	}
	
}
