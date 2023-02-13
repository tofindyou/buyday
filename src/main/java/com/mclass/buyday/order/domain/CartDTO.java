package com.mclass.buyday.order.domain;

import java.io.Serializable;
import java.util.Date;

import com.mclass.buyday.order.domain.CartDTO;

import lombok.Data;

@Data
public class CartDTO implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userid;
	private String productId;
	private String cartid;
	private	String cart_quantity;
	private Date regDate;
	
	public CartDTO () {}

	public CartDTO(String userid, String productId, String cartid, String cart_quantity, Date regDate) {
		super();
		this.userid = userid;
		this.productId = productId;
		this.cartid = cartid;
		this.cart_quantity = cart_quantity;
		this.regDate = regDate;
	}


	
}