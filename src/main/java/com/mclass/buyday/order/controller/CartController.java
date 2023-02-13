package com.mclass.buyday.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mclass.buyday.member.domain.MemberVO;
import com.mclass.buyday.order.domain.CartDTO;
import com.mclass.buyday.order.service.CartService;
import com.mclass.buyday.product.domain.ProductDTO;

@Controller
@RequestMapping(value="cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	
	// 장바구니 삭제하기 버튼 누를시 동작 (ajax 방식)
	@ResponseBody
	@RequestMapping(value="/deleteCart", method=RequestMethod.POST)
	public String deleteCart(CartDTO cartDTO) {
		
		boolean result = cartService.deleteCart(cartDTO);
		
		if (result) { // 삭제 된 경우 반환
			return "OK";
			
		} else { // 삭제 되지 않은 경우 반환
			return "NO";
		}
	}

	
}
