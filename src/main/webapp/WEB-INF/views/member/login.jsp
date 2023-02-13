<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %> 

<script type="text/javascript">

	$(document).ready(function () {
		
		// 회원가입 버튼 클릭시 실행되는 함수
		$("#member_register").click(function(event) {
			event.preventDefault();
			
			location.assign("${ctx}/member/insert");
		});
		
		
		// 아이디 찾기 버튼 클릭시 실행되는 함수
		$("#find_id").click(function(event) {
			event.preventDefault();
			
			
		});
		
		
		// 비밀번호 찾기 버튼 클릭시 실행되는 함수
		$("#find_pw").click(function(event) {
			event.preventDefault();
			
			
		});
		
		
		
	});
	
</script>

<div class="container w-50 mt-5 mb-5 p-5 shadow">
	<div class="mb-3 row">
		<h1>로그인</h1>
	</div>
	<div class="row">
		<form class="form-horizontal" action="${ctx}/member/login" method="post">
			<div class="mb-3 row">
				<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
					<input class="form-control mb-2" id="inputId" placeholder="아이디" name="userid" autofocus required>
					&nbsp;&nbsp;<span style="color: red;"></span>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-10">
					<input class="form-control" id="inputPassword" placeholder="비밀번호" name="userpw" required>
					&nbsp;&nbsp;<span style="color: red;"></span>
				</div>
			</div>				
			<div class="text-center mt-3 row">
				<div>
					<button type="submit" class="btn btn-danger" id="login_button">로그인</button>
					<button class="btn btn-primary" id="member_register">회원가입</button>
				</div>
			</div>
			<div style="display: flex;">
				<div style="margin-left: auto;">
					<button class="btn btn-default" id="find_id">아이디 찾기</button>｜
					<button class="btn btn-default" id="find_pw">비밀번호 찾기</button>
				</div>
			</div>
		</form>
		
	</div> <!-- class=row -->
</div> <!-- class=container -->

<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>


