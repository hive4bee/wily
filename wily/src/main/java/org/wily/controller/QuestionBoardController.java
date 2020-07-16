package org.wily.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.wily.domain.QuestionBoardDTO;
import org.wily.domain.QuestionBoardPageDTO;
import org.wily.domain.StartDTO;
import org.wily.service.QuestionBoardService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/questions/*")
public class QuestionBoardController {
	
	@Setter(onMethod_=@Autowired)
	private QuestionBoardService questionBoardService;
	
	@GetMapping("/board")
	public void board() {
		
	}
	
	@GetMapping(value="/pages/{page}/{amount}", produces= {
					MediaType.APPLICATION_XML_VALUE, 
					MediaType.APPLICATION_JSON_VALUE})
	@ResponseBody
	public ResponseEntity<QuestionBoardPageDTO> getQuestionList(
			@PathVariable("page") int page, @PathVariable("amount") int amount){
		log.info("page: "+page);
		StartDTO startDTO = new StartDTO(page, amount);
		QuestionBoardPageDTO questionBoardPageDTO=questionBoardService.getQuestion(startDTO);
		log.info("questionBoardPageDTO: "+questionBoardPageDTO);
		
		return new ResponseEntity<>(questionBoardPageDTO, HttpStatus.OK);
	}
	
	@PostMapping(value="/addQuestion", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> addQuestion(@RequestBody QuestionBoardDTO questionBoardDTO){
		return questionBoardService.addQuestion(questionBoardDTO) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/showDetailQuestion/{qno}")
	@ResponseBody
	public ResponseEntity<QuestionBoardDTO> showDetailQuestion(@PathVariable("qno") String qno){
		QuestionBoardDTO questionBoardDTO = questionBoardService.showDetailQuestion(qno);
		return new ResponseEntity<>(questionBoardDTO, HttpStatus.OK);
	}
	
	@DeleteMapping(value="/delete/{qno}")
	@ResponseBody
	public ResponseEntity<String> deleteQuestion(@PathVariable("qno") String qno){
		return questionBoardService.deleteQuestion(qno) == 1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value="/modify/{qno}")
	@ResponseBody
	public ResponseEntity<String> modifyQuestion(@PathVariable("qno") String qno, @RequestBody QuestionBoardDTO questionBoardDTO){
		return questionBoardService.modifyQuestion(questionBoardDTO)==1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
