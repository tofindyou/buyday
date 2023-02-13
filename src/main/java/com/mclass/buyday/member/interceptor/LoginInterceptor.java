package com.mclass.buyday.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// LoginInterceptor 클래스에 HandlerInterceptorAdapter 추상 클래스를 상속시키고,
// Override/Implement method 기능을 이용해 preHandle(), postHandle() 메서드를 만든다.
// 인터셉터의 실행 순서는 preHandle() > (MemberController 의) loginPost() > postHandle() 순이다.
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		// view 에서 가져온 HttpServletRequest 의 Session 정보안에
		// "login" 이라는 이름으로 바인딩 된 데이터를 가져왔는지 (로그인 되어있는지) 확인하기 
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("login");
		
		if(obj != null) { // 만약 Session 정보안에 값이 존재하면
			session.removeAttribute("login"); // 값을 지운다.
		}
		
		return true; // 리턴값이 true 이면 Controller 로 넘어간다. (false 이면 실행종료)
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
	}

}
