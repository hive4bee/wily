package org.coffee.service;

import java.util.List;

import org.coffee.domain.ImagesDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.ProductsDTO;
import org.coffee.domain.StartDTO;

public interface AdminService {
	public int confirmLogin(String id, String pwd);
	
	public int getNextPnum();

	public void insertProduct(ProductsDTO productsDTO);

	public void insertImage(ImagesDTO imagesDTO);

	public List<ProductsDTO> getCoffeeList(StartDTO st);

	public int getCoffeeTotalCount();

	public int checkOrderQuantity();

	public List<OrdersDTO> getOrderList();

	public List<OrderProductDTO> showAllOrders();

	public int changeStatus(String onum, String ostatus);

	public JoinedDTO viewProduct(String pnum);

	public int deleteProduct(String pnum);

	public int deleteImage(String pnum);

	public void modifyPro1(ProductsDTO productsDTO);

	public void updateImage(ImagesDTO imagesDTO);

	public int changeH(String pnum, String phide);
}
