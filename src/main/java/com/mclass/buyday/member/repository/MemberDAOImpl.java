package com.mclass.buyday.member.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mclass.buyday.member.domain.LoginDTO;
import com.mclass.buyday.member.domain.MemberDAO;
import com.mclass.buyday.member.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	// mybatis 를 사용할 수 있도록 해줌
	// SqlSession 인터페이스 안에는 select, insert 등의 메서드가 있음
	@Autowired
	private SqlSession sqlSession;
	
	// 매퍼 파일마다 다른 namespace(NS) 를 사용함으로써
	// 여러 매퍼에서 동일한 sql 태그를 작성하더도 충돌이 없도록 함 (클래스로 따지면 일종의 패키지)
	private final String NS = "com.mclass.buyday.mapper.memberMapper";
	
	@Override
	public void insert(MemberVO vo) {
		// TODO Auto-generated method stub
		// namespace + 매퍼의 id (".insert") 로 DAO 와 매퍼를 연결
		// 파라미터로 전달되어 오는 vo 정보는 mapper 의 쿼리 (주로 조건절)에 사용된다.
		sqlSession.insert(NS + ".insert", vo);
	}

	@Override
	public MemberVO read(String userid) {
		// TODO Auto-generated method stub
		// selectOne : Mapper 에서 1개의 데이터(레코드) 만 가져오는 경우 사용한다. 
		return sqlSession.selectOne(NS + ".read", userid);
	}

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		MemberVO vo = sqlSession.selectOne(NS + ".read", userid);
		
		// DB 에 해당 userid 값이 있으면 1, 없으면 0 리턴
		if (vo != null) {
			return 1;
		}else {
			return 0;
		}
	}

	@Override
	public void update(MemberVO vo) {
		// TODO Auto-generated method stub
		sqlSession.update(NS + ".update", vo);
	}

	@Override
	public void delete(MemberVO vo) {
		// TODO Auto-generated method stub
		sqlSession.delete(NS + ".delete", vo);
	}

	@Override
	public MemberVO login(LoginDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NS + ".login", dto);
	}

	@Override
	// AdminController 에서 회원 리스트 창 띄우는 메서드로 활용
	public List<MemberVO> list() {
		// TODO Auto-generated method stub
		// selectList : Mapper 에서 여러 개의 데이터(레코드) 를 가져오는 경우 사용한다.
		// 파라미터로 매개변수를 받아오지 않는 경우는 Mapper 쿼리문에서 조건으로 사용할 인자가 필요없는 경우이다.
		return sqlSession.selectList(NS + ".list");
	}
	
	

}
