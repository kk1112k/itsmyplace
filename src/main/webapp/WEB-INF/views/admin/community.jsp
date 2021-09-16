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
	var bbsSeq = bbsSeq;
	
	/*
	var target = 'pop';
	window.open('',target);
	
	var form = document.commForm;
	form.action="/community/view";
	form.target=target;
	form.submit();
	*/
	//document.commForm.bbsSeq = bbsSeq;
	//document.commForm.action = "/cafe/reservationNext";
	//document.commForm.submit();
	
	window.open("/community/view?bbsSeq=" + bbsSeq);
}

function view2(bbsSeq)
{   
	var bbsSeq = bbsSeq;
	   
	window.open("/community/view?bbsSeq=" + bbsSeq);
}

function fn_adminPublicUpdate(bbsSeq)
{       
   if(!confirm("게시글 차단상태를 수정하시겠습니까?"))
   {
      return;
   }
   
   alert(bbsSeq);
   $.ajax({
      url: "/admin/commAdminPublicUpdateProc",
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
            alert("커뮤니티 게시글 상태가 수정되었습니다.");
            location.reload();
         }
         else if(res.code == -1)
         {
            alert("커뮤니티 게시글 상태변경 중 오류가 발생했습니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 오류");
         }
         else if(res.code == 404)
         {
            alert("커뮤니티 게시글이 없습니다.");
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


function fn_adminPublicUpdate2(cmtSeq)
{       
	alert(cmtSeq);
	alert($("#adminPublic2" + cmtSeq).val());
   if(!confirm("커뮤니티 댓글 차단상태를 수정하시겠습니까?"))
   {
      return;
   }
   
   $.ajax({
      url: "/admin/commCmtAdminPublicUpdateProc",
      data: {
         cmtSeq: cmtSeq,
         adminPublic: $("#adminPublic2" + cmtSeq).val()
      },
      datatype: "JSON", 
        beforeSend: function(xhr) {
           xhr.setRequestHeader("AJAX", "true");
        },
      success: function(res)
      {
         
         if(res.code == 0)
         {
            alert("커뮤니티 댓글 상태가 수정되었습니다.");
            location.reload();
         }
         else if(res.code == -1)
         {
            alert("커뮤니티 댓글 상태변경 중 오류가 발생했습니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 오류");
         }
         else if(res.code == 404)
         {
            alert("커뮤니티 댓글이 없습니다.");
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
                            <h2 class="m-0 font-weight-bold text-primary">커뮤니티 조회</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>                                          
                                        	<th class="text-center" style="width:6%">순번</th>
                                        	<th class="text-center" style="width:11%">게시물번호</th>
                                            <th class="text-center" style="width:9%">댓글순번</th>
                                            <th class="text-center" style="width:7%">아이디</th>
                                            <th class="text-center" style="width:7%">회원명</th>
                                            <th class="text-center" style="width:11%">제목</th>
                                            <th class="text-center" style="width:12%">내용</th>
                                            <th class="text-center" style="width:8%">작성일자</th>
                                            <th class="text-center" style="width:8%">조회수</th>
                                            <th class="text-center" style="width:8%">차단상태</th>
                                            <th class="text-center" style="width:9%">바로가기</th>                  
                                        </tr>
                                    </thead>
                                   
                                   <tbody>
                              <c:if test="${!empty list}">
                                       <c:forEach items="${list}" var="comm" varStatus="status">
                                          <tr>
	                                        <td class="text-center" style="width:6%">${status.count}</td>
	                                        <td class="text-center" style="width:11%">${comm.bbsSeq}</td> 
                                            <td class="text-center" style="width:9%"></td>
                                            <td class="text-center" style="width:7%">${comm.userId}</td>
                                            <td class="text-center" style="width:7%">${comm.userName}</td>
                                            <td class="text-center" style="width:11%">${comm.bbsTitle}</td>
                                            <td class="text-center" style="width:12%">${comm.bbsContent}</td>
                                            <td class="text-center" style="width:8%">${comm.regDate}</td>
                                            <td class="text-center" style="width:8%">${comm.bbsReadCnt}</td>
                                            
                                            
                                            <td class="text-center" style="width:8%"> 
                                                <p>
                                                   <select id="adminPublic${comm.bbsSeq}" name="adminPublic${comm.bbsSeq}" class="form-control"  style="font-size: 1rem; width: 5rem; height: 2.2rem;">
                                                      <option value="Y" <c:if test="${comm.adminPublic == 'Y'}">selected</c:if>>정상</option>
                                                      <option value="N" <c:if test="${comm.adminPublic == 'N'}">selected</c:if>>차단</option>
                                                   </select>
                                                </p>
                                                   
                                                  <input type="button" href="javascript:void(0)" onclick="fn_adminPublicUpdate('${comm.bbsSeq}')" style="margin-left:.10rem; width: 4rem; height: 2rem; " value="변경"> 
                                            </td>
                                                  
                                            <td class="text-center" style="width:9%">                                               
                                               <input type="button" href="javascript:void(0)" onclick="view('${comm.bbsSeq}')" value="바로가기" />                                               
                                            </td>                                  
                                          </tr>
                                          <c:if test="${!empty comm.commCmtList}">
                                          <c:forEach items="${comm.commCmtList}" var="s" varStatus="status1">
                                          
                                          <tr> 
                                          	<td class="text-center" style="width:6%">${comm.rNum}</td>
	                                        <td class="text-center" style="width:11%">${comm.bbsSeq}</td> 
                                            <td class="text-center" style="width:9%">${status1.count}</td>
                                            <td class="text-center" style="width:7%">${s.userId}</td>	
                                            <td class="text-center" style="width:7%">${s.userName}</td>
                                            <td class="text-center" style="width:11%"></td>
                                            <td class="text-center" style="width:12%">${s.cmtContent}</td>
                                            <td class="text-center" style="width:8%">${s.regDate}</td>
                                            <td class="text-center" style="width:8%"></td>
                                            
                                            
                                            <td class="text-center" style="width:8%"> 
                                                <p>
                                                   <select id="adminPublic2${s.cmtSeq}" name="adminPublic2${s.cmtSeq}" class="form-control"  style="font-size: 1rem; width: 5rem; height: 2.2rem;">
                                                      <option value="Y" <c:if test="${s.adminPublic == 'Y'}">selected</c:if>>정상</option>
                                                      <option value="N" <c:if test="${s.adminPublic == 'N'}">selected</c:if>>차단</option>
                                                   </select>
                                                </p>
                                                   
                                                  <input type="button" href="javascript:void(0)" onclick="fn_adminPublicUpdate2('${s.cmtSeq}')" style="margin-left:.10rem; width: 4rem; height: 2rem; " value="변경"> 
                                            </td>
                                                  
                                            <td class="text-center" style="width:9%">                                               
                                               <input type="button" href="javascript:void(0)" onclick="view2('${s.bbsSeq}')" value="바로가기" />                                               
                                            </td>                                  
                                          </tr>
                                          </c:forEach>
                                          </c:if>
                                       </c:forEach>
                                      </c:if>    
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->


    <!-- Logout Modal-->
    

<form name="commForm" id="commForm" method="post">
   <input type="hidden" name="bbsSeq" value=""/>
</form>
    <!-- Page level plugins -->
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

</body>
</html>