package com.mclass.buyday.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mclass.buyday.member.domain.MemberDAO;
import com.mclass.buyday.member.domain.MemberVO;
import com.mclass.buyday.order.domain.CartDAO;
import com.mclass.buyday.order.domain.CartDTO;
import com.mclass.buyday.order.domain.OrderDAO;
import com.mclass.buyday.order.domain.OrderDTO;
import com.mclass.buyday.product.domain.ProductDAO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderDAO orderDAO;
	
	@Autowired
	private CartDAO cartDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	
	@Transactional
	@Override
	public void insert(OrderDTO orderDTO) {
		// TODO Auto-generated method stub
		orderDAO.insert(orderDTO); // 주문 내역 삽입하기
		
		orderDAO.minusProductStock(orderDTO); // 상품 수량 줄이기
		
		orderDAO.plusMemberPoint(orderDTO); // 회원 포인트 올리기
		
		
		// 매개변수를 cartDTO 로 바꿔서 기존 메서드를 이용한다.
		CartDTO cartDTO = new CartDTO();
		cartDTO.setCartid(orderDTO.getUserid());
		cartDTO.setProductId(orderDTO.getProductId());
		
		cartDAO.deleteCart(cartDTO); // 카트 내역 삭제하기
	}


	@Override
	public List<OrderDTO> list(String userid) {
		// TODO Auto-generated method stub
		return orderDAO.list(userid);
	}


	@Override
	public OrderDTO read(String orderId) {
		// TODO Auto-generated method stub
		return orderDAO.read(orderId);
	}


	@Override
	public List<OrderDTO> orderAllList() {
		// TODO Auto-generated method stub
		return orderDAO.orderAllList();
	}


	@Override
	public void deliveryStart(String orderId) {
		// TODO Auto-generated method stub
		orderDAO.deliveryStart(orderId);
	}


	@Override
	public void deliveryEnd(String orderId) {
		// TODO Auto-generated method stub
		orderDAO.deliveryEnd(orderId);
	}

}
