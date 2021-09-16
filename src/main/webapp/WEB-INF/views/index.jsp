<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style type="text/css">
.col-md-3
{
	height:410px;
}

.product-content .target
{
	display:block;
	font-weight:nomal;
	white-space:nowrap;
	overflow: hidden;
	text-overflow:ellipsis;
}
  
.star_rating, .star_rating_modal
{
	font-size:0;
	letter-spacing:-4px;
}

.star_rating a
{
    font-size:18px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
}

.star_rating_modal a
{
    font-size:25px;
    letter-spacing:0;
    display:inline-block;
    margin-left:5px;
    color:#ccc;
    text-decoration:none;
}

.star_rating a:first-child, .star_rating_modal a:first-child
{
	margin-left:0;
}
.star_rating a.on, .star_rating_modal a.on
{
	color:#CC0000;
}

.section .container .row
{
	position: relative;
}

.section .container .row nav
{
	position: absolute;
	bottom: -10vh;
	left: 49.5%;
}
</style>

<script>


function fn_moveUrl(cafeNum){
   
   console.log(cafeNum);
   
   $('#cafeNum').val(cafeNum);
   var check = document.getElementById('cafeNum').val;
   
   console.log(check);
   
   document.indexForm.action="/cafe/reservation";
   document.indexForm.submit();
}

function fn_alert(){
   
   alert("로그인 후 예약가능합니다.");
}

$(document).ready(function(){
    $.ajax({
      
      type: "POST",
      url: "/index/indexProc",
      data: "",
      dataType: "JSON",
      success: function(response){
         if(response.code == 0)
         {   
            var cafeListLength = response.data.length;
             
            for(var i=0; i<cafeListLength; i++)
            {
               console.log(response.data[i]);
               
               var cafeNum = response.data[i].cafeNum;
               var seatVacancyCnt = response.data[i].seatVacancyCnt;
            
               console.log(seatVacancyCnt);
               
               var vacancyStr = '남은좌석 ' + seatVacancyCnt + '/20';
               
               $('#'+cafeNum+'vacancy').text(vacancyStr);
            }         
         }
         else
         {
            alert("카페 자리정보를 불러오는데 실패했습니다.");
         }
      },
      error: function(xhr, status, error){
         icia.common.error(error);
      }
   }); 
})

</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2500">
   <!-- Indicators -->
   <ol class="carousel-indicators">
      <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
      <li data-target="#carousel-example-generic" data-slide-to="1"></li>
      <li data-target="#carousel-example-generic" data-slide-to="2"></li>
      <li data-target="#carousel-example-generic" data-slide-to="3"></li>
   </ol>

   <!-- Wrapper for slides -->
   <div class="carousel-inner index-slider-back-custom" role="listbox">
      <div class="item active">
         <img class="index-slider-image-custom" src="/resources/images/slider/slider-1.png" alt="슬라이더 이미지-1">
<!--       <div class="carousel-caption"></div> -->
      </div>
      <div class="item">
         <img class="index-slider-image-custom" src="/resources/images/slider/slider-2.png" alt="슬라이더 이미지-2">
<!--       <div class="carousel-caption"></div> -->
      </div>
      <div class="item">
         <img class="index-slider-image-custom" src="/resources/images/slider/slider-3.png" alt="슬라이더 이미지-3">
<!--       <div class="carousel-caption"></div> -->
      </div>
      <div class="item">
         <img class="index-slider-image-custom" src="/resources/images/slider/slider-4.png" alt="슬라이더 이미지-4">
<!--       <div class="carousel-caption"></div> -->
      </div>
   </div>
   
   <!-- Controls -->
   <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
      <span class="index-slider-button-custom" aria-hidden="true"></span>
      <span class="index-slider-leftArrow-custom" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
   </a>
   <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
      <span class="index-slider-button-custom" aria-hidden="true"></span>
      <span class="index-slider-rightArrow-custom" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
   </a>
</div>
<!-- 
<div id="carouselExampleControls" class="carousel slide">
<div class="hero-slider">
  <div class="slider-item th-fullpage hero-area" style="background-image: url(resources/images/slider/slider-1.png);">
    <div class="container">
      <div class="row">
      </div>
    </div>
  </div>
   <div class="slider-item th-fullpage hero-area" style="background-image: url(resources/images/slider/slider-2.png);">
    <div class="container">
      <div class="row">
      </div>
    </div>
  </div>
   <div class="slider-item th-fullpage hero-area" style="background-image: url(resources/images/slider/slider-3.png);">
    <div class="container">
      <div class="row">
      </div>
    </div>
  </div>
   <div class="slider-item th-fullpage hero-area" style="background-image: url(resources/images/slider/slider-4.png);">
    <div class="container">
      <div class="row">
      </div>
    </div>
  </div>
 </div>
</div>
 -->
<br/><br/>
<!-- 입점카페섹션 시작 -->
<section class="product-category index-section-custom">
   <div class="container">
      <div class="row">
         <div class="col-md-12">
            <div class="index-logo-custom logo text-left" style="float:left">
               <img src="resources/images/logo3.png" alt="입점카페이미지" height="100" />
            </div>
            <div class=index-info-text style="display:inline-block">카페정보를 확인하시고 지금바로 예약하세요!</div>
         </div>
                  
         <c:if test="${!empty cafeList}">
            <c:forEach var="cafeList" items="${cafeList}" varStatus="status">
               <div class="col-md-6">
                  <div class="category-box">
                     <a id="${cafeList.cafeNum}img" href="/cafe/detail?cafeNum=${cafeList.cafeNum}">
                     <c:choose>
                        <c:when test="${!empty cafeList.cafePhtList}">
                           <img src="/resources/upload/cafe/${cafeList.cafePhtList[0].phtName}" alt="카페이미지"/>
                        </c:when>
                        <c:otherwise>
                           <img src="/resources/images/event/end.png" alt="카페사진없음이미지"/>
                        </c:otherwise>
                     </c:choose>
                     </a>
                  </div>
                  <div class="index-cafeNameTag">
                     <div class="index-cafeNameText" id="${cafeList.cafeNum}cafeName">${cafeList.cafeName}</div>
                     <div class="index-cafeSubText" id="${cafeList.cafeNum}cafeKeyword">${cafeList.cafeKeyword}</div>
                     <div class="index-cafeVacancy" id="${cafeList.cafeNum}vacancy"></div>
                  </div>
                  <c:if test="${!empty user}">
                     <c:if test="${user.userClass eq 'N'}">
                        <button type="button" id="${cafeList.cafeNum}rsrv" class="btn btn-main mb-3 mx-1 index-btn-custom" onClick="fn_moveUrl('${cafeList.cafeNum}')" style="height:45px;">예약바로가기</button>
                     </c:if>
                  </c:if>
               </div>
            </c:forEach>
         </c:if>
      </div>   
   </div>
</section>
<!-- 입점카페섹션 종료 -->

<!-- 이벤트섹션 시작 -->
<section class="product-category section">
   <div class="container">
      <div class="row">
         <div class="col-md-12">
            <div class="index-logo-custom logo text-left" style="float:left">
               <img src="resources/images/event.png" alt="이벤트카테고리이미지" height="100" />
            </div>
            <div class=index-info-text style="display:inline-block">현재 진행 중인 최신 이벤트 정보를 확인하세요!</div>
         </div>
         <c:if test="${!empty eventList}">
            <c:forEach var="eventList" items="${eventList}" varStatus="status">
               <div class="col-md-4">
                  <div class="index-eventNameTag">
                     <c:set var="titleLength" value="${fn:length (eventList.bbsTitle)}" />
                     <c:choose>
                     <c:when test="${titleLength > 20}">
                     <div class="index-eventNameText" id="${eventList.bbsSeq}bbsTitle"><c:set var="title" value="${eventList.bbsTitle}" />${fn:substring(title,0,8)}...</div>
                     </c:when>
                     <c:otherwise>
                     <div class="index-eventNameText" id="${eventList.bbsSeq}bbsTitle">${eventList.bbsTitle}</div>
                     </c:otherwise>
                     </c:choose>                     
                     <div class="index-eventSubText" id="${eventList.bbsSeq}evtDate">${eventList.evtOpnDate}&nbsp;&nbsp;-&nbsp;&nbsp;${eventList.evtClsDate}</div>
                  </div>
                  <div class="category-box category-box-custom2">
                     <a id="${eventList.bbsSeq}img" href="/event/view?bbsSeq=${eventList.bbsSeq}">
                        <c:choose>
                           <c:when test="${!empty eventList.eventBoardFile.fileName}">
                              <img src="/resources/upload/event/${eventList.eventBoardFile.fileName}" style="width:100%; height:100%;" alt="${eventList.bbsSeq}이벤트이미지"/>
                           </c:when>
                           <c:otherwise>
                              <img src="/resources/upload/event/No-Image.png" alt="이벤트종료이미지"/>
                           </c:otherwise>
                        </c:choose>
                     </a>
                  </div>
               </div>
            </c:forEach>
         </c:if>
      </div>
   </div>
</section>
<!-- 이벤트섹션 종료 -->

<!--  리뷰 시작 -->
<section class="product-category index-section-custom">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
            	<div class="index-logo-custom logo text-left" style="float:left">
               		<img src="/resources/images/logo4.png" alt="리뷰 카데고리 이미지" height="100" />
           		</div>
            	<div class=index-info-text style="display:inline-block">실시간으로 등록되는 최신 리뷰를 확인하세요!</div>
         	</div>
		</div>
		
		<c:if test="${!empty reviewList}">
			<c:forEach var="review" items="${reviewList}" varStatus="status">
					<div class="col-md-4">
						<div class="product-item">
							<div class="product-thumb">
								<img class="img-responsive" src="/resources/upload/review/${review.phtName}" alt="" onError="this.src='/resources/upload/review/No_img.jpg'" />
								<div class="preview-meta">
									<ul>
										<c:if test="${review.bbsPublic eq 'Y'}">
										<li>
											<button type="button" class="searchBtn" id="viewModal" data-toggle="modal" data-target="#product-modal" value="${review.rsrvSeq}" 
											title="${review.bbsTitle}" content="${review.bbsContent}" star="${review.bbsStar}" cafe="${review.cafeName}" userId="${review.userId}">
												<i class="tf-ion-ios-search-strong" style="font-size:20px;"></i>
											</button>
										</li>
										</c:if>
									</ul>
		                      	</div>
							</div>
							<div class="product-content" style="margin-top: 5px;">
								<a class="product-content">
									<i class="tf-ion-android-happy" style="color:#000000" ><c:out value="${review.cafeName}" /></i>
								</a>
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
								<div class="target" style="font-size:x-large; margin-top: 5px; margin-bottom: 5px; color:#000000;"><c:out value="${review.bbsTitle}" /></div>
								<a class="product-content">
									<i class="tf-ion-android-person" ><c:out value="${review.userId}" /></i>
								</a>																
							</div>
						</div>
					</div>
			</c:forEach>
		</c:if>
		<div class="text-center"><button type="button" id="btngoReview" class="btn btn-main"><a href="review/list" style="color:#fbf9d3;">리뷰로 이동</a></button></div>
	</div>
</section>

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
							 <div class="col-md-5" style="width:550px;">
								<div class="single-product-slider">
									 <div id='carousel-custom' class='carousel slide' data-ride='carousel'>
										<div class='carousel-outer'>
											<div class='carousel-inner' id="carousel-inner">
												<div class="item active">
													<img src="/resources/upload/review/No_img.jpg" alt="" data-zoom-image="/resources/upload/review/No_img.jpg" />
												</div>
												<!-- 이미지가 들어가는 부분 -->
											</div>
											<!-- 슬라이드 버튼 -->
											<a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
												<i class="tf-ion-ios-arrow-left"></i>
											</a>
											<a class='right carousel-control' href='#carousel-custom' data-slide='next'>
												<i class="tf-ion-ios-arrow-right"></i>
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
	        		<div class="col-md-4 col-sm-6 col-xs-12">
	        			<div class="product-short-details">
	        				<div class="product-title" style="font-size:x-large; color:#4397cf; margin: 0 0 10px;"></div><!-- 리뷰 제목 -->
	        				<div class="product-short-description product-cafeName-modal" style="margin: 0 0 0px;"></div><!-- 카페 이름 -->
							<div class="product-user" style="margin:0 0 3px;"></div><!-- 아이디 -->
							<div class="star_rating_modal" style="margin: 0 0 30px; font-size:25px;"></div><!-- 별점 -->
	        				<div class="product-short-description product-content-modal" style="font-size:large;"></div><!-- 리뷰 내용 -->
	        			</div>
	        		</div>
	        		
	        	</div>
	        </div>
    	</div>
  	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script src="/resources/js/script.js"></script>

<!-- 바로예약하기 버튼 누를때 예약페이지에서 요구하는 카페번호를 가져가기 위함 -->
<form id="indexForm" name="indexForm" method="get">
   <input type="hidden" id="cafeNum" name="cafeNum" value=""/>
</form>

<form name="reviewForm" id="reviewForm" method="post">
   <input type="hidden" name="rsrvSeq" value="${review.rsrvSeq}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

</body>
<script>
$('.preview-meta').on('click', 'ul li .searchBtn', function() {
	var rsrvSeq = this.value;
	//내가 선택한 것들 중 가장 마지막 지금의 경우네느 searchBtn안에 값들(function이 적용되는 곳)
	var title = this.getAttribute('title');
	//getAttribute 속성(태그의) 값을 가지고 오는 것이고 set은 주는 거
	var content = this.getAttribute('content');
	var cafe = this.getAttribute('cafe');
	var star = this.getAttribute('star');
	var userId = this.getAttribute('userId');
	
	var list = [rsrvSeq, title, content, cafe, star, userId];
	//배열
	
	fn_modalPht(list);
})

function fn_modalPht(list){
	 //ajax
	 $.ajax({
		type: "POST",
		url: "/index/modalPhtList",
		data: 
		{
			rsrvSeq: list[0]
		},
		datatype: "JSON",
		beforeSend: function(xhr)
		{
		 	xhr.setRequestHeader("AJAX", "true");  
		},
		success: function(response)
		{
			document.querySelector('.product-title').innerHTML = list[1];
			document.querySelector('.product-content-modal').innerHTML = list[2];
			document.querySelector('.product-cafeName-modal').innerHTML = list[3];
			document.querySelector('.product-user').innerHTML = list[5];
			
			var rating = document.querySelector('.star_rating_modal');
			var starPoint = Number(list[4]);
			var aTag = '';
			
			for(var i = 1; i <= 5; i++)
			{
				aTag += '<a href="#" ' + (i <= starPoint ? 'class="on"' : '') + '>★</a>';
			}
			
			rating.innerHTML = aTag;
			
			var html = document.getElementById('carousel-inner');
			
			html.innerHTML = '';
			
			if(response.code == 0)
			{
				/*
				 이미지 슬라이드 틀을 가지고와서
				 html.innerHTML 플러스 대입이라 값을 계속 더해주므로 다음에 켜지때 초기화를 시켜주기 위해서
				 html.innerHTML = ''; -> 안에 있는 사진을 초기화
				 
				 forEach(function(v, i)
				 : for문 forEach는 같은 개념이지만 forEach 그 해당 리스트의 0번부터 마지막까지 차례대로 돌리는 것
				 --> 중간에 나올 수가 없다.
				 --> 변수 i = response.data 인덱스 (index)
				 --> 변수 v = response.data.get(i) 해당 인덱스에 해당하는 값(i번째 데이타 값) (value)
				 --> .foreach 콜백함수가 function이고 파라미터가 v와 i로 고정되었있다.
				 */
				response.data.forEach(function(v, i){
					var src = '/resources/upload/review/' + v.phtName;
					var pht = '';
					
					pht += '<div class="item' + (i ? '' : ' active') + '">'
					pht += '<img src="' + src + '" style="width:550px; height:600px;" alt="" data-zoom-image="' + src + '" />'
					pht += '</div>';
					
					html.innerHTML += pht;
				})
				
				// array.forEach(function(v, i){}) == for(var i = 0; i < array.size(); i++){}
				// --> array 는 response.data
			}
			else
			{
				var pht = '';
				
				pht += '<div class="item active">'
				pht += '<img src="/resources/upload/review/No_img.jpg" style="width:550px; height:600px;" alt="" data-zoom-image="/resources/upload/review/No_img.jpg" />'
				pht += '</div>';
				
				html.innerHTML += pht;	
			}
		},
	 });
}
</script>
</html>