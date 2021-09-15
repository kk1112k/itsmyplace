<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script>
	$(document).ready(function(){
		$("#btnDetailHanzan").on("click", function() {
			location.href = "/cafe/cafeHanzan";
		});
		
		$("#btnDetailNoname").on("click", function() {
			location.href = "/cafe/cafeNoname";
		});
		
		$("#btnDetailDamda").on("click", function() {
			location.href = "/cafe/cafeDamda";
		});
		
		$("#btnDetailDonut").on("click", function() {
			location.href = "/cafe/cafeDonut";
		});
	});
</script>
</head>
<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<section class="product-category section">
	<div class="container">
		<div class="row">
			<div class="logo text-center" >
				<img src="/resources/images/logo6.png" alt="image" width="250" height="60" />
			</div>
			<br><br><br>
			
			<!-- 카페한잔 -->
			<div class="col-md-6">				
				<div class="content" width="500" height="400">
					<img src="/resources/images/shop/category/hanzan/hanzan.png" width="500" height="400"alt="" />
				</div>
				
				<div >
					<img src="/resources/images/shop/category/hanzan/reviewhanzan.png" width="500" height="100"alt="" />
				</div>		    
				<div class="text-center">
					<br/>				      
					<button type="button" id="btnDetailHanzan" class="btn btn-main text-center">자세히 보기</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnReg" class="btn btn-main text-center">예약하기</button>
				</div>
				<br/><br/><br/><br/>
				
				<!-- 노네임 -->
				<div class="content" width="500" height="400">
					<img src="/resources/images/shop/category/noname/noname.png" width="500" height="400"alt="" />
				</div>
				
				<div >
					<img src="/resources/images/shop/category/noname/reviewnoname.png" width="500" height="100"alt="" />
				</div>		    
				<div class="text-center">
					<br/>				      
					<button type="button" id="btnDetailNoname" class="btn btn-main text-center">자세히 보기</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnReg" class="btn btn-main text-center">예약하기</button>
				</div>
				<br/><br/>
			</div>
			
			<!-- 카페담다 -->
			<div class="col-md-6">
				<div class="content" width="500" height="400">
					<img src="/resources/images/shop/category/damda/damda.png" width="500" height="400"alt="" />
				</div>
					
				<div >
					<img src="/resources/images/shop/category/damda/reviewdamda.png" width="500" height="100"alt="" />
				</div>
					<br/>	
				<div class="text-center">
					<button type="button" id="btnDetailDamda" class="btn btn-main text-center">자세히 보기</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnReg" class="btn btn-main text-center">예약하기</button>
				</div>
				
				<br/><br/><br/><br/>
				
			<!-- 카페 도넛 -->
				<div class="content">
					<img src="/resources/images/shop/category/donut/donut.png" width="500" height="400"alt="" />
				</div>
				
				<div >
					<img src="/resources/images/shop/category/donut/reviewdonut.png" width="500" height="100"alt="" />
				</div>
					<br/>	
				<div class="text-center">
					<button type="button" id="btnDetailDonut" class="btn btn-main text-center">자세히 보기</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" id="btnReg" class="btn btn-main text-center">예약하기</button>
				</div>
				
				
			<div class="col-md-6">
				
			</div>
		</div>
	</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>