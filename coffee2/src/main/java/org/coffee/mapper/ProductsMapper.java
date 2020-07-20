package org.coffee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.coffee.domain.CartDTO;
import org.coffee.domain.CartProductDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.OrdersDetailDTO;
import org.coffee.domain.StartDTO;

public interface ProductsMapper {
	public List<JoinedDTO> getCoffeeList2(StartDTO st);
	
	public int getCoffeeTotalCount2();

	public JoinedDTO viewDetail(String pnum);
	
	public int searchCart(@Param("mid") String mid, @Param("pnum") String pnum);

	public int addToCart(@Param("mid") String mid, @Param("pnum") String pnum, @Param("cqty") String cqty);
	
	public int updateCart(@Param("mid") String mid, @Param("pnum") String pnum, @Param("cqty") String cqty);
	
	public int checkCartQuantity(String mid);

	public List<CartDTO> getCartList(String mid);

	public int updateProductFromCart(@Param("cnum") String cnum, @Param("cqty") String cqty);

	public int deleteProductFromCart(String cnum);
	
	public List<CartProductDTO> getOrderList(@Param("cnum") String[] cnum, @Param("mid") String mid);

	public void insertOrder(OrdersDTO ordersDTO);

	public void deleteAfterOrder(String cnum);

	public void insertOrderDetail(OrdersDetailDTO ordersDetailDTO);

	public List<OrderProductDTO> getOrderDetailList(String cnum);

	public List<OrderProductDTO> getOrderDetailList2(String mid);

	public int checkLike(@Param("mid") String mid, @Param("pnum") String pnum);

	public int insertLike(@Param("mid") String mid, @Param("pnum") String pnum);
	
	public int deleteLike(@Param("mid") String mid, @Param("pnum") String pnum);

	public List<JoinedDTO> viewMyLikesList(@Param("st") StartDTO st, @Param("mid") String mid);

	public int getMyLikesTotal(String mid);
}
