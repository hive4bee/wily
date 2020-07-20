package org.coffee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.coffee.domain.ImagesDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.ProductsDTO;
import org.coffee.domain.StartDTO;

public interface AdminMapper {
	public int confirmLogin(@Param("id") String id, @Param("pwd") String pwd);

	public int getNextPnum();
	
	public void insertProduct(ProductsDTO productsDTO);
	
	public void insertImage(ImagesDTO imagesDTO);

	public List<ProductsDTO> getCoffeeList(StartDTO st);

	public int getCoffeeTotalCount();
	
	public int checkOrderQuantity();

	public List<OrdersDTO> getOrderList();

	public List<OrderProductDTO> showAllOrders();

	public int changeStatus(@Param("onum") String onum, @Param("ostatus") String ostatus);

	public JoinedDTO viewProduct(String pnum);

	public int deleteProduct(String pnum);

	public int deleteImage(String pnum);

	public void modifyPro1(ProductsDTO productsDTO);

	public void updateImage(ImagesDTO imagesDTO);

	public int changeH(@Param("pnum") String pnum, @Param("phide") String phide);
	
}
