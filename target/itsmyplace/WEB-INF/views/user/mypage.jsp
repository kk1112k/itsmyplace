<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
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
          <li><a class="active"  href="userProfile">Profile</a></li>	
          <li><a href="userPost">My Post</a></li>
          <li><a href="userPayment">Payment Statement</a></li>
          <li><a href="address.html">Address</a></li>
        </ul>
        <div class="dashboard-wrapper dashboard-user-profile">
            <div class="media-body">
              <ul class="user-profile-list">
            <form>
                <div class="form-group">
                    <label for="username">이름 : </label>
                    ${user.userName}
                </div>
                <div class="form-group">
                    <label for="username">지역 : </label>
                    <!-- 유저 지역 추가 -->
                </div>
                <div class="form-group">
                    <label for="username">핸드펀 번호 : </label>
                    <!-- 유저 핸드폰번호 추가 -->
                </div>
                <div class="form-group">
                    <label for="username">이메일 : </label>
                    <!-- 유저 이메일 추가 -->
                </div>
                <input type="hidden" id="userId" name="userId" value="${user.userId}" />
                <input type="hidden" id="userPwd" name="userPwd" value="" />
            </form>
              </ul>
            </div>
             
           <ul class="list-inline dashboard-menu text-right">
                    <a href="/user//updateInfo" class="btn btn-primary">회원정보 수정</a> 
      	   </ul>
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

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