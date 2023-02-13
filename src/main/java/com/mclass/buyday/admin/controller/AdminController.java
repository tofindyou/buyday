package com.mclass.buyday.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mclass.buyday.member.domain.MemberVO;
import com.mclass.buyday.member.service.MemberService;
import com.mclass.buyday.order.domain.OrderDTO;
import com.mclass.buyday.order.service.OrderService;
import com.mclass.buyday.product.domain.ProductDTO;
import com.mclass.buyday.product.service.ProductService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	// private 으로 Service 주입받는거 잊지말자.
	private MemberService memberService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private OrderService orderService;
	
	
	// 관리자 메인 페이지 띄우기
	@RequestMapping(value="/main", method=RequestMethod.GET)
	// 반환 타입이 void 이면 해당 URL 경로를 그대로 jsp 파일의 이름으로 사용한다.
	public void main() {
		// return "admin/main";
	}
	
	
	// 회원 리스트 창 띄우기
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void list(Model model) {
		List<MemberVO> list = memberService.list();
		model.addAttribute("list", list);
	}
	
	
	// 상품 리스트 창 띄우기
	@RequestMapping(value="/product/list", method=RequestMethod.GET)
	public void productlist(Model model) {
		List<ProductDTO> list = productService.list();
		model.addAttribute("list", list);
	}
	
	
	// 상품 등록 창 띄우기
	@RequestMapping(value="/product/insert", method=RequestMethod.GET)
	public void insert() {
		
	}
	
	
	// 카테고리 창 띄우기
	@RequestMapping(value="/category/{category}", method=RequestMethod.GET)
	public String categoryUI(@PathVariable("category") String category) {
		return "admin/category/" + category;
	}
	
	
	
	// 카테고리에 해당하는 상품을 화면에 출력하는 코드 (getJSON 방식)
	@ResponseBody
	@RequestMapping(value="/categoryList/{category}", method=RequestMethod.GET)
	public List<ProductDTO> categoryList(@PathVariable("category") String category) {
		List<ProductDTO> list = productService.categoryList(category);
		
		return list;
	}
	
	// 모든 상품을 화면에 출력하는 코드 (getJSON 방식)
	@ResponseBody
	@RequestMapping(value="/allList", method=RequestMethod.GET)
	public List<ProductDTO> allList() {
		List<ProductDTO> list = productService.allList();
		
		return list;
	}
	
	
	
	// 관리자 홈페이지에서 주문 현황 버튼 누를시 동작 (모든 유저 주문내역 확인)
	@RequestMapping(value="/orderAllList")
	public String orderAllList(Model model) {
		List<OrderDTO> orderList = orderService.orderAllList();
		model.addAttribute("orderList", orderList);
		
		return "admin/order/orderList";
	}
		
		
	// 관리자 홈페이지에서 배송시작 버튼 누를시 동작
	@RequestMapping(value="/deliveryStart/{orderId}")
	public String deleveryStart(@PathVariable("orderId") String orderId) {
		orderService.deliveryStart(orderId);
		
		return "redirect:/admin/orderAllList";
	}
	
	
}
