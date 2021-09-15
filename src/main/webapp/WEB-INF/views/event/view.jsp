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
		alert("조회하신 게시물이 존재하지 않습니다.");
		document.eventForm.action="/event/list";
		document.eventForm.submit();
	</c:when>
	
	<c:otherwise>
	
	//목록으로 돌아가는 버튼
	$("#btnList").on("click", function() {
		document.eventForm.action = "/event/list";
		document.eventForm.submit();
	});
	
	
	<c:if test="${boardMe eq 'Y'}">  
	$("#btnUpdate").on("click", function() {
		
		document.eventForm.action = "/event/updateForm";
		document.eventForm.submit();
	});

	$("#btnDelete").on("click", function(){
		if(confirm("게시물을 삭제 하시겠습니까?") == true)
		{
			//ajax
			$.ajax({
				type: "POST",
				url: "/event/eventDelete",
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
						location.href = "/event/list";
					}
					else if(response.code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
					}
					else if(response.code == 404)
					{
						alert("게시물을 찾을 수 없습니다.");
						location.href = "/event/list";
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
	
});	


</script>

</head>



<body id="body">

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<section class="page-wrapper" style="pading:0px;">
	<div class="container">
		<div class="row">
			<div class="col-md-12">	
				<div class="post post-single">
					<h2 class="post-title" style="color: #4397CF; font-weight:700; font-size: 33px;">${eventBoard.bbsTitle}</h2>
					<div class="post-meta">
						<ul>
							<li>
				                <i class="tf-ion-ios-contact"></i>${eventBoard.userName}
				            </li>
							<li>
								<i class="tf-ion-android-person"></i> ${eventBoard.userId}
							</li>
							<li>
								<i class="tf-ion-ios-calendar"></i> ${eventBoard.regDate}
							</li>
							<li>
								<i class="tf-ion-eye"></i> ${eventBoard.bbsReadCnt}
							</li>
						</ul>
					</div>
					
					<div class="post-meta">
						<ul>
							<li>
								<c:set var="evtOpnDate" value="${eventBoard.evtOpnDate}" />
								Start<i class="tf-ion-ios-calendar-outline"></i>&nbsp;${fn:substring(evtOpnDate,0,10)}
							</li>
							<li>
								<c:set var="evtClsDate" value="${eventBoard.evtClsDate}" />
								End<i class="tf-ion-ios-calendar-outline"></i>&nbsp;${fn:substring(evtClsDate,0,10)}
							</li>
						</ul>
					</div>
					<br/>
					<div class="post-thumb" style="text-align:center;">
						<c:if test="${eventBoard.bbsPublic eq 'Y'}">
		            		<c:if test="${eventBoard.fileName ne ''}">
		            			<img class="img-responsive" src="/resources/upload/event/${eventBoard.fileName}" style="position:relative; width:750px; height:600px; left:200px; " alt="/resources/images/avater.jpg" >
		            		</c:if>
		            	
			            	<c:if test="${eventBoard.fileName eq ''}">
			            	<img class="img-responsive" src="/resources/upload/event/No-Image.png" style="position:relative; width:750px; height:600px; left:200px;" alt="/resources/images/avater.jpg" >
			            	</c:if>
		            	</c:if>
		            	
		            	
		            	<c:if test="${eventBoard.bbsPublic eq 'N'}"> 
			            	<c:if test="${eventBoard.fileName ne ''}">
			            		<img class="img-responsive" src="/resources/upload/event/${eventBoard.fileName}" style="position:absolute; z-index:1; width:750px; height:600px; left:200px;" alt="/resources/images/avater.jpg" >
				            	<img class="img-responsive" src="/resources/images/event/end.png" style="position:relative; z-index:100; width:750px; height:600px; left:185px;" alt="/resources/images/avater.jpg" >
			            	</c:if>
			            	
			            	<c:if test="${eventBoard.fileName eq ''}">
			            		<img class="img-responsive" src="/resources/images/event/end.png" style="position:relative; width:750px; height:600px; left:200px;" alt="/resources/images/avater.jpg" >
			            	</c:if>
		            	</c:if>
					
					</div>
					
					<div class="post-content post-excerpt">
						<p style="font-size:16px;"><c:set var="Content" value="${eventBoard.bbsContent}" /><br/>&nbsp;&nbsp;&nbsp;&nbsp; ${fn:substring(Content,0,270)}</p>
						<blockquote class="quote-post">
				            <p style="font-size:16px;"><c:set var="Content" value="${eventBoard.bbsContent}" />&nbsp;&nbsp;&nbsp;&nbsp; ${fn:substring(Content,270,520)}</p>
				        </blockquote>
				        <p style="font-size:16px;"><c:set var="Content" value="${eventBoard.bbsContent}" />&nbsp;&nbsp;&nbsp;&nbsp; ${fn:substring(Content,520,9999999999)}</p>
				    </div>
				    
					<!--  글쓰기 / 수정 / 목록 버튼 --> 
					<div class="text-center" style="position: relative; ">
						<c:if test="${boardMe eq 'Y'}"> 	
						    <a id="btnUpdate" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">게시물 수정</a>
						    &nbsp;&nbsp;&nbsp;&nbsp;
						    <a id="btnDelete" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">게시물 삭제</a>
						    &nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>    
						    <a id="btnList" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; "> 이벤트 목록 </a>
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
</form>
	
	
<form name="searchForm" id="searchForm" method="post">
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />			
</form>
	
	
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   
</body>
</html>









