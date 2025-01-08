<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BEST</title>
<!-- side-bar CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="resources/css/simplebar.css" rel="stylesheet" />
<link href="resources/css/bootstrap.min.css" rel="stylesheet" />
<link href="resources/css/app-style.css" rel="stylesheet" />
<link href="resources/css/sidebar-menu.css" rel="stylesheet" />
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<!-- side-bar JS -->
<script>
</script>
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<script src="resources/js/simplebar.js"></script>
<!-- <script src="resources/js/bootstrap.min.js"></script> -->
</head>
<style>
.btn-finish-work {
	display: none;
}
.work-time {
	width: 100%;
}
.spanAction span {
	display: none;
	width: 30%;
	margin: 0 0 0 14px;
}
.spanAction {
	width: 45%;
	display: none;
}
</style>

<body>
	<div id="sidebar-wrapper" data-simplebar=""
		data-simplebar-auto-hide="true">
		<div class="brand-logo">
			<a href="accessManage.go">
				<h4>
					<span style="color: #E9396B;">BEST</span>
				</h4>
				<h5 class="logo-text">
					<span style="color: #E9396B;">B</span>us <span
						style="color: E9396B;">E</span>mployee <span
						style="color: #E9396B;">S</span>ervice <span
						style="color: #E9396B;">T</span>ool
				</h5>
			</a>
		</div>
		<div class="member-profile">
			<i class="fas fa-user-shield"></i> 
			<ul class="user-Info">
				<li><strong>관리자 계정</strong></li>
				<li></li>
			</ul>
		</div>
		<ul class="sidebar-menu do-nicescrol">
			<li class="sidebar-header"></li>

			<!-- 관욱추가 시작 2025.01.05 -->
			<li><a href="accessManage.go"> 
			    <i class="bi bi-shield-check"></i> 
			    <span>권한관리</span> 
			    <i class="fa-solid fa-angle-right"></i>
			</a></li>
			<!-- 관욱추가 끝 2025.01.05 -->
			
			
			<li>
				<a href="logout.do">
				<i class="fa-solid fa-right-to-bracket"></i>
			 		<span>로그아웃</span> 
				<i class="fa-solid fa-angle-right"></i> </a>
			</li>

		</ul>

	</div>

<script>


</script>


</body>

</html>