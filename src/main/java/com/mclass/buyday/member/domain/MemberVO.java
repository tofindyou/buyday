package com.mclass.buyday.member.domain;

import java.io.Serializable;
import java.util.Objects;

import lombok.Data;

@Data
/* Serializable : 클래스를 VO로 쓰기 위해 반드시 구현해야 하는 인터페이스 */
public class MemberVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userid;
	private String userpw;
	private String username;
	private String useraddress;
	private String email;
	private String tel;
	private String birthDate;
	private String postcode;
	private String point;

	public MemberVO() {} // 기본 생성자

	public MemberVO(String userid, String userpw, String username, String useraddress, String email, String tel,
			String birthDate, String postcode, String point) {
		super();
		this.userid = userid;
		this.userpw = userpw;
		this.username = username;
		this.useraddress = useraddress;
		this.email = email;
		this.tel = tel;
		this.birthDate = birthDate;
		this.postcode = postcode;
		this.point = point;
	} 
	
	
	
}