<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
	parent.kakaoPayResult("${pgToken}");
});
</script>
</head>
<body>
<!-- 
<div class="container">
<c:choose>
   <c:when test="${!empty kakaoPayApprove}">
      <h2>카카오페이 결제가 정상적으로 완료되었습니다.</h2>
      결제일시: ${kakaoPayApprove.approved_at}<br/>
       주문번호: ${kakaoPayApprove.partner_order_id}<br/>
       상품명  : ${kakaoPayApprove.item_name}<br/>
       상품수량: ${kakaoPayApprove.quantity}<br/>
       결제금액: ${kakaoPayApprove.amount.total}<br/>
       결제방법: ${kakaoPayApprove.payment_method_type}<br/>
   </c:when>
   <c:otherwise>
      <h2>카카오페이 결제중 오류가 발생하였습니다.</h2>
   </c:otherwise>
</c:choose>
</div>
<button id="btnClose" type="button">닫기</button>
-->
</body>
</html>