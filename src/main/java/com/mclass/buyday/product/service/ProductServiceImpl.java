package com.mclass.buyday.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mclass.buyday.product.domain.ProductDAO;
import com.mclass.buyday.product.domain.ProductDTO;

@Service
// Service 선언하는거 잊지말자.
public class ProductServiceImpl implements ProductService {

	@Autowired
	// private 으로 DAO 주입받는거 잊지말자.
	private ProductDAO productDAO;
	
	
	@Override
	// AdminController 에서 상품 리스트 창 띄우는 메서드로 활용
	public List<ProductDTO> list() {
		// TODO Auto-generated method stub
		return productDAO.list();
	}


	@Override
	public ProductDTO read(String productId) {
		// TODO Auto-generated method stub
		return productDAO.read(productId);
	}


	@Override
	public ProductDTO updateUI(String productId) {
		// TODO Auto-generated method stub
		// 상품 정보를 화면에 띄우는 로직만 있으면 되니까 기존에 작성한 productDAO.read 로 연결한다.
		return productDAO.read(productId);
	}


	@Override
	public void update(ProductDTO dto) {
		// TODO Auto-generated method stub
		productDAO.update(dto);
	}


	@Override
	public void delete(String productId) {
		// TODO Auto-generated method stub
		productDAO.delete(productId);
	}


	@Override
	public void insert(ProductDTO dto) {
		// TODO Auto-generated method stub
		productDAO.insert(dto);
		
	}


	@Override
	public List<ProductDTO> categoryList(String category) {
		// TODO Auto-generated method stub
		return productDAO.categoryList(category);
	}


	@Override
	public List<ProductDTO> allList() {
		// TODO Auto-generated method stub
		return productDAO.allList();
	}
	


}
