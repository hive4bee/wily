package org.coffee.service;

import java.util.List;

import org.coffee.domain.CartDTO;
import org.coffee.domain.CartProductDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.OrdersDetailDTO;
import org.coffee.domain.StartDTO;
import org.coffee.mapper.ProductsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class ProductsServiceImpl implements ProductsService {
	@Setter(onMethod_ = @Autowired)
	private ProductsMapper mapper;
	
	@Override
	public List<JoinedDTO> getCoffeeList2(StartDTO st) {
		return mapper.getCoffeeList2(st);
	}
	@Override
	public int getCoffeeTotalCount2() {
		return mapper.getCoffeeTotalCount2();
	}
	
	@Override
	public JoinedDTO viewDetail(String pnum) {
		return mapper.viewDetail(pnum);
	}
	
	@Override
	public int searchCart(String mid, String pnum) {
		return mapper.searchCart(mid, pnum);
	}
	
	@Override
	public int addToCart(String mid, String pnum, String cqty) {
		return mapper.addToCart(mid, pnum, cqty);
	}
	
	@Override
	public int updateCart(String mid, String pnum, String cqty) {
		return mapper.updateCart(mid, pnum, cqty);
	}
	@Override
	public int checkCartQuantity(String mid) {
		return mapper.checkCartQuantity(mid);
	}
	
	@Override
	public List<CartDTO> getCartList(String mid) {
		return mapper.getCartList(mid);
	}
	@Override
	public int updateProductFromCart(String cnum, String cqty) {
		return mapper.updateProductFromCart(cnum, cqty);
	}
	@Override
	public int deleteProductFromCart(String cnum) {
		return mapper.deleteProductFromCart(cnum);
	}
	
	@Override
	public List<CartProductDTO> getOrderList(String[] cnum, String mid) {
		return mapper.getOrderList(cnum, mid);
	}
	
	@Override
	public void insertOrder(OrdersDTO ordersDTO) {
		mapper.insertOrder(ordersDTO);
	}
	
	@Override
	public void deleteProductAfterOrder(String cnum) {
		mapper.deleteAfterOrder(cnum);
	}
	@Override
	public void insertOrderDetail(OrdersDetailDTO ordersDetailDTO) {
		mapper.insertOrderDetail(ordersDetailDTO);
	}
	
	@Override
	public List<OrderProductDTO> getOrderDetailList(String cnum) {
		return mapper.getOrderDetailList(cnum);
	}
	
	@Override
	public List<OrderProductDTO> getOrderDetailList2(String mid) {
		return mapper.getOrderDetailList2(mid);
	}
	
	@Override
	public int checkLike(String mid, String pnum) {
		return mapper.checkLike(mid, pnum);
	}
	
	@Override
	public int insertLike(String mid, String pnum) {
		return mapper.insertLike(mid, pnum);
	}
	
	@Override
	public int deleteLike(String mid, String pnum) {
		return mapper.deleteLike(mid, pnum);
	}
	
	@Override
	public List<JoinedDTO> viewMyLikesList(StartDTO st, String mid) {
		
		return mapper.viewMyLikesList(st, mid);
	}
	
	@Override
	public int getMyLikesTotal(String mid) {
		return mapper.getMyLikesTotal(mid);
	}
}
