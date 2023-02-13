package com.mclass.buyday.order.domain;

import java.util.List;

public interface OrderDAO {

	void insert(OrderDTO orderDTO);
	
	void minusProductStock(OrderDTO orderDTO);
	
	void plusMemberPoint(OrderDTO orderDTO);
	
	List<OrderDTO> list(String userid);
	
	OrderDTO read(String orderId);
	
	List<OrderDTO> orderAllList();
	
	void deliveryStart(String orderId);
	
	void deliveryEnd(String orderId);
	
	
}
