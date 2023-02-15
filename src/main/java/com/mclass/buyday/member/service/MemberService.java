package com.mclass.buyday.member.service;

import java.util.List;

import com.mclass.buyday.member.domain.LoginDTO;
import com.mclass.buyday.member.domain.MemberVO;

public interface MemberService {
	void insert(MemberVO vo);
	
	MemberVO read(String userid);
	
	int idCheck(String userid);
	
	void update(MemberVO vo);
	
	void delete(MemberVO vo);
	
	MemberVO login(LoginDTO dto);
	
	List<MemberVO> list(); // Mapper 에 인자가 필요하지 않을 때는 매개변수를 적지않는다. (memberDAOImpl 참고)
	
	MemberVO findId(MemberVO vo);
	
	MemberVO findPw(MemberVO vo);
	
	
}
