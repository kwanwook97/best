<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
	
	.body {
	    height: 90%;
	    width: 78%;
        margin-top: 110px;
    	margin-left: 320px;
    	margin-right: 100%;
	}


	/* 보라색 배경 */
	.purple {
	    background-color: #30005A;
	    border: 2px solid #30005A;
	    color: white;
	}
	
	/* 보라색 선 + 보라색 글씨 */
	.pLine {
	    border: 2px solid #30005A;
	    color: #30005A;
	    height: 100%;
	}
	
	/* 기본 굵은 글씨 */
	.bold{
		font-weight: bold; 
	}
	
	
  	
  	/* inline-block */
  	.inBlock{
  		display: inline-block;
  		border: 2px solid #30005A;
  		vertical-align: top; /* 상단 정렬 */
  		text-align: center;
  		margin: 10px;
	    border-radius: 10px;
  	}
  	
  	.p25{
  		width: 23%;
  	}
  	
  	.p18{
  		width: 18%;
  	}
  	
  	.m20{
  		margin-right: 15%;
  		margin-top: 15%;
  		margin-bottom: 15%;
  	}
  	
  	.contentTop{
  		height: 30%;
		margin-bottom: 40px;  		
	    display: flex; /* Flexbox 활성화 */
	    justify-content: space-between; /* 요소 간 균등한 간격 유지 */
	    align-items: flex-start; /* 모든 요소를 상단 기준으로 정렬 */
	    /* 요소 사이에 간격 추가 */
	    gap: 10px; 
	    padding: 10px; /* 내부 여백 추가 */
	    box-sizing: border-box;
  		
  	}
  	
  	.contentBottom{
  		border-radius: 10px;
  		height: 55%;
  		margin: 10px;
  	}
	
	
	.attendRecord {
	    display: flex; /* Flexbox 활성화 */
	    flex-direction: column; /* 세로 방향 정렬 */
	    justify-content: center; /* 세로 기준 가운데 정렬 */
	    align-items: center; /* 가로 기준 중앙 정렬 */
	    height: 100%; /* 부모 높이에 맞게 */
	    text-align: center; /* 텍스트 중앙 정렬 */
	    box-sizing: border-box; /* 패딩 포함 크기 계산 */
	}
	
	/* 가운데 정렬 */
	.center{
		display: flex; /* Flexbox 활성화 */
	    flex-direction: column; /* 세로 방향 정렬 */
	    justify-content: center; /* 세로 기준 가운데 정렬 */
	    align-items: center; /* 가로 기준 중앙 정렬 */
	    height: 100%; /* 부모 높이에 맞게 */
	    text-align: center; /* 텍스트 중앙 정렬 */
	    box-sizing: border-box; /* 패딩 포함 크기 계산 */
	}
	
	.w100{
		width: 100%;
	}
	
	/* 위아래 마진 10% */
	.m10{
		margin: 10% 0;
	}
	
	/* 패딩 1% */
	.p1{
		 padding: 1%;
	}
	
	/* 위아래 마진 5% */
	.m5{
		margin: 5% 0;
	}
	
	.h28{
		height: 28%;
	}
	
	.h72{
		height: 72%;
	}
	
	/* 연한 보라색 */
	.lPurple{
		color: #8B6AA7;
	}
	
	.wr50{
		display: inline-block;
		width: 50%;
		text-align: right;
		padding-right: 10%;
	}
	
	.wl50{
		display: inline-block;
		width: 50%;
		text-align: left;
		padding-left: 10%;
	}
	
	/* 폰트사이즈 24 */
	.f24{
		font-size: 24px;
	}
	
	/* 폰트사이즈 48 */
	.f48{
		font-size: 48px;
	}
	
	/* 폰트사이즈 16 */
	.f16{
		font-size: 16px;
	}
	
	/* 배경색(베이지) */
	.bgColor{
		background-color: #FFFBF2;
		border-bottom-left-radius: 10px;
		overflow: hidden;
	}
	
	/* 높이 */
	.h10{
		height:10%;
	}
	/* 높이 */
	.h90{
		height:90%;
	}
	
	
	table {
	    width: 100%;
	    /* height: 100%; */
	    border-collapse: collapse;
	    text-align: center;
	    font-size: 24px;
	    max-height: 374px;
	    overflow-y:auto;
	    display: flex;
	    align-items: center;
	    flex-direction: column;
    }
    
 /*    thead{
    	height: 15%;
    } */

    th, td {
        /* padding: 5px; */
        border-bottom: 1px solid #30005A; /* 보라색 선 */
    }

    th {
        color: #30005A; /* 보라색 글씨 */
        font-weight: bold;
    }

    td {
        color: #8B6AA7; /* 연 보라색 글씨 */
        font-weight: bold;
    }
/*     .attendanceList {
    	overflow-y:auto;
    	max-height: 336px;
    } */
    
    thead, tbody tr {
	    display: table; /* 테이블 형태 유지 */
	    width: 100%;
	    table-layout: fixed; /* 각 열의 비율 고정 */
	}

  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="body">
			<div class="contentTop">
				<!-- 날짜 및 출퇴근시간 -->
				<div class="attendRecord pLine inBlock p18">
					<span class="bold m5 f16" id="day">2024/12/18(수)</span>
					<h2 class="bold m5 f48" id="clock">11:08</h2>
					<div class="w100 bold f16">
						<div class="w100 m10">
							<span class="m20 lPurple start-time">출근 시간 : </span><span>09:00</span>
						</div>
						<div class="w100">
							<span class="m20 lPurple end-time">퇴근 시간 : </span><span>00:00</span>
						</div>
					</div>
				</div>
				
				
				<!-- 이번달 근무현황 -->
				<div class="inBlock pLine p25">
					<div class="purple h28 center">
						<div class="f24 bold">
							<i class="bi bi-clock-fill"></i>&nbsp;&nbsp;이번달 근무현황
						</div>
					</div>
					
					<div class="center h72 bold f16">
						<div class="w100 m5">
							<span class="lPurple wr50">근무일수</span><span class="wl50">13일</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50">연장 근무시간</span><span class="wl50">7시간</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50">총 근무시간</span><span class="wl50">103시간</span>
						</div>
					</div>
				</div>
				
				<!-- 이번달 근태현황 -->
				<div class="inBlock pLine p25">
					<div class="purple h28 center">
						<div class="f24 bold">
							<i class="bi bi-suitcase-lg-fill"></i>&nbsp;&nbsp;이번달 근태현황
						</div>
					</div>
					
					
					<div class="center h72 bold f16">
						<div class="w100 m5">
							<span class="lPurple wr50">지각</span><span class="wl50">13일</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50">결근</span><span class="wl50">7시간</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50">연차</span><span class="wl50">103시간</span>
						</div>
					</div>
					
				</div>
				
				<!-- 연차현황 -->
				<div class="inBlock pLine p25">
					<div class="purple h28 center">
						<div class="f24 bold">
							<i class="bi bi-gift-fill"></i>&nbsp;&nbsp;연차 현황
						</div>
					</div>
					
					<div class="center h72 bold f16">
						<div class="w100 m5">
							<span class="lPurple wr50">잔여 연차</span><span class="wl50">12일</span>
						</div>
					</div>
				</div>
		</div>
 		
 		
 		<div class="contentBottom purple p1 f24">
 			<div class="h10 bold">
				<span><i class="bi bi-clock-history"></i>&nbsp;&nbsp;출퇴근 기록</span>
			</div>
			<!-- 출퇴근 기록 -->
			<div class="bgColor h90">
			    <table>
			        <thead>
			            <tr>
			                <th>근무일자</th>
			                <th>출근시간</th>
			                <th>퇴근시간</th>
			                <th>근무상태</th>
			                <th>근무시간</th>
			                <th>연장근무 시간</th>
			            </tr>
			        </thead>
			        <tbody class="attendanceList">
			            <tr>
			                <td>2024-12-17</td>
			                <td>08:50</td>
			                <td>18:00</td>
			                <td>정상</td>
			                <td>9시간 10분</td>
			                <td>*</td>
			            </tr>
			            <tr>
			                <td>2024-12-16</td>
			                <td>08:50</td>
			                <td>18:00</td>
			                <td>정상</td>
			                <td>9시간 10분</td>
			                <td>*</td>
			            </tr>
			            <tr>
			                <td>2024-12-13</td>
			                <td>*</td>
			                <td>*</td>
			                <td>연차</td>
			                <td>연차</td>
			                <td>*</td>
			            </tr>
			            <tr>
			                <td>2024-12-12</td>
			                <td>09:10</td>
			                <td>18:00</td>
			                <td>지각</td>
			                <td>8시간 50분</td>
			                <td>*</td>
			            </tr>
			            <tr>
			                <td>2024-12-11</td>
			                <td>08:58</td>
			                <td>18:10</td>
			                <td>정상</td>
			                <td>9시간 12분</td>
			                <td>10분</td>
			            </tr>
			            <tr>
			                <td>2024-12-10</td>
			                <td>08:55</td>
			                <td>19:00</td>
			                <td>정상</td>
			                <td>10시간 05분</td>
			                <td>1시간 05분</td>
			            </tr>
			        </tbody>
			    </table>
			</div>
			
		</div>
	</div>
</body>
<script>



setInterval(updateClock, 1000)
updateClock()
function updateClock() {
    const curtime = new Date()
    const timeString = String(curtime.getHours()).padStart(2, "0") + ":" +
        String(curtime.getMinutes()).padStart(2, "0") + ":" +
        String(curtime.getSeconds()).padStart(2, "0")
    const year = curtime.getFullYear();
    const month = String(curtime.getMonth() + 1).padStart(2, "0");
    const date = String(curtime.getDate()).padStart(2, "0");
    const dayNames = ["일", "월", "화", "수", "목", "금", "토"];
    const dayName = dayNames[curtime.getDay()];
    const dateString = year + "/" + month + "/" + date + "(" + dayName + ")";

    $('#clock').text(timeString)
    $('#day').text(dateString)
}

updateTime()

function updateTime(){
    $.ajax({
        url: "updateTime.ajax",
        type: "GET",
        data: { loginId:loginId}, 
        dataType: "json", 
        success: function (response) {
        	console.log('response:'+response.startTime);
        	console.log('response:'+response.endTime);
            if (response.startTime != null) {
                $(".start-time").next("span").text(response.startTime.split(" ")[1]);
            } else {
                $(".start-time").next("span").text("출근 시간 없음");
            }
            if (response.endTime != null) {
                $(".end-time").next("span").text(response.endTime.split(" ")[1]);
            } else {
                $(".end-time").next("span").text("퇴근 시간 없음");
            }
            
            $(".attendanceList").empty(); 
            
            response.list.forEach(function (item) {
                const row =
                    "<tr>" +
                        "<td>" + (item.date || "*") + "</td>" +
                        "<td>" + (item.start_time?  item.start_time.split(" ")[1] : "*") + "</td>" +
                        "<td>" + (item.end_time? item.end_time.split(" ")[1] : "*") + "</td>" +
                        "<td>" + (item.status || "*") + "</td>" +
                        "<td>" + (item.calculate_time || "*") + "</td>" +
                        "<td>" + (item.over_time || "*") + "</td>" +
                    "</tr>";
                $(".attendanceList").append(row);
            });
            
           	
            
        },
        error: function (xhr, status, error) {
            console.error("에러:", error);
        }
    });
}




</script>
</html>
