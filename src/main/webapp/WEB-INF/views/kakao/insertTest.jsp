<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<meta charset="UTF-8">
<script type="text/javascript">
$(document).ready(function(){
	
	$.ajax({
	      type: "POST",
	      url: "/kakao/payProc",
	      data: {
	         rsrvSeq: $("#ArsrvSeq").val(),
	      },
	      datatype: "JSON",
	      beforeSend : function (xhr){
	         xhr.setRequestHeader("AJAX","true");
	      },
	      success:function(response){
	         if(response.code == 0)
	         {
	            alert("결제 성공(업데이트)");
	            //location.href="/mypage/userPayment";
	         }
	         else if(response.code == 403){
	        	 alert("결제단계 갱신에 실패했습니다.");
	         }
	         else if(response.code == 404){
	        	 alert("결제 포인트 적립이 실패했습니다.");
	         }
	         else if(response.code == 405){
	        	 alert("결제 포인트 정보 갱신에 실패했습니다.");
	         }
	         else if(response.code == 500)
	         {
	            alert("예약정보 이메일 전송에 실패했습니다.");
	         }
	         else if(response.code == 501)
	         {
	            alert("오류가 발생했습니다.");
	         }
	         location.href="/mypage/userPayment";
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
	//document.testForm.action = "/mypage/userPayment";
	//document.testForm.submit();
});
</script>

</head>
<body>
<form name="testForm" method="post">
	<input type="hidden" name="ArsrvSeq" id="ArsrvSeq" value="${rsrvSeq}"/>
</form> 
</body>
</html>