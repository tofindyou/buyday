package com.mclass.buyday.order.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userid;
	private String username;
	private String email;
	private String tel;
	private String useraddress;
	private String postcode;
	private String point;
	
	private String productId;
	private String productName;
	private String price;
	private String category;
	private String productInfo;
	
	private String orderId;
	private String order_seq;
	private String order_quantity;
	private String selected_size;
	private String delivery_status;
	private String delivery_msg;
	private String amount;
	private String payment_method;
	private Date orderDate;
	
	public OrderDTO () {}

	public OrderDTO(String userid, String username, String email, String tel, String useraddress, String postcode,
			String point, String productId, String productName, String price, String category, String productInfo,
			String orderId, String order_seq, String order_quantity, String selected_size, String delivery_status,
			String delivery_msg, String amount, String payment_method, Date orderDate) {
		super();
		this.userid = userid;
		this.username = username;
		this.email = email;
		this.tel = tel;
		this.useraddress = useraddress;
		this.postcode = postcode;
		this.point = point;
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.category = category;
		this.productInfo = productInfo;
		this.orderId = orderId;
		this.order_seq = order_seq;
		this.order_quantity = order_quantity;
		this.selected_size = selected_size;
		this.delivery_status = delivery_status;
		this.delivery_msg = delivery_msg;
		this.amount = amount;
		this.payment_method = payment_method;
		this.orderDate = orderDate;
	}

	
	
}
