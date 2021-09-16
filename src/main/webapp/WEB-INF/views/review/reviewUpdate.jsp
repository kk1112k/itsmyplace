<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style>
/* 별점 Css */

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

var phtNumList = new Array();
var phtNameList = new Array();

function fn_phtDelete(pht_Num,pht_Name)
{		
	if(confirm("정말로 첨부파일 목록에서 제거하시겠습니까?") == true)
	{
		$("#phtDelete"+pht_Num).css("display", "none");
		
		phtNumList.push(pht_Num);
		phtNameList.push(pht_Name);
	}
	else
	{
		return;
	}
}

$(document).ready(function() {
<c:choose>
   <c:when test="${empty review}">
      alert("게시물이 존재하지 않습니다.");
      location.href="/review/list";
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
         return;
      }
      
      var form = $("#updateForm")[0];
      var formData = new FormData(form);
      
	  var k = 0;
	 	
	  while(k < phtNumList.length)
	  {
			formData.append("phtNum", phtNumList[k]);
			k++;
	  }
      
      $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/review/reviewUpdateProc",
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
                  location.href = "/review/list";
                  //게시판처음들어갔을때상태
                  /*
                  document.bbsForm.action = "/review/list";
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
                  location.href = "/review/list";
               }
               else if(response.code == 900){
					alert("사진 확장자는 jpg, jpeg, png, bmp, jfif만 가능합니다.");
					$("#btnUpdate").prop("disabled", false); //글쓰기 버튼 활성화
				}
               else if(response.code == 999){
					alert("첨부된 사진의 크기를 확인하세요.");
					$("#btnWrite").prop("disabled", false); //글쓰기 버튼 활성화
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
   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/review/list";
      document.bbsForm.submit();
   });
   
   </c:otherwise>
</c:choose>
});
</script>

</head>
<body class="is-loading">
<c:if test="${!empty review}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<img src="/resources/images/comm/updateFormTitle.png" alt="글수정페이지 이미지" height=70px;/>
				</div>
			</div>
		</div>
	</div>


<!-- <section class="user-dashboard page-wrapper"> -->
	<div class="container">
		<div class="row">
			<div class="col-md-50">
				<div class="dashboard-wrapper user-dashboard">

					<form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
						<input type="text" name="rvrsSeq" id="rvrsSeq" maxlength="20" value="${review.cafeName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="카페이름을 입력해주세요." readonly />
						<input type="text" name="userId" id="userId" maxlength="30" value="${review.userId}" style="ime-mode:inactive;" class="form-control mb-2" placeholder="아이디를 입력해주세요" readonly />
						<input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" value="${review.bbsTitle}" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
						
						<div class="form-group">
							<textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" maxlength="200" style="ime-mode:active;" placeholder="내용을 입력해주세요" required>${review.bbsContent}</textarea>
						</div>
						
						<input type="file" id="reviewPht" name="reviewPht" multiple="multiple" class="form-control mb-2" placeholder="파일을 선택하세요." required />
						<c:if test="${!empty review.reviewPhtList}">
							<c:forEach var="reviewPht" items="${review.reviewPhtList}" varStatus="status">
      							<div style="margin-bottom:0.3em; width:80%;" style="display:block;" id="phtDelete${reviewPht.phtNum}"><input type="button" value="x" onClick="fn_phtDelete(${reviewPht.phtNum},'${reviewPht.phtOrgName}');">&nbsp;&nbsp;&nbsp;[첨부사진: ${reviewPht.phtOrgName}]</div>
      						</c:forEach>
						</c:if>
						
						<br />
						
						<h4>별점을 수정해주세요!</h4>
						<div class="form-control mb-2" name="myform" id="myform">
						    <fieldset>
						    	<c:if test="${review.bbsStar eq 5}">
						        <input type="radio" name="bbsStar" value="5.0" id="rate1" checked="checked"><label for="rate1">⭐</label>
						        <input type="radio" name="bbsStar" value="4.0" id="rate2" /><label for="rate2">⭐</label>
						        <input type="radio" name="bbsStar" value="3.0" id="rate3" /><label for="rate3">⭐</label>
						        <input type="radio" name="bbsStar" value="2.0" id="rate4" /><label for="rate4">⭐</label>
						        <input type="radio" name="bbsStar" value="1.0" id="rate5" /><label for="rate5">⭐</label>
						        </c:if>
						        <c:if test="${review.bbsStar eq 4}">
						        <input type="radio" name="bbsStar" value="5.0" id="rate1" /><label for="rate1">⭐</label>
						        <input type="radio" name="bbsStar" value="4.0" id="rate2" checked="checked" /><label for="rate2">⭐</label>
						        <input type="radio" name="bbsStar" value="3.0" id="rate3" /><label for="rate3">⭐</label>
						        <input type="radio" name="bbsStar" value="2.0" id="rate4" /><label for="rate4">⭐</label>
						        <input type="radio" name="bbsStar" value="1.0" id="rate5" /><label for="rate5">⭐</label>
						        </c:if>
						        <c:if test="${review.bbsStar eq 3}">
						        <input type="radio" name="bbsStar" value="5.0" id="rate1" /><label for="rate1">⭐</label>
						        <input type="radio" name="bbsStar" value="4.0" id="rate2" /><label for="rate2">⭐</label>
						        <input type="radio" name="bbsStar" value="3.0" id="rate3" checked="checked" /><label for="rate3">⭐</label>
						        <input type="radio" name="bbsStar" value="2.0" id="rate4" /><label for="rate4">⭐</label>
						        <input type="radio" name="bbsStar" value="1.0" id="rate5" /><label for="rate5">⭐</label>
						        </c:if>
						        <c:if test="${review.bbsStar eq 2}">
						        <input type="radio" name="bbsStar" value="5.0" id="rate1" /><label for="rate1">⭐</label>
						        <input type="radio" name="bbsStar" value="4.0" id="rate2" /><label for="rate2">⭐</label>
						        <input type="radio" name="bbsStar" value="3.0" id="rate3" /><label for="rate3">⭐</label>
						        <input type="radio" name="bbsStar" value="2.0" id="rate4" checked="checked" /><label for="rate4">⭐</label>
						        <input type="radio" name="bbsStar" value="1.0" id="rate5" /><label for="rate5">⭐</label>
						        </c:if>
						        <c:if test="${review.bbsStar eq 1}">
						        <input type="radio" name="bbsStar" value="5.0" id="rate1" /><label for="rate1">⭐</label>
						        <input type="radio" name="bbsStar" value="4.0" id="rate2" /><label for="rate2">⭐</label>
						        <input type="radio" name="bbsStar" value="3.0" id="rate3" /><label for="rate3">⭐</label>
						        <input type="radio" name="bbsStar" value="2.0" id="rate4" /><label for="rate4">⭐</label>
						        <input type="radio" name="bbsStar" value="1.0" id="rate5" checked="checked" /><label for="rate5">⭐</label>
						        </c:if>
						    </fieldset>
						</div>
						
						<br />
						
						<h4>후기를 공개하시겠습니까?</h4>
						<div class="form-control mb-2">
							<c:if test="${review.bbsPublic eq 'Y'}">
							<input type="radio" name="bbsPublic" style="ime-mode:active;" checked="checked" value="Y" required />공개&nbsp;&nbsp;
							<input type="radio" name="bbsPublic" style="ime-mode:active;" value="N" required />비공개
							</c:if>
							<c:if test="${review.bbsPublic eq 'N'}">
							<input type="radio" name="bbsPublic" style="ime-mode:active;" value="Y" required />공개&nbsp;&nbsp;
							<input type="radio" name="bbsPublic" style="ime-mode:active;" checked="checked" value="N" required />비공개
							</c:if>
						</div>
						
						<br />
						
				      <input type="hidden" name="rsrvSeq" value="${review.rsrvSeq}" />
				      <input type="hidden" name="searchType" value="${searchType}" />
				      <input type="hidden" name="searchValue" value="${searchValue}" />
				      <input type="hidden" name="curPage" value="${curPage}" />
				   </form>
   
				   <div class="form-group row">
				      <div class="col-sm-12">
				         <button type="button" id="btnUpdate" class="btn btn-primary" title="수정">수정</button>
				         <button type="button" id="btnList" class="btn btn-secondary" title="리스트">리스트</button>
				      </div>
				   </div>
			</div>
				<form name="bbsForm" id="bbsForm" method="post">
				   <input type="hidden" name="rsrvSeq" value="${review.rsrvSeq}" />
				   <input type="hidden" name="searchType" value="${searchType}" />
				   <input type="hidden" name="searchValue" value="${searchValue}" />
				   <input type="hidden" name="curPage" value="${curPage}" />
				</form>

				</div>
			</div>
		</div>
</section>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</c:if>
</body>
</html>