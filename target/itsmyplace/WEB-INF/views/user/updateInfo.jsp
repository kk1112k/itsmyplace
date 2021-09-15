<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script type="text/javascript">
	
	
$(document).ready(function() {

	$("#btnUpdate").on("click", function() {

		// 모든 공백 체크 정규식
		var emptCheck = /\s/g;
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
		
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#userPwd1").val("");
			$("#userPwd1").focus();
			return;
		}
		
		if (emptCheck.test($("#userPwd1").val())) 
		{
			alert("비밀번호는 공백을 포함할 수 없습니다.");
			$("#userPwd1").focus();
			return;
		}
		
		if (!idPwCheck.test($("#userPwd1").val())) 
		{
			alert("비밀번호는 영문 대소문자와 숫자로 4~12자리 입니다.");
			$("#userPwd1").focus();
			return;
		}
		
		if ($("#userPwd1").val() != $("#userPwd2").val()) 
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#userPwd2").focus();
			return;
		}
		
		if($.trim($("#userName").val()).length <= 0)
		{
			alert("사용자 이름을 입력하세요.");
			$("#userName").val("");
			$("#userName").focus();
			return;
		}
		
		if(!fn_validateEmail($("#userEmail").val()))
		{
			alert("사용자 이메일 형식이 올바르지 않습니다.");
			$("#userEmail").focus();
			return;	
		}
		
		$("#userPwd").val($("#userPwd1").val());

		var targ = document.getElementById("country");
	    var subAreaNum = targ.options[targ.selectedIndex].value;
	    
		if(subAreaNum == ""){
	    	alert("지역을 선택하세요.");
	    	
	    	return;
	    }	
		
		
		$.ajax({
			type: "POST",
			url: "/user/updateProc",
			data: {
				userId: $("#userId").val(),
		         userClass: $("#_userClass").val(),
		         areaNum: $("#areaNum").val(),
		         subAreaNum: subAreaNum,
		         userPwd: $("#userPwd").val(),
		         userName: $("#userName").val(),
		         userEmail: $("#userEmail").val(),
		         userGender: $("#_userGender").val()
			},
			datatype: "JSON",
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success: function(response){
				if(response.code == 0){
					alert("회원정보가 수정되었습니다.");
					location.href = "../";
				}
				else if(response.code == 400){
					alert("파라미터 값이 올바르지 않습니다.");
					$("#userPwd1").focus();
				}
				else if(response.code == 404){
					alert("회원정보가 존재하지 않습니다.");
					location.href = "/";
				}
				else if(response.code == 500){
					alert("회원정보 수정 중 오류가 발생했습니다.");
					$("#userPwd1").focus();
				}
				else{
					alert("회원정보 수정 중 오류가 발생했습니다.");
					$("#userPwd1").focus();
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
	});
});

function fn_validateEmail(value)
{
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	
	return emailReg.test(value);
}

</script>

</head>


<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="../index">
            <img src="/resources/images/logo.png" style="width: 120px;" alt="">
          </a>
          <h2 class="text-center">회원정보 수정</h2>
          <form class="text-left clearfix" id="updateForm" method="post" action="index">          
            <div class="form-group text-center">
            <form class="text-left clearfix" id="userType" method="post">
				<div class="form-check">
					<input class="form-check-input" type="radio" name="authority" id="radio-user" value="N" checked disabled >
					<label class="form-check-label" for="flexRadioDefault1" style="width: 80px">개인</label>
					<input class="form-check-input" type="radio" name="authority" id="radio-oper" value="C" disabled >
					<label class="form-check-label" for="flexRadioDefault2" style="width: 100px">카페운영자</label>
					<input class="form-check-input" type="radio" name="authority" id="radio-admin" value="S" disabled >
					<label class="form-check-label" for="flexRadioDefault3" style="width: 80px">관리자</label>
				</div>
			</form>
			</div>          
            <div class="form-group">
            	 <input type="text" id="userId" name="userId" placeholder="아이디" class="form-control" value="${user.userId}" readonly>
            </div>
            <div class="form-group">
              <input type="password" id="userPwd1" name="userPwd1" value="${user.userPwd}" class="form-control"  placeholder="비밀번호">
            </div>
            <div class="form-group">
              <input type="password" id="userPwd2" name="userPwd2" value="${user.userPwd}" class="form-control"  placeholder="비밀번호 확인">
            </div>
			주소 :&nbsp;&nbsp;
			<select name="city" id="citySelect">
				<option value="032">인천</option>
			</select>
			시/도 &nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;
			<select name="country" id="country">
				<option value="">전체</option>
<c:if test="${!empty subArea}">
   <c:forEach var="subAreaList" items="${subArea}" varStatus="status">
				<option value="${user.subAreaNum}" <c:if test="${subAreaList.subAreaNum eq user.subAreaNum}">selected</c:if>>${subAreaList.subAreaName}</option>
   </c:forEach>
</c:if>
			</select>         
			<br /><br />                 
            <div class="form-group">
              <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" placeholder="이름" >
            </div>
            <div class="form-group">
              <input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}" placeholder="이메일주소">
            </div>            
          
			<form class="text-left clearfix" id="userGender" method="post">
				<div class="form-check text-center">
	            	<input class="form-check-input" type="radio" name="gender_type" id="radio-user" value="M" checked disabled >
	            	<label class="form-check-label" for="flexRadioDefault1" style="width: 60px">남</label>
	            	<input class="form-check-input" type="radio" name="gender_type" id="radio-oper" value="F" disabled >
	    	        <label class="form-check-label" for="flexRadioDefault2" style="width: 60px">여</label>
	        	</div>
	        	</form>
	        	<br /> <br />
	        	<input type="hidden" id="userId" name="userId" value="${user.userId}" />
                <input type="hidden" id="userPwd" name="userPwd" value="" />
                <input type="hidden" id="subAreaNum" name="subAreaNum" value="" />
	            <div class="text-center">
	              <button type="button" id="btnUpdate" class="btn btn-main text-center">회원정보수정</button>
	            </div>
	          </form>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>