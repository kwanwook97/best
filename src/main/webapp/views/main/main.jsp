<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <link href="resources/css/dashBoard.css" rel="stylesheet"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="header.jsp"></jsp:include>
 	<div class="dashboard-body">
 		<div class="dash-profile">
 		<div class="user-profile"></div>
 		<ul>
 			<li style="font-size:20px; font-weight:400;">촉촉이 대리</li>
 			<li style="color: #8B6AA7;">운영 3팀</li>
 		</ul>
 		<ul class="sidebar-menu">
 			<li>
 				<a href="#">
          			<i class="fa-regular fa-clipboard"></i> <span>결재 할 문서</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 			<li>
 				<a href="#">
          			<i class="bi bi-envelope-fill"></i><span>새로운 메일</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 			<li>
 				<a href="#">
          			<i class="bi bi-chat-left-text-fill"></i> <span>새로운 메시지</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 		</ul>
 	</div>
 	<div class="drive-info">
 		<div class="drive-info2"><span>현재 운행 정보</span></div>
 		<div class="drive-info3"> 		
 			<div class="drive-info4"><span>5714</span></div>
 			<div>
 				<ul>
 					<li><span>현재 운행 : </span><span>30</span></li>
 					<li><span>배차 간격 : </span><span>10 ~ 15</span></li>
 				</ul>
 			</div>
 		</div>
 	</div>
 	<div class="year-graph">
 		<div><span>연간 매출</span></div>
 		<div class="year-graph2">
 			<div>
 				<div class="year-graph3"></div><span>1월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>2월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>3월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>4월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>5월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>6월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>7월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>8월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>9월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>10월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>11월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>12월</span>
 			</div>
 		</div>
 	</div>
 	<div class="dash-calendar">
 	
 	</div>
 	<div class="todoList">
 		<div><span>To Do List!</span></div>
 		<div class="todoList2"></div>
 	</div>
 	<div class="road-info">
 		<div><span>오늘의 교통 정보</span></div>
 		<div>
 			<ul>
 				<li><span>2024년 12월 04일 13시 58분</span></li>
 				<li><span>[사고] 올림픽대로성수대교영동대교3차로교통사고</span></li>
 			</ul>
 		</div>
 	</div>
 	<div class="iPhone">
 	
 	</div>
</div>
</body>
<script>

</script>
</html>
