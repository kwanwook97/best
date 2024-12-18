<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="resources/css/busDispatch.css" rel="stylesheet"/>
  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath bold f32 w100 tm2">
		<span class="lPurple">버스정보</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
		<span class="purple">배차현황</span>
		<div class="bus-drive-info">
				
		</div>
	</div>
	<div class="date-navigation">
      <div class="date-content">
        <button class="date-button"><i class="fas fa-angle-double-left"></i></button>
        <button class="date-button"><i class="fas fa-angle-left"></i></button>
        <span class="current-date">2024-12-05</span>
        <button class="date-button"><i class="fas fa-angle-right"></i></button>
        <button class="date-button"><i class="fas fa-angle-double-right"></i></button>
      </div>
      <div class="search-bar-container">
        <input type="text" class="search-bar" placeholder="검색"> 
        <i class="fas fa-search search-icon"></i>
      </div>
    </div>
    <div class="body-content">
    <div class="dispatch-insert">
    	<form action="dispatchInsert.do">
  <div class="body2">
    <div class="content">
      <div class="bus-info-subject bold purple"><span>배차 등록</span></div>
      <div class="bus-info-card">
       	<div class="bus-details">
       	<input type="hidden" name="bus_idx" value="" />
       		<ul>
       			<li><strong>노선 번호:</strong> 
       			<span><input type="text" name="bus_route_name" value=""/></span></li>
       			<li><strong>차량 번호:</strong> 
       			<span><input type="text" name="bus_license_plate" value="" readonly/></span></li>
       			<li><strong>운행 기사:</strong> 
       			<span><input type="text" name="bus_fuel_efficiency" value=""/></span></li>
        		<li><strong>운행 날짜:</strong>
    				<span>
        				<input type="date" id="operation_date" name="operation_date"/>
    				</span>
				</li>
       			<li><strong>운행 시간:</strong> 
       				<span>
        				<select class="shift" name="shift">
        					<option value="정상"></option>
        					<option value="정비 중"></option>
        				</select>
        			</span></li>
       		</ul>
        </div>
        <div class="bus-insert-btn">
				<button class="editbtn" type="submit"><i class="far fa-edit"></i>&nbsp;등록</button>
				<button class="editbtn" type="button"><i class="fas fa-eraser"></i>&nbsp;수정</button>
			</div>
       </div>
    </div>
  </div>
</form>
    </div>

    <!-- 버스 목록 -->
    <div class="bus-list">
      <div class="bus-card">
        <div class="bus-number cGreen">5714</div>
        <div class="bus-details">
          <p><strong>현재 운행:</strong> 27</p>
          <p><strong>배차 기사:</strong> 32</p>
        </div>
        <div class="driver-list">
          <span>장희재 기사</span>
        </div>
      </div>
	</div>
    </div>
  </div>
</body>

<script>

</script>
</html>
