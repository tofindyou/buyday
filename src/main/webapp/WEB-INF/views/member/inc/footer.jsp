<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<script type="text/javascript">

	$(document).ready(function() {
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
	
		
		// 주문/배송 조회 클릭시 수행되는 코드
		$(".foot_order").click(function(event) {
			
			if (userid == null) {
				alert("로그인 후 이용해주세요.");
				location.assign("${ctx}/member/login");
				
			} else {
				location.assign("${ctx}/order/list/${login.userid}")
			}
		});
		
		// 고객 정보 클릭시 수행되는 코드
		$(".foot_userInfo").click(function(event) {
			
			if (userid == null) {
				alert("로그인 후 이용해주세요.");
				location.assign("${ctx}/member/login");
				
			} else {
				location.assign("${ctx}/member/read/${login.userid}")
			}
		});
		
		
	});
	
</script>
	
	<div class="footer">
		<div class="footer_w100">
			<div class="footer_w70">
				<a class="foot_order">주문/배송 조회</a>|
				<a class="foot_userInfo">고객 정보</a>
			</div>
		
		</div>
		
		<div class="footer_left">
			<p>엠아이엔코리아(주) 대표 : min</p>
			<p>주소 : 서울시 금천구 가산동 5678</p>
			<p>사업자등록번호 : 104-77-77777 </p>
			<p>고객만족센터 TEL : 080-777-6666 </p>
			<p>FAX : 02-3333-4444</p>
			<p>E-mail: buyday@Tmail.com</p>
		</div>
		
		<div class="footer_right">
			<p>보상대상: 미배송, 반품/환불거부, 쇼핑몰부도</p>
			<p>콘텐츠산업진흥법에 의한 콘텐츠보호안내</p>
			<p>호스팅서비스사업자 : Mclass(주) 사업부</p>
			<p>COPYRIGHT(C) BUYDAY CO., LTD. ALL RIGHTS RESERVED</p>
		</div>
	</div>
	

