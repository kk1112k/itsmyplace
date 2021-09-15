<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
  
<script type="text/javascript">
$(document).ready(function() {
	
	$("#userId").focus();
	
	$("#userId").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});
	
	$("#userPwd").on("keypress", function(e){
		
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});

	
	$("#btnLogin").on("click", function() {
		$("#_userClass").val($("input[name='userClass']:checked").val());
		fn_loginCheck();
		
	});
	
});

function fn_loginCheck()
{
	if($.trim($("#userId").val()).length <= 0)
	{
		alert("아이디를 입력하세요.");
		$("#userId").focus();
		return;
	}
	
	if($.trim($("#userPwd").val()).length <= 0)
	{
		alert("비밀번호를 입력하세요.");
		$("#userPwd").focus();
		return;
	}
	
	if($.trim($("#_userClass").val()).length <= 0)
	{
		alert("회원구분을 선택하세요.");
		return;
	}
	
	$.ajax({
		type : "POST",
		url : "/user/loginCheck",
		data : {
			userId: $("#userId").val(),
			userPwd: $("#userPwd").val(),
			userClass: $("#_userClass").val()
		},
		datatype : "JSON",
		beforeSend : function(xhr){
            xhr.setRequestHeader("AJAX", "true");
        },
		success : function(response) {
			
			if(!icia.common.isEmpty(response))
			{
				icia.common.log(response);
				
				// var data = JSON.parse(obj);
				var code = icia.common.objectValue(response, "code", -500);
				
				if(code == 0)
				{
					alert("정상적으로 로그인이 성공되었습니다.");
					location.href = "/index";
				}
				else
				{
					if(code == -1){
						alert("비밀번호가 올바르지 않습니다.");
						$("#userPwd").focus();
					}
					else if(code == -2){
						alert("사용 권한이 일치하지 않습니다.");
					}
					else if(code == 404)
					{
						alert("아이디와 일치하는 사용자 정보가 없습니다.");
						$("#userId").focus();
					}
					else if(code == 400)
					{
						alert("파라미터 값이 올바르지 않습니다.");
						$("#userId").focus();
					}
					else
					{
						alert("오류가 발생하였습니다.");
						$("#userId").focus();
					}	
				}	
			}
			else
			{
				alert("오류가 발생하였습니다.");
				$("#userId").focus();
			}
		},
		complete : function(data) 
		{ 
			// 응답이 종료되면 실행, 잘 사용하지않는다
			icia.common.log(data);
		},
		error : function(xhr, status, error) 
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
          <a class="logo" href="/index">
			<img src="../resources/images/logo.png" alt="image" width="150" height="40" />
          </a>
          <form class="text-left clearfix">
            <div class="form-group">
              <input type="text" class="form-control" id="userId" name="userId" maxlength="20" placeholder="Id">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" id="userPwd" name="userPwd" maxlength="20" placeholder="Password">
            </div>
            <br />
            <div class="text-center">
            	 <input type="hidden" id="_userClass" value="" />
			     <input type="radio" id="userClass" name="userClass" value="N"><label for="select1">&nbsp;회원&nbsp;&nbsp;</label>
			     <input type="radio" id="userClass" name="userClass" value="C"><label for="select2">&nbsp;카페 운영자&nbsp;&nbsp;</label>
			     <input type="radio" id="userClass" name="userClass" value="S"><label for="select3">&nbsp;서버 관리자</label>
			</div>
			<br />
			<div class="text-center">
              <button type="button" id="btnLogin" class="btn btn-main text-center">Login</button>
            </div>
          </form>
          <br />
          <p class="mt-20">New in this site ?<a href="regForm"> Create New Account</a></p>
          <p class="mt-20">Forgot your password?<a href="findPwd"> Find password with Email</a></p>
        </div>
      </div>
    </div>
  </div>
</section>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>