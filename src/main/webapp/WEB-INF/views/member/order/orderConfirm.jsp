<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// hidden input 의 productId 값을 변수 productId 로 선언한다.
		var productId = $("#productId").val();
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
		
		
		
		// 계속 쇼핑하기 버튼 클릭시 실행되는 코드
		$(".btn_shopping").click(function(event) {
			event.preventDefault();
			
			location.assign("${ctx}");
		});
		
		
		// 장바구니 버튼 클릭시 실행되는 코드
		$(".btn_cart").click(function(event) {
			event.preventDefault();
			
			location.assign("${ctx}/order/myCart/" + userid);
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
	font-weight: 800;
	margin: 20px;
	border-bottom: 1px solid #ccc;
	width: 100%;
	height: 70px;
	text-align: center;
}



/* 폼 내부 파트별 타이틀 영역 (3개) */

.order_container .title {
	margin-top: 80px;
	padding-left: 180px;
	width: 70%;
}

.order_container .title h4 {
	font-weight: 900;
}



/* 상품정보 */

.order_container .orderInfo_product {
	border-top: 2px solid #bdbebd;
	margin: auto;
	width: 70%;
}

/* 이미지 태그 */

.order_container .orderInfo_product table tbody tr .order_imgTag {
	border: 1px solid #ccc;
	width: 150px;
	height: 100px;
}

.order_container .orderInfo_product table tbody tr td #totalPrice {
	font-weight: 700;
	color: red;
}



/* 유저정보 */

.order_container .orderInfo_user {
 	border-top: 2px solid #bdbebd;
 	border-bottom: 1px solid #ccc;
	margin: auto;
	padding-top: 10px;
	width: 70%;
}



/* 결제정보 */

.order_container .orderInfo_payment {
 	border-top: 2px solid #bdbebd;
 	border-bottom: 1px solid #ccc;
	margin: auto;
	padding-top: 10px;
	padding-bottom: 20px;
	width: 70%;
	text-align: center;
}



/* 총 합계 텍스트 */

.orderInfo_amount {
	text-align: center;
	margin: 50px 0;
}

.orderInfo_amount p #price, .orderInfo_amount p #amount_span {
	font-size: 20px;
	font-weight: 800;
	color: red;
}



/* 맨 아래 버튼 */

.order_sale_btns {
	text-align: center;
}

/* 계속 쇼핑하기 버튼 */

.order_sale_btns .btn_default {
	border: 1px solid #ccc;
}

.order_sale_btns .btn_default:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}

</style>



	<div class="order_container">
	
		<div class="orderHeaderInfo">
			<h1>주문배송조회</h1>
		</div>
		
		<div class="title">
			<h4>1. 상품정보</h4>
			<br> <p>(주문번호 : ${orderDTO.orderId })</p>
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
						<td style="text-transform: uppercase;">[${orderDTO.category}]<br>
							${orderDTO.productName }
						</td>
						
						<!-- 가격 -->
						<td>
							총 금액 : &nbsp; <span id="totalPrice"> <fmt:parseNumber value="${orderDTO.price }" pattern="###,###"/> 원</span><br>
							총 적립금 : &nbsp; <span id="totalPoint"> <fmt:parseNumber value="${orderDTO.price / 100 }" pattern="###,###" integerOnly="true"/> Point</span>
						</td>
						
						<!-- 수량 -->
						<td>${orderDTO.order_quantity }</td>
						
						<!-- 사이즈 -->
						<td>${orderDTO.selected_size }</td>
					</tr>
				</tbody>
			</table>
		</div><!-- class=orderInfo_product -->
		
		
		<div class="title">
			<h4>2. 주문고객/배송지 정보</h4>
			<!-- 주문자 정보 안에 input hidden 으로 보유 point 를 가져옴 -->
			<input type="hidden" value="${orderDTO.point}" name="point" id="userPoint">
		</div>
		
		<div class="orderInfo_user">
			<div class="form-horizontal">
				<div class="mb-3 row">
					<label for="inputId" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<input class="form-control mb-2" id="inputId" placeholder="" name="userid" value="${orderDTO.userid}" readonly>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputName" class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-10">
						<input class="form-control" id="inputName" placeholder="" name="username" value="${orderDTO.username}" readonly>
					</div>
				</div>
				
				<div class="mb-3 row">
					<label for="inputAdd" class="col-sm-2 col-form-label">주소</label>
					<div class="col-sm-10">
						<!-- 우편번호(postcode), 도로명주소(useraddress), 상세주소(detailAddress) 만 가져옴 -->
				    	<input type="text" class="form-control mb-2" id="postcode" name="postcode" placeholder="" value="${orderDTO.postcode}" readonly>&nbsp;
				    	<input type="text" class="form-control mb-2" id="roadAddress" name="useraddress" placeholder="" value="${orderDTO.useraddress}" readonly>
					</div>
				</div>
				
				<div class="mb-3 row">
					<label for="inputEmail" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputEmail" placeholder="" name="email" value="${orderDTO.email}" readonly>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputTel" class="col-sm-2 col-form-label">휴대폰</label>
					<div class="col-sm-10">
						<input type="tel" class="form-control" id="inputTel" placeholder="" name="tel" value="${orderDTO.tel}" readonly>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="InputDelivery_msg" class="col-sm-2 col-form-label">배송메세지</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="InputDelivery_msg" placeholder="" name="delivery_msg" value="${orderDTO.delivery_msg}" readonly>
					</div>
				</div>				
			</div>
		</div><!-- class=orderInfo_user -->
		
		
		<div class="title">
			<h4>3. 결제정보</h4>
		</div>
		
		<div class="row orderInfo_amount">
			<p>결제수단 : <c:if test="${orderDTO.payment_method == 'transfer'}">실시간계좌이체</c:if>
						<c:if test="${orderDTO.payment_method == 'bankbook'}">무통장입금</c:if>
						<c:if test="${orderDTO.payment_method == 'phone_payment'}">핸드폰결제</c:if>
						<c:if test="${orderDTO.payment_method == 'card'}">신용카드</c:if></p>
		
			<p>상품가격 : <span id="price">${orderDTO.price }</span> 원</p>
			
			<p style="font-size: 1.5em;">총 결제금액 : <span id="amount_span">${orderDTO.amount}</span> 원</p>
		</div>
	
	
		<div class="order_sale_btns">
			<button type="button" class="btn btn_default btn_shopping">계속 쇼핑하기</button>
			<button type="button" class="btn btn_default btn_cart">장바구니</button>
		</div>
			
	</div> <!-- order_container -->

<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>


