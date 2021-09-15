<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/admin/head.jsp" %>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/admin/navigation.jsp" %>
<style>
button.button {
  border: none;
  border-color: #4397cf ;
  outline: none;
  font-size: 15px;
  color: #fbf9d3;
  cursor: pointer;
  border-radius: 10px;
  background: #4397cf ;
}
button.button:hover {
  color: #fbf9d3;
  background: #4397cf ;
}


</style>
<script type="text/javascript">

</script>
</head>
<body>
<!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h2 class="m-0 font-weight-bold text-primary">환불 목록</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" valign="middle">
                                    <thead>
                                        <tr>
                                        	<th class="text-center" style="width:6%">순번</th>
                                        	<th class="text-center" style="width:9%">예약번호</th>
                                            <th class="text-center" style="width:10%">아이디</th>
                                            <th class="text-center" style="width:9%">예약자</th>
                                            <th class="text-center" style="width:9%">예약 카페</th>                                         
                                            <th class="text-center" style="width:9%">예약일</th>
                                            <th class="text-center" style="width:9%">예약 자리</th>                                            
                                            <th class="text-center" style="width:10%">예약 인원</th>
                                            <th class="text-center" style="width:15%">환불사유</th>
                                            <th class="text-center" style="width:13%">환불 적립금액</th>
                                            
                                        </tr>
                                    </thead>
                                   
                                    <tbody>
                                       <c:if test="${!empty list}">
                                          <c:forEach items="${list}" var="refund" varStatus="status">
                                              <tr>
                                              	<th class="text-center" style="width:6%">${status.count}</th>
                                             	<th class="text-center" style="width:9%">${refund.rsrvSeq}</th>
	                                            <th class="text-center" style="width:10%">${refund.userId}</th>
	                                            <th class="text-center" style="width:9%">${refund.userName}</th>
	                                            <th class="text-center" style="width:9%">${refund.cafeName}</th>                                         
	                                            <th class="text-center" style="width:9%">${refund.rsrvDate}</th>
	                                            <th class="text-center" style="width:9%">${refund.seatList}</th>
	                                            <th class="text-center" style="width:10%">${refund.rsrvPplCnt}</th>
	                                            <th class="text-center" style="width:15%">${refund.rfdReason}</th>
	                                            <th class="text-center" style="width:13%"><fmt:formatNumber value="${refund.totalPrice}" pattern="#,###" /></th>
                                              </tr> 
                                           </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->


    
    <!-- Page level plugins -->
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script> <!-- 이건 모양 -->
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script> <!-- 이건 search 자체 -->
  

</body>

</html>
</body>
</html>