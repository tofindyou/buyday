<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../inc/header.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		// $.getJSON 이용하여 JSON 데이터를 가져오는 코드
		$.getJSON("${ctx}/admin/categoryList/innerwear", function(data) {
			console.log(data);
			
			var html = '';
			 
			$.each(data, function(index, obj) {
			 
				html += '<div class="col-sm-4 col-md-4">';
				html += '<div class="thumbnail">';
				html += '<div id="img_tag"></div>';
				html += '<div class="caption">';
				html += '<h3> [INNERWEAR] ' + obj.productName + '</h3>';
				html +=	'<h3>' + obj.price + '&nbsp;<span>원</span></h3>';
				html += '<p><a href="${ctx}/product/read/' + obj.productId + '" class="btn btn-primary" role="button">상품보기</a></p>';
				html += '</div>';
				html += '</div>';
				html += '</div>';
				
			});
			
			console.log(html);
			
			$(".products").html(html);
			
		});
		
	});

</script>

<style>

.products {

}

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
}

.caption h3 {
	display: inline-block;
	padding: 5px 0;
}

</style>

	<div class="logo">
		<h1>INNERWEAR</h1>
	</div>



	<!-- .row side_nav -->
	<jsp:include page="../inc/side.jsp"></jsp:include>
	
	
	
	<div class="container mt-3">
			
		<div class="row products"></div>
			
	</div>

<!-- .footer -->
<jsp:include page="../inc/footer.jsp"></jsp:include>

</body>
</html>




