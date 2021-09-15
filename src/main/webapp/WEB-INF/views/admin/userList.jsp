<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  color: #fff;
  background: #c0c1c8 ;
 }

input[type="text"] { 
border: solid 1px #c0c1c8; 
border-radius: 4px; 
 background: #fbf9d3;
 color: #858796;}
 
 input[type="number"] { 
border: solid 1px #c0c1c8; 
border-radius: 4px; 
 background: #fbf9d3;
 color: #858796;}

input[type="button"] { 
 border: none;
  border-color: #4397cf ;
  outline: none;
  font-size: 15px;
  color: #fbf9d3;
  cursor: pointer;
  border-radius: 10px;
  background: #4397cf ;}
</style>
  
<script type="text/javascript">

function fn_statusUpdate(userId) 
{   
   if(!confirm("회원정보를 수정하시겠습니까?"))
   {
      return;
   }
      
   $.ajax({
      url: "/admin/updateProc",
      data: {
         userId: userId,
         status: $("#userStatus" + userId).val()
      },
      datatype: "JSON",
        beforeSend: function(xhr) {
           xhr.setRequestHeader("AJAX", "true");
        },
      success: function(res)
      {
         
         if(res.code == 0)
         {
            alert("회원정보가 수정되었습니다.");
         }
         else if(res.code == -1)
         {
            alert("회원정보 수정 중 오류가 발생했습니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 오류");
         }
         else if(res.code == 404)
         {
            alert("회원정보가 없습니다.");
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

function fn_reward(userId){

	if($.trim($("#pointInsert"+ userId).val()).length <= 0)
	{
		alert("지급사유를 입력하세요");
		$("#pointInsert"+ userId).val("");
		$("#pointInsert"+ userId).focus();
		
		return;
	}
	if($.trim($("#point"+ userId).val()) <= 0)
	{
		alert("지급할 포인트를 입력하세요");
		$("#point"+ userId).val("");
		$("#point"+ userId).focus();
		
		return;
	}
	
   //alert($("#point" + userId).val());
   $.ajax({
	  type: "POST",
      url: "/admin/userPointReward",
      data: {
         userId: userId,
         point: $("#point" + userId).val(),
         savePath: $("#pointInsert" + userId).val()	
      },
      datatype: "JSON",
        beforeSend: function(xhr) {
           xhr.setRequestHeader("AJAX", "true");
        },
      success: function(res)
      {         
         if(res.code == 0)
         {
           
            location.reload();
         }
         else if(res.code == -1)
         {
            alert("포인트 지급 중 오류가 발생했습니다.");
         }
         else if(res.code == 400)
         {
            alert("파라미터 오류가 발생했습니다.");
         }
         else if(res.code == 404)
         {
            alert("회원정보가 없습니다.");
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
                            <h2 class="m-0 font-weight-bold text-primary">전체 회원 목록</h2>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" valign="middle">
                                    <thead>
                                        <tr>
                                        	<th class="text-center" style="width:7%">순번</th>
                                            <th class="text-center" style="width:10%">아이디</th>
                                            <th class="text-center" style="width:6%">회원명</th>
                                            <th class="text-center" style="width:14%">이메일</th>
                                            <th class="text-center" style="width:5%">성별</th>
                                            <th class="text-center" style="width:10%">보유포인트</th>
                                            <th class="text-center" style="width:10%">가입일자</th>
                                            <th class="text-center" style="width:13%">회원 상태</th>
                                            <th class="text-center" style="width:22%">포인트 지급하기</th>                                            
                                        </tr>
                                    </thead>                                   
                                    <tbody>
                                       <c:if test="${!empty list}">
                                          <c:forEach items="${list}" var="user" varStatus="status">
                                              <tr>
                                              	<td class="text-center" style="width:7%"> ${status.count}</td>
                                                  <td class="text-center" style="width:10%"> ${user.userId}</td>
                                                  <td class="text-center" style="width:10%">${user.userName}</td>
                                                  <td class="text-center" style="width:13%">${user.userEmail}</td>
                                                  <td class="text-center" style="width:8%">${user.userGender}</td>
                                                  <td class="text-center" style="width:11%">
                                                  	<fmt:formatNumber value="${user.totalPoint}" pattern="#,###" />
                                                  </td>
                                                  <td class="text-center" style="width:10%">${user.regDate}</td>
                                                 
                                                 
                                                 
                                                   <td class="text-center" style="width:7%">    
                                          			<p>
                                          			<select id="userStatus${user.userId}" name="userStatus${user.userId}" class="form-control"  style="font-size: 1rem; width: 8rem; height: 2.2rem;">
                                             			<option value="Y" <c:if test="${user.status == 'Y'}">selected</c:if>>정상</option>
                                             			<option value="N" <c:if test="${user.status == 'N'}">selected</c:if>>정지</option>
                                        			</select>
                                        			</p>
                                          			<button onclick="fn_statusUpdate('${user.userId}')"  class="button" style="margin-left:.10rem; width: 4rem; height: 2rem; ">변경</button> 
                                       			    </td>
                                       			    
                                                   <td class="text-center" style="width:22%">                                                                                                         
													<p><input type="text" id="pointInsert${user.userId}" name="pointInsert${user.userId}" placeholder="지급사유를 입력하세요"  style="width:200px;" name="point${user.userId}" onfocus="this.select()"> </p>                                                     
                                                    <input type="number" id="point${user.userId}" value="0" style="width:130px;" name="point${user.userId}"onfocus="this.select()">
                                                      &nbsp;
                                                    <input type="button" id="btnReward" class="button" onclick ="fn_reward('${user.userId}')" style="margin-left:.10rem; width: 3rem; height: 2rem;"value="지급" >                                                  
                                                   </td>
                                 
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
    <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
</body>
</html>