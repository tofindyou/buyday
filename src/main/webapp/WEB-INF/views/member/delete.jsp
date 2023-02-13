<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %> 

<script type="text/javascript">
	$(document).ready(function() {
		
		// 회원 탈퇴하기 버튼 클릭시 실행되는 함수
		// 1. 비밀번호 입력 여부
		// 2. 주의사항 체크 여부
		// 3. 비밀번호 일치 여부
		$("#withdrawal_member").click(function(event) {
			event.preventDefault();
			
			var result = confirm("회원 탈퇴 하시겠습니까?") // 확인을 누르면 true 반환
			
			var inputpw = $("#inputPassword").val(); // 입력받은 비밀번호
			var dbpw = $("#dbUserPw").val(); // DB 에 있는 해당 회원 비밀번호
			var isChecked = $("#checkbox").prop("checked"); // 체크박스 체크 여부 (체크 돼있으면 true)
			
			if(result) { // confirm 확인 버튼을 누르면 실행
				
				if(inputpw == "") { // 비밀번호가 공백이라면
					alert("비밀번호를 입력해주세요.");
					$("#inputPassword").focus();
					
				} else { // 비밀번호가 입력 되있다면
					
					if(!isChecked) { // 주의사항 체크가 안되있다면
						alert("회원탈퇴 안내 사항 확인에 체크해주세요.");
						
					} else { // 주의사항 체크가 되어있다면
						
						if(inputpw != dbpw) { // 비밀번호가 일치하지 않는다면
							alert("비밀번호가 일치하지 않습니다.");
							$("#inputPassword").focus();
							
						} else { // 비밀번호가 일치한다면
							$("form").submit(); // form 의 submit 기능 실행
						}
					}
				}
			
			}
			
		});
		
		
		// 마이페이지로 돌아가기 버튼 클릭시 실행되는 함수
	    $("#back_to_myPage").click(function(event) {
	    	event.preventDefault();
	    	
	    	var userid = $("#inputId").val();
	    	location.assign("${ctx}/member/read/" + userid);
	    });
		
		
		
	});
</script>

<div class="container w-50 mt-5 mb-5 p-5 shadow">
	<div class="mb-3 row">
		<p style="color:red;">※ 회원탈퇴 시 탈퇴 안내 사항을 반드시 확인해 주십시오.</h1>
		<br>
		<p style="color:red; font-size:">
		1. 계정내의 모든 포인트 및 개인정보가 삭제됩니다.<br>
		2. 탈퇴 이후에는 어떠한 방법으로도 삭제된 회원정보를 복원할 수 없습니다.</h3>
	</div>
	<br>
	
	<div class="container">
		<h4>비밀번호를 다시 한번 확인해주세요.</h4>
		<br>
	</div>

	<div class="row">
		<form class="form-horizontal" action="${ctx}/member/delete" method="post">
			<div class="mb-3 row">
				<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
					<input class="form-control mb-2" id="inputId" placeholder="아이디를 입력하세요." name="userid" value="${userInfo.userid}" readonly>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputName" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="inputPassword" placeholder="" name="userpw" required>
					<!-- DB 에 있는 해당 유저의 비밀번호를 가져와서 hidden 타입의 input 에 담아놓은 것이다. -->
					<input type="hidden" id="dbUserPw" value="${userInfo.userpw}">
				</div>
			</div>				
			<div class="mt-3 row">
				<div>
					<label>
					<input type="checkbox" id="checkbox" required>회원탈퇴 시 탈퇴 안내 사항을 모두 확인했습니다.
					</label>
				</div>
			</div>
			<div class="text-center mt-3 row">
				<div>
					<button type="submit" class="btn btn-danger" id="withdrawal_member">회원 탈퇴</button>
					<button class="btn btn-success" id="back_to_myPage">마이페이지로 돌아가기</button>
				</div>
			</div>
		</form>
		
	</div>
</div> <!-- class=container -->

<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>


