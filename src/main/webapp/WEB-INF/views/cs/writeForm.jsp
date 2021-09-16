<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {

	if($("#userClass").val() == 'S'){
		alert("잘못된 접근 경로입니다.");
		history.back(); // 강제로 url 치고 들어왔을때 걸러내기 위함
	}
	
	$("#bbsTitle").focus();
	
	$("#btnWrite").on("click", function() {
		
		$("#btnWrite").prop("disabled", true); // 글쓰기 버튼 비활성화
		
		if($.trim($("#bbsTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#bbsTitle").val("");
			$("#bbsTitle").focus();
			
			$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화
			
			return;
		}
		
		if($.trim($("#bbsTitle").val()).length > 60)
		{
			alert("제목은 공백포함 60자 이내로 작성해주세요.");

			$("#bbsTitle").val("");
			$("#bbsTitle").focus();
			$("#btnWrite").prop("disabled", false);  // 글쓰기 버튼 활성화

			return;
		}
		
		if($.trim($("#bbsContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#bbsContent").val("");
			$("#bbsContent").focus();
			
			$("#btnWrite").prop("disabled", false); // 글쓰기 버튼 활성화
			
			return;
		}
		
		var form = $("#writeForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/cs/writeProc",
			data: formData,
			processData: false,			//formData를 string으로 변환하지 않겠다는 뜻
			contentType: false,			//content-type 헤더가 multipart/form-data로 전송
			cache: false,
			timeout: 600000,
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX","true");
			},
			success: function(response){
				if(response.code == 0){
					alert("게시물이 등록되었습니다.");
					location.href = "/cs/list";
				}
				else if(response.code == 400){
					alert("파라미터 값이 올바르지 않습니다. response.code = 400");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else{
					alert("게시물 등록 중 오류가 발생했습니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				
			},
			error: function(error){
				icia.common.error(error);
				alert("게시물 등록중 오류가 발생했습니다.");
				$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
			}
			
	    });
	});
	
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
<c:if test="${user.userClass ne 'S'}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="user-dashboard page-wrapper">
<div class="container">
	<div class="d-flex">
		<div class="logo text-center">
			<a href="/cs/list"><img src="/resources/images/cs/csTitle.png" alt="고객센터 타이틀 이미지" height="80" /></a>
		</div>
	<div class="comm-custom2"></div>
	<div style="height:70px;"><img src="/resources/images/cs/writeFormTitle.png" alt="글쓰기페이지 이미지" height=70px;/></div>
	<div style="height:16.5px; background-color:#4397CF"></div>
	<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
		<input type="text" name="userId" id="userId" maxlength="20" value="작성자 아이디 : ${user.userId}" style="ime-mode:active; background-color:#90D5EB" class="form-control mt-4 mb-2" readonly />
		<input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
		<div class="form-group">
			<textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
		</div>
	
		<div class="form-group row">
			<div class="col-sm-12">
				<button type="button" id="btnList" class="btn btn-main mb-3" style="height:45px;" title="리스트" onclick="fn_list(${curPage})">리스트</button>
				<button type="button" id="btnWrite" class="btn btn-main mb-3" style="height:45px;" title="저장">저장</button>
			</div>
		</div>
	</form>
	<form name="bbsForm" id="bbsForm" method="post">
		<input type="hidden" name="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
	</form>
</div>
</div>
</div>
</c:if>
<input type="hidden" id="userClass" name="userClass" value="${user.userClass}" />
</body>
</html>