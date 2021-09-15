<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
<c:choose>
   <c:when test="">
      alert("조회하신 게시물이 존재하지 않습니다.");
      documnet.bbsForm.action = "/notice/list";
      document.bbsForm.submit();
   </c:when>
   <c:otherwise>
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/notice/list";
      document.bbsForm.submit();
   });
   
   $("#btnReply").on("click", function() {
      document.bbsForm.action = "/notice/replyForm";
      document.bbsForm.submit();
   });
   

   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/notice/updateForm";
      document.bbsForm.submit();
   });
   
   $("#btnDelete").on("click", function(){
      if(confirm("게시물을 삭제 하시겠습니까?") == true)
      { 
    	  //ajax
    	  $.ajax({
    		  type: "POST",
    		  url: "/notice/delete",
    		  data: {
    			  bbsSeq: <c:out value="${notice.bbsSeq}" />
    		  },
    		  datatype: "JSON",
    		  beforeSend: function(xhr){
    			xhr.setRequestHeader("AJAX", "true");  
    		  },
    		  success: function(response){
    			  if(response.code == 0){
    				  alert("게시물이 삭제 되었습니다.");
    				  location.href = "/notice/list";
    			  }
    			  else if(response.code == 400){
    				  alert("파라미터 값이 올바르지 않습니다. code == 400");
    			  }
    			  else if(response.code == 404){
    				  alert("게시물을 찾을 수 없습니다. code == 404"); // bbsseq값이 없거나 삭제할 값이 없는 경우
    			  	  location.href = "/notice/list";
    			  }
    			  else{
    				  alert("게시물 삭제 중 오류가 발생했습니다.");
    			  }
    		  },
    		  complete: function(data){
    			  icia.common.log(data);
    		  },
    		  error: function(xhr, status, error){
    			  icia.common.error(error);
    		  }
    		  
    	  });
      }
   });
   </c:otherwise>
</c:choose>
});
</script>
</head>
<body>
<c:if test="${!empty notice}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
   <h2>공지사항 보기</h2>
   
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table">
         <thead>
            <tr class="table-active">
               <th scope="col" style="width:60%">
                  <c:out value="${notice.bbsTitle}" /> <br/>
                  <c:out value="${notice.userName}" /> &nbsp;&nbsp;&nbsp;
                  <a href="mailto:${notice.userEmail}" style="color:#828282;">${notice.userEmail}</a>
   <c:if test="${!empty notice.noticeFile}">
                  &nbsp;&nbsp;&nbsp;<a href="/notice/download?bbsSeq=${notice.noticeFile.bbsSeq}" style="color:#000;">[첨부파일] </a>
   </c:if>      
               </th>
               <th scope="col" style="width:40%" class="text-right">
                  조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${notice.bbsReadCnt}" /><br/>
                  ${notice.regDate}
               </th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td colspan="2"><pre><c:out value="${notice.bbsContent}" /></pre></td>
            </tr>
         </tbody>
         <tfoot>
         <tr>
               <td colspan="2"></td>
           </tr>
         </tfoot>
      </table>
   </div>
   
   <button type="button" id="btnList" class="btn btn-main btn-small">리스트</button>
   <button type="button" id="btnReply" class="btn btn-main btn-small">답변</button>
   <c:if test="${noticeMe eq 'Y'}">
   <button type="button" id="btnUpdate" class="btn btn-main btn-small">수정</button>
   <button type="button" id="btnDelete" class="btn btn-main btn-small">삭제</button>
   </c:if>
   <br/>
   <br/>
</div>
</c:if>
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="${notice.bbsSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
   <!--  이걸 알아야 컨트롤에서 리퀘스트를 받음 -->
</form>

</body>
</html>