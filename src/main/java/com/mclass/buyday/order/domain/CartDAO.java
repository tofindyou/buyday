package com.mclass.buyday.order.domain;

import java.util.ArrayList;
import java.util.List;

import com.mclass.buyday.product.domain.ProductDTO;

public interface CartDAO {
	boolean findCartGoods(CartDTO cartDTO);
	
	void addGoodsInCart(CartDTO cartDTO);
	
	List<CartDTO> myCartList(String userid);
	
	List<ProductDTO> myCartProductList(List<CartDTO> cartList);
	
	boolean deleteCart(CartDTO cartDTO);
	
	
	
	
}
