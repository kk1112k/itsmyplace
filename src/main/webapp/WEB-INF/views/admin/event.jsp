<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	   
	window.open("/event/view?bbsSeq=" + seq);
}

function fn_adminPublicUpdate(bbsSeq)
{	    
	   if(!confirm("게시글 차단상태를 수정하시겠습니까?"))
	   {
	      return;
	   }
	   
	   $.ajax({
	      url: "/admin/eventAdminPublicUpdateProc",
	      data: {
	    	  bbsSeq: bbsSeq,
	    	  adminPublic: $("#adminPublic" + bbsSeq).val()
	      },
	      datatype: "JSON", 
	        beforeSend: function(xhr) {
	           xhr.setRequestHeader("AJAX", "true");
	        },
	      success: function(res)
	      {
	         
	         if(res.code == 0)
	         {
	            alert("이벤트 게시글 상태가 수정되었습니다.");
	            location.reload();
	         }
	         else if(res.code == -1)
	         {
	            alert("이벤트 게시글 상태변경 중 오류가 발생했습니다.");
	         }
	         else if(res.code == 400)
	         {
	            alert("파라미터 오류");
	         }
	         else if(res.code == 404)
	         {
	            alert("이벤트 게시글이 없습니다.");
	         }
	      },
	      complete: function(data)
	      {
	         icia.common.log(data);
	      },
	      error: function(xhr, status, error)
	      {
	         icia.common.error(error);
	      }
	   });
	   
	
}
</script>
</head>
<body>
<!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading 
                    <h2 class="h3 mb-2 text-gray-800">회원 조회하기</h2>
                    <!--  <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>-->

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h2 class="m-0 font-weight-bold text-primary">이벤트 게시글 조회</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                        	<th class="text-center" style="width:7%">순번</th>
                                        	<th class="text-center" style="width:10%">이벤트 번호</th>
                                            <th class="text-center" style="width:9%">아이디</th>
                                            <th class="text-center" style="width:9%">회원명</th>
                                            <th class="text-center" style="width:20%">제목</th>                                            
                                            <th class="text-center" style="width:8%">작성일자</th>
                                            <th class="text-center" style="width:8%">조회수</th>
                                            <th class="text-center" style="width:10%">차단상태</th> 
                                            <th class="text-center" style="width:10%">바로가기</th>                                        
                                        </tr>
                                    </thead>
                                   
                                    <tbody>
                                    	<c:if test="${!empty list}">
                                    	<c:forEach items="${list}" var="event" varStatus="status">
	                                        <tr>
	                                        	<td class="text-center" style="width:7%">${status.count}</td>
	                                        	<td class="text-center" style="width:10%">${event.bbsSeq}</td>
	                                            <td class="text-center" style="width:9%">${event.userId}</td>
	                                            <td class="text-center" style="width:9%">${event.userName}</td>
	                                            <td class="text-center" style="width:20%">${event.bbsTitle}</td>	                                          
	                                            <td class="text-center" style="width:8%">${event.regDate}</td>
	                                            <th class="text-center" style="width:8%">${event.bbsReadCnt}</th>
	                                            
	                                            <td class="text-center" style="width:10%"> 
                                          			<p>
                                          				<select id="adminPublic${event.bbsSeq}" name="adminPublic${event.bbsSeq}" class="form-control"  style="font-size: 1rem; width: 8rem; height: 2.2rem;">
                                             				<option value="Y" <c:if test="${event.adminPublic == 'Y'}">selected</c:if>>정상</option>
                                             				<option value="N" <c:if test="${event.adminPublic == 'N'}">selected</c:if>>차단</option>
                                        				</select>
                                        			</p>
                                        				
                                          			<input type="button" href="javascript:void(0)" onclick="fn_adminPublicUpdate('${event.bbsSeq}')" style="margin-left:.10rem; width: 4rem; height: 2rem; " value="변경"> 
                                    			</td>
	                                            
	                                            <th class="text-center" style="width:10%">	                                            
	                                            <input type="button" href="javascript:void(0)" onclick="view('${event.bbsSeq}')" value="바로가기" />	                                            
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
    
<form name="eventForm" id="eventForm" method="post">
   <input type="hidden" name="bbsSeq" value=""/>
</form>

   
    <!-- Page level plugins -->
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script> <!-- 이건 모양 -->
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script> <!-- 이건 search 자체 -->

</body>
</html>