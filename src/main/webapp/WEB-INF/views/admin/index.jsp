<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
.slider img{margin:0 auto;}
</style>

<%@ include file="/WEB-INF/views/include/admin/head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<meta charset="utf-8">
<%@ include file="/WEB-INF/views/include/admin/navigation.jsp" %>
<link href='../lib/main.css' rel='stylesheet' />
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="/path/to/jquery.bxslider.css">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>



</head>

<script>
$(document).ready(function(){
      $('.slider').bxSlider();
    });
</script>


</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                     <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">관리자 페이지</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">
                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                총 예약건수 (Monthly)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${fn:length(list0)}건</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                         <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                총 매출 (Monthly)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><c:set var="total" value="0" />
                                 <c:forEach var="result" items="${list}" varStatus="status">     
                             <c:set var= "total" value="${total + result.totalPrice}"/>
                          </c:forEach>
                          <fmt:formatNumber value="${total}" pattern="#,###" /> 원</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">신규 가입자 (Monthly)
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${fn:length(list5)}명</div>
                                                </div>
                                                <div class="col">
                                                    <div class="progress progress-sm mr-2">
                                                        <div class="progress-bar bg-info" role="progressbar"
                                                            style="width: ${fn:length(list5)}%" aria-valuenow="50" aria-valuemin="0"
                                                            aria-valuemax="100"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                신규 게시글 (Monthly)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${totalCount}개</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    <!-- Content Row -->

                    <div class="row">

                       <!-- Area Chart -->
                        <div class="col-xl-7 col-lg-2">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">내자리얌</h6>                                    
                                </div>
                                <!-- Card Body -->
                                <div class="card-body" style="padding-bottom:66px;">
                                    <div class="card-box m-b-50">
                                            <div id="calendar"></div>
                                        </div>
                                </div>
                                <!-- BEGIN MODAL -->
                                    <div class="modal fade none-border" id="event-modal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title"><strong>Add New Event</strong></h4>
                                                </div>
                                                <div class="modal-body"></div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-success save-event waves-effect waves-light">Create event</button>
                                                    <button type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">Delete</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Modal Add Category -->
                                             
                               </div>
                           </div>

                        <!-- Pie Chart -->
                        <div class="col-xl-5 col-lg-4" >
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">카페별 예약현황 (Monthly)</h6>
                                    
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                     <h4 class="small font-weight-bold">카페 한잔<span
                                            class="float-right">${fn:length(list1)}</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: ${fn:length(list1) / 2}%"   
                                            aria-valuenow="${fn:length(list1)}" aria-valuemin="-500" aria-valuemax="600"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">카페 도넛 <span
                                            class="float-right">${fn:length(list2)}</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${fn:length(list2) / 2}%"
                                            aria-valuenow="${fn:length(list2)}" aria-valuemin="0" aria-valuemax="600"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">노네임 <span
                                            class="float-right">${fn:length(list3)}</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar" role="progressbar" style="width: ${fn:length(list3) / 2}%"
                                            aria-valuenow="${fn:length(list3)}" aria-valuemin="0" aria-valuemax="600"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">카페 담다 <span
                                            class="float-right">${fn:length(list4)}</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: ${fn:length(list4) / 2}%"
                                            aria-valuenow="${fn:length(list4)}" aria-valuemin="0" aria-valuemax="600"></div>
                                    </div>
                                </div>
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">이달의 매출왕</h6>
                                    
                                </div>
                                 <div class="card-body" >
                           <div class="slider">
                            <div>
                              <img src='/resources/images/admin/${list6[0].cafeNum}.png' style="position:absolute; z-index:1;" width="400" height="200" alt="슬라이드 이미지1">
                               <img src='/resources/images/admin/1.png' style="position:relative; z-index:100;" width="400" height="200" alt="슬라이드 이미지2">
                            </div>
                             <div>
                              <img src='/resources/images/admin/${list6[1].cafeNum}.png' style="position:absolute; z-index:1;" width="400" height="200" alt="슬라이드 이미지1">
                               <img src='/resources/images/admin/2.png' style="position:relative; z-index:100;" width="400" height="200" alt="슬라이드 이미지2">
                            </div>
                             <div>
                              <img src='/resources/images/admin/${list6[2].cafeNum}.png' style="position:absolute; z-index:1;" width="400" height="200" alt="슬라이드 이미지1">
                              <img src='/resources/images/admin/3.png' style="position:relative; z-index:100;" width="400" height="200" alt="슬라이드 이미지2">
                            </div>
                             <div>
                              <img src='/resources/images/admin/${list6[3].cafeNum}.png' style="position:absolute; z-index:1;" width="400" height="200" alt="슬라이드 이미지1">
                              <img src='/resources/images/admin/4.png' style="position:relative; z-index:100;" width="400" height="200" alt="슬라이드 이미지2">
                            </div>
					     	 </div>

                                 
                            </div>
                          </div>
                     </div>                        
                 </div>  
         </div>
      </div>

   <script src="/resources/plugins/admin/plugins/common/common.min.js"></script>
    <script src="/resources/js/custom.min.js"></script>
    <script src="/resources/js/settings.js"></script>
    <script src="/resources/js/gleek.js"></script>
    <script src="/resources/js/styleSwitcher.js"></script>
    
    <script src="/resources/plugins/admin/plugins/jqueryui/js/jquery-ui.min.js"></script>
    <script src="/resources/plugins/admin/moment/moment.min.js"></script>
    <script src="/resources/plugins/admin/fullcalendar/js/fullcalendar.min.js"></script>
    <script src="/resources/js/plugins-init/fullcalendar-init.js"></script>  
</body>
</html>