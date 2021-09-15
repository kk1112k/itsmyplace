<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 개행문자 값을 저장한다.
	pageContext.setAttribute("newLine", "\n");
%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" >
$(document).ready(function(){	
	<c:choose>
	<c:when test="${empty eventBoard}">
	alert("조회하신 게시물이 존재하지 않습니다아");
	
	document.eventForm.action="/board/eventBoard";
	document.eventForm.submit();
	
	</c:when>
	<c:otherwise>
	
	//목록으로 돌아가는 버튼
	$("#btnList").on("click", function() {
		document.eventForm.action = "/board/eventBoard";
		document.eventForm.submit();
	});
	
	
	<c:if test="${boardMe eq 'Y'}">  
	$("#btnUpdate").on("click", function() {
		
		document.eventForm.action = "/board/eventBoardUpdate";
		document.eventForm.submit();
	});

	$("#btnDelete").on("click", function(){
		if(confirm("게시물을 삭제 하시겠습니까?") == true)
		{
			//ajax
			$.ajax({
				type: "POST",
				url: "/board/eventBoardDelete",
				data: {
					bbsSeq: <c:out value="${eventBoard.bbsSeq}" />
				},
				datatype: "JSON",
				beforeSend: function(xhr){
					xhr.setRequestHeader("AJAX", "true");
				},
				success: function(response)
				{
					if(response.code == 0)
					{
						alert("게시물이 삭제되었습니다.");
						location.href = "/board/eventBoard";
					}
					else if(response.code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
					}
					else if(response.code == 404)
					{
						alert("게시물을 찾을 수 없습니다.");
						location.href = "/board/eventBoard";
					}
					else
					{
						alert("게시물 삭제 중 오류가 발생하였습니다.");
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
	});

	</c:if>
	
	</c:otherwise>
</c:choose>	
	
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

});	


</script>

</head>



<body id="body">

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!--  여기 주석 풀면 위에 공간 쫌더 띄워집니다.
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				
			</div>
		</div>
	</div>
</section>
 -->


<section class="page-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="post post-single">
					
					<h2 class="post-title">${eventBoard.bbsTitle}</h2>
					<div class="post-meta">
						<ul>
							<li>
								<i class="tf-ion-ios-calendar"></i> ${eventBoard.regDate}
							</li>
							<li>
								<i class="tf-ion-android-person"></i> ${eventBoard.userId}
							</li>
							<li>
								<i class="tf-ion-chatbubbles"></i> ${eventBoard.bbsReadCnt}
							</li>
						</ul>
					</div>
					
					<div class="post-thumb">
						<img class="img-responsive" src="/resources/images/shop/single-products/noname/product-1.png" alt="">
					</div>
					
					<div class="post-content post-excerpt">
						<!-- 여기에다가 ${eventBoard.bbsContent} 를 가져온 다음에 글자수 제한을 걸어서 그만큼만 가져오고 나머지는 뒤의 부분에서 다들 잘라서 가져오는거 구현해보자. -->
						<p><c:set var="Content" value="${eventBoard.bbsContent}" /> ${fn:substring(Content,0,350)}</p>
						<blockquote class="quote-post">
				            <p>
				                <c:set var="Content" value="${eventBoard.bbsContent}" /> ${fn:substring(Content,350,700)}
				            </p>
				        </blockquote>
				        <p><c:set var="Content" value="${eventBoard.bbsContent}" /> ${fn:substring(Content,700,1500)}</p>
				        
						<p><c:set var="Content" value="${eventBoard.bbsContent}" /> ${fn:substring(Content,1500,9999999999)}</p>
				    </div>
				    
					<!--  글쓰기 / 수정 / 목록 버튼 --> 
					<div class="text-center" style="position: relative; ">
						<c:if test="${boardMe eq 'Y'}"> 	
						    <a id="btnUpdate" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">게시물 수정</a>
						    &nbsp;&nbsp;&nbsp;&nbsp;
						    <a id="btnDelete" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">게시물 삭제</a>
						    &nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>    
						    <a id="btnList" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">Back to Event</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>






	<form name="eventForm" id="eventForm" method="post">
		<input type="hidden" name="bbsSeq" id="bbsSeqTest" value= "${bbsSeq}" />
		<input type="hidden" name="searchStatus" value= "${searchStatus}" />
		<input type="hidden" name="searchType" value="${searchType}"  />
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









