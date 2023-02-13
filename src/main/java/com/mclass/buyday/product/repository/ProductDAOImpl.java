package com.mclass.buyday.product.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mclass.buyday.product.domain.ProductDAO;
import com.mclass.buyday.product.domain.ProductDTO;

@Repository
// Repository 선언하는거 잊지말자.
public class ProductDAOImpl implements ProductDAO{

	@Autowired
	// private 으로 SqlSession 주입받는거 잊지말자.
	private SqlSession sqlSession;
	
	private final String NS = "com.mclass.buyday.mapper.productMapper";
	
	
	@Override
	// AdminController 에서 상품 리스트 창 띄우는 메서드로 활용
	public List<ProductDTO> list() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + ".list");
	}

	@Override
	public ProductDTO read(String productId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NS + ".read", productId);
	}

	@Override
	public void update(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update(NS + ".update", dto);
	}


	@Override
	public void delete(String productId) {
		// TODO Auto-generated method stub
		sqlSession.delete(NS + ".delete", productId);
	}

	@Override
	public void insert(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert(NS + ".insert", dto);
	}

	@Override
	public List<ProductDTO> categoryList(String category) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + ".categoryList", category);
	}

	@Override
	public List<ProductDTO> allList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + ".allList");
	}

}
