<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/admin/head.jsp" %>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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
                            <h2 class="m-0 font-weight-bold text-primary">예약 목록</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" valign="middle">
                                    <thead>
                                        <tr>
                                        	<th class="text-center" style="width:10%">예약번호</th>
                                            <th class="text-center" style="width:10%">아이디</th>
                                            <th class="text-center" style="width:10%">예약자</th>                                         
                                            <th class="text-center" style="width:15%">예약일</th>
                                            <th class="text-center" style="width:10%">환불사유</th>
                                            <th class="text-center" style="width:10%">환불 </th>
                                            <th class="text-center" style="width:10%">예약 자리</th>
                                            <th class="text-center" style="width:10%">예약 카페</th>
                                            <th class="text-center" style="width:15%">총 금액</th>
                                            
                                        </tr>
                                    </thead>
                                   
                                    <tbody>
                                       <c:if test="${!empty list}">
                                          <c:forEach items="${list}" var="rsRv" varStatus="status">
                                              <tr>
                                             	<th class="text-center" style="width:10%">${rsRv.rsrvSeq}</th>
	                                            <th class="text-center" style="width:10%">${rsRv.userId}</th>
	                                            <th class="text-center" style="width:10%">${rsRv.userName}</th>                                         
	                                            <th class="text-center" style="width:15%">${rsRv.rsrvDate}</th>
	                                            <th class="text-center" style="width:10%">${rsRv.rsrvTime}</th>
	                                            <th class="text-center" style="width:10%">${rsRv.rsrvPplCnt}</th>
	                                            <th class="text-center" style="width:10%">${rsRv.seatList}</th>
	                                            <th class="text-center" style="width:10%">${rsRv.cafeName}</th>
	                                            <th class="text-center" style="width:15%">${rsRv.totalPrice}</th>
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