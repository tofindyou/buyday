package com.mclass.buyday.product.domain;

import java.util.List;

public interface ProductDAO {
	List<ProductDTO> list();
	
	ProductDTO read(String productId);
	
	void update(ProductDTO dto);
	
	void delete(String productId);
	
	void insert(ProductDTO dto);
	
	List<ProductDTO> categoryList(String category);
	
	List<ProductDTO> allList();
	
	
}
