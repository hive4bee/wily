package org.coffee.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.coffee.domain.ImagesDTO;
import org.coffee.domain.IdPwdVO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.PageDTO;
import org.coffee.domain.ProductsDTO;
import org.coffee.domain.StartDTO;
import org.coffee.domain.UserMessageDTO;
import org.coffee.service.AdminService;
import org.coffee.service.UserMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService service;
	
	@Setter(onMethod_ = @Autowired)
	private UserMessageService userMessageService;
	
	@GetMapping("/home")
	public void indexA() {
		
	}
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@PostMapping("/confirmLogin")
	@ResponseBody
	public ResponseEntity<String> confirmLogin(String id, String pwd){
		int check = service.confirmLogin(id, pwd);
		String chk = "";
		log.info("====================================");
		log.info("id : " + id + " / pwd : " + pwd +" / check : " + check);
		log.info("====================================");
		if(check == 1) {
			chk = "y"; 
		}else {
			chk="n";
		}
		return new ResponseEntity<>(chk, HttpStatus.OK);
		
	}
	
	@PostMapping("/loginPro")
	public String loginPro(String id, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("mid", id);
		session.setMaxInactiveInterval(-1);
		return "redirect:/admin/home";
	}
	@GetMapping("/logOut")
	public String logOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/admin/home";
	}
	
	@GetMapping("/coffeeList")
	public void productList(StartDTO st, Model model) {
		st.setStartRecord((st.getPage()-1)*10+1);
		model.addAttribute("list", service.getCoffeeList(st));
		int coffeeTotal = service.getCoffeeTotalCount();
		model.addAttribute("pageMaker", new PageDTO(st, coffeeTotal));
	}
	@GetMapping("/insertProductForm")
	public void insertProductForm() {
		
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		System.out.println(str.replace("-", File.separator));
		return str.replace("-", File.separator);
	}
	
	@PostMapping("/insertPro")
	public String insertPro(ProductsDTO productsDTO, MultipartFile uploadFile, Model model) {
		String uploadFolder = "c:\\upload";
//		String uploadFolder = "/home/eprot/upload";
		int pnum = service.getNextPnum();
		productsDTO.setPnum(pnum);
		service.insertProduct(productsDTO);
		log.info("================================");
		log.info("upload file name : " + uploadFile.getOriginalFilename());
		log.info("upload file size : " + uploadFile.getSize());
		log.info("================================");
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		String uploadFileName = uploadFile.getOriginalFilename();
		ImagesDTO imagesDTO = new ImagesDTO();
		imagesDTO.setPnum(pnum);
		imagesDTO.setFilename(uploadFileName);
		UUID uuid = UUID.randomUUID();
		imagesDTO.setUuid(uuid.toString());
		uploadFileName=uuid.toString()+"_"+uploadFileName;
		
		//File saveFile = new File(uploadFolder, uploadFile.getOriginalFilename());
		File saveFile = new File(uploadPath, uploadFileName);
		try {
			uploadFile.transferTo(saveFile);
			imagesDTO.setUploadpath(uploadFolderPath);
			FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
			Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
			thumbnail.close();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		log.info("imagesDTO : " + imagesDTO);
		service.insertImage(imagesDTO);

		
		return "redirect:/admin/coffeeList";
	}
	
	@GetMapping("/checkOrderQuantity")
	@ResponseBody
	public ResponseEntity<String> checkOrderQuantity(String id){
		log.info("===============================");
		log.info("id : " + id);
		log.info("===============================");
		int check = service.checkOrderQuantity();
		return new ResponseEntity<>(check+"", HttpStatus.OK);
	}
	
	@GetMapping(value="/getOrderList/{id}")
	public ResponseEntity<List<OrdersDTO>> getOrderList(@PathVariable("id") String id){
		log.info("===============================");
		log.info("id : " + id);
		log.info("===============================");
		List<OrdersDTO> list= service.getOrderList();
		list.forEach(a -> log.info(a));
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/showAllOrders")
	public void showAllOrders(Model model) {
		List<OrderProductDTO> list = service.showAllOrders();
		log.info("===============================");
		list.forEach(a->log.info(a));
		log.info("===============================");
		model.addAttribute("list", list);
	}
	
	@GetMapping("changeStatus")
	@ResponseBody
	public ResponseEntity<String> changeStatus(String onum, String ostatus, String mid){
		log.info("================================");
		log.info("ostatus : " + ostatus + " onum : " + onum + " mid : " + mid);
		log.info("================================");
		int check = service.changeStatus(onum, ostatus);
		UserMessageDTO userMessageDTO = new UserMessageDTO();
		userMessageDTO.setMid(mid);
		userMessageDTO.setU_sub("주문번호 "+onum+"의 주문처리가 완료되었습니다.");
		userMessageDTO.setU_msg("매장에 방문하셔서 픽업해주시기 바랍니다. 감사합니다.");
		userMessageService.insertMessage(userMessageDTO);
		return check == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@GetMapping("/viewProduct")
	public void viewProduct(String pnum, Model model) {
		log.info("=================================");
		log.info("pnum : " + pnum);
		log.info("=================================");
		JoinedDTO dto = service.viewProduct(pnum);
		model.addAttribute("dto", dto);
	}
	
	@GetMapping("/deleteProduct")
	public String deleteProduct(String pnum, String fileName) {
		log.info("==================================");
		log.info("pnum : " + pnum);
		log.info("fileName : " + fileName);
		log.info("==================================");
		int checkDI = service.deleteImage(pnum);
		int checkDP = service.deleteProduct(pnum);
		log.info("checkDP : " + checkDP);
		log.info("checkDI : " + checkDI);
		File file;
		try {
			file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
//			file = new File("/home/eprot/upload/"+URLDecoder.decode(fileName, "UTF-8"));			
			file.delete();
			String largeFileName = file.getAbsolutePath().replace("s_","");
			log.info("largeFileName : " + largeFileName);
			file = new File(largeFileName);
			file.delete();
			log.info("successfully deleted from filesystem!!!!");
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "redirect:/admin/coffeeList";
	}
	
	@GetMapping("/modifyProductForm")
	public void modifyProductForm(String pnum, Model model) {
		log.info("======================================");
		log.info("pnum : " + pnum);
		log.info("======================================");
		JoinedDTO dto = service.viewProduct(pnum);
		model.addAttribute("dto", dto);
	}
	
	@PostMapping("/modifyPro")
	public String modifyPro(ProductsDTO productsDTO, MultipartFile uploadFile, @RequestParam("mod") String mod) {
		log.info("=========================================");
		log.info("productsDTO : " + productsDTO);
		log.info("uploadFile : " + uploadFile);
		log.info("=========================================");
		
		if(mod.equals("n")) {//내용을 변경할 때 이미지변경이 포함되지 않은 경우
			service.modifyPro1(productsDTO);
		}else {//내용을 변경할 때 이미지 변경이 포함되어있는 경우.. 먼저 기존이미지를 DB, filesystem에서 지우고 새로운 이미지를 추가한다.
			String fileName = mod;
			File file;
			try {
				file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
//				file = new File("/home/eprot/upload/"+URLDecoder.decode(fileName, "UTF-8"));			
				file.delete();
				String largeFileName = file.getAbsolutePath().replace("s_","");
				log.info("largeFileName : " + largeFileName);
				file = new File(largeFileName);
				file.delete();
				log.info("successfully deleted from filesystem!!!!");
			}catch(UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			service.modifyPro1(productsDTO);
//			String uploadFolder = "/home/eprot/upload";
			String uploadFolder = "c:\\upload";
			String uploadFolderPath = getFolder();
			File uploadPath = new File(uploadFolder, uploadFolderPath);
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}
			String uploadFileName = uploadFile.getOriginalFilename();
			ImagesDTO imagesDTO = new ImagesDTO();
			imagesDTO.setPnum(productsDTO.getPnum());
			imagesDTO.setFilename(uploadFileName);
			UUID uuid = UUID.randomUUID();
			imagesDTO.setUuid(uuid.toString());
			uploadFileName=uuid.toString()+"_"+uploadFileName;
			
			//File saveFile = new File(uploadFolder, uploadFile.getOriginalFilename());
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				uploadFile.transferTo(saveFile);
				imagesDTO.setUploadpath(uploadFolderPath);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			log.info("imagesDTO : " + imagesDTO);
			service.updateImage(imagesDTO);
		}
		return "redirect:/admin/coffeeList";
	}
	
	@GetMapping("/changeH")
	@ResponseBody
	//public ResponseEntity<String> changeH(@RequestBody ImsiVO vo){
	public ResponseEntity<String> changeH(String pnum, String phide){
		//String pnum = vo.getPnum();
		//String phide = vo.getPnum();
		log.info("==================================");
		log.info("pnum : " + pnum + " phide : " + phide);
		//log.info("pnum : " + pnum + " phide : " + phide);
		log.info("==================================");
		
		int check = service.changeH(pnum, phide);
		return check==1?
				new ResponseEntity<>("success", HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
