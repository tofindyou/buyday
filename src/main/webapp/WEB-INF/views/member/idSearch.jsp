<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %> 

<script type="text/javascript">

	$(document).ready(function () {
		
		// 확인 버튼 클릭시 실행되는 함수
		$("#btn_idCheck").click(function(event) {
			event.preventDefault();
			
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
				url : '${ctx}/member/findId',
				data : {
					username : inputUsername,
					email : inputEmail
				},
				dataType : 'text',
				success : function(result) {
					
					if (result != null) {
						var userid = result;
						alert('회원님의 아이디는 ' + userid + ' 입니다.');
						location.assign("${ctx}/member/login");
					}
					
				}
			}); // ajax
			
			alert("일치하는 회원 정보가 없으면 되돌아갑니다..");
			location.assign("${ctx}/member/idSearch");
			
		}); // btn_idCheck
		
	});
	
</script>

<div class="container w-50 mt-5 mb-5 p-5 shadow">
	<div class="mb-5 row">
		<h1>아이디 찾기</h1>
	</div>
	<div class="row">
		<form class="form-horizontal" action="">
			<div class="mb-3 row">
				<label for="inputUsername" class="col-sm-2 col-form-label">이름</label>
				<div class="col-sm-10">
					<input class="form-control mb-2" id="inputUsername" placeholder="이름" name="username" autofocus required>
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
					<button type="button" class="btn btn-primary" id="btn_idCheck">확인</button>
				</div>
			</div>
		</form>
		
	</div> <!-- class=row -->
</div> <!-- class=container -->

<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>


