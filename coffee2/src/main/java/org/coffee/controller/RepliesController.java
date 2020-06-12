package org.coffee.controller;

import java.util.List;

import org.coffee.domain.RepliesDTO;
import org.coffee.domain.RepliesPageDTO;
import org.coffee.domain.StartDTO;
import org.coffee.service.BoardsService;
import org.coffee.service.RepliesService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class RepliesController {
	private RepliesService service;
	
	private BoardsService boardsService;
	
	@Transactional
	@PostMapping(value="/new", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody RepliesDTO dto){
		int cnt = service.register(dto);
		boardsService.updateReplyCnt(dto.getFno(), 1);
		return cnt == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : 
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@Transactional
	@PostMapping(value="/new2", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create2(@RequestBody RepliesDTO dto){
		int cnt = service.register2(dto);
		log.info("====================");
		log.info("RepliesDTO : " + dto);
		log.info("====================");
		service.updateReReplyCnt(dto.getRno(), 1);
		return cnt == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) : 
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@GetMapping(value="/pages/{fno}/{page}", produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<RepliesPageDTO> getList(@PathVariable("page") int page, @PathVariable("fno") Long fno){
		log.info("getList ......");
		StartDTO startDTO = new StartDTO(page);
		startDTO.setStartRecord((page-1)*10+1);
		log.info(startDTO.getStartRecord());
		RepliesPageDTO repliesPageDTO = service.getList(startDTO, fno);
		log.info("////////////////////replyCnt : " + repliesPageDTO.getCnt());
		return new ResponseEntity<>(repliesPageDTO, HttpStatus.OK);
	}
	
	@Transactional
	@DeleteMapping(value="{rno}/{fno}")
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno, @PathVariable("fno") Long fno){
		log.info("remove : " + rno);
		int cnt = service.remove(rno);
		boardsService.updateReplyCnt(fno, -1);
		return cnt == 1 ? new ResponseEntity<>("success",HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@Transactional
	@DeleteMapping(value="/delete/{rno}/{srno}")
	public ResponseEntity<String> remove2(@PathVariable("rno") Long rno, @PathVariable("srno") Long srno){
		log.info("remove : " + rno);
		int cnt = service.remove(rno);
		service.updateReReplyCnt(srno, -1);
		return cnt == 1 ? new ResponseEntity<>("success",HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value="/{rno}")
	public ResponseEntity<String> modify(@RequestBody RepliesDTO dto, @PathVariable("rno") Long rno){
		dto.setRno(rno);
		log.info("rno : " + rno);
		log.info("modify : " + dto);
		return service.modify(dto) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/rno/{rno}")
	public ResponseEntity<List<RepliesDTO>> getReList(@PathVariable("rno") Long rno){
		log.info("getReList ......");
		return new ResponseEntity<>(service.getReList(rno), HttpStatus.OK);
	}
}
