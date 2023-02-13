<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %> 

<script type="text/javascript">

	$(document).ready(function () {
		
		// 회원정보 수정 버튼 클릭시 실행되는 함수
		$("#update_userInfo").click(function() {
			var userid = $("#inputId").val();
			location.assign("${ctx}/member/update/" + userid);
		});
		
		
		// 메인으로 돌아가기 버튼 클릭시 실행되는 함수
		// location.assign() 은 다음 페이지로 이동하면서 현재 페이지를 히스토리에 남기고,
		// location.replace() 는 남기지 않는다. (뒤로가기 누를시 알수있음)
		$("#back_to_main").click(function() {
			location.assign("${ctx}/");
		});
		
		
		// 회원 탈퇴하기 버튼 클릭시 실행되는 함수
		$("#withdrawal_member").click(function() {
			var userid = $("#inputId").val();
			location.assign("${ctx}/member/delete/" + userid);
		});
		
		
		
	});
	
</script>

<div class="container w-50 mt-5 mb-5 p-5 shadow">
	<div class="mb-3 row">
		<h1>MY PAGE</h1>
	</div>
	<div class="row">
		<div class="form-horizontal">
			<div class="mb-3 row">
				<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
					<input class="form-control mb-2" id="inputId" placeholder="아이디를 입력하세요." name="userid" value="${userInfo.userid}" readonly>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputName" class="col-sm-2 col-form-label">이름</label>
				<div class="col-sm-10">
					<input class="form-control" id="inputName" placeholder="" name="username" value="${userInfo.username}" readonly>
				</div>
			</div>				
			<div class="mb-3 row">
				<label for="inputAdd" class="col-sm-2 col-form-label">주소</label>
				<div class="col-sm-10">
					<input class="form-control" id="inputAdd" placeholder="" name="useraddress" value="${userInfo.useraddress}" readonly>
				</div>
			</div>				
			<div class="mb-3 row">
				<label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm-10">
					<input type="email" class="form-control" id="inputEmail" placeholder="name@Example.com" name="email" value="${userInfo.email}" readonly>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputTel" class="col-sm-2 col-form-label">휴대폰</label>
				<div class="col-sm-10">
					<input type="tel" class="form-control" id="inputTel" placeholder="" name="tel" value="${userInfo.tel}" readonly>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputBirth" class="col-sm-2 col-form-label">생년월일</label>
				<div class="col-sm-10">
					<input class="form-control" id="BirthDate" placeholder="" name="birthDate" value="${userInfo.birthDate}" readonly>
				</div>
			</div>				
			<div class="mb-3 row">
				<label for="inputPoint" class="col-sm-2 col-form-label">적립금 (point)</label>
				<div class="col-sm-10">
					<input class="form-control" id="Point" placeholder="0" name="Point" value="${userInfo.point}" readonly>
				</div>
			</div>				
			<div class="text-center mt-3 row">
				<div>
					<button class="btn btn-warning" id="update_userInfo">회원정보 수정하기</button>
					<button class="btn btn-info" id="back_to_main">메인으로 돌아가기</button>
					<button class="btn btn-danger" id="withdrawal_member">회원 탈퇴하기</button>
				</div>
			</div>
		</div>
		
	</div> <!-- class=row -->
</div> <!-- class=container -->

<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>


