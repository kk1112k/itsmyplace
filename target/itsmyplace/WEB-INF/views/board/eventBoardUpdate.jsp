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
location.href="/board/eventBoard";
</c:when>
<c:otherwise>	
	$("#bbsTitle").focus();
	
	//게시물 수정완료 버튼
	$("#btnUpdate").on("click", function(){
		//document.eventForm.bbsSeq.value = "";
		
		$("#btnUpdate").prop("disabled", true); // 글쓰기 버튼 비활성화
			
			if($.trim($("#bbsTitle").val()).length <= 0)
			{
				alert("제목을 입력하세요.");
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
				
				return;
			}
			
			var form = $("#updateForm")[0];
			var formData = new FormData(form);
			
			$.ajax({
		    	type: "POST",
		    	enctype: 'multipart/form-data',
		    	url: "/board/eventBoardUpdateProc",
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
		    			location.href="/board/eventBoard";
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
		document.eventForm.action = "/board/eventBoard";
		document.eventForm.submit();
	});
	</c:otherwise>
</c:choose>
});	


	/*  도움
	function boardList(){
		$.ajax{(
			type: "POST",
			url: "/board/eventBoard",
			datatype: "JSON",
			success: function(response){
				const breadCrumb = $("#breadcrumb");
				let cafeList = "";
				$.each(response, function(i){
					//breadcrumb.append(response.cafeName);
					cafeList += '<li id="'+response.cafeCode+'">'+response.cafeName+'</li>';
				});
				
				breadCurmb.append(cafeList);
			}
		},function(msg){
			alert(msg);
		},false);
	} */
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
				                    <!-- userId -->
				                    <input type="text" name="userId" id="userId" value="${user.userId}" class=" form-control" placeholder="Id *" maxlength="100"  readonly>
				                </div>

				                <div class="col-md-4 form-group">
				                    <!-- userName -->
				                    <input type="text" name="userName" id="userName" value="${user.userName}" class=" form-control" placeholder="Name *" maxlength="100" required="" readonly>
				                </div>
				                
				                <div class="col-md-4 form-group">
				                    <!-- userEmail -->
				                    <input type="email" name="userEmail" id="userEmail" value="${user.userEmail}" class=" form-control" placeholder="Email *" maxlength="100" required="" readonly>
				                </div>


				                <div class="form-group col-md-12">
				                    <!-- Title -->
				                    <input type="text" name="bbsTitle" id="bbsTitle" value="${eventBoard.bbsTitle}" class=" form-control" placeholder="Title *" maxlength="100">
				                </div>
				                
				                <div>
				                    <!-- File -->
				                    <input type="file" name="bbsFile" id="bbsFile" value="${eventBoardFile.bbsFile}" class=" form-control" placeholder="File *" maxlength="100" style="position:relative; width:114rem; height:4rem; left:10px; margin-left:.5rem;" >
				                </div>				                
								
								<br/>
				                <!-- Comment -->
				                <div>
				                    <input type="text" name="bbsContent" id="bbsContent" value="${eventBoard.bbsContent}" class=" form-control" rows="15" placeholder="Comment *" maxlength="20000" style="position:relative; width:114rem; height:50rem; left:10px; margin-left:.5rem;">
				                </div>
								
								<br/>
								
								<input type="hidden" name="bbsSeq" value="${eventBoard.bbsSeq}" />
								<input type="hidden" name="searchStatus" value="${searchStatus}" />
								<input type="hidden" name="searchType" value="${searchType}" />
								<input type="hidden" name="searchValue" value="${searchValue}" />
								<input type="hidden" name="curPage" value="${curPage}" /> 
								
								
								<!--  글쓰기 / 수정 / 목록 버튼 --> 
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
		<input type="hidden" name="searchStatus" value= "${searchStatus}" />
		<input type="hidden" name="searchType" value="${searchType}"  />
		<input type="hidden" name="searchValue" value="${searchValue}" />
		<input type="hidden" name="curPage" value="${curPage}" />
		<!-- 아마도 여기에  -->	
	</form>	
	
	
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   
</body>
</html>
