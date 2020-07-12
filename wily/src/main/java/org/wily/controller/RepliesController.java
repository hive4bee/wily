package org.wily.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.wily.domain.RepliesDTO;
import org.wily.service.RepliesService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/replies")
public class RepliesController {
	
	//@Setter(onMethod_ = @Autowired)
	private RepliesService repliesService;
	
	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<RepliesDTO>> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){
		return new ResponseEntity<>(repliesService.getList(bno), HttpStatus.OK);
	}
}
