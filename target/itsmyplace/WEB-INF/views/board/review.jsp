<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style type="text/css">
  
.target
{
	display:block;
	white-space:nowrap;
	overflow: hidden;
	text-overflow:ellipsis;
}
  
.star_rating
{
	font-size:0;
	letter-spacing:-4px;
}

.star_rating a
{
    font-size:15px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
}

.star_rating a:first-child
{
	margin-left:0;
}
.star_rating a.on
{
	color:#CC0000;
}
</style>

<script>
$(document).ready(function() {
    
	   $("#btnWrite").on("click", function() {
	      
	      document.reviewForm.hiBbsSeq.value = "";
	      document.reviewForm.action = "/board/reviewWrite";
	      document.reviewForm.submit();
	      
	   });
});
</script>

</head>

<body class="is-loading">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">이용 후기</h1>
					<ol class="breadcrumb">
						<li><a href="/index">Home</a></li>
						<li class="active">Review</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>
 
<section class="products section">
	<div class="container">
		<div class="row">
			<!-- <div class="dashboard-wrapper user-dashboard"> -->	
			
<c:if test="${!empty reviewList}">
	<c:forEach var="review" items="${reviewList}" varStatus="status">
			
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive" src="/resources/images/cafe_01.jfif" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<c:if test="${review.bbsPublic eq 'Y'}">
								<li>
									<button type="button" id="viewModal" data-toggle="modal" onclick="viewModal"> <!-- data-target="#product-modal" -->
										<i class="tf-ion-ios-search-strong"></i>
									</button>
								</li>
								</c:if>
								<li>							
			                        <button type="button"><i class="tf-ion-ios-heart"></i></button>
								</li>
							</ul>
                      	</div>
					</div>
					<div class="product-content">
						<h4><c:out value="${review.bbsTitle}" /></h4>
						<div class="target"><c:out value="${review.bbsContent}" /></div>
						<c:if test="${review.bbsStar == 1.0}">
						<div class="star_rating">
							<a href="#" class="on">★</a>
						    <a href="#" >★</a>
						    <a href="#" >★</a>
						    <a href="#">★</a>
						    <a href="#">★</a>
						</div>
						</c:if>
						<c:if test="${review.bbsStar == 2.0}">
						<div class="star_rating">
							<a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" >★</a>
						    <a href="#">★</a>
						    <a href="#">★</a>
						</div>
						</c:if>
						<c:if test="${review.bbsStar == 3.0}">
						<div class="star_rating">
							<a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#">★</a>
						    <a href="#">★</a>
						</div>
						</c:if>
						<c:if test="${review.bbsStar == 4.0}">
						<div class="star_rating">
							<a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#">★</a>
						</div>
						</c:if>
						<c:if test="${review.bbsStar == 5.0}">
						<div class="star_rating">
							<a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						    <a href="#" class="on">★</a>
						</div>
						</c:if>																		
					</div>
				</div>
			</div>	
			
</c:forEach>
</c:if>

		<!-- 글쓰기 버튼 -->
		<button type="button" id="btnWrite" class="btn btn-main pull-right">글쓰기</button>
		
		<form name="reviewForm" id="reviewForm" method="post">
			<input type="hidden" name="hiBbsSeq" value="" />
			<input type="hidden" name="searchType" value="${searchType}" />
			<input type="hidden" name="searchValue" value="${searchValue}" />
			<input type="hidden" name="curPage" value="${curPage}" />
   		</form>
		
		<!-- 페이징 -->	
		<div class="text-center">
			<ul class="pagination post-pagination">
				<li><a href="blog-left-sidebar.html">Prev</a>
				</li>
				<li class="active"><a href="blog-left-sidebar.html">1</a>
				</li>
				<li><a href="blog-left-sidebar.html">2</a>
				</li>
				<li><a href="blog-left-sidebar.html">3</a>
				</li>
				<li><a href="blog-left-sidebar.html">4</a>
				</li>
				<li><a href="blog-left-sidebar.html">5</a>
				</li>
				<li><a href="blog-left-sidebar.html">Next</a>
				</li>
			</ul>
		</div>	
		
<!-- Modal -->
<c:if test="${!empty reviewList}">
	<c:forEach var="review" items="${reviewList}" varStatus="status">

		<div class="modal product-modal fade" id="product-modal">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<i class="tf-ion-close"></i>
			</button>
		  	<div class="modal-dialog " role="document">
		    	<div class="modal-content">
			      	<div class="modal-body">
			        	<div class="row">
			        		<div class="col-md-8 col-sm-6 col-xs-12">
			        			<div class="modal-image">
				        			<img class="img-responsive" src="/resources/images/cafe_01.jfif" alt="product-img" />
			        			</div>
			        		</div>
			        		<div class="col-md-4 col-sm-6 col-xs-12">
			        			<div class="product-short-details">
			        				<h2 class="product-title"><c:out value="${review.bbsTitle}" /></h2>
			        				<p class="product-price"></p>
						        	<c:if test="${review.bbsStar == 1.0}">
									<div class="star_rating">
										<a href="#" class="on">★</a>
									    <a href="#" >★</a>
									    <a href="#" >★</a>
									    <a href="#">★</a>
									    <a href="#">★</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 2.0}">
									<div class="star_rating">
										<a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" >★</a>
									    <a href="#">★</a>
									    <a href="#">★</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 3.0}">
									<div class="star_rating">
										<a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#">★</a>
									    <a href="#">★</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 4.0}">
									<div class="star_rating">
										<a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#">★</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 5.0}">
									<div class="star_rating">
										<a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									    <a href="#" class="on">★</a>
									</div>
									</c:if>	
			        				<p class="product-short-description"><c:out value="${review.bbsContent}" /></p>
			        				<button class="btn btn-main">수정</button>
			        				<button class="btn btn-main">삭제</button>
			        			</div>
			        		</div>
			        	</div>
			        </div>
		    	</div>
		  	</div>
		</div>
	
	</c:forEach>
</c:if>	
	
<!-- /.modal -->

		<!-- </div> -->
		</div>
	</div>	
</section>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>