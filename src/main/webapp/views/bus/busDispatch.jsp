<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="resources/css/bus/busDispatch.css" rel="stylesheet"/>
  <script src="resources/js/bus/busDispatch.js"></script>
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
		<span class="purple">배차관리</span>
		<div class="bus-drive-info">
				
		</div>
	</div>
    <div class="body-content">
    <div class="dispatch-insert">
    <div class="date-navigation">
      <div class="date-content">
        <button class="date-button"><i class="fas fa-angle-double-left"></i></button>
        <button class="date-button"><i class="fas fa-angle-left"></i></button>
        <span class="current-date"></span>
        <button class="date-button"><i class="fas fa-angle-right"></i></button>
        <button class="date-button"><i class="fas fa-angle-double-right"></i></button>
      </div>
    </div>
    	<form id="dispatchForm">
  <div class="body2">
    <div class="content">
      <div class="bus-info-subject bold purple"><span>배차 등록</span></div>
      <div class="bus-info-card">
       	<div class="bus-details">
       	<input type="hidden" name="bus_idx" value="" />
       	<input type="hidden" id="dispatchIdx" name="dispatch_idx" value="" />
       		<ul>
       			<li><strong>노선 번호:</strong> 
       			<span>
        			<select id="routeSelect" name="bus_route_name">
		
        			</select>
    			</span></li>
       			
       			<li><strong>차량 번호:</strong> 
    			<span>
        			<select id="licensePlateSelect" name="bus_license_plate">
        				<option value="">선택</option>
        			</select>
    			</span></li>
       			
       			<li><strong>운행 기사:</strong> 
    			<span>
        			<select id="driverSelect" name="bus_driver_name">
            			<option value="">선택</option>
        			</select>
    			</span>
				</li>
        		
        		<li><strong>운행 날짜:</strong>
    				<span>
        				<input type="date" id="operation_date" name="operation_date"/>
    				</span>
				</li>
				
       			<li><strong>운행 시간:</strong> 
       				<span>
        				<select class="shift" name="shift">
    						<option value="">선택</option>
						</select>
        			</span></li>
       		</ul>
        </div>
        <div class="bus-insert-btn">
				<button class="editbtn" type="submit"><i class="far fa-edit"></i>&nbsp;등록</button>
				<button class="updatebtn" type="submit"><i class="fas fa-eraser"></i>&nbsp;수정</button>
			</div>
       </div>
    </div>
  </div>
</form>
    </div>
    
    <div class="bus-filter">
	<div class="route-filters">
	
	</div>
    <!-- 버스 목록 -->
    <div class="bus-list">
      <div class="bus-card">
      	<table>
      		<thead>
      			<tr>
      				<th>차량 번호</th>
                    <th>첫 차 ~ 14:00</th>
                    <th>14:00 ~ 막차</th>
      			</tr>
      		</thead>
      		<tbody class="list-tbody">
      			
      		</tbody>
      	</table>
      </div>
	</div>
	</div>
	
	
    </div>
  </div>
</body>

<script>


</script>
</html>
