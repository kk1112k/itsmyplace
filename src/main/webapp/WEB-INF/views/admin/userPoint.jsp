<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/admin/head.jsp" %>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/include/admin/navigation.jsp" %>
<script type="text/javascript">


</script>
</head>
<body>
<!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h2 class="m-0 font-weight-bold text-primary">포인트 지급내역</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th class="text-center" style="width:7%">순번</th>
                                            <th class="text-center" style="width:10%">아이디</th>
                                            <th class="text-center" style="width:20%">적립내역</th>
                                            <th class="text-center" style="width:20%">적립일자</th>
                                            <th class="text-center" style="width:20%">소멸예정일자</th>
                                            <th class="text-center" style="width:10%">적립 포인트</th>
                                            <th class="text-center" style="width:10%">포인트 상태</th>                                           
                                        </tr>
                                    </thead>
                                   
                                    <tbody>
                                    	<c:if test="${!empty list}">
                                    	<c:forEach items="${list}" var="point" varStatus="status">
                                    	<tr>
                                    		<td class="text-center" style="width:10%">${status.count}</td>	
                                            <td class="text-center" style="width:10%">${point.userId}</td>
                                            <td class="text-center" style="width:20%">${point.savePath}</td>
                                            <c:set var="saveDate" value="${point.saveDate}" />
                                            <td class="text-center" style="width:20%">${fn:substring(saveDate,0,10)}</td>
                                            <c:set var="delDate" value="${point.delDate}" />
                                            <td class="text-center" style="width:20%">${fn:substring(delDate,0,10)}</td>
                                            <td class="text-center" style="width:10%">
												<fmt:formatNumber value="${point.savePoint}" pattern="#,###" />
                                            </td>
                                            <td class="text-center" style="width:10%">${point.status}</td>
                                        </c:forEach>	
                                        </c:if>
                                    	
                                        
                                       
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Page level plugins -->
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script> <!-- 이건 모양 -->
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script> <!-- 이건 search 자체 -->

</body>

</html>
</body>
</html>