<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script type="text/javascript">

function fn_view(bbsSeq)
{
   document.bbsForm.hiBbsSeq.value = bbsSeq;
   document.bbsForm.action = "/board/view";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.hiBbsSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/board/list";
   document.bbsForm.submit();   
}

</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- Modal -->
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
		        			<img class="img-responsive" src="resources/images/shop/products/modal-product.jpg" alt="product-img" />
	        			</div>
	        		</div>
	        		<div class="col-md-4 col-sm-6 col-xs-12">
	        			<div class="product-short-details">
	        				<h2 class="product-title">GM Pendant, Basalt Grey</h2>
	        				<p class="product-price">$200</p>
	        				<p class="product-short-description">
	        					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rem iusto nihil cum. Illo laborum numquam rem aut officia dicta cumque.
	        				</p>
	        				<a href="cart.html" class="btn btn-main">Add To Cart</a>
	        				<a href="product-single.html" class="btn btn-transparent">View Product Details</a>
	        			</div>
	        		</div>
	        	</div>
	        </div>
    	</div>
  	</div>
</div><!-- /.modal -->

<body id="body">

<!--상단-->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<ol class="breadcrumb">
						<li><a href="index.html">Home</a></li>
						<li class="active">My Account</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 본문 -->
<section class="user-dashboard page-wrapper" style="padding-top: 0px;">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <ul class="list-inline dashboard-menu text-center">
          <li><a href="userProfile">Profile</a></li>	
          <li><a class="active"  href="userPost">My Post</a></li>
          <li><a href="userPayment">Payment Statement</a></li>
          <li><a href="address.html">Address</a></li>
        </ul>


			<div class="dashboard-wrapper user-dashboard">
					<h3>내 글 관리</h3>
            <div class="list-style">
                <div class="sort_area">
                    <a href="/board/review" class="link_sort on">후기게시판</a>
                    <a href="" class="link_sort on">자유게시판</a>
                    <a href="" class="link_sort">작성 댓글</a>
                </div>
            </div>
            
		<div class="table-responsive">
			<table class="table">
				<thead>
               	 <tr>
                    <th scope="col"></th>
         <th scope="col" class="text-center" style="width:10%">번호</th>
         <th scope="col" class="text-center" style="width:55%">제목</th>
         <th scope="col" class="text-center" style="width:15%">날짜</th>
              	  </tr>
             	</thead>
					<tbody>
    <!--
<c:if test="${!empty list}">
   <c:forEach var="Board" items="${list}" varStatus="status">      
      <tr>
      <c:choose>
         <c:when test="${review.BbsCondent eq 0}">
         <td class="text-center">${review.RsrvSeq}</td>
         </c:when>
         <c:otherwise>
         <td class="text-center"></td>
         </c:otherwise>
      </c:choose>
      <td><input type="checkbox" name="post" onclick="check();"></td>
         <td>
            <a href="javascript:void(0)" onclick="fn_view(${review.RsrvSeq})">
      <c:if test="${Board.BbsCondent > 0}">      
            <img src="/resources/images/icon_reply.gif" style="margin-left: ${review.BbsCondent}em;"/>
      </c:if>      	
            <c:out value="${review.BbsTitle}" />
            </a>
         </td>
         <td class="text-center">${review.Date}</td>
      </tr>
   </c:forEach>
</c:if>      -->

	<c:if test="${!empty reviewList}">
		<c:forEach var="review" items="${reviewList}" varStatus="status">      
	<tr>
		<td class="text-center"><c:out value="${review.RsrvSeq}" /></td>
		<td class="text-center">${review.bbsTitle}</td>
		<td class="text-center">${review.RegDate}</td>
	</tr>
		</c:forEach>
	</c:if>   
	
  				</tbody>	
			</table>
		</div>
	
		<!-- 하단 -->	
   <nav>
      <ul class="pagination justify-content-center">
<c:if test="${!empty paging}">      
   <c:if test="${paging.prevBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
   </c:if>
   <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
      <c:choose>
         <c:when test="${i ne curPage}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
         </c:when>
         <c:otherwise>
         <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>         
         </c:otherwise>
      </c:choose>
   </c:forEach>
         
   <c:if test="${paging.nextBlockPage gt 0}">
         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
   </c:if>
</c:if>
      </ul>
   </nav>
        <td>
           <input type="checkbox" name="post" value="전체선택" id="all" onclick="allcheck();"><label>전체선택</label>
        </td>
	<ul class="list-inline dashboard-menu text-right">
  		 <button type="button" id="btndelete" class="btn btn-primary">삭제</button>
 	</ul>
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="BbsSeq" value="" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
</div>
					
				</div>
			</div>
		</div>

</section>



<footer class="footer section text-center">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<ul class="social-media">
					<li>
						<a href="https://www.facebook.com/themefisher">
							<i class="tf-ion-social-facebook"></i>
						</a>
					</li>
					<li>
						<a href="https://www.instagram.com/themefisher">
							<i class="tf-ion-social-instagram"></i>
						</a>
					</li>
					<li>
						<a href="https://www.twitter.com/themefisher">
							<i class="tf-ion-social-twitter"></i>
						</a>
					</li>
					<li>
						<a href="https://www.pinterest.com/themefisher/">
							<i class="tf-ion-social-pinterest"></i>
						</a>
					</li>
				</ul>
				<ul class="footer-menu text-uppercase">
					<li>
						<a href="contact.html">CONTACT</a>
					</li>
					<li>
						<a href="shop.html">SHOP</a>
					</li>
					<li>
						<a href="pricing.html">Pricing</a>
					</li>
					<li>
						<a href="contact.html">PRIVACY POLICY</a>
					</li>
				</ul>
				<p class="copyright-text">Copyright &copy;2021, Designed &amp; Developed by <a href="https://themefisher.com/">Themefisher</a></p>
			</div>
		</div>
	</div>
</footer>
    <!-- 
    Essential Scripts
    =====================================-->
    
    <!-- Main jQuery -->
    <script src="plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap Touchpin -->
    <script src="plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <!-- Instagram Feed Js -->
    <script src="plugins/instafeed/instafeed.min.js"></script>
    <!-- Video Lightbox Plugin -->
    <script src="plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
    <!-- Count Down Js -->
    <script src="plugins/syo-timer/build/jquery.syotimer.min.js"></script>

    <!-- slick Carousel -->
    <script src="plugins/slick/slick.min.js"></script>
    <script src="plugins/slick/slick-animation.min.js"></script>

    <!-- Google Mapl -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
    <script type="text/javascript" src="plugins/google-map/gmap.js"></script>

    <!-- Main Js File -->
    <script src="js/script.js"></script>
    


  </body>
  </html>