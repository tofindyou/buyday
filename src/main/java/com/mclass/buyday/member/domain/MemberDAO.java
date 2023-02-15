package com.mclass.buyday.member.domain;

import java.util.List;

public interface MemberDAO {
	
	void insert(MemberVO vo);
	
	MemberVO read(String userid);
	
	int idCheck(String userid);
	
	void update(MemberVO vo);
	
	void delete(MemberVO vo);
	
	MemberVO login(LoginDTO dto);
	
	List<MemberVO> list();
	
	MemberVO findId(MemberVO vo);
	
	MemberVO findPw(MemberVO vo);
	
	
}
