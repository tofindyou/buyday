<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 상품 정보 수정 버튼 클릭시 실행되는 함수
		/* input[name=productId] : (JQuery 의) name 선택자 */
		var productId = $("input[name=productId]").val();
		
		$("#btn_product_update").click(function() {
			location.assign("${ctx}/product/update/" + productId);
		});
		
		
		// 상품 리스트로 돌아가기 버튼 클릭시 실행되는 함수
		$("#back_to_product_list").click(function() {
			location.assign("${ctx}/admin/product/list");
		});
		
		
		// 상품삭제 버튼 클릭시 실행되는 함수
		$("#btn_product_delete").click(function() {
			var isOK = confirm("상품을 삭제 하시겠습니까? (해당 상품정보는 즉시 삭제되며 되돌릴수 없습니다.)");
			
			if(isOK) {
				location.assign("${ctx}/product/delete/" + productId);
			}
		});
		
		
		
	});

</script>

<style>

/* uploadedInfo (상품 이미지 태그) */

.uploadedInfo {
	float: left;
	width: 40%;
	border: 1px solid #ccc;
	height: 400px;
}



/* productInfo (상품 정보 폼) */

.productInfo {
	float: right;
	width: 50%;
	text-align: left;
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
		
			<div class="form-group uploadedInfo" id="fileDrop">
			</div>
			
			<div class="form-group productInfo">
				<div>
					<label>상품ID</label>
					<input class="form-control" name="productId" value="${productInfo.productId }" readonly>
				</div>
				<div>
					<label>상품명</label>
					<input class="form-control" name="productName" value="${productInfo.productName }" readonly>
				</div>
				<div>
					<label>가격</label>
					<input class="form-control" name="price" value="${productInfo.price }" readonly>
				</div>
				<div>
					<label>수량</label>
					<input class="form-control" name="stock" value="${productInfo.stock }" readonly>
				</div>
				<div>
					<label>카테고리</label>
					<input class="form-control" name="category" value="${productInfo.category }" readonly>
				</div>
				<div>
					<label>상품상세설명</label>
					<input class="form-control" name="productInfo" value="${productInfo.productInfo }" readonly>
				</div>
				<div>
					<label>상품등록날짜</label>
					<input class="form-control" name="regDate" value="${productInfo.regDate }" readonly>
				</div>
				<div>
					<label>상품수정날짜</label>
					<input class="form-control" name="updateDate" value="${productInfo.updateDate }" readonly>
				</div>
				
				<div class="text-center mt-3 row">
					<div>
						<button class="btn btn-warning" id="btn_product_update">상품 수정하기</button>
						<button class="btn btn-info" id="back_to_product_list">상품 리스트로 돌아가기</button>
						<button class="btn btn-danger" id="btn_product_delete">상품삭제</button>
					</div>
				</div>
			</div>
			
		</div> <!-- row -->
	</div> <!-- admin_container -->
	
<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>




