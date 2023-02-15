<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %> 

<script type="text/javascript">

	$(document).ready(function () {
		
		// 확인 버튼 클릭시 실행되는 함수
		$("#btn_pwCheck").click(function(event) {
			event.preventDefault();
			
			var inputUserid = $("#inputUserid").val();
			if (inputUserid == "") {
				$("#inputUserid").focus();
				alert("아이디를 입력하세요.");
				return;
			}
			
			var inputUsername = $("#inputUsername").val();
			if (inputUsername == "") {
				$("#inputUsername").focus();
				alert("이름을 입력하세요.");
				return;
			}
			
			var inputEmail = $("#inputEmail").val();
			if (inputEmail == "") {
				$("#inputEmail").focus();
				alert("이메일을 입력하세요.");
				return;
			}
			
			
			$.ajax({
				
				type : 'post',
				url : '${ctx}/member/findPw',
				data : {
					userid : inputUserid,
					username : inputUsername,
					email : inputEmail
				},
				dataType : 'text',
				success : function(result) {
					
					if (result != null) {
						var userpw = result;
						alert('회원님의 비밀번호는 ' + userpw + ' 입니다.');
						location.assign("${ctx}/member/login");
					}
					
				}
			}); // ajax
			
			alert("일치하는 회원 정보가 없으면 되돌아갑니다..");
			location.assign("${ctx}/member/pwSearch");
			
		}); // btn_pwCheck
		
	});
	
</script>

<div class="container w-50 mt-5 mb-5 p-5 shadow">
	<div class="mb-5 row">
		<h1>비밀번호 찾기</h1>
	</div>
	<div class="row">
		<form class="form-horizontal" action="">
			<div class="mb-5 row">
				<label for="inputUserid" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
					<input class="form-control" id="inputUserid" placeholder="아이디" name="userid" autofocus required>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputUsername" class="col-sm-2 col-form-label">이름</label>
				<div class="col-sm-10">
					<input class="form-control mb-2" id="inputUsername" placeholder="이름" name="username" required>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm-10">
					<input class="form-control" id="inputEmail" placeholder="이메일" name="email" required>
				</div>
			</div>
			<div class="text-center mt-3 row">
				<div>
					<button type="submit" class="btn btn-primary" id="btn_pwCheck">확인</button>
				</div>
			</div>
		</form>
		
	</div> <!-- class=row -->
</div> <!-- class=container -->

<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>


