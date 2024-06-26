<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qms.user.vo.UserVO"%>
<%
UserVO user =(UserVO)session.getAttribute("QMSUser");
String userName = "";
String userPosition = "";
String userDept = "";

if (user != null) {
	userName = user.getUserName();
    userPosition = user.getComName(); 
    userDept = user.getDeptName(); 
}
%>
<header id="header" class="header fixed-top d-flex align-items-center">

	<div class="d-flex align-items-center justify-content-between">
		<a href="/approve/list" class="logo d-flex align-items-center"><span class="d-none d-lg-block">QMS</span>
		</a> <i class="bi bi-list toggle-sidebar-btn"></i>
	</div>
	<!-- End Logo -->


	<nav class="header-nav ms-auto">
		<ul class="d-flex align-items-center">

			<li class="nav-item d-block d-lg-none"><a class="nav-link nav-icon search-bar-toggle " href="#"> <i class="bi bi-search"></i>
			</a></li>
			<!-- End Search Icon-->

			<li class="nav-item dropdown pe-3"><a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown"> 
			<span class="d-none d-md-block dropdown-toggle ps-2"><%= userName %>(<%= userPosition %>)</span>
			</a>
			<!-- End Profile Iamge Icon -->

				<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
					<li class="dropdown-header">
						<h6><%= userName %></h6> <span><%= userDept %></span>
					</li>
					<li>
						<hr class="dropdown-divider">
					</li>


					<li><a class="dropdown-item d-flex align-items-center" href="users-profile.html"> <i class="bi bi-gear"></i> <span>계정 설정</span>
					</a></li>
					<li>
						<hr class="dropdown-divider">
					</li>

					<li>
						<hr class="dropdown-divider">
					</li>

					<li><a class="dropdown-item d-flex align-items-center" href="#" onclick="logout();"> <i class="bi bi-box-arrow-right"></i> <span>로그아웃</span>
					</a></li>

				</ul>
				<!-- End Profile Dropdown Items --></li>
			<!-- End Profile Nav -->

		</ul>
	</nav>
	<!-- End Icons Navigation -->

</header>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

	<ul class="sidebar-nav" id="sidebar-nav">

		<li class="nav-item"><a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" > <i class="bi bi-menu-button-wide"></i><span>전자결재</span><i class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="components-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
				<li><a href="/approve/list" > <i class="bi bi-circle"></i><span>기안서 조회</span>
				</a></li>
				<li><a href="/approve/write"> <i class="bi bi-circle"></i><span>기안서 작성</span>
				</a></li>
				<li><a href="/board/list"> <i class="bi bi-circle"></i><span>공지사항</span>
				</a></li>

			</ul></li>
		<!-- End Components Nav -->

		<li class="nav-item"><a class="nav-link " data-bs-target="#forms-nav" data-bs-toggle="collapse" > <i class="bi bi-journal-text"></i><span>자재관리</span><i class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="forms-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
				<li><a href="/item/list"> <i class="bi bi-circle"></i><span>제품관리</span>
				</a></li>
				<li><a href="/item/bomlist"> <i class="bi bi-circle"></i><span>BOM 조회</span>
				</a></li>
				<li><a href="/partner/list"> <i class="bi bi-circle"></i><span>거래처 자재 관리</span>
				</a></li>
			</ul></li>
		<!-- End Forms Nav -->

		<li class="nav-item"><a class="nav-link collapsed" data-bs-target="#tables-nav" data-bs-toggle="collapse" > <i class="bi bi-layout-text-window-reverse"></i><span>입고관리</span><i class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="tables-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
				<li><a href="/receive/list"> <i class="bi bi-circle"></i><span>입고 등록</span>
				</a></li>
				<li><a href="/receive/list"> <i class="bi bi-circle"></i><span>입고 조회</span>
				</a></li>
				<li><a href="/inventory/list"> <i class="bi bi-circle"></i><span>재고 조회</span>
				</a></li>
				<li><a href="/receive/stuff"> <i class="bi bi-circle"></i><span>입고 품목 조회</span>
				</a></li>
			</ul></li>
		<!-- End Tables Nav -->  
		<li class="nav-item"><a class="nav-link collapsed" data-bs-target="#charts-nav" data-bs-toggle="collapse" > <i class="bi bi-bar-chart"></i><span>주문관리</span><i class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="charts-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
				<li><a href="/partner/list"> <i class="bi bi-circle"></i><span>거래처 주문관리</span>
				</a></li>
				<li><a href="#"> <i class="bi bi-circle"></i><span>무상입고 관리</span>
				</a></li>
				<li><a href="/order/list"> <i class="bi bi-circle"></i><span>자재 주문</span>
				</a></li>
				<li><a href="#"> <i class="bi bi-circle"></i><span>자재 무상입고</span>
				</a></li>
			</ul></li>
		<!-- End Charts Nav -->
		
	
		<li class="nav-item"><a class="nav-link collapsed" data-bs-target="#icons-nav" data-bs-toggle="collapse" > <i class="bi bi-gem"></i><span>생산관리</span><i class="bi bi-chevron-down ms-auto"></i>
		</a>
			<ul id="icons-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
				<li><a href="/plan/list"> <i class="bi bi-circle"></i><span>생산계획관리</span>
				</a></li>
				<li><a href="/plan/mkPlan"> <i class="bi bi-circle"></i><span>생산계획보기</span>
				</a></li>
				<li><a href="/product/list"> <i class="bi bi-circle"></i><span>생산 실적 조회</span>
				</a></li>
				<li><a href="/product/use"> <i class="bi bi-circle"></i><span>완제품 생산 소요량 조회</span>
				</a></li>
			</ul></li>
			
		<!-- End Icons Nav -->
		
				<li class="nav-item">
		    <a class="nav-link collapsed" data-bs-target="#systems-nav" data-bs-toggle="collapse" >
		        <i class="bi bi-stack"></i><span>시스템관리</span><i class="bi bi-chevron-down ms-auto"></i>
		    </a>
		    <ul id="systems-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
		        <li><a href="/partner/list"><i class="bi bi-circle"></i><span>거래처 관리</span></a></li>
		        <li><a href="/user/list"><i class="bi bi-circle"></i><span>사용자 관리</span></a></li>
		        <li><a href="/dept/list"><i class="bi bi-circle"></i><span>부서 관리</span></a></li>
		    </ul>
		</li>

	</ul>

</aside>
<!-- End Sidebar-->
 <form id='logoutform'>
 
  </form>
  
  <script>
    function logout(){
  		call_server(logoutform, "/logout", chkLogOut);
  	}
  	
  	function chkLogOut(){
  		location.href='/login';
  	}
  	
  	</script>