<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<script>
$(document).ready(function(){
	$("#temp").on("click", function(){
	
		$.ajax({
			type: "POST",
			url: "/user/sendMail",
			data: {
				id: $(inputId).val(),
				mailAddress: $(inputEmail).val()
			},
			datatype: "JSON",
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success: function(response){
				if(response.code == 0)
				{
					alert("이메일로 비밀번호가 전송되었습니다. 이메일을 확인하세요.");
				}
				else if(response.code == 403){
					alert("이메일이 계정정보와 일치하지 않습니다.");
				}
				else if(response.code == 404){
					alert("회원 정보가 없습니다.");
				}
				else
				{
					alert("오류가 발생되었습니다. 다시 시도해 주세요.");
				}
			},
			error: function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	});
})

</script>

</head>

<body id="body">

<section class="forget-password-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="/index">
            <img src="/resources/images/logo.png" alt="image" width="150" height="40">
          </a>
          <h2 class="text-center">다시 찾아주셔서 감사합니다.</h2>
          <form class="text-center clearfix">
            <p> 비밀번호를 찾기 위해 아이디와 이메일을 입력해 주세요. <br/>회원 정보가 있으면 임시 비밀번호가 전송됩니다. <br/>비밀번호를 이메일로 받으면 새 비밀번호로 로그인 해주세요.</p>
            <div class="form-group">
              <input type="text" class="form-control" id="inputId" placeholder="본인의 아이디를 입력해 주세요.">
              <br/>
              <input type="email" class="form-control" id="inputEmail" placeholder="본인의 이메일을 입력해 주세요.">
            </div>
            <br/>
            <div class="text-center">
              <button type="button" class="btn btn-main text-center" id="temp">비밀번호 전송받기</button>
            </div>
          </form>
          <p class="mt-20"><a href="/user/login">로그인</a></p>
        </div>
      </div>
    </div>
  </div>
</section>
  </body>
  </html>