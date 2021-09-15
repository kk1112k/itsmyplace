<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<% %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<% response.setDateHeader("Expires",0); %>
<script type="text/javascript">

$("#btnCmtDel").on("click", function(){
	fn_commDelecte(bbsSeq)
	alert("야");
})

function fn_commDelete(bbsSeq)
{
	confirm("정말로 삭제하시겠습니까?");
	
	var bbsSeq = bbsSeq;
	$.ajax({
		type: "POST",
		url: "/community/commDeleteProc",
		data: {'bbsSeq' : bbsSeq},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("삭제완료");
				location.href="/community/list";
			}
			else if(response.code == 404)
			{
				alert("잘못된 요청입니다");
				location.href="/community/list";
			}
			else
			{
				alert("삭제중 오류가 발생하였습니다.");
				location.href="/community/list";
			}
		}
	})
}

function fn_commUpdate(bbs_seq)
{
	var bbs_seq = bbs_seq;
	document.bbsForm.action = "/community/updateForm";
	document.bbsForm.submit();
}


function fn_cmtWrite(bbs_Seq)
{
	var bbs_Seq = bbs_Seq;
	$.ajax({
		type: "POST",
		url: "/community/cmtWriteProc",
		data: {
			'bbsSeq': bbs_Seq,
			'cmtContent': $("#cmtContent").val()
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("댓글작성완료");
				location.reload();
			}
			else if(response.code == 400){
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else{
				alert("게시물 삭제 중 오류가 발생했습니다.");
			}
		}
	})
}


function fn_cmtdelete(bbs_Seq, cmt_Seq)
{
	var bbs_Seq = bbs_Seq;
	var cmt_Seq = cmt_Seq;
	$.ajax({
		type: "POST",
		url: "/community/cmtDelProc",
		data: {
			'cmtSeq': cmt_Seq,
			'bbsSeq': bbs_Seq
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("댓글삭제완료");
				location.reload();
			}
			else if(response.code == 400){
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else if(response.code == 404){
				alert("작성한 유저가 아니거나 유저정보가 없습니다");
			}
			else{
				alert("게시물 삭제 중 오류가 발생했습니다.");
			}
		},
		complete: function(data){
			icia.common.log(data);
		},
		error: function(xhr, status, error){
			icia.common.error(error);
		}
	})
}

$(document).ready(function() {
	<c:choose>
	   <c:when test="">
	      alert("조회하신 게시물이 존재하지 않습니다.");
	      
	      document.bbsForm.action = "/community/list";
	      document.bbsForm.submit();
	   </c:when>
	   <c:otherwise>
	   $("#btnList").on("click", function() {
	      document.bbsForm.action = "/community/list";
	      document.bbsForm.submit();
	   });

		</c:otherwise>
	</c:choose>  
});


</script>

<%--  	$("#btnCmt").on("click", function()
	{
	//ajax
	$.ajax({
		type: "POST",
		url: "/community/cmtWriteProc",
		data: {
			bbsSeq: <c:out value="${comm.bbsSeq}" />,
			cmtContent: $("#cmtContent").val()
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
		if(response.code == 0){
				  alert("댓글작성완료");
				  location.reload();
			  }
			  else if(response.code == 400){
				  alert("파라미터 값이 올바르지 않습니다.");
			  }
			  else{
				  alert("게시물 삭제 중 오류가 발생했습니다.");
			  }
 		  },
 		  complete: function(data){
 			  icia.common.log(data);
 		  },
 		  error: function(xhr, status, error){
 			  icia.common.error(error);
			}
		})
	}); 

	$("#btnCmtDel").on("click", function(){
		$.ajax({
			type: "POST",
			url: "/community/cmtDelProc",
			data: {
				bbsSeq: <c:out value="${comm.bbsSeq}" />
			},
			datatype: "JSON",
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success: function(response){
			if(response.code == 0){
				  alert("댓글삭제완료");
				  location.reload();
			  }
			  else if(response.code == 400){
				  alert("파라미터 값이 올바르지 않습니다.");
			  }
			  else if(response.code == 404){
				  alert("작성한 유저가 아니거나 유저정보가 없습니다");
			  }
			  else{
				  alert("게시물 삭제 중 오류가 발생했습니다.");
			  }
		  },
		  complete: function(data){
			  icia.common.log(data);
		  },
		  error: function(xhr, status, error){
			  icia.common.error(error);
		  }
		})
	});


 function fn_commDelete(bbs_Seq)
{
	$.ajax({
		type: "POST",
		url: "/community/commDeleteProc"
		data: {bbsSeq:bbs_Seq},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("삭제완료");
				location.href="/community/list";
			}
			else if(response.code == 404)
			{
				alert("잘못된 요청입니다");
				location.href="/community/list";
			}
			else
			{
				alert("삭제중 오류가 발생하였습니다.");
				location.href="/community/list";
			}
		}
	}) 
}

function fn_commUpdate(bbs_seq)
{
	document.bbsForm.action = "/community/updateForm";
	document.bbsForm.submit();
}


function fn_cmtWrite(bbs_Seq)
{
	$.ajax({
		type: "POST",
		url: "/community/cmtWriteProc",
		data: {
			bbsSeq: bbs_Seq,
			cmtContent: $("#cmtContent").val()
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("댓글작성완료");
				location.reload();
			}
			else if(response.code == 400){
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else{
				alert("게시물 삭제 중 오류가 발생했습니다.");
			}
		}
	})
}


function fn_cmtdelete(bbs_Seq, cmt_Seq)
{
	$.ajax({
		type: "POST",
		url: "/community/cmtDelProc",
		data: {
			cmtSeq: cmt_Seq,
			bbsSeq: bbs_Seq
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("댓글삭제완료");
				location.reload();
			}
			else if(response.code == 400){
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else if(response.code == 404){
				alert("작성한 유저가 아니거나 유저정보가 없습니다");
			}
			else{
				alert("게시물 삭제 중 오류가 발생했습니다.");
			}
		},
		complete: function(data){
			icia.common.log(data);
		},
		error: function(xhr, status, error){
			icia.common.error(error);
		}
	})
} --%>


</head>
<body>
<c:if test="${!empty comm}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
   <h2>게시물 보기</h2>
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table">
         <thead>
            <tr class="table-active">
               <th scope="col" style="width:60%">
                  <c:out value="${comm.bbsTitle}" /> <br/>
                  <c:out value="${comm.userName}" /> &nbsp;&nbsp;&nbsp;
                  <%-- <a href="mailto:${hiBoard.userEmail}" style="color:#828282;">${hiBoard.userEmail}</a> --%>
  <c:if test="${!empty comm.commPht}">
                  &nbsp;&nbsp;&nbsp;<a href="/community/download?bbsSeq=${comm.commPht.bbsSeq}" style="color:#000;">[첨부파일]</a>
   </c:if>
               </th>
               <th scope="col" style="width:40%" class="text-right">
                  조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${comm.bbsReadCnt}" /><br/>
                  ${comm.regDate}
               </th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td colspan="2"><pre><c:out value="${comm.bbsContent}" /></pre></td>
            </tr>
         </tbody>
         <tfoot>
          <tr>
               <td colspan="2"></td>
           </tr>
         </tfoot>
      </table>
<!-- <form name="listForm" id="listForm" method="post"> -->
      <table class="table table-hover">
		<thead>
			<tr style="background-color: #dee2e6;">
				<td colspan="7"></td>
			</tr>
		</thead>

		<tbody>

<c:if test="${!empty list}">
	<c:forEach var="commCmt" items="${list}" varStatus="status">
		<tr>
			<td><input type="hidden" id="cmtSeq" name="cmtSeq" value="${commCmt.cmtSeq}" /></td>
			<td class="text-center"><c:out value="${commCmt.userId}" /></td>
			<td colspan="3" class="text-left">${commCmt.cmtContent}</td>
			<td class="text-center">${commCmt.regDate}</td>
			<td><button type="button" id="btnCmtDel" class="btn btn-secondary" onClick="fn_cmtdelete(${commCmt.bbsSeq},${commCmt.cmtSeq});">삭제</button></td>
			
		</tr>
	</c:forEach>
</c:if>

	

		</tbody>

	</table>
<!-- </form> -->
   </div>
   <input type="text" id="cmtContent" />
   <button type="button" id="btnList" class="btn btn-secondary">리스트</button>
   <button type="button" id="btnCmt" class="btn btn-secondary" onClick="fn_cmtWrite(${comm.bbsSeq});">댓글달기</button>
   <c:if test="${boardMe eq 'Y'}">
   <button type="button" id="btnUpdate" class="btn btn-secondary" onClick="fn_commUpdate(${comm.bbsSeq});">수정</button>
   <button type="button" id="btnDelete" class="btn btn-secondary" onClick="fn_commDelete(${comm.bbsSeq});">삭제</button>
   </c:if>
   <br/>
   <br/>
</div>
</c:if>
<form name="bbsForm" id="bbsForm" method="post">
	<input type="hidden" name="bbsSeq" value="" />
	<input type="hidden" name="searchType" value="${searchType}" />
	<input type="hidden" name="searchValue" value="${searchValue}" />
	<input type="hidden" name="curPage" value="${curPage}" />
</form>

</body>
</html>