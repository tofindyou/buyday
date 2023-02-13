package com.mclass.buyday.product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mclass.buyday.product.domain.ProductDTO;
import com.mclass.buyday.product.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	
	// 상품 상세 정보 창 띄우기
	@RequestMapping(value="/read/{productId}", method=RequestMethod.GET)
	public String read(@PathVariable("productId") String productId, Model model) {
		ProductDTO dto = productService.read(productId);
		model.addAttribute("productInfo", dto);
		
		return "admin/product/read";
	}
	
	
	// 상품 수정 정보 창 띄우기
	@RequestMapping(value="/update/{productId}", method=RequestMethod.GET)
	public String update(@PathVariable("productId") String productId, Model model) {
		ProductDTO dto = productService.updateUI(productId);
		model.addAttribute("productInfo", dto);
		
		return "admin/product/update";
	}
	
	
	// 상품수정 버튼 누를시 동작
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(ProductDTO dto) {
		productService.update(dto);
		
		return "redirect:/product/read/" + dto.getProductId();
	}
	
	
	// 상품삭제 버튼 누를시 동작
	@RequestMapping(value="/delete/{productId}")
	public String delete(@PathVariable("productId") String productId) {
		productService.delete(productId);
		
		return "redirect:/admin/product/list";
	}
	
	
	// 상품등록 버튼 누를시 동작
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insert(ProductDTO dto) {
		productService.insert(dto);
		
		return "redirect:/product/read/" + dto.getProductId();
	}
	
	
	// 상품 자세히 보기 창 띄우기 (유저가 상품 썸네일을 누를거나 상품명 버튼 누를시 동작)
	@RequestMapping(value="/view/{productId}", method=RequestMethod.GET)
	public String productView(@PathVariable("productId") String productId, Model model) {
		// 상품 정보만 출력하면 되는 메서드 이므로
		// 위에서 만든 productService.read() 메서드를 현재 파라미터로 가져온
		// productId 를 매개변수로 호출시켜서 그 데이터 값을 dto 로 가져와서 담는다.
		ProductDTO dto = productService.read(productId);
		model.addAttribute("productInfo", dto);
		
		return "member/product/view";
	}
	
	
	
	
}
