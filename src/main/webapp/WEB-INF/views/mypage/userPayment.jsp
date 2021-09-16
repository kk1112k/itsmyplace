<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
%>
<meta charset="utf-8">
<script>

function fn_write(rsrvSeqNo){
	document.bbsForm.rsrvSeq.value = rsrvSeqNo;
	document.bbsForm.action = "/review/reviewWrite";
	document.bbsForm.submit();
}

function fn_list(curPage){
	
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/mypage/userPayment";
	document.bbsForm.submit();
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
						<li class="active">내 결제내역</li>
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
          <li><a href="userProfile">내정보</a></li>	
          <li><a href="userPost">내가 쓴 게시물</a></li>
          <li><a class="active" href="userPayment">내 결제내역</a></li>
        </ul>
				<div class="dashboard-wrapper user-dashboard">
					<h3>결제 내역서</h3>
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th class="text-center">주문 번호</th>
									<th class="text-center">이용 날짜</th>
									<th class="text-center">이용 시간</th>
									<th class="text-center">카페 이름</th>
									<th class="text-center">결제 금액</th>
									<th class="text-center">결제 상태</th>
									<th class="text-center">결제 내역</th>
									<th class="text-center">후기 작성</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${!empty rsRv}">
							<c:forEach var="payInfo" items="${rsRv}" varStatus="status">
								<tr>
									<td class="text-center">${payInfo.rsrvSeq}</td>
									<td class="text-center">${payInfo.rsrvDate}</td>
									<td class="text-center">${payInfo.rsrvTime}</td>
									<td class="text-center">${payInfo.cafeName}</td>
									<td class="text-center">${payInfo.totalPrice_s}</td>
									<td class="text-center">${payInfo.payStep}</td>
									<td class="text-center"><a href="/mypage/userPurchaseConfirmation?rsrvSeq=${payInfo.rsrvSeq}" class="btn btn-default">상세보기</a></td>
									<c:choose>
									<c:when test="${payInfo.payStep eq '결제대기' || payInfo.payStep eq '결제완료'}">
										<td class="text-center">작성대기</td>
									</c:when>
									<c:when test="${payInfo.payStep eq '사용완료'}">
										<td class="text-center"><button onclick="fn_write('${payInfo.rsrvSeq}')" class="btn btn-default" style="width:40; height:20;">후기적기</button></td>
									</c:when>
									<c:when test="${payInfo.payStep eq '후기완료'}">
										<td class="text-center">작성완료</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
							</c:if>
							</tbody>
						
						</table>
					</div>	
					
   <nav>
      <ul class="pagination">
			<c:if test="${!empty paging}">      
			   <c:if test="${paging.prevBlockPage gt 0}">
			         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
			   </c:if>
			   <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
			      <c:choose>
			         <c:when test="${i ne curPage}">
			         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
			         </c:when>
			         <c:otherwise>
			         <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>         
			         </c:otherwise>
			      </c:choose>
			   </c:forEach>
			         
			   <c:if test="${paging.nextBlockPage gt 0}">
			         <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
			   </c:if>
			</c:if>
      </ul>
   </nav>
   
   <form name="bbsForm" id="bbsForm" method="post">
      <input type="hidden" name="rsrvSeq" value="${payInfo.rsrvSeq}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>		
								
				</div>			
			</div>
		</div>
	</div>

</section>


 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    


  </body>
  </html>