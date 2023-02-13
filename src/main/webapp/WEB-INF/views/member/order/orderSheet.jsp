<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// hidden input 의 productId 값을 변수 productId 로 선언한다.
		var productId = $("#productId").val();
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
		
		
		
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
		
		
		// 장바구니 버튼 클릭시 실행되는 코드
		$(".btn_cart").click(function(event) {
			event.preventDefault();
			
			location.assign("${ctx}/order/myCart/" + userid);
		});
		
	    
		// 상품 파트에서 확인 버튼 클릭 하거나
		// 결제정보 파트에서 input radio 버튼 클릭시 실행되는 코드
	    $(".btn_confirm, input[name='payment_method']").click(function(event) {

	    	// 선택한 상품 수량
	    	var qty = $("#order_quantity option:selected").val();
	    	// 상품 (1개당)가격
	    	var price = "<c:out value='${productInfo.price}'/>";
	    	// 상품 (1개당)포인트
	    	var point = "<c:out value='${point}'/>";
	    	
	    	var totalPrice = price * qty; // 상품 총 소계 (배송비 미포함)
	    	var totalPoint = point * qty; // 상품 총 적립포인트
	    	
	    	// 상품 파트에 미리보기 형식으로 띄우기
	    	$("#totalPrice").html(totalPrice).css("font-size", "20px").css("font-weight", "800").css("color", "red");
	    	$("#totalPoint").html(totalPoint);
	    	
	    	// 상품 파트에서 input hidden 으로 만들어둔 태그
	    	$("#price").val(totalPrice); // 최종적으로 서버에 전달될 값 (price)
	    	
	    	
	    	// 배송비 2500 원
	    	var shipping = 2500;
	    	// 유저가 기존 보유중이었던 point 값 불러오기 (유저 파트에서 input hidden 으로 저장해둠)
	    	var userPoint = $("#beforePoint").val();
	    	
	    	var amountPoint = 0; // 여러번 눌리더라도 누적되지않게 기존 값으로 초기화 시켜야함!!
	    	
	    	
	    	var amountPrice = totalPrice + shipping; // 총 합계 (배송비 포함)
	    	var amountPoint = userPoint + totalPoint; // 보유하게되는 총 포인트
	    	
	    	// 결제 파트에 최종적으로 띄우는 총 합계
	    	if (totalPrice < 30000) { // 소계가 30000 원 이하라면
	    		$("#result_price").html(totalPrice);
	    		$("#shipping").html(0);
	    		$("#amount_span").html(totalPrice).css("font-size", "20px").css("font-weight", "800").css("color", "red");
	    		$("#amount").val(totalPrice); // 최종적으로 서버에 전달될 값 (amount)
	    	
	    	} else { // 소계가 30000원 이상이라면
	    		$("#result_price").html(totalPrice);
	    		$("#shipping").html(shipping);
	    		$("#amount_span").html(amountPrice).css("font-size", "20px").css("font-weight", "800").css("color", "red");
	    		$("#amount").val(amountPrice); // 최종적으로 서버에 전달될 값 (amount)
	    	}
	    	
	    	$("#afterPoint").val(amountPoint); // 최종적으로 서버에 전달될 값 (point)
	    	
	    	console.log(totalPrice);
	    	console.log(amountPrice);
	    	console.log(amountPoint);
	    	
	    });
		
	    	
		
		
	});

</script>

<style>

.order_container {
	margin: 50px auto;
	width: 70%;
}



/* 최상단 타이틀 영역 */

.order_container .orderHeaderInfo {
	margin: 20px;
	border-bottom: 1px solid #ccc;
	width: 100%;
	height: 70px;
	text-align: center;
}



/* 폼 내부 파트별 타이틀 영역 (3개) */

.order_container form .title {
	margin-top: 80px;
	padding-left: 180px;
	width: 70%;
}

.order_container form .title h4 {
	font-weight: 900;
}



/* 상품정보 */

.order_container form .orderInfo_product {
	border-top: 2px solid #bdbebd;
	margin: auto;
	width: 70%;
}

/* 이미지 태그 */

.order_container form .orderInfo_product table tbody tr .order_imgTag {
	border: 1px solid #ccc;
	width: 150px;
	height: 100px;
}



/* 유저정보 */

.order_container form .orderInfo_user {
 	border-top: 2px solid #bdbebd;
 	border-bottom: 1px solid #ccc;
	margin: auto;
	padding-top: 10px;
	width: 70%;
}



/* 결제정보 */

.order_container form .orderInfo_payment {
 	border-top: 2px solid #bdbebd;
 	border-bottom: 1px solid #ccc;
	margin: auto;
	padding-top: 10px;
	padding-bottom: 20px;
	width: 70%;
	text-align: center;
}

.order_container form .orderInfo_payment input {

}

.order_container form .orderInfo_payment label {
	margin-right: 50px;
}



/* 상품 확인 버튼 */

.btn_confirm {
	margin-bottom: 30px;
	border: 1px solid #ccc;
}

.btn_confirm:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}



/* 맨 아래 버튼 */

.order_sale_btns {
	text-align: center;
}

/* 계속 쇼핑하기 버튼 */

.order_sale_btns .btn_cart {
	border: 1px solid #ccc;
}

.order_sale_btns .btn_cart:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}

</style>


<!-- 오늘 날짜 현재 시간 구하기 (상품 번호에 활용할것임.) -->
<c:set var="today" value="<%=new java.util.Date()%>"/>


<c:set var="Point" value="${point}"/> <!-- 기본 상품 가격의 1/100 -->
<c:set var="Selected_size" value="${selected_size}"/>
<c:set var="Order_quantity" value="${order_quantity}"/>


	<div class="order_container">
	
		<div class="orderHeaderInfo">
			<h1 style="font-weight: 800;">주문서작성/결제</h1>
		</div>
		
		<form action="${ctx}/order/orderConfirm" method="post">
		
			<div class="title">
				<h4>1. 주문하시는 상품</h4>
				<!-- 현재 시간을 이용해서 상품번호를 만들고, 폼에 끼워서 보낸다. -->
				<input value="<fmt:formatDate value="${today}" pattern='yyyyMMddHHmmss'/>" type="hidden" name="orderId">
			</div>
			
			<div class="orderInfo_product">
				<table class="table table-hover">
					<thead>
						<tr>
							<th colspan="2" style="text-align: center;">상품정보</th>
							<th>소계</th>
							<th>수량</th>
							<th>사이즈</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<!-- 이미지 태그 -->
							<td>
								<div class="order_imgTag"></div>
							</td>
							
							<!-- 상품 정보 -->
							<td style="text-transform: uppercase;">[${productInfo.category}]<br>
								${productInfo.productName }
								<!-- 상품ID(productId) 의 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
								<input value="${productInfo.productId}" type="hidden" name="productId" id="productId">
							</td>
							
							<!-- 가격 -->
							<td>
								<!-- 소계(price) 의 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
								<input type="hidden" id="price" name="price">
								<span id="totalPrice">금액 : </span>&nbsp;원 <br>
								
								<span id="totalPoint">적립금 : </span>&nbsp;Point
							</td>
							
							<!-- 수량 -->
							<td>
								<select name="order_quantity" id="order_quantity">
									<c:forEach var="stock" begin="1" end="${productInfo.stock }">
										<!-- JSTL 의 c:if 조건문으로 옵션의 기본값 설정 -->
										<option value="${stock}" <c:if test="${Order_quantity==stock}"> selected </c:if>>${stock}</option>
									</c:forEach>
								</select>
							</td>
							
							<!-- 사이즈 -->
							<td>
								<select name="selected_size" id="selected_size">
									<!-- JSTL 의 c:if 조건문으로 옵션의 기본값 설정 -->
									<option value="S" <c:if test="${Selected_size=='S'}"> selected </c:if>>S</option>
									<option value="M" <c:if test="${Selected_size=='M'}"> selected </c:if>>M</option>
									<option value="L" <c:if test="${Selected_size=='L'}"> selected </c:if>>L</option>
								</select>
							</td>
							
							<!-- 버튼 -->
							<td class="button_box">
								<button type="button" class="btn btn-default btn_confirm">확인</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div><!-- class=orderInfo_product -->
			
			
			<div class="title">
				<h4>2. 주문고객/배송지 정보</h4>
				<!-- 주문자 정보 안에 input hidden 으로 보유 point 를 가져옴 -->
				<input type="hidden" value="${memberInfo.point}" id="beforePoint">
				<!-- point 의 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
				<input type="hidden" name="point" id="afterPoint">
			</div>
			
			<div class="orderInfo_user">
				<div class="form-horizontal">
					<div class="mb-3 row">
						<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
						<div class="col-sm-10">
							<input class="form-control mb-2" id="inputId" placeholder="아이디" name="userid" value="${memberInfo.userid}" readonly>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputName" class="col-sm-2 col-form-label">이름</label>
						<div class="col-sm-10">
							<input class="form-control" id="inputName" placeholder="이름" name="username" value="${memberInfo.username}">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label for="inputAdd" class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-10">
							<!-- 우편번호(postcode), 도로명주소(useraddress), 상세주소(detailAddress) 만 가져옴 -->
					    	<input type="text" class="form-control mb-2" id="postcode" name="postcode" placeholder="우편번호" value="${memberInfo.postcode}">&nbsp;
							<input type="button" class="btn btn-sm btn-outline-secondary p-2 mb-2" id="searchAdd" value="우편번호 찾기"><br>
					    	<input type="text" class="form-control mb-2" id="roadAddress" name="useraddress" placeholder="도로명주소" value="${memberInfo.useraddress}">
					    	<input type="text" class="form-control mb-2" id="detailAddress" name="detailAddress" placeholder="상세주소">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" id="inputEmail" placeholder="name@Example.com" name="email" value="${memberInfo.email}">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputTel" class="col-sm-2 col-form-label">휴대폰</label>
						<div class="col-sm-10">
							<input type="tel" class="form-control" id="inputTel" placeholder="휴대폰" name="tel" value="${memberInfo.tel}">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="InputDelivery_msg" class="col-sm-2 col-form-label">배송메세지</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="InputDelivery_msg" placeholder="택배기사님께 전달할 메세지를 20자이내로 입력해주세요." name="delivery_msg">
						</div>
					</div>				
				</div>
			</div><!-- class=orderInfo_user -->
			
			
			<div class="title">
				<h4>3. 결제정보 선택</h4>
			</div>
			
			<div class="orderInfo_payment">
				<input type="radio" name="payment_method" value="transfer" id="transfer" checked>
				<label for="transfer">실시간계좌이체</label>
				<input type="radio" name="payment_method" value="bankbook" id="bankbook">
				<label for="bankbook">무통장입금</label>
				<input type="radio" name="payment_method" value="phone_payment" id="phone_payment">
				<label for="phone_payment">핸드폰결제</label>
				<input type="radio" name="payment_method" value="card" id="card">
				<label for="card">신용카드</label>
			</div>
			
			<div class="row orderInfo_amount" style="text-align: center; margin: 50px 0;">
				<p>상품가격 : <span id="result_price"></span> 원</p>
				<br>
				
				<p>배송비 : <span id="shipping"></span> 원</p>
				<br>
				
				<p style="font-size: 1.5em;">총 결제금액 : <span id="amount_span"></span> 원</p>
				<input type="hidden" id="amount" name="amount">
				
			</div>
		
		
			<div class="order_sale_btns">
				<button type="button" class="btn btn_cart">장바구니</button>
				<button type="submit" class="btn btn-danger btn_order">결제하기</button>
			</div>
			
			
		</form>
	</div> <!-- order_container -->

<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>


