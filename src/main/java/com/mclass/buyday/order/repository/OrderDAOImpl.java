package com.mclass.buyday.order.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mclass.buyday.member.domain.MemberVO;
import com.mclass.buyday.order.domain.OrderDAO;
import com.mclass.buyday.order.domain.OrderDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private final String NS = "com.mclass.buyday.mapper.orderMapper";
	

	@Override
	public void insert(OrderDTO orderDTO) {
		// TODO Auto-generated method stub
		sqlSession.insert(NS + ".insert", orderDTO);
	}

	@Override
	public void minusProductStock(OrderDTO orderDTO) {
		// TODO Auto-generated method stub
		sqlSession.update(NS + ".minusProductStock", orderDTO);
	}

	@Override
	public void plusMemberPoint(OrderDTO orderDTO) {
		// TODO Auto-generated method stub
		sqlSession.update(NS + ".plusMemberPoint", orderDTO);
	}

	@Override
	public List<OrderDTO> list(String userid) {
		// TODO Auto-generated method stub
		List<OrderDTO> list = sqlSession.selectList(NS + ".list", userid);
		
		if (list.size() == 0) {
			return null;
		}else {
			return list;
		}
	}

	@Override
	public OrderDTO read(String orderId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NS + ".read", orderId);
	}

	@Override
	public List<OrderDTO> orderAllList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + ".orderAllList");
	}

	@Override
	public void deliveryStart(String orderId) {
		// TODO Auto-generated method stub
		sqlSession.update(NS + ".deliveryStart", orderId);
	}

	@Override
	public void deliveryEnd(String orderId) {
		// TODO Auto-generated method stub
		sqlSession.update(NS + ".deliveryEnd", orderId);
	}

}
