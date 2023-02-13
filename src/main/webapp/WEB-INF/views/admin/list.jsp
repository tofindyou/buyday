<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %>

<style>

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
		<h1 style="margin-top: 80px;">회원 리스트</h1>
	</div>
	
	<!-- Bootstrap table -->
	<div class="container admin_container mt-3 mb-5">
		<div class="row">
			<table class="table table-hover">
				<thead>
					<tr>
			 			<th> <input type="hidden" value="${vo.userid }" name="userid">
			 			 아이디</th>
						<th>이름</th>
						<th>주소</th>
						<th>이메일</th>
						<th>휴대폰</th>
						<th>생년월일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="vo">
						<tr>
							<td> <a href="${ctx }/member/read/${vo.userid }">${vo.userid }</a> </td>
							<td>${vo.username }</td>
							<td>${vo.email }</td>
							<td>${vo.tel }</td>
							<td>${vo.useraddress }</td>
							<td>${vo.birthDate }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>






