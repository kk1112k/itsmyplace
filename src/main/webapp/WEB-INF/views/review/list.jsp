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
	
	if(confirm("???????????? ?????? ???????????????????"))
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
					alert("???????????? ?????? ???????????????.");
					
					location.href = "/review/list";
				}
				else if(response.code == 400)
				{
					alert("???????????? ?????? ???????????? ????????????. code == 400");
				}
				else if(response.code == 404)
				{
				 	alert("???????????? ?????? ??? ????????????. code == 404");
				  	
				 	location.href = "/review/list";
				}
				else
				{
					alert("????????? ?????? ??? ????????? ??????????????????.");
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
            <a href="/review/list"><img src="/resources/images/review.png" style="margin-left:15px;" alt="?????? ????????? ?????????" height="80"/></a>
            <!-- <div class="product-size" name="searchForm" id="searchForm" method="post" style="place-content:flex-end; display:flex; justify-content:flex-end; margin-right:13px; margin-bottom:50px;"> -->
               <div class="ml-auto input-group" style="width:auto; display:inline-block; float:right; margin-top:30px; margin-right:15px;">
                  <select id="_searchType" name="_searchType" class="form-control" style="width:auto; height:50px; margin-left:.5rem; ">      
                  <option value="">?????? ??????</option>
                  <option value="1" <c:if test="${searchType eq '1'}"> selected</c:if>>????????????</option>
                  <option value="2" <c:if test="${searchType eq '2'}"> selected</c:if>>??????</option>
                  <option value="3" <c:if test="${searchType eq '3'}"> selected</c:if>>??????</option>
               </select>
                  <input name="_searchValue" id="_searchValue" class="form-control mx-1" style="width:300px; height:50px; font-size:15px;" type="text" placeholder="?????? ?????? ???????????????" value="${searchValue}">
                   <button type="button" id="btnSearch" class="btn btn-main mb-3 mx-1" style="height:50px; font-size:15px;">??????</button>
               </div>
         </div>
			<!--  ?????? ?????? -->
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
										<a href="#" class="on">???</a>
									    <a href="#" >???</a>
									    <a href="#" >???</a>
									    <a href="#">???</a>
									    <a href="#">???</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 2.0}">
									<div class="star_rating">
										<a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" >???</a>
									    <a href="#">???</a>
									    <a href="#">???</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 3.0}">
									<div class="star_rating">
										<a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#">???</a>
									    <a href="#">???</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 4.0}">
									<div class="star_rating">
										<a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#">???</a>
									</div>
									</c:if>
									<c:if test="${review.bbsStar == 5.0}">
									<div class="star_rating">
										<a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
									    <a href="#" class="on">???</a>
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
	<!-- ????????? -->
	<nav>
		<ul class="pagination justify-content-center" style="display:flex; justify-content:center;">
			<c:if test="${!empty paging}">
				<c:if test="${paging.prevBlockPage gt 0}">
					<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">????????????</a></li>
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
					<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">????????????</a></li>
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
													<!-- ????????? ?????? ????????? ????????? -->
													<img src="/resources/upload/review/No_img.jpg" alt="" data-zoom-image="/resources/upload/review/No_img.jpg" />
												</div>
											</div>
											<!-- ???????????? ?????? -->
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
	        				<div class="product-title" style="font-size:x-large; color:#4397cf; margin: 0 0 5px;"></div><!-- ?????? ?????? -->
	        				<div class="product-short-description product-cafeName-modal" style="margin:0 0 5px;"></div><!-- ?????? ?????? -->
							<div class="product-user" style="margin:0 0 3px;"></div><!-- ????????? -->
							<div class="star_rating_modal" style="margin: 0 0 30px; font-size:25px;"></div><!-- ?????? -->
	        				<div class="product-short-description product-content-modal" style="font-size:large;"></div><!-- ?????? ?????? -->
	        				<div class="product-button">
		        				<button type="button" id="btnUpdate" class="btn btn-main">??????</button>
		        				<button type="button" id="btnDelete" class="btn btn-main">??????</button>
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
		var rsrvSeq = this.value;	//?????? ????????? ?????? ??? ?????? ????????? ????????? ???????????? searchBtn?????? ??????(function??? ???????????? ???)
		var title = this.getAttribute('title');	//getAttribute ??????(?????????) ?????? ????????? ?????? ????????? set??? ?????? ???
		var content = this.getAttribute('content');
		var cafe = this.getAttribute('cafe');
		var star = this.getAttribute('star');
		var userId = this.getAttribute('userId');
		var list = [rsrvSeq, title, content, cafe, star, userId]; 	//??????
		
		fn_modalPht(list);
	})

	document.querySelector('#btnUpdate').addEventListener('click', fn_update)
	//==$("#btnUpdate").on("click", function(){})
	//.addEventListener == .on (????????? ??????????????????: ?????? ??????????????????)
	//querySelector??? ?????? ???????????? ???????????? ????????? ??? ??????(id, ?????????, ??????)
	//fn_update ????????? ?????? ?????? ?????? ????????? ?????? ??? ??????????????? ????????? ?????? fn_update ???????????? ???????????? ??????
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
					aTag += '<a href="#" ' + (i <= starPoint ? 'class="on"' : '') + '>???</a>';
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
					????????? ???????????? ?????? ???????????????
					html.innerHTML ????????? ???????????? ?????? ?????? ??????????????? ????????? ????????? ???????????? ???????????? ?????????
					html.innerHTML = ''; -> ?????? ?????? ????????? ?????????
					 
					forEach(function(v, i)
					: for??? forEach??? ?????? ??????????????? forEach ??? ?????? ???????????? 0????????? ??????????????? ???????????? ????????? ???
					--> ????????? ?????? ?????? ??????.
					--> ?????? i = response.data ????????? (index)
					--> ?????? v = response.data.get(i) ?????? ???????????? ???????????? ???(i?????? ????????? ???) (value)
					--> .foreach ??????????????? function?????? ??????????????? v??? i??? ??????????????????.
					
					// array.forEach(function(v, i){}) == for(var i = 0; i < array.size(); i++){}
					// --> array ??? response.data
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