<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<style>

/* 상품ID CSS */

.admin_container div table tbody tr td a {
	display: inline-block;
	padding: 2px;
	border: 1px solid #87CEFA;
	border-radius: 5px;
	font-weight: 700;
	color: #87CEFA;
}

.admin_container div table tbody tr td a:hover {
	background-color: #87CEFA;
	color: white;
}

</style>

	<div class="logo">
		<h1 style="margin-top: 80px;">상품 리스트</h1>
	</div>



	<!-- .row side_nav -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
	
	
	<!-- Bootstrap table -->
	<div class="container admin_container mt-3 mb-5">
		<div class="row">
			<table class="table table-hover">
				<thead>
					<tr>
			 			<th>상품ID</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>카테고리</th>
						<th>상품상세설명</th>
						<th>상품등록날짜</th>
						<th>상품수정날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="dto">
						<tr>
							<td><a href="${ctx}/product/read/${dto.productId }">${dto.productId }</a></td>
							<td>${dto.productName }</td>
							<td>${dto.price }</td>
							<td>${dto.stock }</td>
							<td>${dto.category }</td>
							<td>${dto.productInfo }</td>
							<!-- JSTL 의 Formatting 태그로 처리 -->
							<td><fmt:formatDate value="${dto.regDate }" type="date" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${dto.updateDate }" type="date" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>




