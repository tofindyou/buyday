package com.mclass.buyday.order.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mclass.buyday.member.domain.MemberVO;
import com.mclass.buyday.order.domain.CartDTO;
import com.mclass.buyday.order.domain.OrderDTO;
import com.mclass.buyday.order.service.CartService;
import com.mclass.buyday.order.service.OrderService;
import com.mclass.buyday.product.domain.ProductDTO;
import com.mclass.buyday.product.service.ProductService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private OrderService orderService;
	
	
	// 장바구니 담기 버튼 누를시 동작 (ajax 방식)
	@ResponseBody
	@RequestMapping(value="/cart/{productId}", method=RequestMethod.POST)
	public String addGoodsInCart(@PathVariable("productId") String productId, HttpSession session) {
		// 로그인시 session.getAttribute() 의 세션의 키에 "login" 이름으로 저장했던 멤버 정보 값들을 가져온다.
		// session.getAttribute()의 반환타입은 Object 이므로 (MemberVO) 로 형변환 해주어야 한다.
		MemberVO vo = (MemberVO) session.getAttribute("login"); // 멤버 vo 에 담는다.
		String userid = vo.getUserid(); // vo 에 있는 userid 값만 따로 변수에 담는다.
		
		CartDTO cartDTO = new CartDTO(); // 카트 정보를 사용하기 위해 카트 객체를 생성해야 한다.
		
		// 가져온 userid 와 productId 를 CartDTO 에 담는다.
		cartDTO.setUserid(userid);
		cartDTO.setProductId(productId);
		
		// 유저 장바구니에 상품이 있으면 true, 없으면 false 를 반환한다.
		boolean isAlreadyRegistered = cartService.findCartGoods(cartDTO);
		
		if (isAlreadyRegistered) { // 장바구니에 상품이 있으면
			return "already_registered"; // (이미 해당 상품이 등록되어 있다는 알림창)
			
		} else { // 장바구니에 상품이 없으면
			cartService.addGoodsInCart(cartDTO); // 장바구니에 해당 상품을 담는다.
			return "add_success"; // (해당 상품이 등록되었다는 알림창)
		}
	}
	
	
	// 장바구니 창 띄우기
	@RequestMapping(value="/myCart/{userid}", method=RequestMethod.GET)
	public String myCart(@PathVariable("userid") String userid, Model model) {
		// 카트 정보, 상품 정보 List 2가지를 각각 분리하여 관리하기 위해 Map 을 활용한다.
		Map<String, List> cartMap = cartService.myCart(userid);
		
		model.addAttribute("cartMap", cartMap);
		
		return "member/order/myCart";
	}
	
	
	// 주문 페이지 창 띄우기 (상품 상세보기 창이나 장바구니 창에서 상품을 1종류씩 구매)
	@RequestMapping(value="/orderSheet")
	// view.jsp 에서 파라미터로 넘어오는 값 4가지
	// : productId, point, selecter_size, order_quantity (그리고 Session 의 userid)
	public String orderSheet(ProductDTO productDTO, HttpSession session, Model model,
			@ModelAttribute("point") String point,
			@ModelAttribute("selected_size") String selected_size,
			@ModelAttribute("order_quantity") String order_quantity) {
		
		productDTO = productService.read(productDTO.getProductId());
		
		MemberVO memberVO = (MemberVO) session.getAttribute("login");
		
		model.addAttribute("productInfo", productDTO);
		model.addAttribute("memberInfo", memberVO);
		// point : 해당 상세보기 상품의 1/100 가격으로 계산된 값임 (fmt:parseNumber 로 계산함)
		model.addAttribute("point", point);
		model.addAttribute("selected_size", selected_size);
		model.addAttribute("order_quantity", order_quantity);
		
		return "member/order/orderSheet";
	}
	
	
	// 결제하기 버튼 누를시 동작
	// 넘어오는 값 :
	// orderId, productId,
	// order_quantity, selected_size,
	// userid, username, email, tel, useraddress, postcode, price, point, delivery_msg,
	// payment_method, amount (대충 다 넘어온다.)
	@RequestMapping(value="/orderConfirm", method=RequestMethod.POST)
	public String orderInsert(OrderDTO orderDTO, ProductDTO productDTO, MemberVO memberVO, Model model,
			@ModelAttribute("detailAddress") String detailAddress,
			@ModelAttribute("price") String price) { // 상품 가격이 계속 개별 가격으로 찍혀서 직접 넣음.
		
		String address = memberVO.getUseraddress() + " " + detailAddress;
		
		if (detailAddress == null) { // 상세주소를 전달받지 않은 경우
			address = memberVO.getUseraddress(); // 도로명 주소만 변수로 담는다.
		}
		
		// orderDTO 의 useraddress 에 변수 address 의 값을 담는다.
		orderDTO.setUseraddress(address);
		
		productDTO = productService.read(productDTO.getProductId());
		
		// orderDTO 에 안 들어간 정보 있으면 꼼꼼히 넣어줌.
		orderDTO.setProductName(productDTO.getProductName());
		orderDTO.setCategory(productDTO.getCategory());
		orderDTO.setProductInfo(productDTO.getProductInfo());
		
		orderDTO.setDelivery_status("0");
		
		// SetOrder 에 값을 넣고, 상품 판매 수량만큼 재고 낮추고, 유저 포인트 부여하기
		orderService.insert(orderDTO);
		
		model.addAttribute("orderDTO", orderDTO);
		model.addAttribute("price", price); // 상품 가격은 개별적으로 뿌림.
		
		return "member/order/orderConfirm";
	}
	
	
	// 주문/배송 버튼 누를시 동작 (주문내역 리스트 창 띄우기)
	@RequestMapping(value="/list/{userid}", method=RequestMethod.GET)
	public String list(@PathVariable("userid") String userid, Model model) {
		List<OrderDTO> orderList = orderService.list(userid);
		model.addAttribute("orderList", orderList);
		
		return "member/order/orderList";
	}
	
	
	// 상품 이름 누를시 동작 (자세히보기)
	@RequestMapping(value="/orderRead/{orderId}", method=RequestMethod.GET)
	public String orderRead(@PathVariable("orderId") String orderId, Model model) {
		// 주문 정보 하나만 꺼내오는 메서드
		OrderDTO orderDTO = orderService.read(orderId);
		
		int price = Integer.parseInt(orderDTO.getPrice());
		int order_quantity = Integer.parseInt(orderDTO.getOrder_quantity());
		
		int Price = price * order_quantity;
		
		
		model.addAttribute("orderDTO", orderDTO);
		model.addAttribute("price", Price); // 상품 가격은 개별적으로 계산해서 뿌려야함.
		
		return "member/order/orderConfirm";
	}
	
	
	// 배송완료 누를시 동작
	@RequestMapping(value="/deliveryEnd/{orderId}")
	public String deliveryEnd(@PathVariable("orderId") String orderId, HttpSession session) {
		MemberVO memberVO = (MemberVO) session.getAttribute("login");
		String userid = memberVO.getUserid();
		
		orderService.deliveryEnd(orderId);
		
		return "redirect:/order/list/" + userid;
	}
	
	

}
