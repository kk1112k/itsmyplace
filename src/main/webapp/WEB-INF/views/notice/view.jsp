<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
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
<div class="user-dashboard page-wrapper">
<div class="container">
	<div class="d-flex">
   <div class="logo text-center">
		<a href="/notice/list"><img src="/resources/images/notice/noticeTitle.png" alt="공지사항 타이틀 이미지" height="80" /></a>
   </div>
   <div class="comm-custom2"></div>
   <div style="height:70px;"><img src="/resources/images/notice/noticeTitle2.png" alt="게시글제목이미지" height=70px;/></div>
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table" style="color:#fbf9d3">
         <thead>
            <tr class="table-active" style="background-color:#4397CF">
               <th scope="col" style="width:60%">
                  <h3>&nbsp;<c:out value="${notice.bbsTitle}" /></h3><br/>
				</th>
				<th scope="col" style="width:40%" class="text-right">
                  조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${notice.bbsReadCnt}" /><br/>
                  작성자 아이디 : <c:out value="${notice.userId}" /><br/>
                  작성시간 : ${notice.regDate}
               </th>
            </tr>
         </thead>
         <tbody>
         <tr>
               <td colspan="2" class="text-center">
               <c:if test="${!empty notice.noticeFile}">
               <img src="/resources/upload/notice/${notice.noticeFile.fileName}" alt="사용자첨부이미지" />
               </c:if>
            </td>
         </tr>
            <tr>
               <td colspan="2"><pre style="min-height:150px; background-color:#FFF"><c:out value="${notice.bbsContent}" /></pre></td>
            </tr>
         </tbody>
         <tfoot>
         <tr>
               <td colspan="2">
	               <c:if test="${!empty notice.noticeFile}">
	               <div style="margin-bottom:0.1em; color:#000000;">
	                  <a href="/notice/download?bbsSeq=${notice.noticeFile.bbsSeq}" style="color:#4397CF;">[첨부파일]</a>
	                  ${notice.noticeFile.fileOrgName}  
	   			   </div>
	   			   </c:if>
               </td>
           </tr>
         </tfoot>
      </table>
   </div>
   
   <button type="button" id="btnList" class="btn btn-main mb-3" style="height:45px;" >리스트</button>
   <c:if test="${noticeMe eq 'Y'}">
   <button type="button" id="btnUpdate" class="btn btn-main mb-3" style="height:45px;" >수정</button>
   <button type="button" id="btnDelete" class="btn btn-main mb-3" style="height:45px;" >삭제</button>
   </c:if>
   <br/>
   <br/>
</div>
</div>
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