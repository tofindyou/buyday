package com.mclass.buyday.member.domain;

import lombok.Data;

@Data
// 회원이 로그인 버튼을 누를때 전달되는 id, pw 정보를 담는 DTO 를 따로 만든다.
// 안 만들고 해도되는데 실무 개발에서는 만든다고 한다. (보안 문제 인듯하다..)
public class LoginDTO {
	private String userid;
	private String userpw;
	
	public LoginDTO() {} // 기본생성자
	
	public LoginDTO(String userid, String userpw) { // 인자생성자
		super();
		this.userid = userid;
		this.userpw = userpw;
	}
	
}
