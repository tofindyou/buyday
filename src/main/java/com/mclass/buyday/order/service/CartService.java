package com.mclass.buyday.order.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mclass.buyday.order.domain.CartDTO;
import com.mclass.buyday.product.domain.ProductDTO;

public interface CartService {
	boolean findCartGoods(CartDTO cartDTO);
	
	void addGoodsInCart(CartDTO cartDTO);
	
	Map<String, List> myCart(String userid);
	
	boolean deleteCart(CartDTO cartDTO);
	
	
	
}
