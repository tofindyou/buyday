<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
		
		
		
		// 계속 쇼핑하기 버튼 클릭시 실행되는 코드
		$(".btn_shopping").click(function(event) {
			event.preventDefault();
			
			location.assign("${ctx}");
		});
		
		
		// 바로주문 버튼 클릭시 실행되는 코드 (상품 개별적으로 주문하기)
		// URL 에 현재 보낼 수 있는 파라미터들을 모두 담아서 GET 방식으로 보냄
		$(".btn_order").click(function(event) {
			event.preventDefault();
			
			// 이전요소 선택자 로 해당 버튼과 같은 행에 있는 정보들을 각각의 변수로 담음
			var productId = $(this).parent().prev().prev().prev().prev().prev().children("#productId").attr("value");
			var point = $(this).parent().prev().prev().prev().prev().children("#point").attr("value");
			var selected_size = $(this).parent().prev().prev().children().val();
			var order_quantity = $(this).parent().prev().prev().prev().children().val();
		
			console.log(productId, point, selected_size, order_quantity);
			
			if (order_quantity == "0") { // 해당 상품의 재고가 없으면
				alert("상품 재고가 없습니다.. 다른 상품을 선택해주세요.")
			
			} else { // 해당 상품의 재고가 있으면
				location.assign("${ctx}/order/orderSheet?productId="+productId+"&point="+point+"&selected_size="+selected_size+"&order_quantity="+order_quantity);
			}
			
		});
		
		
		// 삭제하기 버튼 클릭시 수행되는 함수
		$(".btn_delete").click(function() {
			event.preventDefault();
			
			var productId = $(this).parent().prev().prev().prev().prev().prev().children("#productId").attr("value");
		
			if (confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")) {
				
				$.ajax({
				
					type : "post",
					url : "${ctx}/cart/deleteCart",
					data : {
						userid : userid,
						productId : productId
					},
					dataType : "text",
					success : function(result) {
						
						if (result == "OK") {
							alert("장바구니에서 삭제되었습니다.")
							location.assign("${ctx}/order/myCart/" + userid);
						} 
						
					}
				});
			}
			
		});
		
		
		
		
		
		
	});

</script>

<style>

.cart_container {
	margin: 50px auto;
	width: 70%;
}

.cart_container .cartHeaderInfo {
	margin: 20px;
	border-bottom: 1px solid #ccc;
	width: 100%;
	height: 70px;
	text-align: center;
}



/* 테이블 */

.cart_container .cartInfo_table {
	border-top: 2px solid #bdbebd;
	margin: 50px auto;
	width: 90%;
}



/* 장바구니가 비어있을때 텍스트 */

.cart_container .cartInfo_table #cartForm table tbody tr .empty_cart {
	height:200px;
	text-align: center;
	padding-top: 70px;
	font-wehigt: 900;
	font-size: 30px;
}



/* 이미지 태그 */

.cart_container .cartInfo_table #cartForm table tbody tr .cart_imgTag {
	border: 1px solid #ccc;
	width: 150px;
	height: 100px;
}



/* 상품Id 버튼 */

.cart_container .cartInfo_table #cartForm table tbody tr td .cart_productId {
	display: inline-block;
	padding: 2px;
	border: 1px solid #87CEFA;
	border-radius: 5px;
	font-weight: 700;
	color: #87CEFA;
}

.cart_container .cartInfo_table #cartForm table tbody tr td .cart_productId:hover {
	background-color: #87CEFA;
	color: white;
}



.button_box {
	display: flex;
	flex-direction: column;
}

/* 삭제하기 버튼 */

.button_box .btn_delete {
	margin-top: 10px;
	margin-bottom: 40px;
	border: 1px solid #ccc;
}

.button_box .btn_delete:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}



/* 계속 쇼핑하기 버튼 */

.cart_sale_btns .btn_shopping {
	border: 1px solid #ccc;
}

.cart_sale_btns .btn_shopping:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}

</style>


<!-- OrderController 에서 가져온 Map 에서 cartList 와 productList 를 꺼내서 변수로 선언 -->
<c:set var="cartList" value="${cartMap.cartList }"></c:set>
<c:set var="productList" value="${cartMap.productList }"></c:set>


	<div class="cart_container">
		<div class="cartHeaderInfo">
			<h1>장바구니</h1>
		</div>

		<div class="cartInfo_table">
			<form action="" method="post" id="cartForm">
				<table class="table table-hover">
					<thead>
						<tr>
							<th colspan="2" class="th_colspan2" style="text-align: center;">
								상품정보
							</th>
							<th>가격</th>
							<th>수량</th>
							<th>사이즈</th>
							<th>상품설명</th>
							<th class="button_space"></th>
						</tr>
					</thead>
					<tbody>
						<!-- JSTL core 태그 조건문의 시작 -->
						<c:choose>
							<c:when test="${productList == null }">
								<tr>
									<td colspan="7" class="empty_cart">장바구니에 저장하신 상품이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
							
								<!-- JSTL core 태그의 forEach 반복문의 시작 -->
								<!-- 값을 화면에 출력할때는 pList. 으로 입력하고, -->
								<!-- 값을 담을때는 producList[status.index]. 으로 입력하자. -->
								<c:forEach var="pList" items="${productList }" varStatus="status">
									<tr>
										<!-- 이미지 태그 -->
										<td>
											<div class="cart_imgTag"></div>
										</td>
										
										<!-- 상품 정보 -->
										<td style="text-transform: uppercase;">[${pList.category}]
											<!-- ${productList[status.index].productId} 는 상품 리스트에서 현재 상품에 대한 개별적 productId 임. -->
											<!-- a 태그의 href 속성에는, JSTL core 태그 forEach 문의 의 별칭을 사용할수 없다. -->
											<br> <a class="cart_productId" href="${ctx}/product/view/${productList[status.index].productId}"> ${pList.productName }</a>
											<!-- 상품ID(productId) 의 개별 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
											<input value="${productList[status.index].productId}" type="hidden" name="productId" id="productId">
										</td>
										
										<!-- 가격 -->
										<td> <fmt:formatNumber value="${pList.price }" type="number" var="price" />${price }&nbsp;원 <br>
											<span>(-) <fmt:parseNumber value="${pList.price / 100}" type="number" var="point" integerOnly="true"/>${point }&nbsp;원 </span>
											<!-- 적립금(point)의 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
											<input value="${point }" type="hidden" name="point" id="point">
										</td>
										
										<!-- 수량 -->
										<td>
											<c:choose>
												<c:when test="${pList.stock != 0}">
													<select name="order_quantity" id="order_quantity">
														<c:forEach var="stock" begin="1" end="${pList.stock }">
															<option value="${stock}">${stock}</option>
														</c:forEach>
													</select>
												</c:when>
												<c:otherwise>
													<!-- 바로주문 버튼 클릭시, 재고가 없다면 JQuery 에 의해서 해당 버튼이 비활성화된다. -->
													<input type="hidden" value="0">
													<span style="color: red;">재고 부족</span>
												</c:otherwise>
											</c:choose>
										</td>
										
										<!-- 사이즈 -->
										<td>
											<select name="selected_size" id="selected_size">
												<option value="S">S</option>
												<option value="M">M</option>
												<option value="L">L</option>
											</select>
										</td>
										
										<!-- 상품 설명 -->
										<td>${pList.productInfo }</td>
										
										<!-- 버튼 -->
										<td class="button_box">
											<button style="width: 90px;" type="button" class="btn btn-danger btn_order">바로주문</button>
											<button style="width: 90px;" type="button" class="btn btn-default btn_delete">삭제하기</button>
										</td>
									</tr>
								</c:forEach>
								<!-- JSTL core 태그의 forEach 반복문의 끝 -->
								
							</c:otherwise>
						</c:choose>
						<!-- JSTL core 태그 조건문의 끝 -->
					</tbody>
				</table>
			</form>
		</div>
		
		<div class="row">
			<div class="cart_sale_btns" style="text-align: center;">
				<button type="button" class="btn btn_shopping">계속 쇼핑하기</button>
			</div>
		</div>
		
	</div> <!-- cart_container -->

<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>


