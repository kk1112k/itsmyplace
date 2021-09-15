<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">

function fn_confirm(bbsSeq)
{
   if(confirm("정말로 삭제하시겠습니까?")==true)
   {
      fn_commDelete(bbsSeq)
   }
   else
   {
      return;
   }
      
}

function fn_commDelete(bbsSeq)
{   
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
   document.bbsForm.bbsSeq.value = bbs_seq;
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
            console.log("댓글작성완료");
            location.reload();
         }
         else if(response.code == 400){
            alert("댓글 내용을 입력하세요.");
         }
         else{
            alert("게시물 삭제 중 오류가 발생했습니다.");
         }
      }
   })
}

//댓글 수정
function fn_cmtUpdateTo(bbs_Seq, cmt_Seq, cmt_Group)
{   
   
   if($(".btnCmtReply").css("display") == "block")
   {
      $(".btnCmtReply").css("display","none");
   }
   else
   {
      $(".btnCmtReply").css("display","block");
   }
   
   if($(".btnCmtUpdate").css("display") == "block")
   {
      $(".btnCmtUpdate").css("display","none");
   }
   else
   {
      $(".btnCmtUpdate").css("display","block");
   }
   
   if($(".btnCmtDelete").css("display") == "block")
   {
      $(".btnCmtDelete").css("display","none");
   }
   else
   {
      $(".btnCmtDelete").css("display","block");
   }
   
   if($("#btnCmtUpdateDone"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtUpdateDone"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtUpdateDone"+cmt_Seq).css("display","block");
   }
   
   if($("#btnCmtUpdateCancel"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtUpdateCancel"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtUpdateCancel"+cmt_Seq).css("display","block");
   }
   
   if($("#ttt"+cmt_Seq).css("display") == "block")
   {
      $("#ttt"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#ttt"+cmt_Seq).css("display","block");
   }
   
   if($("#cmtContentLoc"+cmt_Seq).css("display") == "block")
   {
      $("#cmtContentLoc"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#cmtContentLoc"+cmt_Seq).css("display","block");
   }
      
}

function fn_cmtUpdateKey(bbs_Seq, cmt_Seq, cmt_Group)
{
	if(event.keyCode == 13)
	{
		fn_cmtUpdateDone(bbs_Seq, cmt_Seq, cmt_Group);
	}
}

function fn_cmtUpdateDone(bbs_Seq, cmt_Seq, cmt_Group)
{
   $.ajax({
      type: "POST",
      url: "/community/cmtUpdateProc",
      data: {
         'cmtSeq': cmt_Seq,
         'bbsSeq': bbs_Seq,
         'cmtContent': $('#ttt'+cmt_Seq).val()
      },
      datatype: "JSON",
      beforeSend: function(xhr){
         xhr.setRequestHeader("AJAX", "true");
      },
      success: function(response){
         if(response.code == 0){
        	alert("댓글이 수정되었습니다.");
            location.reload();
            
            if($("#btnCmtUpdate"+cmt_Seq).css("display") == "block")
            {
               $("#btnCmtUpdate"+cmt_Seq).css("display","none");
            }
            else
            {
               $("#btnCmtUpdate"+cmt_Seq).css("display","block");
            }
            
            if($("#btnCmtUpdateDone"+cmt_Seq).css("display") == "block")
            {
               $("#btnCmtUpdateDone"+cmt_Seq).css("display","none");
            }
            else
            {
               $("#btnCmtUpdateDone"+cmt_Seq).css("display","block");
            }
            
            if($("#btnCmtUpdateCancel"+cmt_Seq).css("display") == "block")
            {
               $("#btnCmtUpdateCancel"+cmt_Seq).css("display","none");
            }
            else
            {
               $("#btnCmtUpdateCancel"+cmt_Seq).css("display","block");
            }
         }
         else if(response.code == 400){
            alert("파라미터 값이 올바르지 않습니다.");
         }
         else if(response.code == 404){
            alert("작성한 유저가 아니거나 유저정보가 없습니다");
         }
         else if(response.code == 900){
            alert("댓글 내용을 입력하세요.");
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
   
   console.log("완료");
   
}

function fn_cmtUpdateCancel(bbs_Seq, cmt_Seq, cmt_Group)
{
   console.log("취소");
   
   if($(".btnCmtReply").css("display") == "block")
   {
      $(".btnCmtReply").css("display","none");
   }
   else
   {
      $(".btnCmtReply").css("display","block");
   }
   
   if($(".btnCmtUpdate").css("display") == "block")
   {
      $(".btnCmtUpdate").css("display","none");
   }
   else
   {
      $(".btnCmtUpdate").css("display","block");
   }
   
   if($(".btnCmtDelete").css("display") == "block")
   {
      $(".btnCmtDelete").css("display","none");
   }
   else
   {
      $(".btnCmtDelete").css("display","block");
   }
   
   if($("#btnCmtUpdateDone"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtUpdateDone"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtUpdateDone"+cmt_Seq).css("display","block");
   }
   
   if($("#btnCmtUpdateCancel"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtUpdateCancel"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtUpdateCancel"+cmt_Seq).css("display","block");
   }
   
   if($("#ttt"+cmt_Seq).css("display") == "block")
   {
      $("#ttt"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#ttt"+cmt_Seq).css("display","block");
   }
   
   if($("#cmtContentLoc"+cmt_Seq).css("display") == "block")
   {
      $("#cmtContentLoc"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#cmtContentLoc"+cmt_Seq).css("display","block");
   }

}

//댓글 답글
function fn_cmtReplyTo(bbs_Seq, cmt_Group, cmt_Seq)
{   
   if($(".btnCmtReply").css("display") == "block")
   {
      $(".btnCmtReply").css("display","none");
   }
   else
   {
      $(".btnCmtReply").css("display","block");
   }
   
   if($(".btnCmtUpdate").css("display") == "block")
   {
      $(".btnCmtUpdate").css("display","none");
   }
   else
   {
      $(".btnCmtUpdate").css("display","block");
   }
   
   if($(".btnCmtDelete").css("display") == "block")
   {
      $(".btnCmtDelete").css("display","none");
   }
   else
   {
      $(".btnCmtDelete").css("display","block");
   }
   
   if($("#btnCmtReplyDone"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtReplyDone"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtReplyDone"+cmt_Seq).css("display","block");
   }
   
   if($("#btnCmtReplyCancel"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtReplyCancel"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtReplyCancel"+cmt_Seq).css("display","block");
   }
   
   
    $('#replyLoc'+ cmt_Seq).after("<tr id='xxxparent'><td/><td colspan='5'><input type='text' id='xxx' style='height:45px;'class='form-control mx-1' name='cmtContentxxx' placeholder='작성할 답글 내용을 입력하세요.' onkeypress='if(event.keyCode == 13){fn_replyDone("+bbs_Seq+","+cmt_Group+","+cmt_Seq+")}'/></td></tr>");
   
}

function fn_replyDone(bbs_Seq, cmt_Group, cmt_Seq)
{   
   $.ajax({
      type: "POST",
      url: "/community/cmtWriteProc",
      data: {
         'cmtGroup': cmt_Group,
         'bbsSeq': bbs_Seq,
         'cmtContentxxx': $('#xxx').val()
      },
      datatype: "JSON",
      beforeSend: function(xhr){
         xhr.setRequestHeader("AJAX", "true");
      },
      success: function(response){
         if(response.code == 0){
            console.log("댓글답변완료");
            location.reload();
            
            if($(".btnCmtReply").css("display") == "block")
            {
               $(".btnCmtReply").css("display","none");
            }
            else
            {
               $(".btnCmtReply").css("display","block");
            }
            
            if($(".btnCmtUpdate").css("display") == "block")
            {
               $(".btnCmtUpdate").css("display","none");
            }
            else
            {
               $(".btnCmtUpdate").css("display","block");
            }
            
            if($(".btnCmtDelete").css("display") == "block")
            {
               $(".btnCmtDelete").css("display","none");
            }
            else
            {
               $(".btnCmtDelete").css("display","block");
            }
            
            if($("#btnCmtReplyDone"+cmt_Seq).css("display") == "block")
            {
               $("#btnCmtReplyDone"+cmt_Seq).css("display","none");
            }
            else
            {
               $("#btnCmtReplyDone"+cmt_Seq).css("display","block");
            }
            
            if($("#btnCmtReplyCancel"+cmt_Seq).css("display") == "block")
            {
               $("#btnCmtReplyCancel"+cmt_Seq).css("display","none");
            }
            else
            {
               $("#btnCmtReplyCancel"+cmt_Seq).css("display","block");
            }
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

function fn_replyCancel(bbs_Seq, cmt_Group, cmt_Seq)
{
   $('#xxxparent').remove();
   
   console.log("취소");
   
   if($(".btnCmtReply").css("display") == "block")
   {
      $(".btnCmtReply").css("display","none");
   }
   else
   {
      $(".btnCmtReply").css("display","block");
   }
   
   if($(".btnCmtUpdate").css("display") == "block")
   {
      $(".btnCmtUpdate").css("display","none");
   }
   else
   {
      $(".btnCmtUpdate").css("display","block");
   }
   
   if($(".btnCmtDelete").css("display") == "block")
   {
      $(".btnCmtDelete").css("display","none");
   }
   else
   {
      $(".btnCmtDelete").css("display","block");
   }
   
   if($("#btnCmtReplyDone"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtReplyDone"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtReplyDone"+cmt_Seq).css("display","block");
   }
   
   if($("#btnCmtReplyCancel"+cmt_Seq).css("display") == "block")
   {
      $("#btnCmtReplyCancel"+cmt_Seq).css("display","none");
   }
   else
   {
      $("#btnCmtReplyCancel"+cmt_Seq).css("display","block");
   }
}

function fn_cmtConfirm(bbs_Seq, cmt_Seq)
{
   if(confirm("정말로 삭제하시겠습니까?")==true)
   {
      fn_cmtDelete(bbs_Seq, cmt_Seq)
   }
   else
   {
      return;
   }
      
}


function fn_cmtDelete(bbs_Seq, cmt_Seq)
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

function fn_btnList(curPage)
{
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/community/list";
   document.bbsForm.submit();
}

function fn_block_cmt()
{
	alert("댓글을 등록하려면 로그인하세요.");
}

function fn_block_cmtReplyTo()
{
	alert("답글을 등록하려면 로그인하세요.");
}

$(document).ready(function(){
<c:if test="${empty comm}">
	alert("홈페이지의 커뮤니티 메뉴를 이용해서 접근하세요.");
	location.href="/";
</c:if>
})

</script>

</head>
<body>
<c:if test="${!empty comm}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="user-dashboard page-wrapper">
<div class="container">
      <div class="d-flex">
   <div class="logo text-left">
      <a href="/community/list"><img src="/resources/images/comm/commTitle.png" alt="커뮤니티 타이틀 이미지" height="80" /></a>
   </div>
   <div class="comm-custom2"></div>
   <div style="height:70px;"><img src="/resources/images/comm/commCmtTitle2.png" alt="게시글제목이미지" height=70px;/></div>
   <div class="row" style="margin-right:0; margin-left:0;">
      <table class="table" style="color:#fbf9d3">
         <thead>
            <tr class="table-active" style="background-color:#4397CF">
               <th scope="col" style="width:60%">
               <h1>&nbsp;<c:out value="${comm.bbsTitle}" /> </h1><br/>
               <%-- <a href="mailto:${hiBoard.userEmail}" style="color:#828282;">${hiBoard.userEmail}</a> --%>
            
               </th>
               <th scope="col" style="width:40%" class="text-right">
                  조회 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${comm.bbsReadCnt}" /><br/>
                  작성자명 : <c:out value="${comm.userName}" /><br/>
                  작성시간 : ${comm.regDate}
               </th>
            </tr>
         </thead>
         <tbody>
         	<tr>
         		<td colspan="2" class="text-center">
					<c:if test="${!empty comm.commPhtList}">
					<c:forEach var="commPht" items="${comm.commPhtList}" varStatus="status">
					<img src="/resources/upload/comm/${commPht.phtName}" alt="사용자첨부이미지" style="max-height:300px;"/>
					</c:forEach>
					</c:if>
				</td>
			</tr>
            <tr>
               <td colspan="2"><pre style="min-height:150px; background-color:#FFF"><c:out value="${comm.bbsContent}" /></pre></td>
            </tr>
         </tbody>
         <tfoot>
            <tr>
               <td colspan="2">
                  <c:if test="${!empty comm.commPhtList}">
                  <c:forEach var="commPht" items="${comm.commPhtList}" varStatus="status">
                  <div style="margin-bottom:0.1em; color:#000000;"><a href="/community/download?bbsSeq=${commPht.bbsSeq}&&phtNum=${commPht.phtNum}" style="color:#4397CF;">
                     [첨부사진 <c:out value="${status.count}"/>]
                  </a>${commPht.phtOrgName}</div> 
                  </c:forEach>
                  </c:if>
               </td>
            </tr>
         </tfoot>
      </table>

      <div style="height:80px;"><img src="/resources/images/comm/commCmtTitle.png" alt="댓글제목이미지" height=90px;/></div>
      <table class="table table-hover">
         <thead>
            <tr style="background-color: #4397CF;">
               <td colspan="4"></td>
            </tr>
         </thead>
         <tbody>
            <c:if test="${!empty list}">
               <c:forEach var="commCmt" items="${list}" varStatus="status">
                  <tr id="replyLoc${commCmt.cmtSeq}">
                     <td class="text-center"><c:out value="${commCmt.userId}" /><input type="hidden" id="cmtSeq" name="cmtSeq" value="${commCmt.cmtSeq}" /></td>
                     <td class="text-left" id="cmtContentUp${commCmt.cmtSeq}">
                  <c:if test="${commCmt.cmtIndent > 0}">
                        <div id="indentImgLoc" style="width:35px; float:left;"><img src="/resources/images/icon_reply.gif" style="margin-left: ${commCmt.cmtIndent}em;"/></div>
                  </c:if>
                        <div style="width:80%; height:25px; float:left;">
                        <div id="cmtContentLoc${commCmt.cmtSeq}" style="display:block;">${commCmt.cmtContent}</div>
                        <div><input type="text" id="ttt${commCmt.cmtSeq}" value="${commCmt.cmtContent}" onkeypress="fn_cmtUpdateKey(${commCmt.bbsSeq},${commCmt.cmtSeq},${commCmt.cmtGroup})" style="display:none; height:25px;" class='form-control mx-1'/></div></div>
                     </td>
                     <td class="text-right">${commCmt.regDate}</td>
                     <td class="text-right" id="updateLoc" width="200px;">
                        <c:choose>
                        <c:when test="${!empty user}">
                        	<img id="btnCmtReply${commCmt.cmtSeq}" style="display:block; float:right; margin-left:10px;" class="btnCmtReply" onClick="fn_cmtReplyTo(${commCmt.bbsSeq},${commCmt.cmtGroup},${commCmt.cmtSeq});" src="/resources/images/comm/reply.png" alt="답글이미지" title="답글" height="25px"/>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                        	<img id="btnCmtReply${commCmt.cmtSeq}" style="display:block; float:right; margin-left:10px;" class="btnCmtReply" onClick="fn_block_cmtReplyTo();" src="/resources/images/comm/reply.png" alt="답글이미지" title="답글" height="25px"/>&nbsp;&nbsp;
                        </c:otherwise>
                        </c:choose>
                        <img id="btnCmtReplyCancel${commCmt.cmtSeq}" style="display:none; float:right; margin-left:5px;" onClick="fn_replyCancel(${commCmt.bbsSeq},${commCmt.cmtGroup},${commCmt.cmtSeq});" src="/resources/images/comm/cancel.png" alt="답글작성취소이미지" title="답글작성취소" height="25px"/>&nbsp;&nbsp;
                        <img id="btnCmtReplyDone${commCmt.cmtSeq}" style="display:none; float:right;" onClick="fn_replyDone(${commCmt.bbsSeq},${commCmt.cmtGroup},${commCmt.cmtSeq});" src="/resources/images/comm/done.png" alt="답글작성완료이미지" title="답글작성완료" height="25px"/>&nbsp;&nbsp;                        
                     <c:if test="${commCmt.commentMe eq 'Y'}">
                        <%-- <button type="button" id="btnCmtUpdate${commCmt.cmtSeq}" class="btn btn-secondary" onClick="fn_cmtUpdateTo(${commCmt.bbsSeq},${commCmt.cmtSeq});">수정</button> --%>
                        <img id="btnCmtDelete${commCmt.cmtSeq}" style="display:block; float:right; margin-left:10px;" class="btnCmtDelete" onClick="fn_cmtConfirm(${commCmt.bbsSeq},${commCmt.cmtSeq});" src="/resources/images/comm/delete.png" alt="삭제이미지" title="삭제" height="25px"/>
                        <img id="btnCmtUpdate${commCmt.cmtSeq}" style="display:block; float:right;" class="btnCmtUpdate" onClick="fn_cmtUpdateTo(${commCmt.bbsSeq},${commCmt.cmtSeq},${commCmt.cmtGroup});" src="/resources/images/comm/edit.png" alt="수정이미지" title="수정" height="25px"/>&nbsp;&nbsp;
                        <img id="btnCmtUpdateCancel${commCmt.cmtSeq}" style="display:none; float:right; margin-left:5px;" onClick="fn_cmtUpdateCancel(${commCmt.bbsSeq},${commCmt.cmtSeq},${commCmt.cmtGroup});" src="/resources/images/comm/cancel.png" alt="댓글수정취소이미지" title="댓글수정취소" height="25px"/>&nbsp;&nbsp;
                        <img id="btnCmtUpdateDone${commCmt.cmtSeq}" style="display:none; float:right;" onClick="fn_cmtUpdateDone(${commCmt.bbsSeq},${commCmt.cmtSeq},${commCmt.cmtGroup});" src="/resources/images/comm/done.png" alt="댓글수정완료이미지" title="댓글수정완료" height="25px"/>&nbsp;&nbsp;                     
                     </c:if>

                     </td>
                  </tr>
               </c:forEach>
            </c:if>
         </tbody>
      </table>

   </div>
   
		<c:choose>
		<c:when test="${!empty user}">
		   	<div>
         	<div style="width:88%; float:left; margin-right:5px;">
         	<input type="text" id="cmtContent" class='form-control mx-1' placeholder="새롭게 등록할 댓글내용을 입력하세요." onkeypress="if(event.keyCode==13){fn_cmtWrite(${comm.bbsSeq})}"/></div>
         	<div style="width:10%; float:left;"><button type="button" id="btnCmt" class="btn btn-main mb-3" style="height:45px;" onClick="fn_cmtWrite(${comm.bbsSeq});">댓글달기</button></div>
         	</div>
   		</c:when>
   		<c:otherwise>
   			<div>
         	<div style="width:88%; float:left; margin-right:5px;"><input type="text" id="cmtContent" class='form-control mx-1' placeholder="댓글을 등록하려면 로그인하세요." readonly/></div>
         	<div style="width:10%; float:left;"><button type="button" id="btnCmt" class="btn btn-main mb-3" style="height:45px;" onClick="fn_block_cmt();">댓글달기</button></div>
         	</div>
   		</c:otherwise>
		</c:choose>
         <div style="margin-top:50px;">
         <button type="button" id="btnList" class="btn btn-main mb-3" style="height:45px;" onClick="fn_btnList(${curPage});">리스트</button>
      <c:if test="${boardMe eq 'Y'}">
         <button type="button" id="btnUpdate" class="btn btn-main mb-3" style="height:45px;" onClick="fn_commUpdate(${comm.bbsSeq});">수정</button>
         <button type="button" id="btnDelete" class="btn btn-main mb-3" style="height:45px;" onClick="fn_confirm(${comm.bbsSeq});">삭제</button>
      </c:if>
         </div>
   <br/>
   <br/>
</div>
</div>
</div>
</c:if>

<div>
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>
</div>

</body>
</html>