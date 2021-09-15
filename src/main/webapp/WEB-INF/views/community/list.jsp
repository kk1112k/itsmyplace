<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
/* long ifModi = request.getDateHeader("If-Modified-Since");
response.setDateHeader("If-Modified-Since", ifModi);
String eTag = request.getHeader("ETag");
response.setHeader("If-None-Match", eTag); */
%>
<meta charset="utf-8">
<script type="text/javascript">


function fn_view(bbsSeq)
{
	document.bbsForm.bbsSeq.value = bbsSeq;
	document.bbsForm.action = "/community/view";
	document.bbsForm.submit();
}

function fn_list(curPage)
{
	document.bbsForm.bbsSeq.value = "";
 	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/community/list";
	document.bbsForm.submit();   
}


$(document).ready(function() {
	
	$("#_searchValue").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			document.bbsForm.bbsSeq.value = "";
			document.bbsForm.searchType.value = $("#_searchType").val();
			document.bbsForm.searchValue.value = $("#_searchValue").val();
			document.bbsForm.curPage.value = "1";
			document.bbsForm.action = "/community/list";
			document.bbsForm.submit();
		}
		
	});
	
	$("#btnWrite").on("click", function() {
		
		<c:choose>
		<c:when test="${!empty user}">
		
		document.bbsForm.bbsSeq.value = "";
		document.bbsForm.action = "/community/writeForm";
		document.bbsForm.submit();
		
		</c:when>
		<c:otherwise>
		
		alert("게시물을 등록하려면 로그인하세요.")
		
		</c:otherwise>
		</c:choose>
		

	});
	
	$("#btnSearch").on("click", function() {
		document.bbsForm.bbsSeq.value = "";
		document.bbsForm.searchType.value = $("#_searchType").val();
		document.bbsForm.searchValue.value = $("#_searchValue").val();
		document.bbsForm.curPage.value = "1";
		document.bbsForm.action = "/community/list";
		document.bbsForm.submit();
	});
	
<c:choose>
   <c:when test="">
      alert("조회하신 게시물이 존재하지 않습니다.");
      
      document.moveForm2.action = "/community/list";
      document.moveForm2.submit();
   </c:when>
   <c:otherwise>
   $("#btnList").on("click", function() {
      document.moveForm2.action = "/community/list";
      document.moveForm2.submit();
   });

	</c:otherwise>
</c:choose>  
});

</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="user-dashboard page-wrapper">
<div class="container">
	<div class="d-flex">
	<div class="logo text-left">
		<a href="/community/list"><img src="/resources/images/comm/commTitle.png" style="margin-left:25px;" alt="커뮤니티 타이틀 이미지" height="80"/></a>
		<div class="ml-auto input-group" style="width:auto; display:inline-block; float:right; margin-top:30px; margin-right:13px;">
			<select id="_searchType" name="_searchType" class="form-control mx-1" style="width:auto; height:50px; font-size:15px;">
			    <option value="">조회 항목</option>
			    <option value="1" <c:if test="${searchType == '1'}">selected</c:if>>아이디</option>
			    <option value="2" <c:if test="${searchType == '2'}">selected</c:if>>제목</option>
			    <option value="3" <c:if test="${searchType == '3'}">selected</c:if>>내용</option>
			</select>
	
		<input type="text" name="_searchValue" id="_searchValue" class="form-control mx-1" value="${searchValue}" style="width:300px; height:50px; font-size:15px; ime-mode:active" placeholder="조회값을 입력하세요." />
		<button type="button" id="btnSearch" class="btn btn-main mb-3 mx-1" style="height:50px; font-size:15px;">조회</button>
	   </div>
	</div>
	
	
	
	<div class="comm-custom2"></div>
	</div>

<div class="comm-custom2">
<table class="table table-hover" border="2" bordercolor="#ADD8E6">
	<thead>
		<tr style="background-color: #4397CF;">
			<th scope="col" style="width:100px; color:#fbf9d3" class="text-center">번호</th>
			<th scope="col" style="color:#fbf9d3" class="text-center">제목</th>
			<th scope="col" style="width:100px; color:#fbf9d3" class="text-center">아이디</th>
			<th scope="col" style="width:100px; color:#fbf9d3" class="text-center">날짜</th>
			<th scope="col" style="width:100px; color:#fbf9d3" class="text-center">조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!empty list}">
			<c:forEach var="comm" items="${list}" varStatus="status">
				<tr>
					<td class="text-center" style="color:#000000"><c:out value="${comm.bbsSeq}" /></td>
					<td>
						<a href="javascript:void(0)" onclick="fn_view(${comm.bbsSeq})" style="color:#000000">
							<c:out value="${comm.bbsTitle}" />
						</a>
					<c:if test="${comm.commCmtCnt ne 0}">
					<span style="color:#4397CF">
						[<c:out value="${comm.commCmtCnt}"/>]
					</span>
					</c:if>
					</td>
					<td class="text-center" style="color:#000000"><c:out value="${comm.userId}" /></td>
					<td class="text-center" style="color:#000000">${comm.regDate}</td>
					<td class="text-center" style="color:#000000"><fmt:formatNumber type="number" maxFractionDigits="3" value="${comm.bbsReadCnt}" /></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
</div>
<nav>
<div>
<%-- 	<div class="ml-auto input-group" style="width:auto; float:left;">
	<select name="_searchType" id="_searchType" class="form-control mx-1" style="width:auto; height:45px;">
		<option value="">조회 항목</option>
		<option value="1" <c:if test="${searchType eq '1'}"> selected</c:if>>아이디</option>
		<option value="2" <c:if test="${searchType eq '2'}"> selected</c:if>>제목</option>
		<option value="3" <c:if test="${searchType eq '3'}"> selected</c:if>>내용</option>
	</select>
	<input type="text" name="_searchValue" id="_searchValue" class="form-control mx-1" value="${searchValue}" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
	&nbsp;<button type="button" id="btnSearch" class="btn btn-main mb-3 mx-1" style="height:45px;">조회</button>
	</div> --%>
</div>
<%
if(com.icia.itsmyplace.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
{
%>
<div class="ml-auto input-group" style="width:auto; float:right; margin-right:10px;">
<button type="button" id="btnWrite" class="btn btn-main mb-3" style="height:45px;">글쓰기</button>
</div>
<%
}
%>



<div class="comm-padd-custom"></div>
<div class="ml-auto input-group" style="width:auto; margin: 0 auto;">
<ul class="pagination justify-content-center">
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
</div>

</nav>



</div>
</div>
<div>
<form name="bbsForm" id="bbsForm" method="post">
	<input type="hidden" name="bbsSeq" value="">
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>