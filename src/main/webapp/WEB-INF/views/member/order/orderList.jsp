<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
		
		// input hidden 요소 안에 있는 orderId 값을 변수로 선언함
		var orderId = $("#orderId").val();
		
		
		
		// 계속 쇼핑하기 버튼 클릭시 실행되는 코드
		$(".btn_shopping").click(function(event) {
			event.preventDefault();
			
			location.assign("${ctx}");
		});
		
		
		
	});

</script>

<style>

.orderList_container {
	margin: 50px auto;
	width: 70%;
}

.orderList_container .orderListHeaderInfo {
	margin: 20px;
	border-bottom: 1px solid #ccc;
	width: 100%;
	height: 70px;
	text-align: center;
}



/* 테이블 */

.orderList_container .orderListInfo_table {
	border-top: 2px solid #bdbebd;
	margin: 50px auto;
	width: 90%;
}



/* 주문 내역이 비어있을때 텍스트 */

.orderList_container .orderListInfo_table table tbody tr .empty_orderList {
	height:200px;
	text-align: center;
	padding-top: 70px;
	font-wehigt: 900;
	font-size: 30px;
}



/* 이미지 태그 */

.orderList_container .orderListInfo_table table tbody tr .orderList_imgTag {
	border: 1px solid #ccc;
	width: 150px;
	height: 100px;
}



/* 상품Id, 배송완료 버튼 */

.orderList_container .orderListInfo_table table tbody tr td a {
	display: inline-block;
	padding: 2px;
	border: 1px solid #87CEFA;
	border-radius: 5px;
	background-color: white;
	font-weight: 700;
	color: #87CEFA;
}

.orderList_container .orderListInfo_table table tbody tr td a:hover {
	background-color: #87CEFA;
	color: white;
}



/* 계속 쇼핑하기 버튼 */

.orderList_sale_btns .btn_shopping {
	border: 1px solid #ccc;
}

.orderList_sale_btns .btn_shopping:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}

</style>



	<div class="orderList_container">
		<div class="orderListHeaderInfo">
			<h1>주문내역</h1>
		</div>

		<div class="orderListInfo_table">
			<table class="table table-hover">
				<thead>
					<tr>
						<th colspan="2" class="th_colspan2" style="text-align: center;">
							상품명
						</th>
						<th>가격</th>
						<th>수량</th>
						<th>사이즈</th>
						<th>결제금액</th>
						<th>결제일</th>
						<th>배송현황</th>
					</tr>
				</thead>
				<tbody>
					<!-- JSTL core 태그 조건문의 시작 -->
					<c:choose>
						<c:when test="${orderList == null }">
							<tr>
								<td colspan="8" class="empty_orderList">주문하신 상품이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
						
							<!-- JSTL core 태그의 forEach 반복문의 시작 -->
							<c:forEach var="dto" items="${orderList }" varStatus="status">
								<tr>
									<!-- 이미지 태그 -->
									<td>
										<div class="orderList_imgTag"></div>
									</td>
									
									<!-- 상품 정보 -->
									<td style="text-transform: uppercase;">[${dto.category}]
										<!-- ${productList[status.index].productId} 는 상품 리스트에서 현재 상품에 대한 개별적 productId 임. -->
										<!-- a 태그의 href 속성에는, JSTL core 태그 forEach 문의 의 별칭을 사용할수 없다. -->
										<br> <a class="orderList_orderId" href="${ctx}/order/orderRead/${dto.orderId}"> ${dto.productName }</a>
										<!-- 주문ID(orderId) 의 개별 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
										<input value="${orderId}" type="hidden" name="orderId" id="orderId">
									</td>
									
									<!-- 가격 -->
									<td> <fmt:parseNumber value="${dto.price }"/> &nbsp;원 <br>
									</td>
									
									<!-- 수량 -->
									<td>${dto.order_quantity}</td>
									
									<!-- 사이즈 -->
									<td>${dto.selected_size}</td>
									
									<!-- 결제금액 -->
									<td> <fmt:parseNumber value="${dto.amount}"/> &nbsp;원 </td>
									
									<!-- 결제일 -->
									<td> <fmt:formatDate value="${dto.orderDate}" type="date" pattern="yyyy-MM-dd"/> </td>
									
									<!-- 배송현황 -->
									<td> ${dto.delivery_status == 0 ? "배송 준비중" : dto.delivery_status == 1 ? "배송중" : "배송완료"}
										<br>
										<a class="delivery_end" href="${ctx}/order/deliveryEnd/${dto.orderId}">배송완료</a> </td>
									
								</tr>
							</c:forEach>
							<!-- JSTL core 태그의 forEach 반복문의 끝 -->
							
						</c:otherwise>
					</c:choose>
					<!-- JSTL core 태그 조건문의 끝 -->
				</tbody>
			</table>
		</div>
		
		<div class="row">
			<div class="orderList_sale_btns" style="text-align: center;">
				<button type="button" class="btn btn_shopping">계속 쇼핑하기</button>
			</div>
		</div>
		
	</div> <!-- cart_container -->

<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>


