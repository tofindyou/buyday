<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// ID 중복체크 버튼 클릭시 실행되는 함수
		$("#idCheck").click(function(event) {
			event.preventDefault(); // 기존 버튼의 기능을 막는다.
			var inputId = $("#inputId").val();
			
			// ajax : 화면전환 없이 데이터 전송
			// $.ajax : JQuery(외부 라이브러리) 안에 내장되어 있는 기본 함수
			$.ajax({
				
				type : 'post',
				url : '${ctx}/member/idCheck',
				data : { // 보낼 데이터
					// 변수명 : 변수의 값
					userid : inputId
				},
				dataType : 'text',
				// success : 정상적으로 데이터를 가져왔을 경우 실행될 코드	
				// result : MemberController 에서 리턴 받은 값
				success : function(result) {
					
					if (inputId == "") {
						$("#inputId").focus();
						var span = $("#idCheck").next();
						span.html("아이디를 입력하세요.");
						return;
					}
					
					if (result == 1) { // 입력한 아이디가 DB에 존재함
						// .next() : 다음 요소(태그) 선택하는 함수 (JQuery 내장 함수)
						var span = $("#idCheck").next();
						span.html("중복된 ID 입니다.");
						$("#inputId").focus();
						
					} else { // 입력한 아이디가 DB에 존재하지 않음
						var span = $("#idCheck").next();
						span.html("사용 가능한 ID 입니다.");
					}
				}
			});
		}); // idCheck
		
		
	    // searchAdd(우편번호 검색) 버튼을 새로 재정의하여 postcode 함수를 실행하도록 만듬
	    $("#searchAdd").click(function(event) {
			event.preventDefault();
			postcode();
		});
		
		// 카카오 주소 api 코드를 postcode 함수로 재정의해서 사용
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function postcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }

	                // 우편번호와 도로명주소 정보를 해당 필드에 넣는다. 2개만 사용한다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                
	            }

	        }).open();
	    } // postcode
	    

	    // 회원가입 버튼을 클릭시 실행되는 함수
	    $(".submit").click(function(event) {
			event.preventDefault(); // 기존 submit 기능을 막는다.
			
			var pw1 = $("#inputPassword").val(); // 입력한 비밀번호
			var pw2 = $("#inputPassword2").val(); // 입력한 비밀번호 확인
			var inputId = $("#inputId").val(); // 입력한 아이디
			
			if (inputId == "") {
				$("#inputId").focus();
				var span = $("#idCheck").next();
				span.html("아이디를 입력하세요.");
				return;
			}
			
			if (pw1 == "") {
				$("#inputPassword").focus();
				var span = $("#inputPassword").next();
				span.html("비밀번호를 입력하세요.");
				return;
			}
			
			// ID 중복확인 버튼에서 사용한 AJAX 수행을 한번 더 해서 ID 중복을 확실히 확인함
			$.ajax({
				
				type : 'post',
				url : '${ctx}/member/idCheck',
				data : {
					// 변수명 : 변수의 값
					userid : inputId
				},
				dataType : 'text',
				// success : 정상적으로 데이터를 가져왔을 경우 실행될 코드	
				// result : MemberController 에서 리턴 받은 값
				success : function(result) {
					
					if (result == 1) { // 입력한 아이디가 DB에 존재함
						alert("이미 존재하는 아이디입니다! ID 중복체크를 반드시 확인하세요.")
						location.assign("${ctx}/member/insert")
					}
				}
			});
			
			if (pw1 != pw2) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#inputPassword2").focus();
			} else { // 두 값이 일치하면
				$("form").submit(); // form 의 submit 기능 실행
			}
		});
	    
	    
	    
	    
	});
	
</script>

<div class="container w-50 mt-5 mb-5 p-5 shadow">
	<div class="mb-3 row">
		<h1>회원가입</h1>
	</div>
	<div class="row">
		<form class="form-horizontal" action="${ctx}/member/insert" method="post">
			<div class="mb-3 row">
				<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-10">
					<input class="form-control mb-2" id="inputId" placeholder="아이디를 입력하세요." name="userid" autofocus required>
					<button class="btn btn-outline-secondary" id="idCheck">ID 중복체크</button>
					&nbsp;&nbsp;<span style="color: red;"></span>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="inputPassword" placeholder="" name="userpw" required>
					&nbsp;&nbsp;<span style="color: red;"></span>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPassword2" class="col-sm-2 col-form-label">비밀번호 확인</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="inputPassword2" placeholder="">
				</div>
			</div>				
			<div class="mb-3 row">
				<label for="inputName" class="col-sm-2 col-form-label">이름</label>
				<div class="col-sm-10">
					<input class="form-control" id="inputName" placeholder="" name="username">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputAdd" class="col-sm-2 col-form-label">주소</label>
				<div class="col-sm-10">
					<!-- 우편번호(postcode), 도로명주소(useraddress), 상세주소(detailAddress) 만 가져옴 -->
			    	<input type="text" class="form-control mb-2" id="postcode" name="postcode" placeholder="우편번호">&nbsp;
					<input class="btn btn-sm btn-outline-secondary p-2 mb-2" id="searchAdd" value="우편번호 찾기"><br>
			    	<input type="text" class="form-control mb-2" id="roadAddress" name="useraddress" placeholder="도로명주소">
			    	<input type="text" class="form-control mb-2" id="detailAddress" name="detailAddress" placeholder="상세주소">
			    </div>
			</div>
			<div class="mb-3 row">
				<label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm-10">
					<input type="email" class="form-control" id="inputEmail" placeholder="name@Example.com" name="email">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputTel" class="col-sm-2 col-form-label">휴대폰</label>
				<div class="col-sm-10">
					<input type="tel" class="form-control" id="inputTel" placeholder="" name="tel">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputBirth" class="col-sm-2 col-form-label">생년월일</label>
				<div class="col-sm-10">
					<input type="date" class="form-control" id="inputBirth" placeholder="" name="birthDate">
				</div>
			</div>				
			<div class="text-center mt-3 row">
				<div>
					<button type="submit" class="btn btn-primary submit">회원가입</button>
				</div>
			</div>
		</form>
		
	</div> <!-- row -->
</div> <!-- container -->

<!-- .footer -->
<jsp:include page="inc/footer.jsp"></jsp:include>

</body>
</html>


