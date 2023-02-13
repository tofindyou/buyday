<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 해당 페이지의 productId 값을 변수 productId 로 선언한다.
		var productId = $("#productId").val();
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
		
		
		// 옵션(상품 사이즈)과 구매수량의 select 태그로 값을 바꿨을때 실행되는 코드
		// 주문 내역 미리보기
		$(".select_size, #select_stock").on('change', function() {
			
			var price = $("#price").val(); // 해당 상품의 가격
			
			var opt = $(".select_size").val(); // 선택한 사이즈 옵션
			var count = $("#select_stock").val(); // 선택한 수량
			
			if (count*price >= 30000) { // 상품 총 가격이 30000 원 이상이라면
				var shipping = '무료배송'; // 배송비
				var finalPrice = count*price; // 총 금액
				
			} else { // 상품 총 가격이 30000 원 미만이라면
				var shipping = 2500;
				var finalPrice = (count*price) + shipping;
			}
			
			var str = '';
			
			str += '<p><label>수량 : </label><span>&nbsp;' + count + '</span>&nbsp;&nbsp;&nbsp;';	
			str += '<label>옵션 : </label><span>&nbsp;' + opt + '</span>&nbsp;&nbsp;&nbsp;';	
			str += '<label>배송비 : </label><span>&nbsp;' + shipping + '</span>&nbsp;&nbsp;&nbsp;';
			str	+= '<label>가격 : </label><span>&nbsp;' + price + ' 원</span></p>';
			str += '<h4><label>결제금액 : </label><span>&nbsp;' + finalPrice + ' 원</span></h4>'; 
			
			// 구매수량 옵션 아래에 해당 str 문자열 (태그 모음) 을 출력한다.
			$(".selected_option").html(str);
			
		});
		
		
		// 바로 구매하기 버튼 클릭시 실행되는 코드
		$(".btn_order").click(function(event) {
			event.preventDefault();
			
			// 상품 수량
			var stock = "<c:out value='${productInfo.stock}'/>";
			
			if(userid == null) {
				alert("로그인 후 구매해주세요.")
				location.assign("${ctx}/member/login");
				
			} else {
				
				if (stock == "0") {
					alert("상품 재고가 없습니다..")
					
				} else {
					$(".product_container_form").submit();
				}
			}
		});
		
		
		
	});
	
	// 장바구니 담기 버튼 클릭시 실행되는 코드
	$(document).on("click", ".btn_cart", function(event) {
		event.preventDefault();
		
		var productId = $("#productId").val();
		var userid = $("#login_userid").val();
		
		if(userid == null) { // 로그인이 안되어 있을 경우
			alert("로그인 후 이용해주세요.")
			location.assign("${ctx}/member/login");
			
		} else {
		
			$.ajax({
				
				type : "post",
				url : "${ctx}/order/cart/" + productId,
				data : {
					productId : productId
				},
				dataType : "text",
				success : function(result) {
					
					if(result == "add_success") {
						alert("장바구니에 상품이 등록되었습니다.");
						location.assign("${ctx}/order/myCart/" + userid);
						
					} else if(result == "already_registered") {
						alert("이미 장바구니에 등록된 상품입니다..");
					}
				}
			});
		}
		
	});

</script>

<style>

.product_container_form {
	margin: 0 auto;
	width: 70%;
	height: 700px;
	display: flex; /* flex container */
	/* flex-direction: row; 가 기본값이므로 메인축은 가로이고, 아이템들도 가로로 정렬됨*/
	flex-wrap: wrap; /* 아이템들이 한 줄에 가득차서 넘치게되면 줄바꿈하기 */
	justify-content: space-around; /* 축을 기준으로 아이템들 간의 사이에 균일한 간격을 맞추기 */
	align-items: flex-start; /* 수직 방향으로 시작점(위)부터 정렬 */
}

.product_container_form .productHeaderInfo { /* 첫번째 자식요소 : 카테고리 이름 */
	margin: 20px;
	border-bottom: 1px solid #ccc;
	width: 100%;
	height: 70px;
	text-align: center;
}

.product_container_form .imgTagInfo { /* 두번째 자식요소 : 이미지 태그 아이템 */
	border: 1px solid #ccc;
	flex-basis: 500px; /* 메인축(flex-direction)이 가로이므로 기본 너비값이 500px 으로 설정됨 */
	height: 400px;
}

.product_container_form .productInfo { /* 세번째 자식요소 : 상품 정보 태그 아이템 */
	flex-basis: 500px; /* 메인축(flex-direction)이 가로이므로 기본 너비값이 500px 으로 설정됨 */
}

</style>

	<div class="product_container">
		<form class="product_container_form" action="${ctx}/order/orderSheet" method="post">
			<div class="productHeaderInfo">
				<h1 style="text-transform: uppercase;">[${productInfo.category}] ${productInfo.productName}</h1>
				<!-- 상품ID(productId)의 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
				<input type="hidden" id="productId" value="${productInfo.productId}" name="productId">
			</div>
			
			<div class="imgTagInfo"></div>
	
			<div class="productInfo">
				<div class="form-group" style="text-align: center;">
					<h3 class="page-header"><span style="text-transform: uppercase;">[${productInfo.category}] ${productInfo.productName}</span>
					<br><p style="margin: 5px; font-size: 22px;">${productInfo.productInfo}</p></h3>
				</div>
				
				<hr>
				<div class="form-group" style="text-align: left;">
					<!-- 가격을 JSTL 의 fmt 태그로 number 양식의 문자열로 선언함. -->
					<label>가격 : </label><span>&nbsp;<fmt:formatNumber value="${productInfo.price}" type="number"/></span><span>&nbsp;원</span>
					<!-- 가격(price)을 jQuery 변수로 사용하기위해 input hidden 으로 만들어둔다. -->
					<input type="hidden" value="${productInfo.price}" id="price">
				</div>
				
				<div class="form-group" style="text-align: left;">
					<label>배송비 : </label><span>&nbsp;2,500원</span>
					<p style="margin: auto;">(3만원 이상 결제시 무료배송)</p>
				</div>
				
				<div class="form-group" style="text-align: left;">
					<!-- 적립금은 JSTL 의 fmt 태그로 가격(숫자)의 1/100 만큼의 정수로 값을 받을수 있도록 함. -->
					<label>적립금 : </label><span><fmt:parseNumber value="${productInfo.price / 100}" type="number" var="point" integerOnly="true"/> ${point}&nbsp;원
					<!-- 적립금(point)의 파라미터와 값을 넘길수 있도록 input hidden 으로 만들어둔다. -->
					<input value="${point}" type="hidden" name="point" id="point"></span>
				</div>
				
				<br>
				<c:choose>
					<c:when test="${productInfo.stock != 0 }">
						<div class="form-horizontal" style="text-align: left;">
							<label>옵션 : </label> 
							<select class="form-select select_size" name="selected_size">
								<!-- 상품 size 는 DB 에서 가져온 값이 없으므로 반복문 없이 직접 적는다. -->
								<option value="S">S</option>
								<option value="M">M</option>
								<option value="L">L</option>
							</select>
						</div>
						
						<div class="form-horizontal" style="text-align: left;">
							<label>구매수량 : </label> 
							<select class="form-select" id="select_stock" name="order_quantity">
								<!-- 상품 count 는 DB 에서 가져온 값을 활용하여 JSTL 의 core 태그로 반복문 처리한다. -->
								<c:forEach var="stock" begin="1" end="${productInfo.stock}">
									<option value="${stock}">${stock}</option>
								</c:forEach>
								</select>
						</div>
					</c:when>
					<c:otherwise>
						<h3 style="font-weight: 900; color: red;">현재 상품 재고가 없습니다..</h3>
					</c:otherwise>
				</c:choose>
				<hr>
				<div class="row">
					<!-- 동적 태그가 들어올 공간 -->
					<!-- 이 값 들을 orderSheet.jsp 에 넘기진않고, 일종의 미리보기 역할만 한다. -->
					<div class="selected_option" style="text-align: right;">
					</div>
					
					<div class="product_sale_btns" style="text-align: center;">
						<button type="button" class="btn btn-danger btn_order" type="submit">바로 구매하기</button>
						<button type="button" class="btn btn-success btn_cart">장바구니 담기</button>
					</div>
				</div>
				<hr>	
			</div>
		</form>
	</div> <!-- product_container -->

<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>


