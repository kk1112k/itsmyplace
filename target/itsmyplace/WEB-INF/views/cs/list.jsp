<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script type="text/javascript">
$(document).ready(function() {
	
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
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content"><!-- context -->
					<h1 class="page-name">Help Desk</h1>
					<br/>
			        <ul class="list-inline dashboard-menu text-left">	
			          <li><a class="active" href="/cs/list">Home</a></li>
			          <li><a href="/cs/faq">FAQ</a></li>
			        </ul>
		        </div>
			</div>
		</div>
	</div>
</section>

<div class="container">
   <div class="d-flex">
   		<div id="school_list" style="width:90%; margin:auto; margin-top:5rem;">
	     <div class="single-product-details" style="display:flex; margin-bottom:0.8rem; position: relative; left: 630px;">
	      
	         <form class="product-size" name="searchForm" id="searchForm" method="post" style="place-content: flex-end;">
	            <select id="_searchType" name="_searchType" class="form-control" style="font-size: 1rem; width: 10rem; height: 3rem; margin-left:.5rem; ">
	               <option value="">검색타입</option>
	               <option value="1" <c:if test="${searchType == '1'}">selected</c:if>>작성자</option>
	               <option value="2" <c:if test="${searchType == '2'}">selected</c:if>>제목</option>
	               <option value="3" <c:if test="${searchType == '3'}">selected</c:if>>내용</option>
	            </select>
	            <input name="_searchValue" id="_searchValue" class="form-control me-sm-2" style="width:25rem; height: 3rem; margin-left:.5rem;" type="text" placeholder="내용을 입력하세요" value="${searchValue}">
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	             <a id="btnSearch"  class="btn btn-small btn-main " style="margin-left:.10rem;">조회</a>
	         </form>
	     </div>
	  </div>
		<!-- div class="ml-auto input-group" style="width:50%;">
	         <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
	            <option value="">조회 항목</option>
	            <option value="1" <c:if test="${searchType eq '1'}"> selected</c:if>>작성자</option>
	            <option value="2" <c:if test="${searchType eq '2'}"> selected</c:if>>제목</option>
	            <option value="3" <c:if test="${searchType eq '3'}"> selected</c:if>>내용</option>
	         </select>
         <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
         <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button>
      </div-->
    </div>
    <br/><br/>
   <table class="table table-hover" border="2" bordercolor="#ADD8E6">
      <thead>
      <tr style="background-color: #4397cf;">
         <th scope="col" class="text-center" style="width:10%">번호</th>
         <th scope="col" class="text-center" style="width:55%">제목</th>
         <th scope="col" class="text-center" style="width:10%">작성자</th>
         <th scope="col" class="text-center" style="width:15%">날짜</th>
         <th scope="col" class="text-center" style="width:10%">조회수</th>
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
            <a href="javascript:void(0)" onclick="fn_view(${cs.bbsSeq})">
      <c:if test="${cs.bbsIndent > 0}">
            <img src="/resources/images/icon_reply.gif" style="margin-left: ${cs.bbsIndent}em;"/>
      </c:if>
            <c:out value="${cs.bbsTitle}" />
            </a>
         </td>
         <td class="text-center"><c:out value="${cs.userName}" /></td>
         <td class="text-center">${cs.regDate}</td>
         <td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="3" value="${cs.bbsReadCnt}" /></td>
      </tr>
   </c:forEach>
</c:if>
      </tbody>
   </table>
   <nav>
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
   </nav>
   
   <button type="button" id="btnWrite" class="btn btn-main btn-small">글쓰기</button>
  	<br/><br/><br/>
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="bbsSeq" value="" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" /> 
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>