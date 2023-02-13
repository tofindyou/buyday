package com.mclass.buyday.order.service;

import java.util.List;

import com.mclass.buyday.order.domain.OrderDTO;

public interface OrderService {

	void insert(OrderDTO orderDTO);
	
	List<OrderDTO> list(String userid);
	
	OrderDTO read(String orderId);
	
	List<OrderDTO> orderAllList();
	
	void deliveryStart(String orderId);
	
	void deliveryEnd(String orderId);
	
	
}
