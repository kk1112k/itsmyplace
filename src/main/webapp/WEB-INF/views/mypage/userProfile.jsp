<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script>
$(document).ready(function() {	
	$("#withdrawal").on("click", function() {
		if(confirm("정말로 회원탈퇴 하시겠습니까?")){
			fn_withdrawal();
		}
		else{
			alert("회원탈퇴가 취소되었습니다.");
		}
	});
});

function updateInfo(){
	location.href = "/mypage/updateInfo";
}
function fn_withdrawal(){
	
	$.ajax({
		type: "POST",
		url: "/mypage/withdrawal",
		data: {
			 userId: $("#userId").val(),
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("탈퇴가 정상적으로 처리되었습니다. 이용해주셔서 감사합니다.");
				location.href = "/index";
			}
			else if(response.code == 400){
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else if(response.code == 404){
				alert("회원정보가 존재하지 않습니다.");
			}
			else if(response.code == 500){
				alert("회원탈퇴 중 오류가 발생했습니다.");
			}
			else{
				alert("회원탈퇴 중 오류가 발생했습니다.");
			}
		},
		complete: function(data){
			//응답이 종료되면 실행
			icia.common.log(data);
		},
		error: function(xhr, status, error){
			icia.common.error(error);
		}
		
	});
}
</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!--상단-->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<ol class="breadcrumb">
						<li><a href="/index">홈</a></li>
						<li class="active">마이페이지</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 본문 -->
<section class="user-dashboard page-wrapper" style="padding-top: 0px;">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <ul class="list-inline dashboard-menu text-center">
          <li><a class="active"  href="userProfile">내정보</a></li>	
          <li><a href="userPost">내가쓴 게시물</a></li>
          <c:choose>
          <c:when test="${user.userClass == 'N'}">
          <li><a href="userPayment">내 결제내역</a></li>
          </c:when>
          <c:otherwise>
          <li><a href="rsrvInfo">예약현황</a></li>
          </c:otherwise>
          </c:choose>
        </ul>
        <div class="dashboard-wrapper dashboard-user-profile">
            <div class="media-body">
              <ul class="user-profile-list">
            <form>
                <div class="form-group">
                    <label for="username">이름 : </label>
                    ${user.userName}
                </div>
                <div class="form-group">
                    <label for="username">성별 : </label>
                    <c:if test="${user.userGender eq 'M'}">남</c:if>
                    <c:if test="${user.userGender eq 'F'}">여</c:if>
                </div>
                <div class="form-group">
                    <label for="username">지역 : </label>
                    ${user.areaName}
                    ${user.subAreaName}
                </div>
                <div class="form-group">
                    <label for="username">이메일 : </label>
                    ${user.userEmail}
                </div>
                <div class="form-group">
                    <label for="username">마일리지 : </label>
					${user.totalPoint}
                </div>
                <input type="hidden" id="userId" name="userId" value="${user.userId}" />
                <input type="hidden" id="userPwd" name="userPwd" value="" />
            </form>
              </ul>
            </div>
             
           <ul class="list-inline dashboard-menu text-right">
               <button type="button" class="btn btn-main mb-3" id="updateInfo" onclick="updateInfo();">회원정보 수정</button> 
           	   <button type="button" class="btn btn-main mb-3" id="withdrawal">회원탈퇴</button>
      	   </ul>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>