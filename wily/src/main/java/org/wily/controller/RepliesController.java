package org.wily.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.wily.domain.RepliesDTO;
import org.wily.domain.RepliesPageDTO;
import org.wily.domain.StartDTO;
import org.wily.service.RepliesService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/replies")
public class RepliesController {
	
	@Setter(onMethod_ = @Autowired)
	private RepliesService repliesService;
	
//	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_VALUE})
//	public ResponseEntity<List<RepliesDTO>> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page) {
//		return new ResponseEntity<>(repliesService.getList(bno), HttpStatus.OK);
//	}
	
	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<RepliesPageDTO> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page) {
		log.info("bno: "+bno);
		log.info("page: "+page);
		StartDTO startDTO = new StartDTO();
		startDTO.setStartRecord((page-1)*10);
		RepliesPageDTO repliesPageDTO = repliesService.getList(startDTO, bno);
		return new ResponseEntity<>(repliesPageDTO, HttpStatus.OK);
	}
	
	@PostMapping(value="/addReply", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> addReply(@RequestBody RepliesDTO repliesDTO){
		log.info("repliesDTO: "+repliesDTO);
		int cnt = repliesService.addReply(repliesDTO);
		return cnt == 1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/deleteReply/{bno}/{rno}")
	public ResponseEntity<String> deleteReply(@PathVariable("bno") Long bno,@PathVariable("rno") Long rno){
		log.info("bno: "+bno);
		log.info("rno: "+rno);
		int chk=repliesService.deleteReply(bno, rno);
		return chk==1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value="/modifyReply/{rno}")
	public ResponseEntity<String> modify(@RequestBody RepliesDTO repliesDTO, @PathVariable("rno") Long rno){
		return repliesService.modifyReply(repliesDTO) == 1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="/addRereply", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> addRereply(@RequestBody RepliesDTO repliesDTO){
		log.info("repliesDTO: "+repliesDTO);
		int cnt = repliesService.addRereply(repliesDTO);
		return cnt == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/re/{rno}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<RepliesDTO>> getReList(@PathVariable("rno") Long rno){
		log.info("rno: "+rno);
		return new ResponseEntity<>(repliesService.getReList(rno), HttpStatus.OK);
	}
}
