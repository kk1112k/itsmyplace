<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/style.css">
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Frequently Asked Questions</h1>
					<br/>
					<ul class="list-inline dashboard-menu text-left">
			          <li><a href="/cs/list">Home</a></li>	
			          <li><a class="active" href="/cs/faq">FAQ</a></li>
			        </ul>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="page-wrapper">
		<div class="container">
		<h2>Frequently Asked Questions</h2>
					<p>궁금한 점을 찾을 수 있다면 도움말을 확인해 주세요.</p>
					<p>admin@icia.co.kr</p>
			<ul class="accordion">
		      <li class="item">
		         <h2 class="accordionTitle">"정지된 계정입니다" 라는 문구가 뜨면서 로그인이 되지 않습니다. <span class="accIcon"></span></h2>
		         <div class="text">저희 내자리얌은 비방·욕설 글에 대하여 1아웃제를 운영하고 있으며 이에 해당하는 회원은 글 삭제와 동시에 회원 정지 처리됩니다. 사이트 유저들을 위하여 보다 깨끗한 네티즌 문화를 만들어갑시다. </div>
		      </li>
		      <li class="item">
		         <h2 class="accordionTitle">결제했어요! 포인트 적립은 상시 2%만 적립되는건가요? <span class="accIcon"></span></h2>
		         <div class="text">예, 그렇습니다. 결제금액의 2%를 포인트로 적립해드립니다. 추후 꾸준히 저희 시스템을 이용해주시는 고객님들을 위해 5%의 포인트 적립 제도를 운영할 예정입니다.</div>
		      </li>
		      <li class="item">
		         <h2 class="accordionTitle">결제 수단이 부족해요. <span class="accIcon"></span></h2>
		         <div class="text">저희 내자리얌은 카카오페이 결제를 우선적으로 장려하고 있습니다. 추후 네이버페이, 계좌이체, 신용카드 결제 등 결제 시스템이 도입될 예정입니다.</div>
		      </li>
		      <li class="item">
		         <h2 class="accordionTitle">예약을 했는데 취소하고 싶어요. 환불은 어떻게 이루어지나요? <span class="accIcon"></span></h2>
		         <div class="text">환불은 없습니다. 결제했으면 끝입니다.</div>
		      </li>
		      <li class="item">
		         <h2 class="accordionTitle">이거 프로젝트 언제 끝나요? <span class="accIcon"></span></h2>
		         <div class="text">빨리 끝났으면 좋겠어요</div>
		      </li>
		   </ul>
		</div>
</section>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>


    <!-- 
    Essential Scripts
    =====================================-->
    
    <!-- Main jQuery -->
    <script src="/resources/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="/resources/plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap Touchpin -->
    <script src="/resources/plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <!-- Instagram Feed Js -->
    <script src="/resources/plugins/instafeed/instafeed.min.js"></script>
    <!-- Video Lightbox Plugin -->
    <script src="/resources/plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
    <!-- Count Down Js -->
    <script src="/resources/plugins/syo-timer/build/jquery.syotimer.min.js"></script>

    <!-- slick Carousel -->
    <script src="/resources/plugins/slick/slick.min.js"></script>
    <script src="/resources/plugins/slick/slick-animation.min.js"></script>

    <!-- Google Mapl -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
    <script type="text/javascript" src="/resources/plugins/google-map/gmap.js"></script>

    <!-- Main Js File -->
    <script src="/resources/js/script.js"></script>
    


  </body>
</html>
