<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
<c:choose>
   <c:when test="${empty cs}">
      alert("게시물이 존재하지 않습니다.");
      location.href="/cs/list";
   </c:when>
   <c:otherwise>
   $("#bbsTitle").focus();
   
   $("#btnUpdate").on("click", function() {
      
      $("#btnUpdate").prop("disabled", true);  // 수정 버튼 비활성화
      
      if($.trim($("#bbsTitle").val()).length <= 0)
      {
         alert("제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bbsTitle").focus();
         $("#btnUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
         return;
      }
      
      if($.trim($("#bbsTitle").val()).length > 60)
      {
      	alert("제목은 공백포함 60자 이내로 작성해주세요.");

      	$("#bbsTitle").val("");
      	$("#bbsTitle").focus();
      	$("#btnUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화

      	return;
      }
      
      if($.trim($("#bbsContent").val()).length <= 0)
      {
         alert("내용을 입력하세요.");
         $("#bbsContent").val("");
         $("#bbsContent").focus();
         $("#btnUpdate").prop("disabled", false);  // 글쓰기 버튼 활성화
         return;
      }
      
      var form = $("#updateForm")[0];
      var formData = new FormData(form);
      
      $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/cs/updateProc",
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            beforeSend: function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
            success: function(response)
            {
               if(response.code == 0){
                  alert("게시물이 수정되었습니다.");
                  location.href = "/cs/list";
                  //게시판처음들어갔을때상태
                  /*
                  document.bbsForm.action = "/board/list";
                  document.bbsForm.submit();
                        차이점: 현재폼에 액션태그 넣고 bbsForm을 submit 했기 때문에 서치타입, 서치밸류 들고가게됨 
                  */
               }
               else if(response.code == 400)
               {
                  alert("파라미터 값이 올바르지 않습니다.");
                  $("#btnUpdate").prop("disabled", false); // 버튼 활성화
               }
               else if(response.code == 404)
               {
                  alert("게시물을 찾을 수 없습니다.");
                  location.href = "/cs/list";
               }
               else
               {
                  alert("게시물 수정 중 오류가 발생하였습니다.");
                  $("#btnUpdate").prop("disabled", false);
               }
            },
            error: function(error)
            {
               icia.common.error(error);
               alert("게시물 수정 중 오류가 발생하였습니다.");
               $("#btnUpdate").prop("disabled", false);
            }
      });
   });
   
   </c:otherwise>
</c:choose>
});

function fn_list(curPage)
{
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/cs/list";
   document.bbsForm.submit();   
}

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
	<div style="height:70px;"><img src="/resources/images/cs/updateFormTitle.png" alt="글수정페이지 이미지" height=70px;/></div>
	<div style="height:16.5px; background-color:#4397CF"></div>
   <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
      <input type="text" name="userId" id="userId" maxlength="20" value="작성자 아이디 : ${user.userId}" style="ime-mode:active;" class="form-control mt-4 mb-2" readonly />
      <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" value="${cs.bbsTitle}" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
         <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required>${cs.bbsContent}</textarea>
      </div>
      
      <input type="hidden" name="bbsSeq" value="${cs.bbsSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
   
   <div class="form-group row" style="margin-top:15px;">
      <div class="col-sm-12">
         <button type="button" id="btnUpdate" class="btn btn-main mb-3" style="height:45px;" title="수정">수정</button>
         <button type="button" id="btnList" class="btn btn-main mb-3" style="height:45px;" title="리스트">리스트</button>
      </div>
   </div>
</div>
</div>
</div>
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="${cs.bbsSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>
</c:if>
</body>
</html>