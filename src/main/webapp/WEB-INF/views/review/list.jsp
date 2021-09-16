<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
/* .col-md-3
{
	height:410px;
} */

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
$(document).ready(function() {
	
	$("#_searchValue").on("keypress", function(e){
			
		if(e.which == 13)
		{	
			document.reviewForm.rsrvSeq.value = "";
			document.reviewForm.searchType.value = $("#_searchType").val();
			document.reviewForm.searchValue.value = $("#_searchValue").val();
			document.reviewForm.curPage.value = "1";
			document.reviewForm.action = "/review/list";
			document.reviewForm.submit();
		}
	});
	
	$("#btnSearch").on("click", function() {
		
		document.reviewForm.rsrvSeq.value = "";
		document.reviewForm.searchType.value = $("#_searchType").val();
		document.reviewForm.searchValue.value = $("#_searchValue").val();
		document.reviewForm.curPage.value = "1";
		document.reviewForm.action = "/review/list";
		document.reviewForm.submit();
	});
});

function fn_reievewMe(rsrvSeqNo){
	document.reviewForm.rsrvSeq.value = rsrvSeqNo;
	document.reviewForm.submit();
}

function fn_update(){
	var rsrvSeq = document.querySelector('#btnUpdate').value;
	document.reviewForm.rsrvSeq.value = rsrvSeq;
	document.reviewForm.action = "/review/reviewUpdate";
	document.reviewForm.submit();
}

function fn_list(curPage)
{
	document.reviewForm.rsrvSeq.value = "";
	document.reviewForm.curPage.value = curPage;
	document.reviewForm.action = "/review/list";
	document.reviewForm.submit();   
}

function fn_delete(){
	var rsrvSeq = document.querySelector('#btnUpdate').value;
	
	if(confirm("게시물을 삭제 하시겠습니까?"))
	{
		 //ajax
		 $.ajax({
			type: "POST",
			url: "/review/reviewDelete",
			data: 
			{
				rsrvSeq: rsrvSeq
			},
			datatype: "JSON",
			beforeSend: function(xhr)
			{
			 	xhr.setRequestHeader("AJAX", "true");  
			},
			success: function(response)
			{
				if(response.code == 0)
				{
					alert("게시물이 삭제 되었습니다.");
					
					location.href = "/review/list";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다. code == 400");
				}
				else if(response.code == 404)
				{
				 	alert("게시물을 찾을 수 없습니다. code == 404");
				  	
				 	location.href = "/review/list";
				}
				else
				{
					alert("게시물 삭제 중 오류가 발생했습니다.");
				}
			 },
			 complete: function(data)
			 {
				  icia.common.log(data);
			 },
			 error: function(xhr, status, error)
			 {
				  icia.common.error(error);
			 } 
		}); 
	}
}
</script>
</head>
<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<div class="user-dashboard page-wrapper">
   <div class="container">
      <div class="d-flex">
         <div class="logo text-left" style="margin-bottom:50px;">
            <a href="/review/list"><img src="/resources/images/review.png" style="margin-left:15px;" alt="후기 타이틀 이미지" height="80"/></a>
            <!-- <div class="product-size" name="searchForm" id="searchForm" method="post" style="place-content:flex-end; display:flex; justify-content:flex-end; margin-right:13px; margin-bottom:50px;"> -->
               <div class="ml-auto input-group" style="width:auto; display:inline-block; float:right; margin-top:30px; margin-right:15px;">
                  <select id="_searchType" name="_searchType" class="form-control" style="width:auto; height:50px; margin-left:.5rem; ">      
                  <option value="">조회 항목</option>
                  <option value="1" <c:if test="${searchType eq '1'}"> selected</c:if>>카페이름</option>
                  <option value="2" <c:if test="${searchType eq '2'}"> selected</c:if>>제목</option>
                  <option value="3" <c:if test="${searchType eq '3'}"> selected</c:if>>내용</option>
               </select>
                  <input name="_searchValue" id="_searchValue" class="form-control mx-1" style="width:300px; height:50px; font-size:15px;" type="text" placeholder="조회 값을 입력하세요" value="${searchValue}">
                   <button type="button" id="btnSearch" class="btn btn-main mb-3 mx-1" style="height:50px; font-size:15px;">조회</button>
               </div>
         </div>
			<!--  리뷰 시작 -->
			<c:if test="${!empty reviewList}">
				<c:forEach var="review" items="${reviewList}" varStatus="status">
						<div class="col-md-3" style="height:auto;">
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
								
								<div class="product-content">
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
									<div class="target" style="font-size:x-large; margin-bottom:2px;"><c:out value="${review.bbsTitle}" /></div>
									<a class="product-content">
										<i class="tf-ion-android-person" ><c:out value="${review.userId}" /></i>
									</a>
																							
								</div>
							</div>
						</div>				
				</c:forEach>
			</c:if>
		</div>
	</div>
	<!-- 페이징 -->
	<nav>
		<ul class="pagination justify-content-center" style="display:flex; justify-content:center;">
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
</div>

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
													<!-- 오류로 인한 디폴트 이미지 -->
													<img src="/resources/upload/review/No_img.jpg" alt="" data-zoom-image="/resources/upload/review/No_img.jpg" />
												</div>
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
	        				<div class="product-title" style="font-size:x-large; color:#4397cf; margin: 0 0 5px;"></div><!-- 리뷰 제목 -->
	        				<div class="product-short-description product-cafeName-modal" style="margin:0 0 5px;"></div><!-- 카페 이름 -->
							<div class="product-user" style="margin:0 0 3px;"></div><!-- 아이디 -->
							<div class="star_rating_modal" style="margin: 0 0 30px; font-size:25px;"></div><!-- 별점 -->
	        				<div class="product-short-description product-content-modal" style="font-size:large;"></div><!-- 리뷰 내용 -->
	        				<div class="product-button">
		        				<button type="button" id="btnUpdate" class="btn btn-main">수정</button>
		        				<button type="button" id="btnDelete" class="btn btn-main">삭제</button>
	        				</div>
	        			</div>
	        		</div>
	        		
	        	</div>
	        </div>
    	</div>
  	</div>
</div>
	
<input type="hidden" value="${reviewMe}" id="cookieId"/>
	
<form name="reviewForm" id="reviewForm" method="post">
	<input type="hidden" name="rsrvSeq" value="${review.rsrvSeq}" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
<script>
	$('.preview-meta').on('click', 'ul li .searchBtn', function() {
		var rsrvSeq = this.value;	//내가 선택한 것들 중 가장 마지막 지금의 경우네느 searchBtn안에 값들(function이 적용되는 곳)
		var title = this.getAttribute('title');	//getAttribute 속성(태그의) 값을 가지고 오는 것이고 set은 주는 거
		var content = this.getAttribute('content');
		var cafe = this.getAttribute('cafe');
		var star = this.getAttribute('star');
		var userId = this.getAttribute('userId');
		var list = [rsrvSeq, title, content, cafe, star, userId]; 	//배열
		
		fn_modalPht(list);
	})

	document.querySelector('#btnUpdate').addEventListener('click', fn_update)
	//==$("#btnUpdate").on("click", function(){})
	//.addEventListener == .on (바닐라 자바스크립트: 순수 자바스크립트)
	//querySelector는 내가 선택해서 아무거나 가져올 수 있어(id, 클래스, 태그)
	//fn_update 괄호를 넣지 않는 것은 실행이 되는 걸 막기위해서 괄호를 빼고 fn_update 스크립트 호출하는 개념
	document.querySelector('#btnDelete').addEventListener('click', fn_delete)

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
				
				var cookieId = document.querySelector('#cookieId').value;
				
				if(cookieId === list[5])
				{
					document.querySelector('.product-button').style.display = 'block'
					document.querySelector('#btnUpdate').value = list[0];
					document.querySelector('#btnDelete').value = list[0];
				}
				else
				{
					document.querySelector('.product-button').style.display = 'none'
				}
				
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
					
					// array.forEach(function(v, i){}) == for(var i = 0; i < array.size(); i++){}
					// --> array 는 response.data
					*/
					response.data.forEach(function(v, i)
					{
						var src = '/resources/upload/review/' + v.phtName;
						var pht = '';
						
						pht += '<div class="item' + (i ? '' : ' active') + '">'
						pht += '<img src="' + src + '" style="width:550px; height:600px;" alt="" data-zoom-image="' + src + '" />'
						pht += '</div>';
						
						html.innerHTML += pht;
					})
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