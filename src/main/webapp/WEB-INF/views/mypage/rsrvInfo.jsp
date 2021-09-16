<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script>

function fn_write(rsrvSeqNo){
	document.bbsForm.rsrvSeq.value = rsrvSeqNo;
	document.bbsForm.action = "/review/reviewWrite";
	document.bbsForm.submit();
}

function fn_list(curPage){
	
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action = "/mypage/rsrvInfo";
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
						<li><a href="index.html">홈</a></li>
						<li class="active">마이페이지</li>
						<li class="active">예약현황</li>
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
          <li><a href="userPost">내가쓴 게시글</a></li>
          <li><a class="active" href="userPayment">예약현황</a></li>
        </ul>
				<div class="dashboard-wrapper user-dashboard">
					<h3>${cafe.cafeName} 예약현황</h3>
					<div class="table-responsive">
						<table class="table table-hover" border="2" bordercolor="#ADD8E6">
							<thead>
								<tr style="background-color: #4397CF;">
									<th scope="col" class="text-center" style="width:8%">주문 번호</th>
									<th scope="col" class="text-center" style="width:10%">이용 날짜</th>
									<th scope="col" class="text-center" style="width:8%">이용 시간</th>
									<th scope="col" class="text-center" style="width:10%">이용 자리</th>
									<th scope="col" class="text-center" style="width:10%">결제 금액</th>
									<th scope="col" class="text-center" style="width:10%">결제 상태</th>
									<th scope="col" class="text-center" style="width:44%">주문내역</th>
									
								</tr>
							</thead>
							<tbody>
							<c:if test="${!empty rsRv}">
							<c:forEach var="payInfo" items="${rsRv}" varStatus="status">
								<tr>
									<td scope="col" class="text-center" style="width:8%">${payInfo.rsrvSeq}</td>
									<td scope="col" class="text-center" style="width:10%">${payInfo.rsrvDate}</td>
									<td scope="col" class="text-center" style="width:8%">${payInfo.rsrvTime}</td>
									<td scope="col" class="text-center" style="width:10%">${payInfo.mypage.rsrvSeatList}</td>
									<td scope="col" class="text-center" style="width:10%">${payInfo.mypage.originPrice_s}</td>
									<td scope="col" class="text-center" style="width:10%">${payInfo.payStep}</td>
			                    	<td scope="col" class="text-center" style="width:44%">
			                    		<c:forEach var="list" items="${payInfo.mypage.orderList}" varStatus="status">
			                    			<c:out value="${list.menuName}" />
			                    			X
			                    			<c:out value="${list.menuCount}" />&nbsp;&nbsp;
			                    		</c:forEach>
			                    	</td>
								</tr>
							</c:forEach>
							</c:if>
							</tbody>
						
						</table>
					</div>	
					
   <nav>
      <ul class="pagination justify-content-center">
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