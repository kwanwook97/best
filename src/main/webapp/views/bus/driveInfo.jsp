<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <link href="resources/css/driveInfo.css" rel="stylesheet"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=22a285f2d102273ceeee6ef0345b540c"></script>
  <script src="resources/js/driveInfo.js"></script>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <style>

</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="body">
 		<!-- 페이지 경로정보 -->
 		<div class="navbus-info">
		<div class="naviPath bold f32 w100 tm2">
			<span class="lPurple">버스정보</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
			<span class="cPurple">운행현황</span>
		</div>
			<div class="bus-drive-info bold f32 w100">
				
			</div>
		</div>
		<div class="content">		
			<!-- 운행정보 -->
			<div class="bus-info-container lContent f16">
			
				<div class="bus-info">
					<c:forEach var="route" items="${info}">
					<div class="bus-header">
    					<div class="bus-main-info">
								<div>
    								<c:choose>
										<c:when test="${fn:length(route.route_name) == 3}">
      										<span class="bus-number f48 cBlue">${route.route_name}</span>
  										</c:when>
										<c:when test="${fn:length(route.route_name) == 4}">
      										<span class="bus-number f48 cGreen">${route.route_name}</span>
  										</c:when>
  										<c:otherwise>
                							<span class="bus-number f48 cRed">Invalid Data: ${route.route_name}</span>
            							</c:otherwise>
									</c:choose>
								</div>
								<input type="hidden" value="${route.bus_id}" />
  							<div class="route-header">
  								<div class="route-summary">
  								
  								</div>
								<div class="route-summary total">
  								
 								</div>
 							</div>
        				</div>
    				</div>
					</c:forEach>
				</div>
				
			<div id="map" class="bus-map">
			
			</div>	
			<div class="bus-api-container rContent">
			
			</div>
		</div>
	</div>
</body>
<script>

</script>
</html>
