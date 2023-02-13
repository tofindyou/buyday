<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL에서 제공하는 태그 라이브러리 -->
<!-- 변수선언, 조건문/반복문, URL 처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 숫자, 날짜, 시간포맷 지정 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 컬렉션, 문자열처리 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- EL(Expression Language) 태그 사용 -->
<!-- pageContext.request.contextPath : 프로젝트의 contextPath (/buyday) 를 가져옴 -->
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buyday 스토어</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    
    <!-- 부트스트랩 5.2.3 버전 적용을 위한 CSS 와 JS 의 CDN 소스 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    
    <!-- jquery 를 사용하기 위해 적용해둔 스크립트 코드 -->    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    
    <!-- 카카오주소 api 를 사용하기 위한 코드 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <!-- FontAwsome 을 사용하기 위한 코드 -->
    <script src="https://kit.fontawesome.com/fae8883d6b.js" crossorigin="anonymous"></script>
    
    <!-- handlebars 를 사용하기 위한 코드 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
    
    <link rel="stylesheet" href="${ctx}/css/main.css">
    
    <script src="/resources/js/upload.js" type="text/javascript"></script>
    
</head>

<body>
	<div class="header">
		<div id="gnb">
			<div class="left_gnb">
				<a href="${ctx}">HOME</a>
			</div>
			<div class="right_gnb">
				<c:if test="${login.userid == null}">
					<a href="${ctx}/member/login">로그인</a>
					<a href="${ctx}/member/insert">회원가입</a>
				</c:if>
				<c:if test="${login.userid != null}">
					<span id="login_log" style="border-bottom: 1px solid white;">${login.userid}님</span>
					<a href="${ctx}/member/read/${login.userid}">마이페이지</a>
					<a href="${ctx}/member/logout" id="logout_btn">로그아웃</a>
					<!-- 로그인한 유저 정보를 jsp 에서 사용하기 위해 userid 값을 hidden 타입의 input 담아둠. -->
					<input type="hidden" value="${login.userid}" id="login_userid">
				</c:if>
			</div>
		</div>
	</div>
	
	<div class="nav">
		<nav>
			<ul>
				<li><a href="${ctx}/admin/orderAllList">주문 현황</a></li>
				<li><a href="${ctx}/admin/list">회원 관리</a></li>
				<li><a href="${ctx}/admin/product/insert">상품 등록</a></li>
				<li><a href="${ctx}/admin/product/list">상품 조회</a></li>
			</ul>
		</nav>
	</div>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 로그아웃 버튼 클릭시 실행되는 함수
		$("#logout_btn").click(function(event) {
			event.preventDefault();
			
			var logout = confirm("로그아웃 하시겠습니까?");
			
			if (logout) {
				location.assign("${ctx}/member/logout");
			}
		});
		
		
		
		
	});

</script>