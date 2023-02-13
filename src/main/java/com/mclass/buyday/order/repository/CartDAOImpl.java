package com.mclass.buyday.order.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mclass.buyday.order.domain.CartDAO;
import com.mclass.buyday.order.domain.CartDTO;
import com.mclass.buyday.product.domain.ProductDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Autowired
	private SqlSession sqlSession;
	
	private final String NS = "com.mclass.buyday.mapper.orderMapper";

	@Override
	public boolean findCartGoods(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		String result = sqlSession.selectOne(NS + ".findCartGoods", cartDTO);
		
		return Boolean.parseBoolean(result);
	}

	@Override
	public void addGoodsInCart(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		System.out.println("cartDTO : " + cartDTO);

		sqlSession.insert(NS + ".addGoodsInCart", cartDTO);
	}

	@Override
	public List<CartDTO> myCartList(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + ".myCartList", userid);
	}

	@Override
	public List<ProductDTO> myCartProductList(List<CartDTO> cartList) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + ".myCartProductList", cartList);
	}

	@Override
	public boolean deleteCart(CartDTO cartDTO) {
		// TODO Auto-generated method stub
		// 기본적으로 sqlSession.delete() 는 반환값으로
		// 삭제 됐으면 1, 삭제되지 않았으면 0 을 반환한다.
		int result = sqlSession.delete(NS + ".deleteCart", cartDTO);
		
		if(result == 1) { // 삭제된 경우
			return true;
			
		} else { // 삭제되지 않은 경우
			return false;
		}
	}

	
	
}
