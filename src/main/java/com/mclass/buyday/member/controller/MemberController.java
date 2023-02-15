package com.mclass.buyday.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mclass.buyday.member.domain.LoginDTO;
import com.mclass.buyday.member.domain.MemberVO;
import com.mclass.buyday.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	
	// 회원가입 창 띄우기
	@RequestMapping(value="/insert", method=RequestMethod.GET)
	public String insert() {
		return "member/register";
	}
	
	// 회원 가입 버튼 누를시 동작
	// 파라미터로 회원의 모든 정보를 전달하므로 POST 방식 사용
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	// ModelAttribute : html(View) 에서 name 속성으로 강제 전달받은 (MemberVO 에 없는)
	// 					detailAddress(상세주소)를 다시 화면에 출력하기 위해서 Model 에 담는다.
	public String insert(MemberVO vo, @ModelAttribute("detailAddress") String detailAddress) {
		// 도로명주소(useraddress) 와 상세주소(detailAddress) 를 더한 문자열을 변수 address 로 저장한다.
		String address = vo.getUseraddress() + " " + detailAddress;
		
		if (detailAddress == null) { // 상세주소를 전달받지 않은 경우
			address = vo.getUseraddress(); // 도로명 주소만 변수로 담는다.
		}
		
		// MemberVO 의 useraddress 에 변수 address 의 값을 담는다.
		vo.setUseraddress(address);
		
		memberService.insert(vo);
		
		
		// Redirect 시 URI 에 붙는 파라미터 제거 하기
		// https://whitelife.tistory.com/249 참고
//		ModelAndView mav = new ModelAndView();
//
//		RedirectView redirectView = new RedirectView(); // redirect url 설정
//		redirectView.setUrl("/buyday/member/read/" + vo.getUserid());
//		redirectView.setExposeModelAttributes(false);
//
//		mav.setView(redirectView);
//
//		return mav;
		
		// DB 에 전달한 값 그대로 redirect 하여 view(list) 에 전달
		return "redirect:/member/read/" + vo.getUserid();
	}
	
	
	// 회원 조회 (MyPage 창 띄우기)
	// 매개변수로 @RequestParam 방식 대신 @PathVariable 방식 사용 (userid 값은 필수로 받아야 하므로)
	// 파라미터로 회원의 id 정보만 전달하므로 GET 방식 사용
	@RequestMapping(value="/read/{userid}", method=RequestMethod.GET)
	public String read(@PathVariable("userid") String userid, Model model) {
		MemberVO vo = memberService.read(userid);
		model.addAttribute("userInfo", vo);
		
		return "member/read";
	}
	
	
	// 회원가입 Id 중복 체크 (ajax 방식)
	@ResponseBody // return 값을 view 경로가 아닌 문자열 그대로를 반환해주는 애너테이션
	@RequestMapping(value="/idCheck", method=RequestMethod.POST)
	public int idCheck(MemberVO vo) {
		String userid = vo.getUserid();
		// result : DB 에 아이디가 존재하면 1, 존재하지 않으면 0 값을 가짐
		int result = memberService.idCheck(userid);
		
		return result;
	}
	
	
	// 회원정보 수정하기 창 띄우기
	@RequestMapping(value="/update/{userid}", method=RequestMethod.GET)
	public String update(@PathVariable("userid") String userid, Model model) {
		MemberVO vo = memberService.read(userid);
		model.addAttribute("userInfo", vo);
		
		return "member/update";
	}
	
	// 회원정보 수정 버튼 누를시 동작 (회원가입 완료 버튼 누를시 동작 로직과 비슷하다.)
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public ModelAndView update(MemberVO vo, @ModelAttribute("detailAddress") String detailAddress) {
		
		String address = vo.getUseraddress() + detailAddress;
		if(detailAddress == null) {
			address = vo.getUseraddress();
		}
		vo.setUseraddress(address);
		
		memberService.update(vo);
		
		ModelAndView mav = new ModelAndView();
		
		// 다음 로직이 redirect 동작을 해준다고 생각하자.
		RedirectView redirectView = new RedirectView(); // redirect url 설정
		redirectView.setUrl("/buyday/member/read/" + vo.getUserid());
		redirectView.setExposeModelAttributes(false);

		mav.setView(redirectView);

		return mav; 
	}
	
	
	// 회원탈퇴 창 띄우기
	@RequestMapping(value="/delete/{userid}", method=RequestMethod.GET)
	public String delete(@PathVariable("userid") String userid, Model model) {
		MemberVO vo = memberService.read(userid);
		model.addAttribute("userInfo", vo);
		
		return "member/delete";
	}
	
	// 회원 탈퇴 버튼 클릭시 동작
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(MemberVO vo) {
		memberService.delete(vo);
		
		// redirect:URL 은 redirect 오른쪽의 해당 URL 경로로 한번 더 요청하는 것을 의미한다.
		return "redirect:/member/logout";
	}
	
	
	// 로그인 창 띄우기
	@RequestMapping(value="/login", method=RequestMethod.GET)
	// 반환 타입이 void 이면 해당 URL 경로(login) 를 그대로 jsp 파일의 이름으로 사용한다.
	public void login() {
		// return "member/login";
	}
	
	// 로그인 버튼 누를시 동작
	@RequestMapping(value="/login", method=RequestMethod.POST)
	// 로그인시 전달된 userid, userpw 값을 LoginDTO 에 담는다.
	// (MemberDTO 에 담아도 상관없긴한데 실무에서는 LoginDTO 에 따로 담는다.)
	public String login(LoginDTO dto, HttpSession session) {
		String returnURL = "";
		
		MemberVO vo = memberService.login(dto); // DB 에서 id, pw 가 일치하여 가져온 멤버의 모든 정보를 vo 에 담는다.
		
		if(vo != null) { // DB 에 해당 멤버가 있다면
			session.setAttribute("login", vo); // 해당 vo 값(value)을 "login" 이라는 이름의 key 로 session(세션) 에 저장한다.
			returnURL = "redirect:/"; // 메인 페이지로 이동 (http://localhost:8088/buyday/ 요청)
		}else { // DB 에 해당 멤버가 없다면
			returnURL = "redirect:/member/login"; // 로그인 창으로 이동
		}
		return returnURL;
	}
	
	
	// 로그아웃 버튼
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.invalidate(); // 세션 지우기
		
		response.sendRedirect("/buyday"); // 메인 페이지로 이동 (메인페이지 경로 요청)
	}
	
	
	// 아이디 찾기 버튼 누를시 동작
	@RequestMapping(value="/idSearch", method=RequestMethod.GET)
	public void idSearch() {
		// return "member/idSearch";
	}
	
	// 아이디 찾기 창에서 확인 버튼 누를시 동작 (ajax 방식)
	@ResponseBody
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public String findId(MemberVO vo) {
		vo = memberService.findId(vo);
		System.out.println(vo.getUserid());
		
		if(vo != null) {
			return vo.getUserid();
		} else {
			return null;
		}
	}
	
	// 비밀번호 찾기 버튼 누를시 동작
	@RequestMapping(value="/pwSearch", method=RequestMethod.GET)
	public void pwSearch() {
		// return "member/pwSearch";
	}
	
	// 비밀번호 찾기 창에서 확인 버튼 누를시 동작 (ajax 방식)
	@ResponseBody
	@RequestMapping(value="/findPw", method=RequestMethod.POST)
	public String findPw(MemberVO vo) {
		vo = memberService.findPw(vo);
		System.out.println(vo.getUserpw());
		
		if(vo != null) {
			return vo.getUserpw();
		} else {
			return null;
		}
	}
	
	
}
