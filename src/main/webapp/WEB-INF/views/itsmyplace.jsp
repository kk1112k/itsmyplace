<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script>
	$(document).ready(function(){
		$("#btngoCafePage").on("click", function() {
			location.href = "/cafe/intro";
		});
	});
</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

	<section class="about section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<img class="img-responsive" src="/resources/images/about/about.png" style="margin:-30px; padding:0;">
				</div>
				<div class="text-center"><button type="button" id="btngoCafePage" class="btn btn-main text-center" style="margin-top:30px;">카페 둘러보기</button></div>
			</div>
		</div>
	</section>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>