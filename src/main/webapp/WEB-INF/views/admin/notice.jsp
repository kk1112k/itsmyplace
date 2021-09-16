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
input[type="button"] 
{ 
 border: none;
  border-color: #4397cf ;
  outline: none;
  font-size: 15px;
  color: #fbf9d3;
  cursor: pointer;
  border-radius: 4px;
  background: #4397cf ;
}
</style>

<script type="text/javascript">
function view(bbsSeq)
{
	var seq = bbsSeq;
	   
	window.open("/notice/view?bbsSeq=" + seq);
}
</script>
</head>
<body>
<!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h2 class="m-0 font-weight-bold text-primary">공지사항 조회</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                         <tr>                                                                                     
                                            <th class="text-center" style="width:7%">순번</th>
                                            <th class="text-center" style="width:10%">게시물번호</th>
                                            <th class="text-center" style="width:8%">아이디</th>
                                            <th class="text-center" style="width:8%">회원명</th>
                                            <th class="text-center" style="width:17%">제목</th>
                                            <th class="text-center" style="width:18%">내용</th>
                                            <th class="text-center" style="width:12%">작성일자</th>
                                            <th class="text-center" style="width:10%">조회수</th>
                                            <th class="text-center" style="width:10%">바로가기</th>                
                                        </tr>
                                    </thead>
                                   
                                    <tbody>
                                    <c:if test="${!empty list}">
                                    	<c:forEach items="${list}" var="notice" varStatus="status">
                                        <tr>
                                           <td class="text-center" style="width:7%">${status.count}</td>
                                           <td class="text-center" style="width:10%">${notice.bbsSeq}</td>
                                           <td class="text-center" style="width:8%">${notice.userId}</td>
                                           <td class="text-center" style="width:8%">${notice.userName}</td>
                                           <td class="text-center" style="width:17%">${notice.bbsTitle}</td>
                                           <td class="text-center" style="width:18%">${notice.bbsContent}</td>
                                           <td class="text-center" style="width:12%">${notice.regDate}</td>
                                           <th class="text-center" style="width:10%">${notice.bbsReadCnt}</th>
                                           <th class="text-center" style="width:10%">
                                           	<input type="button" href="javascript:void(0)" onclick="view('${notice.bbsSeq}')" value="바로가기" />
                                           </th> 
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
    
<form name="noticeForm" id="noticeForm" method="post">
   <input type="hidden" name="bbsSeq" value=""/>
</form>
   
    <!-- Page level plugins -->
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script> <!-- 이건 모양 -->
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script> <!-- 이건 search 자체 -->


</body>
</html>