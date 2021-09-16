<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style>

#myform fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    border: 0; /* 필드셋 테두리 제거 */
}
#myform input[type=radio]{
    display: none; /* 라디오박스 감춤 */
}
#myform label{
    font-size: 1em; /* 이모지 크기 */
    color: transparent; /* 기존 이모지 컬러 제거 */
    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
}
#myform label:hover{
    text-shadow: 0 0 0 #a00; /* 마우스 호버 */
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 #a00; /* 마우스 호버 뒤에오는 이모지들 */
}
#myform fieldset{
    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
    direction: rtl; /* 이모지 순서 반전 */
    border: 0; /* 필드셋 테두리 제거 */
}
#myform fieldset legend{
    text-align: left;
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 #a00; /* 마우스 클릭 체크 */
}

</style>

<script type="text/javascript">
$(document).ready(function() {
	
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
		console.log(form);
		var formData = new FormData(form);
		
		$.ajax({
			type: "POST",
			enctype: 'multipart/form-data',
			url: "/review/reviewWriteProc",
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
					location.href = "/mypage/userPayment";
				}
				else if(response.code == 400){
					alert("파라미터 값이 올바르지 않습니다. response.code = 400");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else if(response.code == 404){
					alert("포인트 적립중 오류가 발생했습니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else if(response.code == 405){
					alert("포인트 정보 갱신 중 오류가 발생했습니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else if(response.code == 900){
					alert("사진 확장자는 jpg, jpeg, png, bmp, jfif만 가능합니다.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
				}
				else if(response.code == 999){
					alert("첨부된 사진의 크기를 확인하세요.");
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
	
	$("#btnList").on("click", function() {
		document.bbsForm.action = "/mypage/userPayment";
		document.bbsForm.submit();
	});
});

</script>
</head>
<body class="is-loading">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<img src="/resources/images/comm/writeFormTitle.png" alt="이용후기 글쓰기 이미지" height="80" />
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-md-50">
				<div class="dashboard-wrapper user-dashboard">

					<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
						<input type="text" name="rsrvSeq" id="rsrvSeq" maxlength="30" value="${rsRv.rsrvSeq}" style="ime-mode:inactive;" class="form-control mb-2" placeholder="예약번호를 입력하세요" readonly />
						<input type="text" name="cafeName" id="cafeName" maxlength="20" value="${rsRv.cafeName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="카페이름을 입력해주세요." readonly />
						<input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
						
						<div class="form-group">
							<textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" maxlength="200" style="ime-mode:active;" placeholder="내용을 입력해주세요" required></textarea>
						</div>
						
						<input type="file" id="reviewPht" multiple="multiple" name="reviewPht" class="form-control mb-2" placeholder="파일을 선택하세요." required />
						
						<br />
						
						<h4>카페 이용은 만족하셨나요? (별점을 선택하지 않을 시 5점이 부여됩니다.)</h4>
						<div class="form-control mb-2" name="myform" id="myform">
						    <fieldset>
						        <input type="radio" name="bbsStar" value="5" id="rate1"><label for="rate1">⭐</label>
						        <input type="radio" name="bbsStar" value="4" id="rate2"><label for="rate2">⭐</label>
						        <input type="radio" name="bbsStar" value="3" id="rate3"><label for="rate3">⭐</label>
						        <input type="radio" name="bbsStar" value="2" id="rate4"><label for="rate4">⭐</label>
						        <input type="radio" name="bbsStar" value="1" id="rate5"><label for="rate5">⭐</label>
						    </fieldset>
						</div>
						
						<br />
						
						<h4>후기를 공개하시겠습니까? (선택하지 않으시면 공개처리 됩니다.)</h4>
						<div class="form-control mb-2">
							<input type="radio" name="bbsPublic" style="ime-mode:active;" value="Y" required />공개&nbsp;&nbsp;
							<input type="radio" name="bbsPublic" style="ime-mode:active;" value="N" required />비공개
						</div>
						
						<br />
						
						<div class="form-group row">
							<div class="col-sm-12">
								<br/>
								<button type="button" id="btnWrite" class="btn btn-main" title="저장">저장</button>
								<button type="button" id="btnList" class="btn btn-main" title="리스트">리스트</button>
							</div>
						</div>
					</form>
					
					<form name="bbsForm" id="bbsForm" method="post">
						<input type="hidden" name="rsrvSeq" value="${rsrv.rsrvSeq}" />
						<input type="hidden" name="curPage" value="${curPage}" />
					</form>

				</div>
			</div>
		</div>
	</div>
</section>



<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>