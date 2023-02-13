<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="member/inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// header.jsp 에 있는 subnav 요소들을 누르면
		// 해당 카테고리에 대한 상품을 home.jsp 에 동적인 태그로 띄워주고
		// 해당 위치로 스크롤 시켜주는 코드
		$("li.subnav").on('click', function() {
			var category = $(this).attr("value");
			
			$("h1.category_logo").html(category); // h1 태그의 텍스트도 같이 변수인 category 값으로 바꿔준다.
			
			// $.getJSON 을 이용하여 해당 category 에 해당 하는 상품 정보를 JSON 데이터로 가져와서 썸네일 구조로 출력하는 코드
			$.getJSON("${ctx}/admin/categoryList/" + category, function(data) {
				console.log(data);
				
				var html = '';
				 
				$.each(data, function(index, obj) {
				 
					html += '<div class="col-sm-4 col-md-4">';
					html += '<div class="thumbnail">';
					html += '<div id="img_tag">';
					html += '<input style="width:240px; height:200px;" type="button" id="input_productId" value="' + obj.productId + '">';
					html += '</div>'
					html += '<div class="caption">';
					html += '<h3 style="text-transform: uppercase;"> [' + obj.category + '] ' + obj.productName + '</h3>';
					html +=	'<h3>' + obj.price + '&nbsp;<span>원</span></h3>';
					html += '<p><button class="btn btn-success btn_cart">장바구니 담기</button></p>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
					
				});
				
				console.log(html);
				
				$(".products").html(html);
				
				// 상품 상세보기 (catergory_view) 로 스크롤이 이동하는 코드
				var scrollPosition = $(".catergory_view").offset().top;
				$("html").animate({scrollTop: scrollPosition}, 10);
				
			});
			
		});
		
		// header.jsp 에 있는 ALL 을 누르면 실행되는 코드
		$("li.all_nav").on('click', function() {
			
			$("h1.category_logo").html("all");
			
			// $.getJSON 을 이용하여 모든 상품 정보를 JSON 데이터로 가져와서 썸네일 구조로 출력하는 코드
			$.getJSON("${ctx}/admin/allList", function(data) {
				console.log(data);
				
				var html = '';
				 
				$.each(data, function(index, obj) {
				 
					html += '<div class="col-sm-4 col-md-4">';
					html += '<div class="thumbnail">';
					html += '<div id="img_tag">';
					html += '<input style="width:240px; height:200px;" type="button" id="input_productId" value="' + obj.productId + '">';
					html += '</div>'
					html += '<div class="caption">';
					html += '<h3 style="text-transform: uppercase;"> [' + obj.category + '] ' + obj.productName + '</h3>';
					html +=	'<h3>' + obj.price + '&nbsp;<span>원</span></h3>';
					html += '<p><button class="btn btn-success btn_cart">장바구니 담기</button></p>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
					
				});
				
				console.log(html);
				
				$(".products").html(html);
				
				// 상품 상세보기 (catergory_view) 로 스크롤이 이동하는 코드
				var scrollPosition = $(".catergory_view").offset().top;
				$("html").animate({scrollTop: scrollPosition}, 10);
				
			});
			
		});
		
		
		
	});
	
	
	
	// 썸네일의 이미지 태그 클릭시 수행되는 코드
	// # 동적으로 생성된 태그 (썸네일 태그) 에 이벤트 부여하는 방법
	// $(document).on 을 이용한다.
	// 1. 파라미터 첫번째 값 : click, change 등의 이벤트
	// 2. 파라미터 두번째 값 : 이벤트를 적용할 타겟 태그
	// 3. 파라미터 세번째 값 : 동작 함수
	$(document).on("click", "#input_productId", function() { // 상품 썸네일에서 input 태그 클릭시 수행되는 함수
		// 해당 input 태그 안의 value 값을 변수로 선언한다.
		var productId = $(this).attr('value');
		
		location.assign("${ctx}/product/view/" + productId);
	});

	
	
	// 썸네일 상품의 장바구니 담기 버튼 클릭시 실행되는 코드
	$(document).on("click", ".btn_cart", function(event) {
		event.preventDefault();
		
		// 다음과 같이 만들면 첫번째 썸네일 상품 input value 값만 불러오는 에러가 발생한다.
		// var productId = $("#input_productId").val();
		
		// 따라서 썸네일 마다 해당하는 상품 input value 값을 불러오려면 다음과 같이 만든다.
		// 부모, 이전, 자식 요소 선택 함수 이용
		// 선택 순서 : (this) 카트버튼 > (부모) p 태그 > (부모) div caption 태그 > (이전) div img 태그 > (자식) input 태그
		var productId = $(this).parent().parent().prev().children().attr('value');
		
		// header.jsp 에서 hidden 타입의 input 에 담겨있는 userid 값을 가져와 변수로 선언한다.
		var userid = $("#login_userid").val();
		
		
		if(userid == null) { // 로그인이 안되어 있을 경우
			alert("로그인 후 이용해주세요.")
			location.assign("${ctx}/member/login");
			
		} else {
		
			$.ajax({
				
				type : "post",
				// 해당 경로의 메서드는 장바구니에 상품이 있는지 확인하고 없으면 등록한다.
				url : "${ctx}/order/cart/" + productId,
				data : {
					productId : productId
				},
				dataType : "text",
				success : function(result) {
					
					if(result.trim() == "add_success") {
						alert("장바구니에 상품이 등록되었습니다.");
						location.assign("${ctx}/order/myCart/" + userid);
						
					} else if(result.trim() == "already_registered") {
						alert("이미 장바구니에 등록된 상품입니다..");
					}
				}
			});
		}
		
	});
	
	
	
	

</script>

<style>

.home_header {
	margin: 20px auto;
	width: 38%;
	border-bottom: 1px solid #ccc;
	height: 50px;
	text-align: center;
}



/* carousel */

.carousel-item {
	position: relative;
}

.carousel-item .carousel-text {
	position: absolute;
	top: 40%;
	left: 25%;
	width: 100%;
	transform: translate(-50%, -50%);
	font-size: 20px;
	text-align: center;
	color: white;
	font-weitht: bold;
	text-shadow: 2px 2px 2px black;
}

.carousel-item .carousel-text p {
	margin-bottom: 10px;
}



/* category_scroll */

.category_scroll {
	margin: 80px auto;
	width: 70%;
}

.category_scroll .catergory_view {
	border-top: 1px solid #888;
	border-bottom: 1px solid #888;
	padding: auto;
	height: 60px;
	width: 100%;
}

.category_scroll .catergory_view:hover {
	background-color: grey;
}

.category_scroll .catergory_view p {
	padding: 10px;
	text-align: center;
	font-size: 25px;
	font-weight: 800;
	color: black;
}



/* thumbnail */

.thumbnail {
	margin: 30px;
	border: 1px solid #ccc;
	text-align: center;
}

#img_tag {
	display: inline-block;
	border: 1px solid #ccc;
	margin: 10px;
	width: 240px;
	height: 200px;
	color: white;
}

.caption h3 {
	display: inline-block;
	padding: 5px 0;
}



/*  */




</style>

	<div class="home_header">
		<h1>BUYDAY 에 오신 것을 환영합니다! </h1>
	</div>
	
	<!-- carousel -->
	<div class="container-fluid p-0">
		<div id="demo" class="carousel slide" data-bs-ride="carousel">
		
			<!-- Indicators/dots -->
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
				<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
				<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
				<button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
				<button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
			</div>
		
			<!-- The slideshow/carousel -->
			<div class="carousel-inner">
			
				<div class="carousel-item active" data-bs-interval="3000">
					<div class="carousel-img">
						<img src="${ctx}/img/outer.jpg" alt="..." class="d-block w-100">
					</div>
					<div class="carousel-text">
						<p>2023 SPRING SEASON</p>
						<h2>OUTER</h2>
						<p>봄처럼 산뜻한 아우터</p>
					</div>
			    </div>
			    
				<div class="carousel-item">
					<div class="carousel-img">
						<img src="${ctx}/img/tops.jpg" alt="..." class="d-block w-100">
					</div>
					<div class="carousel-text">
						<p>2023 SPRING SEASON</p>
						<h2>TOPS</h2>
						<p>어디서나 어울리는 캐주얼 맨투맨</p>
					</div>
				</div>
				
				<div class="carousel-item">
					<div class="carousel-img">
						<img src="${ctx}/img/bottoms.jpg" alt="..." class="d-block w-100">
					</div>
					<div class="carousel-text">
						<p>2023 SPRING SEASON</p>
						<h2>BOTTOMS</h2>
						<p>일상 속에 편안한 팬츠</p>
					</div>
				</div>
				
				<div class="carousel-item">
					<div class="carousel-img">
						<img src="${ctx}/img/innerwear.jpg" alt="..." class="d-block w-100">
					</div>
					<div class="carousel-text">
						<p>2023 SPRING SEASON</p>
						<h2>INNERWEAR</h2>
						<p>공기처럼 가벼운 이너웨어</p>
					</div>
				</div>
				
				<div class="carousel-item">
					<div class="carousel-img">
						<img src="${ctx}/img/accessories.jpg" alt="..." class="d-block w-100">
					</div>
					<div class="carousel-text">
						<p>2023 SPRING SEASON</p>
						<h2>ACCESSORIES</h2>
						<p>더욱 다채로워진 악세서리</p>
					</div>
				</div>
			</div>
		
			<!-- Left and right controls/icons -->
			<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
				<span class="carousel-control-next-icon"></span>
			</button>
		</div>	
	</div>
	<!-- /carousel -->
	
	
	<div class="category_scroll">
		<div class="catergory_view">
			<p>상품 카테고리 별로 보기</p>
		</div>

		
		<div class="logo" style="margin-left: 400px;">
			<h1 class="category_logo" style="padding: 30px 10px; text-transform: uppercase;">상단에서 카테고리를 선택해주세요.</h1>
		</div>
		<div class="container mt-3">
			<div class="row products"></div>
		</div>
		
	</div>

<!-- .footer -->
<jsp:include page="member/inc/footer.jsp"></jsp:include>

</body>
</html>
