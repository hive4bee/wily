package org.coffee.service;

import java.util.List;

import org.coffee.domain.CartDTO;
import org.coffee.domain.CartProductDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.OrdersDetailDTO;
import org.coffee.domain.StartDTO;

public interface ProductsService {
	public List<JoinedDTO> getCoffeeList2(StartDTO st);

	public int getCoffeeTotalCount2();

	public JoinedDTO viewDetail(String pnum);
	
	public int searchCart(String mid, String pnum);

	public int addToCart(String mid, String pnum, String cqty);

	public int updateCart(String mid, String pnum, String cqty);

	public int checkCartQuantity(String mid);

	public List<CartDTO> getCartList(String mid);

	public int updateProductFromCart(String cnum, String cqty);

	public int deleteProductFromCart(String cnum);
	
	public List<CartProductDTO> getOrderList(String[] cnum, String mid);

	public void insertOrder(OrdersDTO ordersDTO);

	public void deleteProductAfterOrder(String cnum);

	public void insertOrderDetail(OrdersDetailDTO ordersDetailDTO);

	public List<OrderProductDTO> getOrderDetailList(String cnum);

	public List<OrderProductDTO> getOrderDetailList2(String mid);

	public int checkLike(String mid, String pnum);

	public int insertLike(String mid, String pnum);

	public int deleteLike(String mid, String pnum);

	public List<JoinedDTO> viewMyLikesList(StartDTO st, String mid);

	public int getMyLikesTotal(String mid);
}
