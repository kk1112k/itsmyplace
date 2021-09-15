<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" >
$(document).ready(function(){	

	$("#btnSearch").on("click", function(){
		
		document.eventForm.bbsSeq.value = "";
		document.eventForm.searchStatus.value = $("#searchStatus").val();
		document.eventForm.searchType.value = $("#searchType").val();
		document.eventForm.searchValue.value = $("#searchValue").val();
		document.eventForm.curPage.value = "1";
		
		document.eventForm.action = "/board/eventBoard"; //"/board/list.jsp";
		document.eventForm.submit();
		
		
		alert($("#searchStatusTest").val());    // 값 테스트
		alert($("#searchTypeTest").val());    // 값 테스트
		alert($("#searchValueTest").val());    // 값 테스트
	});
	
	//카페이름 클릭시 해당 게시글만 보여주는 [김호준]
	
	
	//내자리얌 전체 이벤트
	$("#btnItsMyPlace").on("click", function(){
		alert("btnItsMyPlace 성공")
		
		document.eventForm.bbsSeq.value = "";
		document.eventForm.searchType.value = "1";
		document.eventForm.searchValue.value = ""   //여기에 전체 관리자 아이디 넣어줘
		document.eventForm.curPage.value = "1";
		document.eventForm.action = "/board/eventBoard"; 
		document.eventForm.submit();
	});
	//한잔 이벤트
	$("#btnCafeHanzan").on("click", function(){
		alert("btnCafeHanzan 성공")
		document.eventForm.bbsSeq.value = "";
		document.eventForm.searchType.value = "1";
		document.eventForm.searchValue.value = "cafe1"
		document.eventForm.curPage.value = "1";
		document.eventForm.action = "/board/eventBoard"; 
		document.eventForm.submit();
	});
	//카페도넛 이벤트
	$("#btnCafeDonut").on("click", function(){
		alert("btnCafeDonut 성공")
		document.eventForm.bbsSeq.value = "";
		document.eventForm.searchType.value = "1";
		document.eventForm.searchValue.value = "cafe2"
		document.eventForm.curPage.value = "1";
		document.eventForm.action = "/board/eventBoard"; 
		document.eventForm.submit();
	});
	//카페노네임 이벤트
	$("#btnCafeNoname").on("click", function(){
		alert("btnCafeNoname 성공")
		document.eventForm.bbsSeq.value = "";
		document.eventForm.searchType.value = "1";
		document.eventForm.searchValue.value = "cafe3"
		document.eventForm.curPage.value = "1";
		document.eventForm.action = "/board/eventBoard"; 
		document.eventForm.submit(); 		//값테스트
		
		alert($("#searchValueTest").val());
	});
	//카페담다 이벤트
	$("#btnCafeDamda").on("click", function(){
		alert("btnCafeDamda 성공")
		document.eventForm.bbsSeq.value = "";
		document.eventForm.searchType.value = "1";
		document.eventForm.searchValue.value = "cafe4"
		document.eventForm.curPage.value = "1";
		document.eventForm.action = "/board/eventBoard"; 
		document.eventForm.submit();
		
		alert($("#searchValueTest").val());  //값테스트
	});
	
	
	
	//게시물 작성 버튼 [김호준] -> 근데 이거 나중에 관리자만 작성가능하게 처리 그거 해줘야돼 !
	$("#btnWrite").on("click", function(){
		document.eventForm.bbsSeq.value = "";
		document.eventForm.action = "/board/eventBoardWrite";  //여기 주소를 /board/eventBoardWrite 로 바꿔서 화면 하나 더 구현해야될듯 ? 
		document.eventForm.submit();
	});
	
	//도움
	$('#breadcrumb').click(function(){
		
	});

});	

function eventBoardDetail(bbsSeq)
{
	document.eventForm.bbsSeq.value = bbsSeq;
	document.eventForm.action = "/board/eventBoardDetail";
	document.eventForm.submit();
}

function fn_list(curPage)
{
	document.eventForm.bbsSeq.value = "";
	document.eventForm.curPage.value = curPage;
	document.eventForm.action = "/board/eventBoard";
	document.eventForm.submit();	
}



	/*  도움
	function boardList(){
		$.ajax{(
			type: "POST",
			url: "/board/eventBoard",
			datatype: "JSON",
			success: function(response){
				const breadCrumb = $("#breadcrumb");
				let cafeList = "";
				$.each(response, function(i){
					//breadcrumb.append(response.cafeName);
					cafeList += '<li id="'+response.cafeCode+'">'+response.cafeName+'</li>';
				});
				
				breadCurmb.append(cafeList);
			}
		},function(msg){
			alert(msg);
		},false);
	} */
</script>

</head>


<body id="body">

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- 페이지 헤드 메뉴 시작 -->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name" style="font-family:fantasy;">EVENT</h1>
					
					<ol class="breadcrumb" id="breadcrumb"> 
						<li><a href="/board/eventBoard">전체</a></li>
						<li class="img-responsive"><a id="btnItsMyPlace">내자리얌</a></li>
						<li><a id="btnCafeHanzan">한잔</a></li>
						<li><a id="btnCafeDonut">카페도넛</a></li>
						<li><a id="btnCafeNoname">노네임</a></li>
						<li><a id="btnCafeDamda">카페담다</a></li>
						<c:forEach var="board" items="${eventBoard}" varStatus="status">
							<c:out value="${board.bbsSeq}" />
							<li id="${event.bbsSeq}">${board.userId}</li>						
						</c:forEach>
					</ol>
					
				</div>
			</div>
		</div>

	
	<div id="school_list" style="width:90%; margin:auto; margin-top:5rem;">
		<div class="single-product-details" style="display:flex; margin-bottom:0.8rem; position: relative; left: 490px;">
		
			<form class="product-size" name="searchForm" id="searchForm" method="post" style="place-content: flex-end;">
				<select id="searchStatus" name="searchStatus" class="form-control" style="font-size: 1rem; width: 15rem; height: 3rem;">
					<option value="">이벤트 진행 상태</option>
					<option value="Y" <c:if test="${searchStatus =='Y'}">selected</c:if>>진행중</option>        <!-- [수정필요] test 안에 이벤트 종료일인 evtClsDate 가 현재날짜를 지났냐 이거를 가져와야될듯 ?   -->
					<option value="N" <c:if test="${searchStatus =='N'}">selected</c:if>>종료</option> 	 		<!-- [수정필요] test 안에 이벤트 종료일인 evtClsDate 가 현재날짜를 지났냐 이거를 가져와야될듯 ?   -->
				</select>
				<select id="searchType" name="searchType" class="form-control" style="font-size: 1rem; width: 10rem; height: 3rem; margin-left:.5rem; ">
					<option value="">검색타입</option>
					<option value="1" <c:if test="${searchType == '1'}">selected</c:if>>작성자</option>
					<option value="2" <c:if test="${searchType == '2'}">selected</c:if>>제목</option>
					<option value="3" <c:if test="${searchType == '3'}">selected</c:if>>내용</option>
				</select>
				<input name="searchValue" id="searchValue" class="form-control me-sm-2" style="width:25rem; height: 3rem; margin-left:.5rem;" type="text" placeholder="내용을 입력하세요" value="${searchValue}">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    			<a id="btnSearch"  class="btn btn-small btn-main " style="margin-left:.10rem;">조회</a>
				
				<!-- <input type="hidden" name="curPage" value="${curPage}" />          나중에 주석 풀자-->
			</form>
		</div>
	</div>
	</div>
</section>	


<!-- 게시판 시작[김호준] -->

<div class="page-wrapper">
	<div class="container">
		<div class="row">
			<c:if test="${!empty list}">
				<c:forEach items="${list}" var="eventBoard" varStatus="status">
					<div class="col-md-6">
				        <div class="post">
				          <div class="post-thumb">
				            <a href="blog-single.html">
				              <img class="img-responsive" src="/resources/images/blog/example1.jpg" alt="/resources/images/avater.jpg">
				            </a>
				          </div>
				          <h2 class="post-title"><a href="blog-single.html">${eventBoard.bbsTitle}</a></h2>
				          <div class="post-meta">
				            <ul>
				              <li>
				                <i class="tf-ion-android-person"></i>${eventBoard.userId}
				              </li>	
				              <li>
				                <i class="tf-ion-ios-calendar"></i>${eventBoard.regDate}
				              </li>
				              <li>
				                <i class="tf-ion-chatbubbles"></i>${eventBoard.bbsReadCnt}
				              </li>
				            </ul>
				          </div>
				          <div class="post-content">
				            <p> ${eventBoard.bbsContent}
				               </p>
				            <a href="javascript:void(0)" onclick="eventBoardDetail(${eventBoard.bbsSeq})" class="btn btn-main">READ MORE DETAIL</a>
				          </div>
						</div>
		        	</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
<!-- 게시판 끝[김호준] -->



	<!--  글쓰기 버튼 --> 
	<div class="text-center" style="position: relative; ">
	    <a href="/board/eventBoardWrite" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">게시글 작성</a>
	</div>
	


	<!--  페이징처리하기 -->
		<div class="text-center">
			<ul class="pagination post-pagination">
				<c:if test="${!empty paging}">
					<c:if test="${paging.prevBlockPage gt 0}">
						<li><a href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">Prev</a></li>
					</c:if>
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
							<c:when test="${i ne curPage}">
								<li class="active"><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="javascript:void(0)" style="cursor:default;">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>	
					
					<c:if test="${paging.nextBlockPage gt 0}">	
						<li><a href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">Next</a></li>
					</c:if>	
				</c:if>
			</ul>
		</div>

	<form name="eventForm" id="eventForm" method="post">
		<input type="hidden" name="bbsSeq" value="" id="bbsSeqTest" />
		<input type="hidden" name="searchStatus" value="${searchStatus}" id="searchStatusTest" />
		<input type="hidden" name="searchType" value="${searchType}" id="searchTypeTest" />
		<input type="hidden" name="searchValue" value="${searchValue}" id="searchValueTest" />
		<input type="hidden" name="curPage" value="${curPage}" />
		<!-- 아마도 여기에  -->	
	</form>
	
	
	<!-- 이거 테스트용..? 아니 이거 되면 이거 써야되나 ?   -->
	<form name="searchForm" id="searchForm" method="post">
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />			
	</form>
	
	
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   
</body>
</html>
