package org.coffee.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.coffee.domain.CartDTO;
import org.coffee.domain.CartProductDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.MembersDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.OrdersDetailDTO;
import org.coffee.domain.ProductPageDTO;
import org.coffee.domain.StartDTO;
import org.coffee.service.MembersService;
import org.coffee.service.ProductsService;
import org.coffee.service.ShopsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/products/*")
@AllArgsConstructor
public class ProductsController {

	@Setter(onMethod_ = @Autowired)
	private ProductsService service;
	
	@Setter(onMethod_ = @Autowired)
	private ShopsService shopsService;
	
	@Setter(onMethod_ = @Autowired)
	private MembersService membersService;
	
	@GetMapping("/coffeeList2")
	public void productList(StartDTO st, Model model) {
		st.setStartRecord((st.getPage()-1)*8+1);
		List<JoinedDTO> list = service.getCoffeeList2(st);
		log.info("=======================================");
		list.forEach(a -> log.info(a));
		log.info("=======================================");
		model.addAttribute("list", list);
		int coffeeTotal = service.getCoffeeTotalCount2();
		model.addAttribute("pageMaker", new ProductPageDTO(st, coffeeTotal));
	}
	@GetMapping("/viewMyLikes")
	public void viewMyLikes(@RequestParam("mid") String mid, StartDTO st, Model model) {
		st.setStartRecord((st.getPage()-1)*8+1);
		List<JoinedDTO> list = service.viewMyLikesList(st, mid);
		log.info("=======================================");
		list.forEach(a -> log.info(a));
		log.info("=======================================");
		model.addAttribute("list", list);
		int coffeeTotal = service.getMyLikesTotal(mid);
		model.addAttribute("pageMaker", new ProductPageDTO(st, coffeeTotal));
	}
	
	@GetMapping("/viewDetail")
	public void viewDetail(@RequestParam("pnum") String pnum, Model model) {
		model.addAttribute("dto", service.viewDetail(pnum));
	}
	
	@GetMapping("/addToCart")
	@ResponseBody
	public ResponseEntity<String> addToCart(String mid, String pnum, String cqty){
		log.info("=========================================");
		log.info("mid : " + mid + " pnum : " + pnum + " cqty : " + cqty);
		log.info("=========================================");
		int check = 0;
		if(service.searchCart(mid, pnum) == 1) {
			check = service.updateCart(mid, pnum, cqty);
		}else {
			check = service.addToCart(mid, pnum, cqty);
		}
		return check == 1 ?
			new ResponseEntity<>("success", HttpStatus.OK) : 
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	@GetMapping("/checkCartQuantity")
	@ResponseBody
	public ResponseEntity<String> checkCartQuantity(String mid){
		log.info("====================================");
		log.info("mid : " + mid);
		log.info("====================================");
		int cnt = service.checkCartQuantity(mid);
		return new ResponseEntity<>(cnt+"", HttpStatus.OK);
	}
	
	@GetMapping("/viewCart")
	public void viewCart(@RequestParam("mid") String mid, @CookieValue(value="jAddr", required = false) Cookie jAddr, Model model) {
		
		
		
		if(jAddr!=null) {
			String snum = jAddr.getValue();
			log.info("==================================");
			model.addAttribute("addr", shopsService.getAddress(snum));
			log.info("==================================");
		}
		
		model.addAttribute("list", service.getCartList(mid));
	}
	@GetMapping("/updateProductFromCart")
	@ResponseBody
	public ResponseEntity<String> updateProductFromCart(String cnum, String cqty){
		log.info("==================================");
		log.info("cnum : " + cnum + " cqty : " + cqty);
		log.info("==================================");
		int check = service.updateProductFromCart(cnum, cqty);
		return check == 1 ?
			new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/mid/{mid}")
	@ResponseBody
	public ResponseEntity<List<CartDTO>> getCartList2(@PathVariable("mid") String mid){
		log.info("getCartList ......");
		List<CartDTO> list = service.getCartList(mid);
		log.info("////////////////////////////////////");
		list.forEach(a -> log.info(a));
		log.info("////////////////////////////////////");
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/deleteProductFromCart")
	@ResponseBody
	public ResponseEntity<String> deleteProductFromCart(String cnum){
		int check = service.deleteProductFromCart(cnum);
		return check==1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/cooookie")
	public String makeCookie(String snum, HttpServletResponse response) {
		log.info("====================================");
		log.info("snum : " + snum);
		log.info("====================================");
		
//		log.info("====================================");
//		log.info("replace addr : " + addr.replaceAll(" ", "&nbsp;"));
//		log.info("====================================");
//		
//		log.info("====================================");
//		String[] splited = addr.split(" ");
//		String imsiStr = "";
//		for(int i=0; i<splited.length; i++) {
//			
//			if(i==splited.length-1) {
//				imsiStr+=(splited[i]);
//			}else {
//				imsiStr+=(splited[i]+"|");
//			}
//		}
//		log.info("imsiStr : " + imsiStr);
//		log.info("====================================");
		
		Cookie jAddr = new Cookie("jAddr", snum);
		jAddr.setMaxAge(60*60*2);
		response.addCookie(jAddr);
		return "redirect:/products/coffeeList2";
	}
	
	@GetMapping("/orderForm")
	public void orderForm(String[] cnum, String mid, String addr, Model model) {
		log.info("======================================");
		log.info("cnum : " + cnum);
		log.info("mid : " + mid);
		log.info("addr : " + addr);
		log.info("======================================");
		MembersDTO mdto = membersService.getUserInfo(mid);
		List<CartProductDTO> list = service.getOrderList(cnum, mid);
		model.addAttribute("list", list);
		model.addAttribute("mdto", mdto);
		model.addAttribute("addr", addr);
	}
	
	@GetMapping("/viewOrderResult")
	public void viewOrderResult(@ModelAttribute("ordersDTO") OrdersDTO ordersDTO, 
			@RequestParam("pnum") String[] pnum, 
			@RequestParam("oqty") String[] oqty, 
			@RequestParam("cnum") String[] cnum, @CookieValue(value="jAddr", required = false) Cookie jAddr, Model model) {
		log.info("===========================================");
		log.info("ordersDTO : " + ordersDTO);
		log.info("===========================================");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddkkmmss");
		String onum = "D"+sdf.format(date)+"_U"+ordersDTO.getMid();
		ordersDTO.setOnum(onum);
		service.insertOrder(ordersDTO);
		OrdersDetailDTO ordersDetailDTO = null;
		for(int i=0; i<pnum.length; i++) {
			ordersDetailDTO = new OrdersDetailDTO();
			ordersDetailDTO.setPnum(Long.parseLong(pnum[i]));
			ordersDetailDTO.setOnum(onum);
			ordersDetailDTO.setOqty(Long.parseLong(oqty[i]));
			service.insertOrderDetail(ordersDetailDTO);
			service.deleteProductAfterOrder(cnum[i]);
		}
		if(jAddr !=null) {
			jAddr.setMaxAge(0);
		}
		model.addAttribute("list", service.getOrderDetailList(onum));
	}
	
	@GetMapping("/likes")
	@ResponseBody
	public ResponseEntity<String> likes(String mid, String pnum) {
		log.info("==============================================");
		log.info("mid : " + mid + " pnum : " + pnum);
		log.info("==============================================");
		
		int check = service.checkLike(mid, pnum);
		return check==1 ?
				new ResponseEntity<>("exist", HttpStatus.OK) :
					new ResponseEntity<>("no",HttpStatus.OK);
	}
	
	@GetMapping("/insertLike")
	@ResponseBody
	public ResponseEntity<String> insertLike(String mid, String pnum){
		log.info("==============================================");
		log.info("mid : " + mid + " pnum : " + pnum);
		log.info("==============================================");
		return service.insertLike(mid, pnum)==1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/deleteLike")
	@ResponseBody
	public ResponseEntity<String> deleteLike(String mid, String pnum){
		log.info("==============================================");
		log.info("mid : " + mid + " pnum : " + pnum);
		log.info("==============================================");
		return service.deleteLike(mid, pnum)==1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
