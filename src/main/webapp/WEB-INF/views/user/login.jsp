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
	
	$(':radio[name="userClass"]').on("keypress", function(e){
		$("#_userClass").val($("input[name='userClass']:checked").val());
		if(e.which == 13)
		{	
			fn_loginCheck();
		}
		
	});

	
	$("#btnLogin").on("click", function() {
		fn_loginCheck();
	});
	
});

function fn_loginCheck()
{
	$("#_userClass").val($("input[name='userClass']:checked").val());
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
					location.href = "/";

					
				}
				else
				{
					if(code == -1){
						alert("비밀번호가 올바르지 않습니다.");
						$("#userPwd").focus();
					}
					else if(code == -3){
						alert("사용할 수 없는 아이디입니다.");
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
			<img src="../resources/images/logo.png" alt="image" width="240" height="60" />
          </a>
          <form class="text-left clearfix">
            <div class="form-group">
              <input type="text" class="form-control" id="userId" name="userId" maxlength="20" placeholder="아이디">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" id="userPwd" name="userPwd" maxlength="20" placeholder="비밀번호">
            </div>
            <br />
            <div class="text-center">
            	 <input type="hidden" id="_userClass" value="" />
			     <input type="radio" id="userClass1" name="userClass" value="N" checked ><label for="userClass1" style="font-size:18px;">&nbsp;회원&nbsp;&nbsp;</label>
			     <input type="radio" id="userClass2" name="userClass" value="C"><label for="userClass2" style="font-size:18px;">&nbsp;카페운영자&nbsp;&nbsp;</label>
			     <input type="radio" id="userClass3" name="userClass" value="S"><label for="userClass3" style="font-size:18px;">&nbsp;사이트관리자</label>
			</div>
			<br />
			<div class="text-center">
              <button type="button" id="btnLogin" class="btn btn-main text-center" style="witdth:200px; height:60px;">로그인</button>
            </div>
          </form>
          <br />
          <p class="mt-20" style="font-size:18px;"> 내자리얌을 이용하세요! <a href="regForm"> 회원가입</a></p>
          <p class="mt-20" style="font-size:18px;"> 비밀번호를 잊으셨나요? <a href="findPwd"> 비밀번호찾기</a></p>
        </div>
      </div>
    </div>
  </div>
</section>


<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>