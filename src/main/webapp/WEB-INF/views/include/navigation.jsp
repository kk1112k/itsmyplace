<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<br/><br/>
<script>


</script>
<section>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-xs-12 col-sm-4">
				<div class="contact-number">
					<i class="tf-ion-ios-telephone"></i>
					<span style="font-size:15px; color:#000000;">032-876-3332</span>
					<br/>
					<i class="tf-ion-ios-email"></i>
					<span style="font-size:15px; color:#000000;">itsmyplace1@naver.com</span>
				</div>
			</div>
			<div class="col-md-4 col-xs-12 col-sm-4">
				<!-- Site Logo -->
				<div class="logo text-center">
					<a href="/index">
						<!-- replace logo here -->
					<img src="/resources/images/logo.png" alt="image" width="240" height="80" />						
					</a>
				</div>
			</div>
					
			<div class="col-md-4 col-xs-12 col-sm-4"> <!--  한영전환-->
				<%
				if(com.icia.itsmyplace.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
				{
				%>
					<ul class="top-menu text-right list-inline">
						<li class="loginOut" style="font-size:18px;"><a href="/user/loginOut" >로그아웃 </a></li>
					<%

					if(com.icia.common.util.StringUtil.equals(com.icia.itsmyplace.util.CookieUtil.getHexValue(request, (String)request.getAttribute("AUTH_COOKIE_NAME")), "admin")){
					%>
						<li class="adminPage" style="font-size:18px;"><a href="/admin/index">관리 </a>
					<%
					}
					else{
					%>
						<li class="userProfile" style="font-size:18px;"><a href="/mypage/userProfile" > 마이페이지 </a>	
					<%
					}
					%>
					</ul>
					<%				
				}
				else
				{
				%>
				<ul class="top-menu text-right list-inline">
					<li class="login" style="font-size:18px;"><a href="/user/login" >로그인 </a></li>
					<li class="join" style="font-size:18px;"><a href="/user/regForm" >회원가입 </a>	
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
						<a href="/itsmyplace" style="font-size:20px;">내자리얌 </a>
					</li>
					<!-- / 내자리얌 -->
					
					<li class="dropdown ">
						<a href="/notice/list" style="font-size:20px;">공지사항</a>
					</li>

					<!-- 입점카페 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false" style="font-size:20px;">카페 <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">카페 모아보기 </li>
							<li><a href="/cafe/intro" style="font-size:20px;">카페 모아보기</a></li>
							<li><a href="/cafe/detail?cafeNum=A0000001" style="font-size:20px;">카페한잔</a></li>
							<li><a href="/cafe/detail?cafeNum=A0000002" style="font-size:20px;">카페도넛</a></li>
							<li><a href="/cafe/detail?cafeNum=A0000003" style="font-size:20px;">카페노네임</a></li>
							<li><a href="/cafe/detail?cafeNum=A0000004" style="font-size:20px;">카페담다</a></li>
						</ul>
					</li>
					<!-- /입점카페 -->
					
					<!-- 공지사항 -->
					
					<!-- / 공지사항 -->
					
					<!-- 이벤트 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false" style="font-size:20px;">이벤트 <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
						<li class="dropdown-header">이벤트 모아보기</li>
							<li><a href="/event/list" style="font-size:20px;">카페 이벤트</a></li>
						</ul>
					</li>
					<!-- /이벤트-->
					
					
					<!-- 커뮤니티 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false" style="font-size:20px;">커뮤니티 <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
						<li class="dropdown-header">와글와글</li>
							<li><a href="/community/list" style="font-size:20px;">자유게시판</a></li>
							<li><a href="/review/list" style="font-size:20px;">구매후기</a></li>
						</ul>
					</li>
					<!-- /커뮤니티  -->
					
					<!-- 고객센터 -->
					<li class="dropdown dropdown-slide">
						<a href="/" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false" style="font-size:18px;">고객센터 <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
						<li class="dropdown-header">문의사항</li>
							<li><a href="/cs/list" style="font-size:20px;">Q&A</a></li>
							<li><a href="/cs/faq" style="font-size:20px;">FAQ</a></li>
							<!-- <li><a href="/">To. 내자리얌</a></li>
							<li><a href="/">(미사용중)</a></li>-->
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

