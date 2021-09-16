<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
function viewIndex()
{
	window.open("/index");
}
</script>

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/admin/index">
               
                <div class="sidebar-brand-text mx-3"><img src="/resources/images/logo1.png" alt="image" width="180" height="50" /> </sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="/admin/index">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>메인페이지</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="javascript:void(0)" onclick="viewIndex();">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>사용자페이지로돌아가기</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                사이트 관리
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
           <li class="nav-item">
                <a class="nav-link collapsed" href="" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>회원관리</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">회원관리</h6>
                        <a class="collapse-item" href="/admin/userList">회원리스트</a>
                        <a class="collapse-item" href="/admin/userPoint">회원 포인트</a>                       
                    </div>
                </div>
            </li>
           
           <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>예약 관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">예약 관리</h6>
                        <a class="collapse-item" href="/admin/rsRv">예약 리스트</a>
                        <a class="collapse-item" href="/admin/refund">환불 리스트</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                카페 관리
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="/resources/#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>게시글 관리</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">게시글</h6>                      
                        <a class="collapse-item" href="/admin/notice">공지사항 조회</a>
                        <a class="collapse-item" href="/admin/event">이벤트 조회</a>
                        <a class="collapse-item" href="/admin/review">리뷰 조회</a>
                        <a class="collapse-item" href="/admin/community">커뮤니티 조회</a>
                        <a class="collapse-item" href="/admin/cs">고객센터 조회</a>
                        <!--<a class="collapse-item" href="/resources/1/register.html">Register</a>
                        <a class="collapse-item" href="/resources/1/forgot-password.html">Forgot Password</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="/resources/1/404.html">404 Page</a>
                        <a class="collapse-item" href="/resources/1/blank.html">Blank Page</a>-->
                    </div>
                </div>
            </li>


            <!-- Nav Item - Tables -->
            

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Search -->
                    

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        

                        <!-- Nav Item - Alerts -->
                      

                        <!-- Nav Item - Messages -->
                  

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="/resources/#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">admin</span>
                                <img class="img-profile rounded-circle"
                                    src="/resources/images/undraw_profile.svg">
                            </a>
                            
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->