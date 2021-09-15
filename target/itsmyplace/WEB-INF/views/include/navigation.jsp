<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<br/><br/>
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-xs-12 col-sm-4">
				<div class="contact-number">
					<i class="tf-ion-ios-telephone"></i>
					<span>0129- 12323-123123</span>
				</div>
			</div>
			<div class="col-md-4 col-xs-12 col-sm-4">
				<!-- Site Logo -->
				<div class="logo text-center">
					<a href="/index">
						<!-- replace logo here -->
					<img src="/resources/images/logo.png" alt="image" width="180" height="60" />						
					</a>
				</div>
			</div>
					
			<div class="col-md-4 col-xs-12 col-sm-4">
				<%
				if(com.icia.itsmyplace.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
				{
				%>
				<ul class="top-menu text-right list-inline">
					<li class="loginOut"><a href="/user/loginOut" >LOGOUT </a></li>
					<li class="userProfile"><a href="/user/userProfile" > MYPAGE </a>
				</ul>
				<%
				}
				else
				{
				%>
				<ul class="top-menu text-right list-inline">
					<li class="login"><a href="/user/login" >LOGIN </a></li>
					<li class="join"><a href="/user/regForm" >REGISTER </a>	
				</ul>
				<%
				}
				%>
			</div>
		</div>
	</div>
</section>
<!-- End Top Header Bar -->
<br/><br/>
<!-- Main Menu Section -->
<section class="menu">
	<nav class="navbar navigation">
		<div class="container">
			<div class="navbar-header">
				<h2 class="menu-title">Main Menu</h2>
			</div><!-- / .navbar-header -->

			<!-- Navbar Links -->
			<div id="navbar" class="navbar-collapse collapse text-center">
				<ul class="nav navbar-nav">

					<!-- 내자리얌 -->
					<li class="dropdown ">
						<a href="/itsmyplace">ABOUT </a>
					</li>
					<!-- / 내자리얌 -->
					
					<li class="dropdown ">
						<a href="/notice/list">NOTICE</a>
					</li>

					<!-- 입점카페 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">CAFE <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">카페 모아보기 </li>
							<li><a href="/cafe/intro">카페 모아보기</a></li>
							<li><a href="/cafe/cafeDonut">커피 도넛</a></li>
							<li><a href="/cafe/cafeNoname">노네임</a></li>
							<li><a href="/cafe/cafeDamda">카페 담다</a></li>
							<li><a href="/cafe/cafeHanzan">카페 한잔</a></li>
						</ul>
					</li>
					<!-- /입점카페 -->
					
					<!-- 공지사항 -->
					
					<!-- / 공지사항 -->
					
					<!-- 이벤트 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">EVENT <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
						<li class="dropdown-header">이벤트 모아보기</li>
							<li><a href="/board/eventBoard">카페 이벤트</a></li>
							<li><a href="/test">(미사용중1)</a></li>
							<li><a href="/">(미사용중)</a></li>
						</ul>
					</li>
					<!-- /이벤트-->
					
					<!-- 구매후기 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">REVIEW <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/board/review">구매후기</a></li>
							<li><a href="/">(미사용중)</a></li><!-- 이달의후기왕 -->
						</ul>
					</li>
					<!-- /구매후기 -->
					
					<!-- 커뮤니티 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">COMMUNITY <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
						<li class="dropdown-header">와글와글</li>
							<li><a href="/community/list">자유게시판</a></li>
							<li><a href="/">(미사용중)</a></li>
							<li><a href="/">(미사용중)</a></li>
							<li><a href="/">(미사용중)</a></li>
						</ul>
					</li>
					<!-- /커뮤니티  -->
					
					<!-- 고객센터 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">Q&A <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
						<li class="dropdown-header">뱅뱅사거리</li>
							<li><a href="/cs/list">고객센터</a></li>
							<li><a href="/cs/faq">FAQ</a></li>
							<li><a href="/">To. 내자리얌</a></li>
							<li><a href="/">(미사용중)</a></li>
						</ul>
					</li>
					<!-- /고객센터  -->
					<br/><br/>
				</ul><!-- / .nav .navbar-nav -->

			</div>
			<!--/.navbar-collapse -->
		</div><!-- / .container -->
	</nav>
</section>

