<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BEST</title>
<!-- side-bar CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="resources/css/simplebar.css" rel="stylesheet"/>
<link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="resources/css/app-style.css" rel="stylesheet"/>
<link href="resources/css/sidebar-menu.css" rel="stylesheet"/>
<link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
<!-- side-bar JS -->
<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
<script src="resources/js/sidebar-menu.js"></script>
<script src="resources/js/simplebar.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
</head>

<body>
   <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
     <div class="brand-logo">
      <a href="main.go">
       <h4><span style="color:#E9396B;">BEST</span></h4>
       <h5 class="logo-text"><span style="color:#E9396B;">B</span>us <span style="color:E9396B;">E</span>mployee 
       <span style="color:#E9396B;">S</span>ervice <span style="color:#E9396B;">T</span>ool</h5>
     </a>
   	</div>
   	<div class="member-profile">
   		<div class="profile-photo"></div>
   		<ul>
   			<li> 촉촉이 / 대리
   			</li>
   			<li> chockchock@gmail.com
   			</li>
   		</ul>
   	</div>
   <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header"></li>
      <li>
        <a href="main.go">
          <i class="mdi mdi-view-dashboard"></i> <span>대쉬보드</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
      <li>
        <a href="attendance.go">
          <i class="bi bi-clock-fill"></i> <span>근태관리</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
      <li class="dropD">
        <a href="calendar.go">
          <i class="fa-regular fa-calendar-check"></i> <span>캘린더</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
      <li class="dropD">
        <a href="javaScript:void(0);">
          <i class="bi bi-bus-front-fill"></i> <span>버스정보</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
    		<li class="dropD-item">
      			<a href="driveInfo.go">
        			<i class="fa-solid fa-road"></i> <span>운행현황</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
    		</li>
    		<li class="dropD-item">
      			<a href="busDispatch.go">
        			<i class="fa-solid fa-user-tie"></i> <span>배차현황</span>
 					<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
   			<li class="dropD-item">
      			<a href="busDetail.go">
        			<i class="bi bi-bus-front"></i> <span>버스관리</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
        </ul>
      </li>
      
      <li>
        <a href="javaScript:void(0);">
          <i class="bi bi-chat-left-text-fill"></i> <span>메신져</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
	  <li class="dropD">
  		<a href="javaScript:void(0);">
    		<i class="bi bi-envelope-fill"></i> <span>메일함</span>
    		<i class="fa-solid fa-angle-right"></i>
  		</a>
  		<ul class="dropD-menu">
    		<li class="dropD-item">
      			<a href="mail.go">
        			<i class="bi bi-envelope-paper-fill"></i> <span>받은 메일함</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
    		</li>
    		<li class="dropD-item">
      			<a href="javaScript:void(0);">
        			<i class="bi bi-send"></i> <span>보낸 메일함</span>
 					<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
   			<li class="dropD-item">
      			<a href="javaScript:void(0);">
        			<i class="bi bi-envelope-exclamation-fill"></i> <span>임시저장</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
    		<li class="dropD-item">
      			<a href="javaScript:void(0);">
        			<i class="bi bi-trash-fill"></i> <span>휴지통</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
  		</ul>
	</li>
      
      
      <li class="dropD">
  		<a href="javaScript:void();">
          <i class="fa-regular fa-clipboard"></i> <span>결재문서</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
    		<li class="dropD-item">
      			<a href="documentBoard.go">
        			<i class="bi bi-file-text-fill"></i> <span>진행 중</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
    		</li>
    		<li class="dropD-item">
      			<a href="documentApproved.go">
        			<i class="bi bi-file-earmark-check-fill"></i> <span>완료</span>
 					<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
   			<li class="dropD-item">
      			<a href="documentDraft.go">
        			<i class="bi bi-file-earmark-arrow-up-fill"></i> <span>임시저장</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
    		<li class="dropD-item">
      			<a href="documentReject.go">
        			<i class="bi bi-file-earmark-break-fill"></i> <span>반려 문서</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
  		</ul>
  		
      </li>

      <li>
        <a href="orgChart.go">
          <i class="bi bi-diagram-3-fill"></i> <span>조직도</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>

       <li class="dropD">
        <a href="javaScript:void();">
          <i class="bi bi-layout-text-window-reverse"></i> <span>게시판</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
    		<li class="dropD-item">
      			<a href="noticeBoard.go">
        			<i class="bi bi-megaphone-fill"></i> <span>공지사항</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
    		</li>
    		<li class="dropD-item">
      			<a href="freeBoard.go">
        			<i class="bi bi-window-stack"></i> <span>자유 게시판</span>
 					<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
          </ul>
      </li>
      
      
    <li class="dropD">
        <a href="javaScript:void(0);">
          <i class="fa-regular fa-calendar-check"></i> <span>회의실</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
     
        <ul class="dropD-menu">
    		<li class="dropD-item">
      			<a href="meetingRoomCalendar.do">
        			<i class="bi bi-file-text-fill"></i> <span>회의실 예약</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
    		</li>
    		<li class="dropD-item">
      			<a href="myReserve.go">
        			<i class="bi bi-file-earmark-check-fill"></i> <span>내 예약 현황</span>
 					<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
   			<li class="dropD-item">
      			<a href="roomInfo.go">
        			<i class="bi bi-file-earmark-arrow-up-fill"></i> <span>회의실 정보</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
  		</ul>
	</li>
	
	
      <!-- 관욱수정 2024.12.12 시작 -->
      <li class="dropD">
      	  <a href="javaScript:void();">
            <i class="bi bi-person-vcard"></i> <span>사원관리</span>
            <i class="fa-solid fa-angle-right"></i>
          </a>
      
	      <ul class="dropD-menu">
	    		<li class="dropD-item">
	      			<a href="empList.go">
			          <i class="bi bi-person-vcard"></i> <span>사원목록</span>
			          <i class="fa-solid fa-angle-right"></i>
			        </a>
	   			</li>
	    		<li class="dropD-item">
	      			<a href="empCreate.go">
			          <i class="bi bi-person-vcard"></i> <span>사원등록</span>
			          <i class="fa-solid fa-angle-right"></i>
			        </a>
	   			</li>
	        </ul>
      	</li>
      	
      	<!-- 관욱수정 2024.12.12 끝 -->
       <li class="dropD">
        <a href="javaScript:void();">
          <i class="bi bi-bar-chart-fill"></i> <span>매출현황</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
    		<li class="dropD-item">
      			<a href="javaScript:void();">
        			<i class="bi bi-bar-chart-fill"></i> <span>월별현황</span>
 					<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
   			<li class="dropD-item">
      			<a href="javaScript:void();">
        			<i class="bi bi-graph-up"></i> <span>연별현황</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
   			<li class="dropD-item">
      			<a href="javaScript:void();">
        			<i class="bi bi-file-earmark-bar-graph-fill"></i> <span>매출등록</span>
        			<i class="fa-solid fa-angle-right"></i>
      			</a>
   			</li>
        </ul>
      </li>
      
       <li>
        <a href="javaScript:void();">
          <i class="bi bi-wallet-fill"></i> <span>지출정산</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
       <li>
        <a href="javaScript:void();">
          <i class="fa-solid fa-video"></i> <span>CCTV</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>

      <li class="sidebar-header"></li>
      <li>
      <a href="javaScript:void(0);">
      	<i class="fa-regular fa-bell"></i> <span>알림</span>
      	<i class="fa-solid fa-angle-right"></i>
      	</a>
      </li>
      <li>
      <a href="javaScript:void(0);">
      	<i class="bi bi-person-fill-gear"></i> <span>내 정보관리</span>
      	<i class="fa-solid fa-angle-right"></i>
      	</a>
      </li>
      <li>
      	<a href="javaScript:void(0);"><i class="fa-solid fa-right-to-bracket"></i> <span>로그아웃</span>
      	<i class="fa-solid fa-angle-right"></i>
      	</a>
      </li>

    </ul>
   
   </div>

<header class="topbar-nav">
 <nav class="navbar navbar-expand fixed-top">
  <ul class="navbar-nav mr-auto align-items-center">
    <li>
		<div class="work-time">
   			<i class="bi bi-clock-history"></i>
   			<button>출근</button>
   		</div>
    </li>
  </ul>
     
  <ul class="navbar-nav align-items-center right-nav-link">
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="fa fa-envelope-open-o"></i></a>
    </li>
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="fa fa-bell-o"></i></a>
    </li>
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="bi bi-person-circle"></i>
      </a>
    </li>
  </ul>
</nav>
</header>
<script>
	
</script>

</body>

</html>