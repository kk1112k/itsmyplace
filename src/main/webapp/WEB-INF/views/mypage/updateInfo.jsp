<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script type="text/javascript">

//지역정보를 담을 배열 전역변수 생성
var areaArray = new Array();

function fn_areaBefore(){
		
	//지역 전체 리스트
	var areaList = $('.areaNum');
	
	//배열에 리스트 값 입력
	//if 조건문은 전역변수인 array가 무한으로 증가하는 것을 막기위함
	if(areaArray.length == 0)
	{
		for(var i=0; i<areaList.length; i++)
		{
			areaArray.push(areaList[i]);
		}
	}
	
	//선택한 지역 객체
	var selectedArea = $('#area option:selected');
	
	//세부지역 셀렉트박스 목록 삭제
	$('#subArea').empty();
	
 	$.ajax({
		type: "POST",
		url: "/user/areaProc",
		data: {areaNum: selectedArea.val()},
		dataType: "JSON",
		success: function(response){
			if(response.code==0){
				
				var subAreaList = response.data;
				
				var AllsubAreaStr = {subAreaNum:00000, subAreaName:"전체"};
				
				subAreaList.unshift(AllsubAreaStr);
								
				for(var j=0; j<subAreaList.length; j++)
				{					
					var appendStr = '<option id="subAreaNum' + j;
					appendStr += '" name="subAreaNum' + j;
					appendStr += '" value="' + subAreaList[j].subAreaNum;
					appendStr += '">' + subAreaList[j].subAreaName;
					appendStr += '</option>';
					
					$('#subArea').append(appendStr);
				}
			}
			else{
				alert("시/군/구 정보를 불러오는 데 실패하였습니다.");
			}
		},
		error: function(error){
			icia.common.error(error);
		}
	});
	
}
	
$(document).ready(function() {
	//fn_areaBefore();
	
	$.ajax({
		type: "POST",
		url: "/user/areaProc",
		data: {areaNum: $("#areaNum0").val()},
		dataType: "JSON",
		success: function(response){
			if(response.code==0){
				
				var subAreaList = response.data;
				
				//var AllsubAreaStr = {subAreaNum:00000, subAreaName:"전체"};
				
				//subAreaList.unshift(AllsubAreaStr);
				
				for(var j=0; j<subAreaList.length; j++)
				{				
					
					if(subAreaList[j].subAreaNum != $("#subAreaNum0").val()){
					
						var appendStr = '<option id="subAreaNum' + j;
						appendStr += '" name="subAreaNum' + j;
						appendStr += '" value="' + subAreaList[j].subAreaNum;
						appendStr += '">' + subAreaList[j].subAreaName;
						appendStr += '</option>';
						$('#subArea').append(appendStr);	
					}
				
				}
			}
			else{
				alert("시/군/구 정보를 불러오는 데 실패하였습니다.");
			}
		},
		error: function(error){
			icia.common.error(error);
		}
	});
	
	
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
		
		if($.trim($("#userEmail").val()).length <= 0){
			alert("이메일을 입력하세요.");
			$("#userEmail").val("");
			$("#userEmail").focus();
			return;
		}
		
		if(!fn_validateEmail($("#userEmail").val()))
		{
			alert("사용자 이메일 형식이 올바르지 않습니다.");
			$("#userEmail").focus();
			return;	
		}
		
		$("#userPwd").val($("#userPwd1").val());

		var Atarget = document.getElementById("area");
		var areaNum = Atarget.options[Atarget.selectedIndex].value;
		
		var Btarget = document.getElementById("subArea");
		var subAreaNum = Btarget.options[Btarget.selectedIndex].value;
	    
		
		/* 		var target = document.getElementById("country");
			    var areaNum = target.options[target.selectedIndex].value; */
		if(areaNum == "" || subAreaNum == ""){
	    	alert("지역을 선택하세요.");
	    	
	    	return;
	    }	
		
		fn_userUpdate(areaNum, subAreaNum);
		
	});
});

function fn_validateEmail(value)
{
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	
	return emailReg.test(value);
}

function fn_userUpdate(area_Num, subArea_Num){
	
	$.ajax({
		type: "POST",
		url: "/user/updateProc",
		data: {
			 userId: $("#userId").val(),
	         userPwd: $("#userPwd").val(),
	         userName: $("#userName").val(),
	         userEmail: $("#userEmail").val(),
	         areaNum: area_Num,
	         subAreaNum: subArea_Num
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
				alert("시/군/구를 선택하세요.");
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
					<label>회원구분</label> : 
					<c:if test="${user.userClass eq 'N'}">회원</c:if>
					<c:if test="${user.userClass eq 'C'}">카페운영자</c:if>
					<c:if test="${user.userClass eq 'S'}">관리자</c:if>
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
			지역 :&nbsp;&nbsp;
				<c:if test="${!empty areaList}">
					<select name="area" id="area" onchange="fn_areaBefore()">
							<option id="areaNum0" class="areaNum" value="${user.areaNum}">${user.areaName}</option>
						<c:forEach var="areaList" items="${areaList}" varStatus="status">
							<option id="areaNum${status.count}" class="areaNum" value="${areaList.areaNum}">${areaList.areaName}</option>
						</c:forEach>
					</select>
				</c:if>
				&nbsp;&nbsp;시/군/구 :&nbsp;&nbsp;
				<select name="subArea" id="subArea">
					<option id="subAreaNum0" class="subAreaNum" value="${user.subAreaNum}">${user.subAreaName}</option>
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
	        	<!-- input type="hidden" id="userId" name="userId" value="${user.userId}" /> -->
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