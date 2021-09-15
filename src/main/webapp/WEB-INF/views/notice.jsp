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
      document.bbsForm.action = "/board/noticeWriteForm";
      document.bbsForm.submit();
   });
	
	$("#btnSearch").on("click", function() {
      document.bbsForm.bbsSeq.value = "";
      document.bbsForm.searchType.value = $("#_searchType").val();
      document.bbsForm.searchValue.value = $("#_searchValue").val();
      document.bbsForm.curPage.value = "1";
      document.bbsForm.action = "/notice";
      document.bbsForm.submit();
	});
});

function fn_view(bbsSeq)
{
   document.bbsForm.bbsSeq.value = bbsSeq;
   document.bbsForm.action = "/noticeView";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.bbsSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/notice";
   document.bbsForm.submit();   
}

</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
   
   <div class="d-flex">
      <div style="width:50%;">
         <h1 class="page-name">공지사항</h1>
      </div>
      <div class="ml-auto input-group" style="width:50%;">
         <select name="_searchType" id="_searchType" class="custom-select" style="width:auto;">
            <option value="">조회 항목</option>
            <option value="1" <c:if test="${searchType eq '1'}"> selected</c:if>>작성자</option>
            <option value="2" <c:if test="${searchType eq '2'}"> selected</c:if>>제목</option>
            <option value="3" <c:if test="${searchType eq '3'}"> selected</c:if>>내용</option>
         </select>
         <input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" class="form-control mx-1" maxlength="20" style="width:auto;ime-mode:active;" placeholder="조회값을 입력하세요." />
         <button type="button" id="btnSearch" class="btn btn-secondary mb-3 mx-1">조회</button>
      </div>
    </div>
    
   <table class="table table-hover">
      <thead>
      <tr style="background-color: #dee2e6;">
         <th scope="col" class="text-center" style="width:10%">번호</th>
         <th scope="col" class="text-center" style="width:55%">제목</th>
         <th scope="col" class="text-center" style="width:10%">작성자</th>
         <th scope="col" class="text-center" style="width:15%">날짜</th>
         <th scope="col" class="text-center" style="width:10%">조회수</th>
      </tr>
      </thead>
      <tbody>
<c:if test="${!empty list}">
   <c:forEach var="notice" items="${list}" varStatus="status">
      <tr>
         <td class="text-center"><c:out value="${notice.bbsSeq}" /></td>
         <td>
            <a href="javascript:void(0)" onclick="fn_view(${notice.bbsSeq})">
            <c:out value="${notice.bbsTitle}" />
            </a>
         </td>
         <td class="text-center"><c:out value="${notice.userId}" /></td>
         <td class="text-center">${notice.regDate}</td>
         <td class="text-center"><fmt:formatNumber type="number" maxFractionDigits="3" value="${notice.bbsReadCnt}" /></td>
      </tr>
   </c:forEach>
</c:if>
      </tbody>
      <tfoot>
      <tr>
            <td colspan="5"></td>
        </tr>
      </tfoot>
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
   
   <button type="button" id="btnWrite" class="btn btn-secondary mb-3">글쓰기</button>
  
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