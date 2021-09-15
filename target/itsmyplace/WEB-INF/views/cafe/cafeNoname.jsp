<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<!-- 카페 상세페이지 상단바 -->
<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<section class="single-product">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<ol class="breadcrumb">
					<li><a href="index.html">메인페이지 </a></li>
					<li><a href="shop.html">카페</a></li>
					<li class="active">상세 페이지</li>
				</ol>
			</div>
			<div class="col-md-6">
				<ol class="product-pagination text-right">
					<li><a href="blog-left-sidebar.html"><i class="tf-ion-ios-arrow-left"></i> 다음 카페 </a></li>
					<li><a href="blog-left-sidebar.html">이전 카페 <i class="tf-ion-ios-arrow-right"></i></a></li>
				</ol>
			</div>
		</div>
<!-- 카페 상세페이지 상단바 끝 -->

<!-- 카페 소개 메인 시작 -->
		<div class="row mt-20">
			<div class="col-md-5">
				<div class="single-product-slider">
					<div id='carousel-custom' class='carousel slide' data-ride='carousel'>
						<div class='carousel-outer'>
						
							<!-- 카페 소개 사진 슬라이드 시작 -->
							<div class='carousel-inner '>
								<div class='item active'>
									<img src='/resources/images/shop/single-products/noname/product-1.png' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-1.png" />
								</div>
								<div class='item'>
									<img src='/resources/images/shop/single-products/noname/product-2.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-2.jpg" />
								</div>
								
								<div class='item'>
									<img src='/resources/images/shop/single-products/noname/product-3.jpg' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-3.jpg" />
								</div>
								<div class='item'>
									<img src='/resources/images/shop/single-products/noname/product-4.jpeg' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-4.jpeg" />
								</div>
								<div class='item'>
									<img src='/resources/images/shop/single-products/noname/product-5.jpeg' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-5.jpeg" />
								</div>
								<div class='item'>
									<img src='/resources/images/shop/single-products/noname/product-6.jpeg' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-6.jpeg" />
								</div>
								<div class='item'>
									<img src='/resources/images/shop/single-products/noname/product-7.jpeg' alt='' data-zoom-image="/resources/images/shop/single-products/noname/product-7.jpeg" />
								</div>							
							</div>
							
							<!-- 슬라이더 -->
							<a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
								<i class="tf-ion-ios-arrow-left"></i>
							</a>
							<a class='right carousel-control' href='#carousel-custom' data-slide='next'>
								<i class="tf-ion-ios-arrow-right"></i>
							</a>
						</div>
						
						<!-- 썸네일 -->
						<ol class='carousel-indicators mCustomScrollbar meartlab'>
							<li data-target='#carousel-custom' data-slide-to='0' class='active'>
								<img src='/resources/images/shop/single-products/noname/product-1.png' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='1'>
								<img src='/resources/images/shop/single-products/noname/product-2.jpg' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='2'>
								<img src='/resources/images/shop/single-products/noname/product-3.jpg' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='3'>
								<img src='/resources/images/shop/single-products/noname/product-4.jpeg' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='4'>
								<img src='/resources/images/shop/single-products/noname/product-5.jpeg' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='5'>
								<img src='/resources/images/shop/single-products/noname/product-6.jpeg' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='6'>
								<img src='/resources/images/shop/single-products/noname/product-7.jpeg' alt='' />
							</li>
							<li data-target='#carousel-custom' data-slide-to='7'>
								<img src='/resources/images/shop/single-products/noname/product-8.jpeg' alt='' />
							</li>	
						</ol>
					</div>
				</div>
			</div>
			
<!-- 카페 설명 -->
			<div class="col-md-7">
				<div class="single-product-details">
					<h2>노네임</h2>
					<p class="product-price">#가성비 #번화가</p>
					
					<p class="product-description mt-20">
					
					안녕하세요. 이름없는 카페 '노네임'입니다. <br><br>
					저희 노네임은 멈춰진 일상에 ‘활력’을 넣고, 변화를 공유하며, <br>
					어디에서든 모두에게 닿을 수 있는 부분을 찾고자 합니다. <br><br>
					우리의 맥락은 합정점을 시작으로, 한남, 부평까지 이어지게 되었습니다. <br>
					우리가 만드는 공간들은 새롭고 낯선 시간의 직접적 경험을 제공하며<br><br>
					모두의 작업실이자 스스로 정의를 내릴 수 있는 곳이길 바랍니다.<br><br>				
					</p>
					<p>영업시간 : am10 ~ pm22, 연중무휴</p><br>
					<p>	BEST 자두스무디<br>
					BEST 비엔나 커피<br>
					BEST 망고에이드<br></p>
					<a href="/cafe/reservation?cafenum=A0000003" class="btn btn-main mt-20">예약 하러가기</a>
					<a href="cart.html" class="btn btn-cart mt-20">장바구니</a>
				</div>
			</div>
		</div>
		
<!-- 지도와 리뷰 시작 -->
		<div class="row">
			<div class="col-xs-12">
				<div class="tabCommon mt-20">
				<!-- 지도 시작 -->
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#details" aria-expanded="true">위치 보기</a></li>
						<li class=""><a data-toggle="tab" href="#reviews" aria-expanded="false">리뷰</a></li>
					</ul>
					<div class="tab-content patternbg">
						<div id="details" class="tab-pane fade active in">
							<p><img class="media-object comment-avatar" src="/resources/images/blog/map/noname.png" alt=""/></p>
						</div>
				<!-- 지도 종료 -->
				
				<!-- 리뷰1 시작 -->
						<div id="reviews" class="tab-pane fade">
							<div class="post-comments">
						    	<ul class="media-list comments-list m-bot-50 clearlist">
								    <li class="media">
								        <a class="pull-left" href="#!">
								            <img class="media-object comment-avatar" src="/resources/images/blog/review/noname/3.png" alt="" width="1100" height="150">
								        </a>
								    </li>
				<!-- 리뷰1 끝 -->
				
				<!-- 리뷰2 시작 -->
								  <li class="media">
								        <a class="pull-left" href="#!">
								            <img class="media-object comment-avatar" src="/resources/images/blog/review/noname/2.png" alt="" width="1100" height="150">
								        </a>
								    </li>
				<!-- 리뷰2 끝 -->
				
				<!-- 리뷰3 시작 -->
								    <li class="media">
								        <a class="pull-left" href="#!">
								            <img class="media-object comment-avatar" src="/resources/images/blog/review/noname/1.png" alt="" width="1100" height="150">
								        </a>
								    </li>								
								</ul>
							</div>
						</div>
				<!-- 리뷰3 끝 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--  지도와 리뷰 종료  -->

<!-- 다른카페 둘러보기 시작 -->
<section class="products related-products section">
	<div class="container">
		<div class="row">
			<div class="title text-center">
				<h2>다른카페 둘러보기</h2>
			</div>
		</div>
<!-- 해당카페 -->
		<div class="row">
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive" src="/resources/images/shop/products/aroundcafe/noname.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li>
									<span  data-toggle="modal" data-target="#product-modal">
										<i class="tf-ion-ios-search"></i>
									</span>
								</li>
							</ul>
                      	</div>
					</div>
					<div class="product-content">
						<h4><a href="product-single.html">Reef Boardsport</a></h4>
						<p class="price">노네임</p>
					</div>
				</div>
			</div>
			
<!-- 카페 담다 -->
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive" src="/resources/images/shop/products/aroundcafe/damda.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li>
									<span  data-toggle="modal" data-target="#product-modal2">
										<i class="tf-ion-ios-search"></i>
									</span>
								</li>
							</ul>
                      	</div>
					</div>
					<div class="product-content">
						<h4><a href="product-single.html">Rainbow Shoes</a></h4>
						<p class="price">담다</p>
					</div>
				</div>
			</div>

<!-- 카페 도넛 -->
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive" src="/resources/images/shop/products/aroundcafe/donut.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li>
									<span  data-toggle="modal" data-target="#product-modal3">
										<i class="tf-ion-ios-search"></i>
									</span>
								</li>
							</ul>
                      	</div>
					</div>
					<div class="product-content">
						<h4><a href="product-single.html">Strayhorn SP</a></h4>
						<p class="price">커피 도넛</p>
					</div>
				</div>
			</div>
			
<!-- 카페 한잔 -->			
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive" src="/resources/images/shop/products/aroundcafe/hanzan.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li>
									<span  data-toggle="modal" data-target="#product-modal4">
										<i class="tf-ion-ios-search"></i>
									</span>
								</li>
							</ul>
                      	</div>
					</div>					
					<div class="product-content">
						<h4><a href="product-single.html">Bradley Mid</a></h4>
						<p class="price">카페 한잔</p>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</section>

<!-- 다른카페 둘러보기 버튼 누르면 나오는 화면-->
  <!-- 해당 카페 시작 -->
	<div class="modal product-modal fade" id="product-modal">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<i class="tf-ion-close"></i>
		</button>
	  	<div class="modal-dialog " role="document">
	    	<div class="modal-content">
		      	<div class="modal-body">
		        	<div class="row">
		        		<div class="col-md-8">
		        			<div class="modal-image">
			        			<img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modalnoname.jpg  />
		        			</div>
		        		</div>
		        		<div class="col-md-3">
		        			<div class="product-short-details">
		        				<h5 class="product-title">인천 부평구 부평대로38번길 1,2층</h5>
		        				<p class="product-price">노네임</p>
		        				<p class="product-short-description">
		        					<p>영업시간 : am10 ~ pm22, 연중무휴</p><br>
									<p>	BEST 자두스무디<br>
										BEST 비엔나 커피<br>
										BEST 망고에이드<br>
									</p>
		        				</p>
		        				<a href="/cafe/cafeNoname" class="btn btn-main">자세히 보기</a>
		        			</div>
		        		</div>
		        	</div>
		        </div>
	    	</div>
	  	</div>
	</div>
<!-- 해당 카페 끝 -->

<!-- 2번째 카페 시작 -->
	<div class="modal product-modal fade" id="product-modal2">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<i class="tf-ion-close"></i>
		</button>
	  	<div class="modal-dialog " role="document">
	    	<div class="modal-content">
		      	<div class="modal-body">
		        	<div class="row">
		        		<div class="col-md-8">
		        			<div class="modal-image">
			        			<img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modaldamda.png  />
		        			</div>
		        		</div>
		        		<div class="col-md-3">
		        			<div class="product-short-details">
		        				<h5 class="product-title">인천 남동구 인주대로604 49-14 1층</h5>
		        				<p class="product-price">카페 담다</p>
		        				<p class="product-short-description">
		        					<p>영업시간 : am10 ~ pm22, 연중무휴</p><br>
									<p>	BEST 배도라지<br>
										BEST 석류 오미자<br>
										BEST 복숭아 홍차<br>
									</p>
		        				</p>
		        				<a href="/cafe/cafeDamda" class="btn btn-main">자세히 보기</a>
		        			</div>
		        		</div>
		        	</div>
		        </div>
	    	</div>
	  	</div>
	</div>
<!-- 2번째 카페 끝 -->

<!-- 3번째 카페 시작 -->
	<div class="modal product-modal fade" id="product-modal3">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<i class="tf-ion-close"></i>
		</button>
	  	<div class="modal-dialog " role="document">
	    	<div class="modal-content">
		      	<div class="modal-body">
		        	<div class="row">
		        		<div class="col-md-8">
		        			<div class="modal-image">
			        			<img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modaldonut.jpg  />
		        			</div>
		        		</div>
		        		<div class="col-md-3">
		        			<div class="product-short-details">
		        				<h5 class="product-title">인천 연수구 아트센터대로 107 302동 168호 3층</h5>
		        				<p class="product-price">카페 도넛</p>
		        				<p class="product-short-description">
		        					<p>영업시간 : am10 ~ pm21, 매주 수요일 휴무</p><br>
									<p>	BEST 심슨도넛<br>
										BEST 티라미수<br>
										BEST 까망 라떼<br>
									</p>
		        					</p>
		        				<a href="/cafe/cafeDonut" class="btn btn-main">자세히 보기</a>
		        			</div>
		        		</div>
		        	</div>
		        </div>
	    	</div>
	  	</div>
	</div>	
		
<!-- 3번째 카페 끝 -->

<!-- 4번째 카페 시작 -->
	<div class="modal product-modal fade" id="product-modal4">
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<i class="tf-ion-close"></i>
		</button>
	  	<div class="modal-dialog " role="document">
	    	<div class="modal-content">
		      	<div class="modal-body">
		        	<div class="row">
		        		<div class="col-md-8">
		        			<div class="modal-image">
			        			<img class="img-responsive" src=/resources/images/shop/products/aroundcafe/modalhanzan.jpg  />
		        			</div>
		        		</div>
		        		<div class="col-md-3">
		        			<div class="product-short-details">
		        				<h5 class="product-title">인천 중구 신포로35길 17 1층</h5>
		        				<p class="product-price">카페 한잔</p>
		        				<p class="product-short-description">
		        					<p>영업시간 : am10 ~ pm21, 매주 일요일 휴무</p><br>
									<p>	BEST 쿠앤크 빙수<br>
										BEST 크로크무슈<br>
										BEST 피스타치오 라떼<br></p>
		        				</p>
		        				<a href="/cafe/cafeHanzan" class="btn btn-main">자세히 보기</a>
		        			</div>
		        		</div>
		        	</div>
		        </div>
	    	</div>
	  	</div>
	</div>
<!-- 4번째 카페 끝 -->

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>
  </html>