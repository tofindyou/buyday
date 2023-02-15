package com.mclass.buyday.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mclass.buyday.member.domain.LoginDTO;
import com.mclass.buyday.member.domain.MemberDAO;
import com.mclass.buyday.member.domain.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	
	@Override
	// DAO 로직이 간단한 이유는 동시 처리 작업없이 회원가입 처리 하나만 하기 때문이다.
	public void insert(MemberVO vo) {
		// TODO Auto-generated method stub
		memberDAO.insert(vo);
	}

	@Override
	public MemberVO read(String userid) {
		// TODO Auto-generated method stub
		return memberDAO.read(userid);
	}

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		return memberDAO.idCheck(userid);
	}

	@Override
	public void update(MemberVO vo) {
		// TODO Auto-generated method stub
		memberDAO.update(vo);
	}

	@Override
	public void delete(MemberVO vo) {
		// TODO Auto-generated method stub
		memberDAO.delete(vo);
	}

	@Override
	public MemberVO login(LoginDTO dto) {
		// TODO Auto-generated method stub
		return memberDAO.login(dto);
	}

	@Override
	// AdminController 에서 회원 리스트 창 띄우는 메서드로 활용
	public List<MemberVO> list() {
		// TODO Auto-generated method stub
		return memberDAO.list();
	}

	@Override
	public MemberVO findId(MemberVO vo) {
		// TODO Auto-generated method stub
		return memberDAO.findId(vo);
	}

	@Override
	public MemberVO findPw(MemberVO vo) {
		// TODO Auto-generated method stub
		return memberDAO.findPw(vo);
	}
	
	

}
