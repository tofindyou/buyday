package com.mclass.buyday.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mclass.buyday.order.domain.CartDAO;
import com.mclass.buyday.order.domain.CartDTO;
import com.mclass.buyday.order.domain.OrderDTO;
import com.mclass.buyday.product.domain.ProductDTO;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDAO cartDAO;
	

	@Override
	public boolean findCartGoods(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		return cartDAO.findCartGoods(cartDTO);
	}

	@Override
	public void addGoodsInCart(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		cartDAO.addGoodsInCart(cartDTO);
	}

	@Override
	public Map<String, List> myCart(String userid) {
		// TODO Auto-generated method stub
		// 맵 객체를 사용하기위해서 맵을 선언한다.
		Map<String, List> cartMap = new HashMap<String, List>();
		
		
		// 하나의 List 정보에 카트 정보를 담는다.
		List<CartDTO> cartList = cartDAO.myCartList(userid);
		// 만약 장바구니에 상품이 하나도 없을경우 null 을 반환한다.
		if(cartList.size() == 0) {
			return null;
		}
		
		// 또 다른 하나의 List 정보에는 상품 정보를 담는다.
		List<ProductDTO> productList = cartDAO.myCartProductList(cartList);
		
		
		// 생성한 2개의 List 를 Map 에 담는다.
		cartMap.put("cartList", cartList);
		cartMap.put("productList", productList);
			
		return cartMap;
	}

	@Override
	public boolean deleteCart(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		return cartDAO.deleteCart(cartDTO);
	}

	
	
}
