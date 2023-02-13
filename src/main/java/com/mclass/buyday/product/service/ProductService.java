package com.mclass.buyday.product.service;

import java.util.List;

import com.mclass.buyday.product.domain.ProductDTO;

public interface ProductService {
	List<ProductDTO> list();
	
	ProductDTO read(String productId);
	
	ProductDTO updateUI(String productId);
	
	void update(ProductDTO dto);
	
	void delete(String productId);
	
	void insert(ProductDTO dto);
	
	List<ProductDTO> categoryList(String category);
	
	List<ProductDTO> allList();
	
}
