<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
%>
<meta charset="utf-8">
<script type="text/javascript">
$(document).ready(function() {
	
	$("#_searchValue").on("keypress", function(e){
	      
	      if(e.which == 13)
	      {   
	    	  document.bbsForm.bbsSeq.value = "";
	          document.bbsForm.searchType.value = $("#_searchType").val();
	          document.bbsForm.searchValue.value = $("#_searchValue").val();
	          document.bbsForm.curPage.value = "1";
	          document.bbsForm.action = "/cs/list";
	          document.bbsForm.submit();
	      }
	 });
	
	$("#btnWrite").on("click", function() {
    	  document.bbsForm.bbsSeq.value = "";
          document.bbsForm.action = "/cs/writeForm";
          document.bbsForm.submit();
   });
	
	$("#btnSearch").on("click", function() {
      document.bbsForm.bbsSeq.value = "";
      document.bbsForm.searchType.value = $("#_searchType").val();
      document.bbsForm.searchValue.value = $("#_searchValue").val();
      document.bbsForm.curPage.value = "1";
      document.bbsForm.action = "/cs/list";
      document.bbsForm.submit();
	}); 
});

function fn_view(bbsSeq)
{
   document.bbsForm.bbsSeq.value = bbsSeq;
   document.bbsForm.action = "/cs/view";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.bbsSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/cs/list";
   document.bbsForm.submit();   
}

</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="user-dashboard page-wrapper">

<div class="container">
	<div class="d-flex">
		<div class="logo text-left"><!-- context -->
			<a href="/cs/list"><img src="/resources/images/king/qna.png" alt="image" width="220" height="80" style="margin-left:13px;" /></a>
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
        <div style="margin-left:13px;">
        	<ul class="list-inline dashboard-menu text-left">	
	          <li><a class="active" href="/cs/list">Q&A</a></li>
	          <li><a href="/cs/faq">FAQ</a></li>
	        </ul>
        </div>
	</div>


<div class="comm-custom2">
<table class="table table-hover" border="2" bordercolor="#ADD8E6">
      <thead>
      <tr style="background-color: #4397cf;">
         <th scope="col" class="text-center" style="width:100px; color:#fbf9d3">번호</th>
         <th scope="col" class="text-center" style="color:#fbf9d3">제목</th>
         <th scope="col" class="text-center" style="width:100px; color:#fbf9d3">아이디</th>
         <th scope="col" class="text-center" style="width:100px; color:#fbf9d3">날짜</th>
         <th scope="col" class="text-center" style="width:100px; color:#fbf9d3">조회수</th>
      </tr>
      </thead>
<tbody>
<c:if test="${!empty list}">
   <c:forEach var="cs" items="${list}" varStatus="status">
      <tr>
      <c:choose>
         <c:when test="${cs.bbsIndent eq 0}">
         <td class="text-center">${cs.bbsSeq}</td>
         </c:when>
         <c:otherwise>
         <td class="text-center"></td>
         </c:otherwise>
      </c:choose>
         <td>
            <a href="javascript:void(0)" onclick="fn_view(${cs.bbsSeq})" style="color:#000000">
      <c:if test="${cs.bbsIndent > 0}">
            <img src="/resources/images/icon_reply.gif" style="margin-left: ${cs.bbsIndent}em;"/>
      </c:if>
            <c:out value="${cs.bbsTitle}" />
            </a>
         </td>
         <td class="text-center"><c:out value="${cs.userId}" /></td>
         <td class="text-center">${cs.regDate}</td>
         <td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cs.bbsReadCnt}" /></td>
      </tr>
   </c:forEach>
</c:if>
      </tbody>
   </table>
</div>


<nav>
<div>
   
</div>
<%
if(com.icia.itsmyplace.util.CookieUtil.getCookie(request, (String)request.getAttribute("AUTH_COOKIE_NAME")) != null)
{
%>
<div class="ml-auto input-group" style="width:auto; float:right; margin-right:10px;">
	<c:if test="${user.userClass ne 'S'}">
		<button type="button" id="btnWrite" class="btn btn-main btn-medium">글쓰기</button>
	</c:if>
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

	 <input type="hidden" id="userClass" name="userClass" value="${user.userClass}">
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="bbsSeq" value="" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" /> 
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>