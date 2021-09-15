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
function view()
{	   
		window.open("/review/list");
}


function fn_adminPublicUpdate(rsrvSeq)
{	    
   if(!confirm("게시글 차단상태를 수정하시겠습니까?"))
   {
      return;
   }
   
   $.ajax({
      url: "/admin/reviewAdminPublicUpdateProc",
      data: {
    	  rsrvSeq: rsrvSeq,
    	  adminPublic: $("#adminPublic" + rsrvSeq).val()
      },
      datatype: "JSON", 
        beforeSend: function(xhr) {
           xhr.setRequestHeader("AJAX", "true");
        },
      success: function(res)
      {
         
         if(res.code == 0)
         {
            alert("리뷰 게시글 상태가 수정되었습니다.");
            location.reload();
         }
         else if(res.code == -1)
         {
            alert("리뷰 게시글 상태변경 중 오류가 발생했습니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 오류");
         }
         else if(res.code == 404)
         {
            alert("리뷰 게시글이 없습니다.");
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

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h2 class="m-0 font-weight-bold text-primary">리뷰 게시글 조회</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="vertical-align:center;">
                                    <thead>
                                    	<tr>
                                            <th class="text-center" style="width:8%">순번</th>
                                            <th class="text-center" style="width:10%">예약 번호</th>
                                            <th class="text-center" style="width:8%">아이디</th>
                                            <th class="text-center" style="width:17%">제목</th>
                                            <th class="text-center" style="width:17%">내용</th>
                                            <th class="text-center" style="width:14%">작성일자</th>
                                            <th class="text-center" style="width:8%">조회수</th>
                                            <th class="text-center" style="width:8%">차단상태</th>
                                            <th class="text-center" style="width:10%">바로가기</th>
                                        </tr>       
                                    </thead>
                                   
                                    <tbody style="vertical-align:center;">
										<c:if test="${!empty list}">
                                    	<c:forEach items="${list}" var="review" varStatus="status">
	                                       <tr>
	                                       <td class="text-center" style="width:8%" >${status.count}</td>
	                                       <td class="text-center" style="width:10%" >${review.rsrvSeq}</td>
                                            <td class="text-center" style="width:8%">${review.userId}</td>                     
                                            <td class="text-center" style="width:17%">${review.bbsTitle}</td>
                                            <td class="text-center" style="width:17%">${review.bbsContent}</td>
                                            <td class="text-center" style="width:14%">${review.regDate}</td>
                                            <th class="text-center" style="width:8%">${review.bbsReadCnt}</th>
                                            
                                            <td class="text-center" style="width:8%"> 
                                         		<p>
                                         			<select id="adminPublic${review.rsrvSeq}" name="adminPublic${review.rsrvSeq}" class="form-control"  style="font-size: 1rem; width: 8rem; height: 2.2rem;">
	                                      				<option value="Y" <c:if test="${review.adminPublic == 'Y'}">selected</c:if>>정상</option>
	                                      				<option value="N" <c:if test="${review.adminPublic == 'N'}">selected</c:if>>차단</option>
                                       				</select>
                                       			</p>
                                       				
                                         			<input type="button" href="javascript:void(0)" onclick="fn_adminPublicUpdate('${review.rsrvSeq}')" style="margin-left:.10rem; width: 4rem; height: 2rem; " value="변경"> 
                                   			</td>
                                             
                                             
                                             
                                            <th class="text-center" style="width:10%">	                                            
                                            	<input type="button" href="javascript:void(0)" onclick="view()" value="바로가기" />	                                            
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

<form name="reviewForm" id="reviewForm" method="post">
   <input type="hidden" name="bbsSeq" value=""/>
</form>
   
    <!-- Page level plugins -->
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script> <!-- 이건 모양 -->
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script> <!-- 이건 search 자체 -->

</body>
</html>