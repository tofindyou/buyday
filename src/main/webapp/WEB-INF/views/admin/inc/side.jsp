<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<script type="text/javascript">

	$(document).ready(function() {
		
		// subnav 를 누르면 해당 페이지로 이동시켜주는 코드
		$("li.subnav").on('click', function() {
			var category = $(this).attr("value");
			
			location.assign("${ctx}/admin/category/" + category);
		});
		
	});

</script>

<!-- style 은 main.css 에서 관리한다. -->

	<div class="side_nav">
		<nav>
			<ul class="nav">
				<li class="subnav" value="outer"><a>OUTER</a></li>
				<li class="subnav" value="tops"><a>TOPS</a></li>
				<li class="subnav" value="bottoms"><a>BOTTOMS</a></li>
				<li class="subnav" value="innerwear"><a>INNERWEAR</a></li>
				<li class="subnav" value="accessories"><a>ACCESSORIES</a></li>
			</ul>
		</nav>
	</div>
	
	
	
	