<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// name 속성 선택자를 이용하여, 해당 name 의 input 요소 안의 값 (${productInfo.productId }) 을
		// 변수 productId 에 선언해둔다.
		var productId = $("input[name=productId]").val();
		

		// 카테고리를 선택하고 입력하기 버튼 클릭시 실행되는 함수
		$("#btn_category").on('click', function(event) {
			event.preventDefault();
			var category = $("#category option:selected").val();
			$("input[name='category']").val(category);
		});

		
		// 상품정보로 돌아가기 버튼 클릭시 실행되는 함수
		$("#back_to_product_read").click(function() {
			location.assign("${ctx}/product/read/" + productId);
		});
		
		
		
		
		
	});

</script>

<style>

/* uploadedInfo (상품 이미지 업로드 태그) */

/* 업로드 태그 전체를 감싸는 div */
.uploadedInfo {
	float: left;
	width: 40%;
	border: 1px solid #ccc;
	height: 400px;
}

/* 업로드 태그 안에 div */
.fileDrop {
	float: left;
	width: 100%;
	height: 400px;
}



/* productInfo (상품 정보 폼) */

.productInfo {
	float: right;
	width: 50%;
	text-align: left;
}



/* 카테고리 태그 */

.form-inline {
	display: flex;
}

.form-inline select, .form-inline button, .form-inline input {
	margin: 0 10px;
	width: auto;
}

.form-inline select {
	cursor: pointer;
}

.form-inline button {
	border: 1px solid #ccc;
}

.form-inline button:hover {
	border: 1px solid #ccc;
	background-color: #ccc;
	color: white;
}

</style>

	<div class="logo">
		<h1>${productInfo.productName }</h1>
	</div>



	<!-- .row side_nav -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
	
	
	<div class="container admin_container mt-3">
		<!-- div row 속성으로 인해 하위 자식간에 가로 정렬 -->
		<div class="row">
		
			<!-- file 업로드 태그 -->
			<div class="form-group uploadedInfo" id="fileDrop">
				<div class="fileDrop"></div>
			</div>
			<!-- /file 업로드 태그 -->
			
			<div class="form-group productInfo">
				<form action="${ctx}/product/update" method="post">
					<div>
						<label>상품ID</label>
						<input class="form-control" name="productId" value="${productInfo.productId }" readonly>
					</div>
					<div>
						<label>상품명</label>
						<input class="form-control" name="productName" value="${productInfo.productName }">
					</div>
					<div>
						<label>가격</label>
						<input class="form-control" name="price" value="${productInfo.price }">
					</div>
					<div>
						<label>수량</label>
						<input class="form-control" name="stock" value="${productInfo.stock }">
					</div>
					
					<div>
						<label>카테고리</label>
						<!-- 카테고리는 select 태그로 정해진 값만 넣도록 한다. -->
						<div class="form-inline">
							<select class="form-select" id="category">
								<option value="outer">1. 아우터</option>
								<option value="tops">2. 상의</option>
								<option value="bottoms">3. 하의</option>
								<option value="innerwear">4. 이너웨어</option>
								<option value="accessories">5. 악세서리</option>
							</select>
							<button class="btn btn-default" id="btn_category">입력하기</button>
							<input class="form-control" name="category" value="${productInfo.category }" readonly>
						</div>
					</div>
					
					<div>
						<label>상품상세설명</label>
						<input class="form-control" name="productInfo" value="${productInfo.productInfo }">
					</div>
					<div>
						<label>상품등록날짜</label>
						<!-- name 속성을 지정하지 않는다. why? 서버로 넘어가서 변경되면 안되는 값이다. -->
						<input class="form-control" value="${productInfo.regDate }" readonly>
					</div>
					<div>
						<label>상품수정날짜</label>
						<!-- name 속성을 지정하지 않는다. why? 서버로 넘기지 않아도, Mapper 의 update 쿼리문 작성시에 현재시간 (default) 으로 수정할 수 있다.  -->
						<input class="form-control" value="${productInfo.updateDate }" readonly>
					</div>
					
					<div class="text-center mt-3 row">
						<div>
							<button class="btn btn-warning" id="btn_product_update">상품수정</button>
							<button class="btn btn-success" id="back_to_product_read">상품정보로 돌아가기</button>
						</div>
					</div>
				</form>
			</div>
			
		</div> <!-- row -->
	</div> <!-- admin_container -->
	
<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>






