package org.coffee.service;

import java.util.List;

import org.coffee.domain.ImagesDTO;
import org.coffee.domain.JoinedDTO;
import org.coffee.domain.OrderProductDTO;
import org.coffee.domain.OrdersDTO;
import org.coffee.domain.ProductsDTO;
import org.coffee.domain.StartDTO;
import org.coffee.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService {
	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	@Override
	public int confirmLogin(String id, String pwd) {
		return mapper.confirmLogin(id, pwd);
	}
	
	@Override
	public int getNextPnum() {
		return mapper.getNextPnum();
	}
	
	@Override
	public void insertProduct(ProductsDTO productsDTO) {
		mapper.insertProduct(productsDTO);
	}
	
	@Override
	public void insertImage(ImagesDTO imagesDTO) {
		mapper.insertImage(imagesDTO);
	}
	
	@Override
	public List<ProductsDTO> getCoffeeList(StartDTO st) {
		return mapper.getCoffeeList(st);
	}
	
	@Override
	public int getCoffeeTotalCount() {
		return mapper.getCoffeeTotalCount();
	}
	
	@Override
	public int checkOrderQuantity() {
		return mapper.checkOrderQuantity();
	}
	
	@Override
	public List<OrdersDTO> getOrderList() {
		return mapper.getOrderList();
	}
	
	@Override
	public List<OrderProductDTO> showAllOrders() {
		return mapper.showAllOrders();
	}
	
	@Override
	public int changeStatus(String onum, String ostatus) {
		return mapper.changeStatus(onum, ostatus);
	}
	
	@Override
	public JoinedDTO viewProduct(String pnum) {
		return mapper.viewProduct(pnum);
	}
	
	@Override
	public int deleteProduct(String pnum) {
		return mapper.deleteProduct(pnum);
	}
	
	@Override
	public int deleteImage(String pnum) {
		return mapper.deleteImage(pnum);
	}

	@Override
	public void modifyPro1(ProductsDTO productsDTO) {
		mapper.modifyPro1(productsDTO);
	}
	
	@Override
	public void updateImage(ImagesDTO imagesDTO) {
		mapper.updateImage(imagesDTO);
	}
	
	@Override
	public int changeH(String pnum, String phide) {
		return mapper.changeH(pnum, phide);
	}
}
