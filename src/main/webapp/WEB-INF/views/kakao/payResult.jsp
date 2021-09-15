<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function() {
	opener.movePage();
	$("#btnClose").on("click", function() {
		//opener.movePage();
		window.close();
	});
});
</script>
</head>
<body>

<div class="container">
<c:choose>
	<c:when test="${!empty kakaoPayApprove}">
		<h2>카카오페이 결제가 정상적으로 완료되었습니다.</h2>
		<table id="purchase-receipt" class="table" style="text-align: center;">
		<tr>
			<th>결제일시: </th>
			<th>${kakaoPayApprove.approved_at}</th>
		</tr>
		<tr>
			<th>주문번호: </th>
			<th>${kakaoPayApprove.partner_order_id}</th>
		</tr>
		<tr>
			<th>상품명: </th>
			<th>${kakaoPayApprove.item_name}</th>
		</tr>
		<tr>
			<th>상품수량: </th>
			<th>${kakaoPayApprove.quantity}</th>
		</tr>
		<tr>
			<th>결제금액: </th>
			<th>${kakaoPayApprove.amount.total}</th>
		</tr>
		<tr>
			<th>결제방법: </th>
			<th>${kakaoPayApprove.payment_method_type}</th>
		</tr>
	    </table>
	</c:when>
	<c:otherwise>
		<h2>카카오페이 결제중 오류가 발생하였습니다.</h2>
	</c:otherwise>
</c:choose>
</div>
<button id="btnClose" type="button" class="btn btn-primary" style="text-align: center;">닫기</button>
</body>
</html>