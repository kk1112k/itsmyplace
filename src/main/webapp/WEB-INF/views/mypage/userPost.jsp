<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
%>
<meta charset="utf-8">
<script type="text/javascript">

var checkBoxArr = ""; 
var checkBoxArr2 = ""; 

function fn_view(bbsSeq)
{
   document.bbsForm.bbsSeq.value = bbsSeq;
   document.bbsForm.action = "/community/view";
   document.bbsForm.submit();
}

function fn_list(curPage)
{
   document.bbsForm.bbsSeq.value = "";
   document.bbsForm.curPage.value = curPage;
   document.bbsForm.action = "/mypage/userPost";
   document.bbsForm.submit();   
}

function fn_list2(curPage2)
{
   document.reviewForm.rsrvSeq.value = "";
   document.reviewForm.curPage2.value = curPage2;
   document.reviewForm.action = "/mypage/userPost";
   document.reviewForm.submit();   
}

//자유
$(document).on('click','.chk_all',function(){ 
    if($('.chk_all').is(':checked')){ 
       $('.del-chk').prop('checked',true); 
    }else{ 
       $('.del-chk').prop('checked',false); 
    } 
    chkList(${userPostList.bbsSeq});
});

$(document).on('click','.del-chk',function(){ 
    if($('input[class=del-chk]:checked').length==$('.del-chk').length){
        $('.chk_all').prop('checked',true); 
    }else{ 
       $('.chk_all').prop('checked',false); 
    } 
}); 

//리뷰
$(document).on('click','.chk_all2',function(){ 
    if($('.chk_all2').is(':checked')){ 
       $('.del-chk2').prop('checked',true); 
    }else{ 
       $('.del-chk2').prop('checked',false); 
    } 
    chkList2(${userReviewPostList.rsrvSeq});
});

$(document).on('click','.del-chk2',function(){ 
    if($('input[class=del-chk2]:checked').length==$('.del-chk2').length){
        $('.chk_all2').prop('checked',true); 
    }else{ 
       $('.chk_all2').prop('checked',false); 
    } 
}); 


function chkList(bbsSeq){
	
	var query = 'input[name="checkbox"]:checked';
	   var selectedEls = document.querySelectorAll(query);
	   var checkBoxArrs = ''; 
	   selectedEls.forEach((el) => {
		   checkBoxArrs += el.value + ' ';
	   });
	   checkBoxArr = checkBoxArrs;
}

function chkList2(rsrvSeq){
	
	var query = 'input[name="checkbox2"]:checked';
	   var selectedEls = document.querySelectorAll(query);
	   var checkBoxArrs = ''; 
	   selectedEls.forEach((el) => {
		   checkBoxArrs += el.value + ' ';
	   });
	   checkBoxArr2 = checkBoxArrs;
}


/*
function chkList(bbsSeq){
	
	var query = 'input[name="checkbox"]:checked';
	   var selectedEls = document.querySelectorAll(query);
	   var checkBoxArrs = ''; 
	   selectedEls.forEach((el) => {
		   checkBoxArrs += el.value + ' ';
	   });
	   checkBoxArr = checkBoxArrs;
}
*/


function chkDeleteClick(){
	if(confirm("게시물을 삭제 하시겠습니까?") == true){ 
	 $.ajax({
	      type  : "POST",
	      url    : "/mypage/chkDeleteProc",
	      data: {checkBoxArr : checkBoxArr},
			datatype: "JSON",
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success: function(response){
				if(response.code == 0){
					alert("게시물이 삭제되었습니다.");
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
	}﻿
}

function chkReviewDeleteClick(){
	alert(checkBoxArr2);
	if(confirm("게시물을 삭제 하시겠습니까?") == true){ 
	 $.ajax({
	      type  : "POST",
	      url    : "/mypage/chkReviewDeleteProc",
	      data: {checkBoxArr2 : checkBoxArr2},
			datatype: "JSON",
			beforeSend: function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success: function(response){
				if(response.code == 0){
					alert("게시물이 삭제되었습니다.");
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
	}﻿
}

</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!--상단-->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<ol class="breadcrumb">
						<li><a href="/index">홈</a></li>
						<li class="active">마이페이지</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 본문 -->
<section class="user-dashboard page-wrapper" style="padding-top: 0px;">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <ul class="list-inline dashboard-menu text-center">
          <li><a href="userProfile">내정보</a></li>
          <li><a class="active" href="userPost">내가쓴 게시물</a></li>
			<c:choose>
			<c:when test="${user.userClass == 'N'}">
          <li><a href="userPayment">내 결제내역</a></li>
			</c:when>
			<c:otherwise>
			<li><a href="rsrvInfo">예약현황</a></li>
			</c:otherwise>
			</c:choose>
        </ul>




	  <div class="dashboard-wrapper user-dashboard">
		<h3>자유게시판</h3>

    
		<div class="checkbox_group">
			<table class="table table-hover" border="2" bordercolor="#ADD8E6">
				<thead>
               	 <tr style="background-color: #4397CF;">
                    <th scope="col" class="text-center" style="width:5%"><input type="checkbox" class="chk_all"></th>
         			<th scope="col" class="text-center" style="width:5%">번호</th>
        		    <th scope="col" class="text-center" style="width:65%">제목</th>
       			    <th scope="col" class="text-center" style="width:20%">날짜</th>
       			    <th scope="col" class="text-center" style="width:5%">상태</th>
              	  </tr>
             	</thead>
				<tbody>
		 			<c:if test="${!empty list}">
					<c:forEach var="userPostList" items="${list}" varStatus="status">
					<tr>
						<td class="text-center" style="width:5%"><input type="checkbox" name="checkbox" value="${userPostList.bbsSeq}" class="del-chk" onclick="chkList(${userPostList.bbsSeq});"></td>
						<td class="text-center" style="width:5%"><c:out value="${userPostList.bbsSeq}" /></td>
						<td class="text-center" style="width:65%">
							<a href="javascript:void(0)" onclick="fn_view(${userPostList.bbsSeq})">
							<c:out value="${userPostList.bbsTitle}" />
							</a>
						</td>
						<td class="text-center" style="width:20%">${userPostList.regDate}</td>
						<td class="text-center" style="width:5%">${userPostList.regDate}</td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>	
			</table>
		</div>
<br/>
<nav>
	<ul class="pagination justify-content-center">
		<c:if test="${!empty paging}">
			<c:if test="${paging.prevBlockPage gt 0}">
				<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
				<c:choose>
					<c:when test="${i ne curPage}">
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
				<c:if test="${paging.nextBlockPage gt 0}">
					<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
				</c:if>
		</c:if>
	</ul>
</nav>
   <a class="btn btn-primary"  style="width:60px; height:35px; float:right; text-align;" onclick="chkDeleteClick();">삭제</a>
   <br/>
 	  <form name="bbsForm" id="bbsForm" method="post">
     	 <input type="hidden" id="bbsSeq" name="bbsSeq" value="" />
     	 <input type="hidden" id="curPage" name="curPage" value="${curPage}" />
  	 </form>
  	 
  	 			</div>
  	 			
			</div>
		</div>
	</div>			
</section>

<!-- 리뷰 -->
<!-- 본문 -->
<c:if test="${user.userClass eq 'N'}">
<section class="user-dashboard page-wrapper" style="padding-top: 0px;">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        


	  <div class="dashboard-wrapper user-dashboard">
		<h3>후기게시판</h3>
    
		<div class="checkbox_group">
			<table class="table table-hover" border="2" bordercolor="#ADD8E6">
				<thead>
               	 <tr style="background-color: #4397CF;">
                    <th scope="col" class="text-center" style="width:5%"><input type="checkbox" class="chk_all2"></th>
         			<th scope="col" class="text-center" style="width:5%">번호</th>
        		    <th scope="col" class="text-center" style="width:15%">제목</th>
        		    <th scope="col" class="text-center" style="width:55%">내용</th>
       			    <th scope="col" class="text-center" style="width:15%">날짜</th>
       			    <th scope="col" class="text-center" style="width:5%">비고</th>
              	  </tr>
             	</thead>
				<tbody>
		 			<c:if test="${!empty list2}">
					<c:forEach var="userReviewPostList" items="${list2}" varStatus="status">
					<tr>
						<td class="text-center" style="width:5%"><input type="checkbox" name="checkbox2" value="${userReviewPostList.rsrvSeq}" class="del-chk2" onclick="chkList2(${userReviewPostList.rsrvSeq});"></td>
						<td class="text-center" style="width:5%"><c:out value="${userReviewPostList.rsrvSeq}" /></td>
						<td class="text-center" style="width:15%">
							<c:out value="${userReviewPostList.bbsTitle}" />
						</td>
						<td style="width:55%"><c:out value="${userReviewPostList.bbsContent}" /></td>
						<td class="text-center" style="width:20%">${userReviewPostList.regDate}</td>
						<td class="text-center" style="width:5%"><a href="/review/reviewUpdate?rsrvSeq=${userReviewPostList.rsrvSeq}" class="btn btn-default">수정</a></td>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>	
			</table>
		</div>
<br/>
<nav>
	<ul class="pagination justify-content-center">
		<c:if test="${!empty paging2}">
			<c:if test="${paging2.prevBlockPage gt 0}">
				<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list2(${paging2.prevBlockPage})">이전블럭</a></li>
			</c:if>
			<c:forEach var="i" begin="${paging2.startPage}" end="${paging2.endPage}">
				<c:choose>
					<c:when test="${i ne curPage2}">
						<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list2(${i})">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
				<c:if test="${paging2.nextBlockPage gt 0}">
					<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list2(${paging2.nextBlockPage})">다음블럭</a></li>
				</c:if>
		</c:if>
	</ul>
</nav>
   <a class="btn btn-primary"  style="width:60px; height:35px; float:right; text-align;" onclick="chkReviewDeleteClick();">삭제</a>
   <br/>
 	  <form name="reviewForm" id="reviewForm" method="post">
     	 <input type="hidden" id="rsrvSeq" name="rsrvSeq" value="" />
     	 <input type="hidden" id="curPage2" name="curPage2" value="${curPage2}" />
  	 </form>
  	 
  	 			</div>
  	 			
			</div>
		</div>
	</div>			
</section>
</c:if>
<input type="hidden" id="userClass" name="userClass" value="${user.userClass}" />
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

  </body>
  </html>