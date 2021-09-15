<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
alert("게시물이 존재하지 않습니다아");
location.href="/event/list";
</c:when>
<c:otherwise>	
	$("#bbsTitle").focus();
	
	var today = new Date();
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	var dateString = year + month + day;
	
	//게시물 수정완료 버튼
	$("#btnUpdate").on("click", function(){
		
		var evtOpnDateVal = ($("#evtOpnDate").val()).slice(0,4) + ($("#evtOpnDate").val()).slice(5,7) + ($("#evtOpnDate").val()).slice(8,10);
		var evtClsDateVal = ($("#evtClsDate").val()).slice(0,4) + ($("#evtClsDate").val()).slice(5,7) + ($("#evtClsDate").val()).slice(8,10);
		
		$("#btnUpdate").prop("disabled", true);
			
			if($.trim($("#bbsTitle").val()).length <= 0)
			{
				alert("제목을 입력하세요.");
				$("#bbsTitle").val("");
				$("#bbsTitle").focus();

				$("#btnUpdate").prop("disabled", false);
				
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
				
				$("#btnUpdate").prop("disabled", false);
				return;
			}
			
			if($.trim($("#evtOpnDate").val()).length <= 0)
			{
				alert("이벤트 시작일을 입력하세요.");
				$("#evtOpnDate").val("");
				$("#evtOpnDate").focus();
				
				$("#btnWrite").prop("disabled", false);
				
				return;
			}
			
			if($.trim($("#evtClsDate").val()).length <= 0)
			{
				alert("이벤트 종료일을 입력하세요.");
				$("#evtClsDate").val("");
				$("#evtClsDate").focus();
				
				$("#btnWrite").prop("disabled", false);
				
				return;
			}
			
			if(dateString > evtOpnDateVal)
			{
				alert("등록하고있는 현재 날짜 이후의 날짜를 입력하세요.");
				$("#evtOpnDate").val("");
				$("#evtOpnDate").focus();
				
				$("#btnWrite").prop("disabled", false);
				
				return;
			}
			
			if(evtClsDateVal < evtOpnDateVal)
			{
				alert("이벤트 시작일보다 종료일이 나중이어야 합니다.");
				$("#evtClsDate").val("");
				$("#evtClsDate").focus();
				
				$("#btnWrite").prop("disabled", false);
				
				return;
			}
			
			var form = $("#updateForm")[0];
			var formData = new FormData(form);
			
			$.ajax({
		    	type: "POST",
		    	enctype: 'multipart/form-data',
		    	url: "/event/updateProc",
		    	data: formData,
		    	processData: false,		//formData를 String으로 변환하지 않는다는 의미로 사용했따 !! 
		    	contentType: false,		//contentType 헤더가 multipart/form-data로 전송한다는 의미이다아ㅏ
		    	cache: false,
		    	timeout: 600000,
		    	beforeSend: function(xhr)
		    	{
		    		xhr.setRequestHeader("AJAX");
		    	},
		    	success: function(response)
		    	{
		    		if(response.code == 0)
		    		{
		    			alert("이벤트 게시물이 정상적으로 수정되었습니다.");
		    			location.href="/event/list";
		    		}
		    		else if(response.code == 400)
		    		{
		    			alert("파라미터 값이 올바르지 않습니다.");
		    			$("#btnUpdate").prop("disable", false);		//글쓰기 버튼 활성화 처리
		    		}
		    		else
		    		{
		    			alert("게시물 수정 중 오류가 발생하였습니다.");
		    			$("#btnUpdate").prop("disable", false);		//글쓰기 버튼 활성화 처리
		    		}
		    		
		    	},
		    	error: function(error)
		    	{
		    		icia.common.error(error);
		    		alert("이벤트 게시물 수정 중 오류가 발생하였습니다.");
		    		$("#btnUpdate").prop("disable", false);		//글쓰기 버튼 활성화 처리
		    	}
		    	
		    	
			});
			
	});
	
	$("#btnList").on("click", function() {
		document.eventForm.action = "/event/list";
		document.eventForm.submit();
	});
	</c:otherwise>
</c:choose>
});	


</script>

</head>


<body id="body">

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>



<section class="page-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="post post-single">
				    <div class="post-comments-form">
				    	<h5 class="post-sub-heading">Update Your Event Posting</h5>
				    	<form method="post" name="updateForm" id="updateForm" enctype="multipart/form-data" >
				            <div class="row">

				                <div class="col-md-4 form-group">
				                    <input type="text" name="userId" id="userId" value="${user.userId}" class=" form-control" placeholder="Id *" maxlength="100"  readonly>
				                </div>

				                <div class="col-md-4 form-group">
				                    <input type="text" name="userName" id="userName" value="${user.userName}" class=" form-control" placeholder="Name *" maxlength="100" required="" readonly>
				                </div>
				                
				                <div class="col-md-4 form-group">
				                    <input type="email" name="userEmail" id="userEmail" value="${user.userEmail}" class=" form-control" placeholder="Email *" maxlength="100" required="" readonly>
				                </div>
								
								
								<p><c:set var="evtOpnDate" value="${eventBoard.evtOpnDate}" /></p>
								<p><c:set var="evtClsDate" value="${eventBoard.evtClsDate}" /></p>
								<div class="col-md-6 form-group">
				                    &nbsp;&nbsp;이벤트 시작일<input type="date" name="evtOpnDate" id="evtOpnDate" value="${fn:substring(evtOpnDate,0,4)}-${fn:substring(evtOpnDate,5,7)}-${fn:substring(evtOpnDate,8,10)}" class=" form-control" placeholder="Event Open Date *" maxlength="100" required="" >
				                </div>
				                
				                <div class="col-md-6 form-group">
				                    &nbsp;&nbsp;이벤트 종료일<input type="date" name="evtClsDate" id="evtClsDate" value="${fn:substring(evtClsDate,0,4)}-${fn:substring(evtClsDate,5,7)}-${fn:substring(evtClsDate,8,10)}" class=" form-control" placeholder="Event Close Date *" maxlength="100" required="" >
				                </div>		
										
				                <div class="form-group col-md-12">
				                    <input type="text" name="bbsTitle" id="bbsTitle" value="${eventBoard.bbsTitle}" class=" form-control" placeholder="Title *" maxlength="100" required="">
				                </div>
				                
				                <div>
				                    <input type="file" name="bbsFile" id="bbsFile" value="${eventBoardFile.bbsFile}" class=" form-control" placeholder="File *" maxlength="100" style="position:relative; width:114rem; height:4rem; left:10px; margin-left:.5rem;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[첨부파일 : ${eventBoard.fileOrgName}]
				                </div>				                
								
								<br/>
								
				                <div>
				                    <textarea name="bbsContent" id="bbsContent" value="${eventBoard.bbsContent}" class=" form-control" rows="15" placeholder="Comment *" maxlength="20000" style="position:relative; width:114rem; height:50rem; left:10px; margin-left:.5rem;" required="">${eventBoard.bbsContent}</textarea>
				                </div>
								
								<br/>
								
								<input type="hidden" name="bbsSeq" value="${eventBoard.bbsSeq}" />
								<input type="hidden" name="searchStatus" value="${searchStatus}" />
								<input type="hidden" name="searchType" value="${searchType}" />
								<input type="hidden" name="searchValue" value="${searchValue}" />
								<input type="hidden" name="curPage" value="${curPage}" /> 
								
								
								<!--  수정 / 목록 버튼 --> 
								<div class="text-center" style="position: relative; ">
								    <a id="btnUpdate" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">&nbsp;&nbsp;수정&nbsp;&nbsp;</a>
								    &nbsp;&nbsp;&nbsp;&nbsp;
								    <a id="btnList" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">&nbsp;&nbsp;목록&nbsp;&nbsp;</a>
								</div>
				            </div>
				        </form>
				    </div>	
				</div>
			</div>
		</div>
	</div>
</section>


<form name="eventForm" id="eventForm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="bbsSeq" value="${eventBoard.bbsSeq}" />
	<input type="hidden" name="bbsTitle" value="${eventBoard.bbsTitle}" />
	<input type="hidden" name="bbsContent" value="${eventBoard.bbsContent}" />
	<input type="hidden" name="evtOpnDate" value="${eventBoard.evtOpnDate}" />
	<input type="hidden" name="evtClsDate" value="${eventBoard.evtClsDate}" />
	<input type="hidden" name="searchStatus" value= "${searchStatus}" />
	<input type="hidden" name="searchType" value="${searchType}"  />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>	
	
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   
</body>
</html>
