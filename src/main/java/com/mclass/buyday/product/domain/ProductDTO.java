package com.mclass.buyday.product.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class ProductDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String productId;
	private String productName;
	private String price;
	private String stock;
	private String category;
	private String productInfo;
	private Date regDate;
	private Date updateDate;
	// 여러 개의 파일을 받을 수 있도록 배열 타입으로 선언한다.
	private String[] files;
	
	public ProductDTO () {}

	public ProductDTO(String productId, String productName, String price, String stock, String category,
			String productInfo, Date regDate, Date updateDate, String[] files) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.stock = stock;
		this.category = category;
		this.productInfo = productInfo;
		this.regDate = regDate;
		this.updateDate = updateDate;
		this.files = files;
	}

	
	
}
