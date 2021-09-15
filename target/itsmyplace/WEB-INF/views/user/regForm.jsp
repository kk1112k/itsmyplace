<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/head.jsp" %>	

<script type="text/javascript">

$(document).ready(function() {
	
	$("#userId").focus();	
	
	$("#btnConfirm").on("click", function() {

		// 모든 공백 체크 정규식
		var emptCheck = /\s/g;
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
				
		if($.trim($("#userId").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#userId").val("");
			$("#userId").focus();
			return;
		}
		
		if (emptCheck.test($("#userId").val())) 
		{
			alert("사용자 아이디는 공백을 포함할 수 없습니다.");
			$("#userId").focus();
			return;
		}
		
		if (!idPwCheck.test($("#userId").val())) 
		{
			alert("사용자 아이디는 4~12자의 영문 대소문자와 숫자로만 입력하세요");
			$("#userId").focus();
			return;
		}
		// -- > 유효성검사 완료
		/*
		var hz = document.getElementById('hz');
				if (hz.innerText == "A") {
			        hz.innerText = "B";  
				}*/
			
		// -- > 중복체크확인 완료
		////////////////////////////////////////////////////////////////
		//ajax 통신으로 DB에 있는 아이디와 비교하고 중복체크확인 alert 나오도록 구현 필요//
		////////////////////////////////////////////////////////////////
		//ajax
	      $.ajax({
	         type: "POST",
	         url: "/user/idCheck",
	         data: {
	            userId: $("#userId").val()
	         },
	         datatype: "JSON",
	         beforeSend : function (xhr){
	            xhr.setRequestHeader("AJAX","true");
	         },
	         success:function(response){
	            if(response.code == 0)
	            {
	               //아이디 중복 없으면 회원가입 진행
	               alert("사용 가능한 아이디입니다.");
	               var dcheck1 = document.getElementById('dcheck');
					if (dcheck1.innerText == "A") {
						dcheck1.innerText = "B";  
					}
	               //fn_userReg();
	            }
	            else if(response.code == 100)
	            {
	               alert("중복된 아이디입니다.");
	               dcheck.innerText = "A"
	               $("#userId").focus();
	            }
	            else if(response.code == 400)
	            {
	               alert("파라미터 값이 올바르지 않습니다.");
	               dcheck.innerText == "A"
	               $("#userId").focus();
	            }
	            else
	            {
	               alert("오류가 발생했습니다.");
	               dcheck.innerText = "A"
	               $("#userId").focus();
	            }
	            
	         },
	         complete: function(data)
	         {
	            //응답이 종료되면
	            icia.common.log(data);
	         },
	         error: function(xhr, status, error)
	         {
	            icia.common.error(error);
	         }
	      
	      });
	});
	

	$("#btnReg").on("click", function() {

		var emptCheck = /\s/g;
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
		// 이메일 유효성검사
		var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
		var dcheck2 = document.getElementById('dcheck');
	
		if($.trim($("#userId").val()).length <= 0)
		{
			alert("사용자 아이디를 입력하세요.");
			$("#userId").val("");
			$("#userId").focus();
			return;
		}
		
		if (dcheck2.innerText == "A") {
			alert("아이디 중복확인을 체크해주세요");
			$("#userId").focus();
			return;
		}

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
		
		if (emptCheck.test($("#userPwd1").val())) 
		{
			alert("비밀번호는 공백을 포함할 수 없습니다.");
			$("#userPwd1").focus();
			return;
		}
		
		if($.trim($("#userEmail").val()).length <= 0)
		{
			alert("사용자 이메일을 입력하세요.");
			$("#userEmail").val("");
			$("#userEmail").focus();
			return;
		}
		
		if(!emailReg.test($("#userEmail").val()))
		{
			alert("사용자 이메일 형식이 올바르지 않습니다.");
			$("#userEmail").focus();
			return;	
		}
		$("#_userClass").val($("input[name='userClass']:checked").val());
		$("#userPwd").val($("#userPwd1").val());
		$("#_userGender").val($("input[name='userGender']:checked").val());
		
		var target = document.getElementById("country");
	    var areaNum = target.options[target.selectedIndex].value;
		
	    if(areaNum == ""){
	    	alert("지역을 선택하세요.");
	    	
	    	return;
	    }	
	    
		fn_userReg(areaNum);
		
	});
	
});

function fn_userReg(areaNum)
{	
	$.ajax({
	      type: "POST",
	      url: "/user/regProc",
	      data: {
	         userId: $("#userId").val(),
	         userClass: $("#_userClass").val(),
	         areaNum: $("#areaNum").val(),
	         subAreaNum: areaNum,
	         userPwd: $("#userPwd").val(),
	         userName: $("#userName").val(),
	         userEmail: $("#userEmail").val(),
	         userGender: $("#_userGender").val()
	      },
	      datatype: "JSON",
	      beforeSend : function (xhr){
	         xhr.setRequestHeader("AJAX","true");
	      },
	      success:function(response){
	         if(response.code == 0)
	         {
	            alert("회원 가입이 되었습니다.");
	            location.href="/../index";
	         }
	         else if(response.code == 100)
	         {
	            alert("회원 아이디가 중복되었습니다.");
	            $("#userId").focus();
	         }
	         else if(response.code == 400)
	         {
	            alert("파라미터 값이 올바르지 않습니다.");
	            $("#userId").focus();
	         }
	         else if(response.code == 500)
	         {
	            alert("회원 가입중 오류가 발생하였습니다.");
	            $("#userId").focus();
	         }
	         else
	         {
	            alert("회원 가입중 오류가 발생했습니다.");
	            $("#userId").focus();
	         }
	         
	      },
	      complete: function(data)
	      {
	         //응답이 종료되면
	         icia.common.log(data);
	      },
	      error: function(xhr, status, error)
	      {
	         icia.common.error(error);
	      }
	   
	   });
}


</script>
</head>
<body id="body">

<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="/">
            <img src="/resources/images/logo.png" style="width: 120px;" alt="">
          </a>
          <h2 class="text-center">회원가입</h2>
          <form name="form" method="post" action="">
				<div class="form-group">
					<input type="text" id="userId" name="userId" placeholder="아이디" class="form-control">
				</div>
				<div class="form-group text-center">
		           	<button type="button" id="btnConfirm" class="btn btn-main text-center">중복확인</button>
		           	<span id="dcheck" style="display:none;">A</span><br>
	           </div>
				<div class="form-group text-center">
					<div class="form-check">
						<input type="hidden" id="_userClass" value="" />
						<input class="form-check-input" type="radio" name="userClass" id="userClass" value="N" checked>
						<label class="form-check-label" for="flexRadioDefault1">개인</label>
						<input class="form-check-input" type="radio" name="userClass" id="userClass" value="C">
						<label class="form-check-label" for="flexRadioDefault2">카페운영자</label>
						<input class="form-check-input" type="radio" name="userClass" id="userClass" value="S" disabled>
						<label class="form-check-label" for="flexRadioDefault3">관리자</label>
					</div>
				</div>
				주소 :&nbsp;&nbsp;
				<select name="city" id="areaNum">
					<option value="032">인천</option>
				</select>
				시/도 &nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;
				<select name="country" id="country">
					<option value="">전체</option>
<c:if test="${!empty subArea}">
   <c:forEach var="subAreaList" items="${subArea}" varStatus="status">
					<option value="${subAreaList.subAreaNum}" <c:if test="${subAreaList.subAreaNum eq subAreaNum}">selected</c:if>>${subAreaList.subAreaName}</option>
   </c:forEach>
</c:if>
				</select>
				<br /><br />
				<div class="form-group">
	              <input type="password" class="form-control" id="userPwd1" name="userPwd1" placeholder="비밀번호">
	            </div>
	            <div class="form-group">
	              <input type="password" class="form-control" id="userPwd2" name="userPwd2" placeholder="비밀번호확인">
	            </div>
	            <input type="hidden" id="userPwd" name="userPwd" value="" />
	            <input type="hidden" id="areaNum" name="areaNum" value="" />
				<div class="form-group">
					<input type="text" class="form-control" id="userName" name="userName" placeholder="이름">
				</div>
				<div class="form-group">
					<input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일주소">
				</div>
				<div class="form-group text-center">
					<input type="hidden" id="_userGender" value="" />
					<input class="form-check-input" type="radio" name="userGender" id="userGender" value="M">
					<label class="form-check-label" for="flexRadioDefault1"  style="width: 80px">남</label>
					<input class="form-check-input" type="radio" name="userGender" id="userGender" value="F" >
					<label class="form-check-label" for="flexRadioDefault2"  style="width: 80px">여</label>
				</div>
	
				<div class="text-center">
					<button type="button" id="btnReg" class="btn btn-main text-center">회원가입</button>
				</div>
			</form>
          <p class="mt-20">Already have an account ?<a href="login"> Login</a></p>
        </div>
      </div>
    </div>
  </div>
</section>

</body>
</html>