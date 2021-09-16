<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" >
$(document).ready(function(){   

	$("#searchValue").on("keypress", function(e){
      
      if(e.which == 13)
      {   
         document.eventForm.bbsSeq.value = "";
         document.eventForm.searchStatus.value = $("#searchStatus").val();
         document.eventForm.searchType.value = $("#searchType").val();
         document.eventForm.searchValue.value = $("#searchValue").val();
         document.eventForm.curPage.value = "1";
         
         document.eventForm.action = "/event/list";
         document.eventForm.submit();
      }
    });
	
	
   $("#btnSearch").on("click", function(){
      
      document.eventForm.bbsSeq.value = "";
      document.eventForm.searchStatus.value = $("#searchStatus").val();
      document.eventForm.searchType.value = $("#searchType").val();
      document.eventForm.searchValue.value = $("#searchValue").val();
      document.eventForm.curPage.value = "1";
      
      document.eventForm.action = "/event/list";
      document.eventForm.submit();
   });
   
   //카페이름 클릭시 해당 게시글만 보여주는 [김호준]
   
   //한잔 이벤트
   $("#btnCafeHanzan").on("click", function(){
      document.eventForm.bbsSeq.value = "";
      document.eventForm.searchType.value = "1";
      document.eventForm.searchValue.value = "cafeHanzan"
      document.eventForm.curPage.value = "1";
      document.eventForm.action = "/event/list"; 
      document.eventForm.submit();
   });
   
   //카페도넛 이벤트
   $("#btnCafeDonut").on("click", function(){
      document.eventForm.bbsSeq.value = "";
      document.eventForm.searchType.value = "1";
      document.eventForm.searchValue.value = "cafeDonut"
      document.eventForm.curPage.value = "1";
      document.eventForm.action = "/event/list"; 
      document.eventForm.submit();
   });
   
   //카페노네임 이벤트
   $("#btnCafeNoname").on("click", function(){
      document.eventForm.bbsSeq.value = "";
      document.eventForm.searchType.value = "1";
      document.eventForm.searchValue.value = "cafeNoname"
      document.eventForm.curPage.value = "1";
      document.eventForm.action = "/event/list"; 
      document.eventForm.submit(); 
   });
   
   //카페담다 이벤트
   $("#btnCafeDamda").on("click", function(){
      document.eventForm.bbsSeq.value = "";
      document.eventForm.searchType.value = "1";
      document.eventForm.searchValue.value = "cafeDamda"
      document.eventForm.curPage.value = "1";
      document.eventForm.action = "/event/list"; 
      document.eventForm.submit();

   });
   

   //게시물 작성 버튼 [김호준] -> 근데 이거 나중에 관리자만 작성가능하게 처리 그거 해줘야돼 !
   $("#btnWrite").on("click", function(){
      document.eventForm.bbsSeq.value = "";
      document.eventForm.action = "/event/writeForm";
      document.eventForm.submit();
   });
   
   
   //Public 업데이트 버튼
   $("#btnPublicUpdate").on("click", function(){
      var today = new Date();
      var year = today.getFullYear();
      var month = ('0' + (today.getMonth() + 1)).slice(-2);
      var day = ('0' + today.getDate()).slice(-2);
      var dateString = year + month + day;
      
      document.eventForm.action = "/event/eventPublicUpdateProc";
      document.eventForm.submit();
      
      alert("이벤트 종료일에 따른 공개여부 업데이트가 완료되었습니다.");
   });
});   

function eventBoardDetail(bbsSeq)
{
   document.eventForm.bbsSeq.value = bbsSeq;
   document.eventForm.action = "/event/view";
   document.eventForm.submit();
}

function fn_list(curPage)
{
   document.eventForm.bbsSeq.value = "";
   document.eventForm.curPage.value = curPage;
   document.eventForm.action = "/event/list";
   document.eventForm.submit();   
}

</script>

</head>


<body id="body">

<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 
<!-- 페이지 헤드 메뉴 시작 -->
<div class="user-dashboard page-wrapper page-header" style="margin-bottom:-15px;">
   <div class="container">
      <div class="d-flex">
         <div class="logo text-left" style="margin-top:-20px;" >
            <a href="/event/list"><img src="/resources/images/event.png" alt="이벤트 타이틀 이미지" height="80" /></a>
            <div class="ml-auto input-group" style="width:auto; display:inline-block; float:right; margin-top:60px;">
               <select id="searchStatus" name="searchStatus" class="form-control" style="width:auto; height:50px;">
                  <option value="">이벤트 진행 상태</option>
                  <option value="Y" <c:if test="${searchStatus =='Y'}">selected</c:if>>진행중 이벤트</option>
                  <option value="N" <c:if test="${searchStatus =='N'}">selected</c:if>>종료된 이벤트</option>
               </select>
               <select id="searchType" name="searchType" class="form-control" style="width:auto; height:50px;">
                  <option value="">검색타입</option>
                  <option value="1" <c:if test="${searchType == '1'}">selected</c:if>>작성자</option>
                  <option value="2" <c:if test="${searchType == '2'}">selected</c:if>>제목</option>
                  <option value="3" <c:if test="${searchType == '3'}">selected</c:if>>내용</option>
               </select>
               <input type="text" name="searchValue" id="searchValue" class="form-control me-sm-2" style="width:300px; height:50px; font-size:15px;" placeholder="내용을 입력하세요" value="${searchValue}">
               <a id="btnSearch" class="btn btn-main mb-3 mx-1" style="text-align:left; height:50px; font-size:15px; margin-left:.10rem; padding-top:12px;">조회</a>
            </div>
            <!-- 로고 하단 이동 태그 -->
            <ol class="breadcrumb" id="breadcrumb"> 
               <li><a href="/event/list">전체</a></li>
               <li><a href="#" id="btnCafeHanzan">카페한잔</a></li>
               <li><a href="#" id="btnCafeDonut">카페도넛</a></li>
               <li><a href="#" id="btnCafeNoname">노네임</a></li>
               <li><a href="#" id="btnCafeDamda">카페담다</a></li>
               <c:forEach var="board" items="${eventBoard}" varStatus="status">
            <c:out value="${board.bbsSeq}" />
            <li id="${event.bbsSeq}">${board.userId}</li>                  
            </c:forEach>   
            </ol>     
            </div>   
       </div>       
   </div>
</div>

<!-- 게시판 시작[김호준] -->

<div class="container">
   <div class="row">
      <c:if test="${!empty list}">
         <c:forEach items="${list}" var="eventBoard" varStatus="status">
            <div class="col-md-6">
                 <div class="post">
                   <div class="post-thumb">
                     <a>
                        <c:if test="${eventBoard.bbsPublic eq 'Y'}">
                           <c:if test="${eventBoard.fileName ne ''}">
                              <img class="img-responsive" src="/resources/upload/event/${eventBoard.fileName}" style="overflow:auto; width:600px; height:400px;" alt="/resources/images/avater.jpg" >
                           </c:if>
                           
                           <c:if test="${eventBoard.fileName eq ''}">
                              <img class="img-responsive" src="/resources/upload/event/No-Image.png" style="overflow:auto; width:600px; height:400px;" alt="/resources/images/avater.jpg" >
                           </c:if>
                        </c:if>
                        
                        
                        <c:if test="${eventBoard.bbsPublic eq 'N'}"> 
                           <c:if test="${eventBoard.fileName ne ''}">
                              <img class="img-responsive" src="/resources/upload/event/${eventBoard.fileName}" style="position:absolute; z-index:1; overflow:auto; width:555px; height:400px;" alt="/resources/images/avater.jpg" >
                              <img class="img-responsive" src="/resources/images/event/end.png" style="position:relative; z-index:100; overflow:auto; width:600px; height:400px;" alt="/resources/images/avater.jpg" >
                           </c:if>
                           
                           <c:if test="${eventBoard.fileName eq ''}">
                              <img class="img-responsive" src="/resources/images/event/end.png" style="overflow:auto; width:600px; height:400px;" alt="/resources/images/avater.jpg" >
                           </c:if>
                        </c:if>
                     </a>
                   </div>

                   <h2 class="post-title" style="color: #4397CF; font-weight:700; font-size: 24px;"><a href="javascript:void(0)" onclick="eventBoardDetail(${eventBoard.bbsSeq})">${eventBoard.bbsTitle}</a></h2>
                                      
                   <div class="post-meta">
                     <ul>
                       <li style="font-size: 13px;">
                         <i class="tf-ion-ios-contact"></i>${eventBoard.userName}
                       </li>
                       <li style="font-size: 13px;">
                         <i class="tf-ion-ios-contact"></i>${eventBoard.userId}
                       </li>
                       <li style="font-size: 13px;">
                         <c:set var="evtOpnDate" value="${eventBoard.evtOpnDate}" />
                         <i class="tf-ion-ios-calendar-outline"></i>&nbsp;${fn:substring(evtOpnDate,0,10)} 
              		   </li>
              		   
                       <li style="font-size: 13px;">
                          -
                       </li>
                       
                       <li style="font-size: 13px;">
                         <c:set var="evtClsDate" value="${eventBoard.evtClsDate}" />
                         <i class="tf-ion-ios-calendar-outline"></i>&nbsp;${fn:substring(evtClsDate,0,10)}
                       </li>
                       
                   	   <li style="font-size: 13px;">
                         <i class="tf-ion-eye"></i>${eventBoard.bbsReadCnt}
                       </li>
                     </ul>
                   </div>

                   <div class="post-content" >      
                      <c:set var="contentLength" value="${fn:length (eventBoard.bbsContent)}" />
                      <c:choose>
                         <c:when test="${contentLength >= 31}">
                            <p style="overflow:auto; width:515px; height:30px; font-size: 17px;"><c:set var="Content" value="${eventBoard.bbsContent}" />${fn:substring(Content,0,31)} . .</p>
                         </c:when>
                         <c:otherwise>
                            <p style="overflow:auto; width:515px; height:30px; font-size: 17px;"><c:set var="Content" value="${eventBoard.bbsContent}" /> ${fn:substring(Content,0,31)}</p>
                         </c:otherwise>
                      </c:choose>
                        <a href="javascript:void(0)" onclick="eventBoardDetail(${eventBoard.bbsSeq})" class="btn btn-main" style="position:relative; padding-top:7.5px; width:300px; height:38px; left:105px; font-size: 15px;">자세히 보기</a>
                   </div>
               </div>
              </div>
         </c:forEach>
      </c:if>
   </div>
</div>

<!-- 게시판 끝[김호준] -->

<!--  글쓰기 버튼 --> 
<div class="text-center" style="position: relative; ">
   <c:if test="${boardClass eq 'Y'}">
       <a href="/event/writeForm" class="btn btn-main " style="height: 4.5rem; width: 45 rem; left: 600 px; ">게시글 작성</a>
    </c:if>
</div>
   
<!--  페이징처리하기 -->
<div class="ml-auto input-group" style="width:auto; margin: 0 auto;">
   <ul class="pagination justify-content-center">
      <c:if test="${!empty paging}">
         <c:if test="${paging.prevBlockPage gt 0}">
            <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">Prev</a></li>
         </c:if>
         <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
            <c:choose>
               <c:when test="${i ne curPage}">
                  <li class="page-item"><a class="page-link" href="javascript:void(0)"  onclick="fn_list(${i})">${i}</a></li>
               </c:when>
               <c:otherwise>
                  <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor:default;">${i}</a></li>
               </c:otherwise>
            </c:choose>
         </c:forEach>   
         
         <c:if test="${paging.nextBlockPage gt 0}">   
            <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">Next</a></li>
         </c:if>   
      </c:if>
   </ul>
</div>


<form name="eventForm" id="eventForm" method="post">
   <input type="hidden" name="bbsSeq" value="" id="bbsSeqTest" />
   <input type="hidden" name="searchStatus" value="${searchStatus}" id="searchStatusTest" />
   <input type="hidden" name="searchType" value="${searchType}" id="searchTypeTest" />
   <input type="hidden" name="searchValue" value="${searchValue}" id="searchValueTest" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>

<form name="searchForm" id="searchForm" method="post">
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />         
</form>
   
   
   
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   
</body>
</html>