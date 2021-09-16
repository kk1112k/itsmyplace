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
      documnet.bbsForm.action = "/cs/list";
      document.bbsForm.submit();
   </c:when>
   <c:otherwise>
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/cs/list";
      document.bbsForm.submit();
   });
   
   $("#btnReply").on("click", function() {
	   if($("#userClass").val() == 'S'){
			//document.bbsForm.bbsSeq.value = "";
			document.bbsForm.action = "/cs/replyForm";
		    document.bbsForm.submit();
		}
		else{
			alert("관리자만 답글을 작성할 수 있습니다.");
			return;
		}
   });
   

   $("#btnUpdate").on("click", function() {
      document.bbsForm.action = "/cs/updateForm";
      document.bbsForm.submit();
   });
   
   $("#btnDelete").on("click", function(){
      if(confirm("게시물을 삭제 하시겠습니까?") == true)
      { 
    	  //ajax
    	  $.ajax({
    		  type: "POST",
    		  url: "/cs/delete",
    		  data: {
    			  bbsSeq: <c:out value="${cs.bbsSeq}" />
    		  },
    		  datatype: "JSON",
    		  beforeSend: function(xhr){
    			xhr.setRequestHeader("AJAX", "true");  
    		  },
    		  success: function(response){
    			  if(response.code == 0){
    				  alert("게시물이 삭제 되었습니다.");
    				  location.href = "/cs/list";
    			  }
    			  else if(response.code == 400){
    				  alert("파라미터 값이 올바르지 않습니다. code == 400");
    			  }
    			  else if(response.code == 404){
    				  alert("게시물을 찾을 수 없습니다. code == 404"); // bbsseq값이 없거나 삭제할 값이 없는 경우
    			  	  location.href = "/cs/list";
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
<c:if test="${!empty cs}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="user-dashboard page-wrapper">
<div class="container">
   <div class="d-flex">
	<div class="logo text-center">
		<a href="/cs/list"><img src="/resources/images/cs/csTitle.png" alt="고객센터 타이틀 이미지" height="80" /></a>
	</div>
	<div class="comm-custom2"></div>
	<div style="height:70px;"><img src="/resources/images/cs/csTitle2.png" alt="게시글제목이미지" height=70px;/></div>
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table" style="color:#fbf9d3">
         <thead>
            <tr class="table-active" style="background-color:#4397CF">
               <th scope="col" style="width:60%">
                 <h2>&nbsp;<c:out value="${cs.bbsTitle}" /></h2><br/>
               </th>
               <th scope="col" style="width:40%" class="text-right">
                  조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${cs.bbsReadCnt}" /><br/>
                  작성자 아이디 : <c:out value="${cs.userId}" /><br/>
                  작성시간 : ${cs.regDate}
               </th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td colspan="2"><pre style="min-height:150px; background-color:#FFF"><c:out value="${cs.bbsContent}" /></pre></td>
            </tr>
         </tbody>
         <tfoot>
         <tr>
               <td colspan="2"></td>
           </tr>
         </tfoot>
      </table>
   </div>
   
   <input type="hidden" id="userClass" name="userClass" value="${user.userClass}">
   <button type="button" id="btnList" class="btn btn-main mb-3" style="height:45px;" >리스트</button>
   <c:if test="${user.userClass eq 'S'}">
   <button type="button" id="btnReply" class="btn btn-main mb-3" style="height:45px;" >답변</button>
   </c:if>
   <c:if test="${csMe eq 'Y'}">
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
   <input type="hidden" name="bbsSeq" value="${cs.bbsSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
   <!--  이걸 알아야 컨트롤에서 리퀘스트를 받음 -->
</form>

</body>
</html>