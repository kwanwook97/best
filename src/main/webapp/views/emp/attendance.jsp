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
    	position: absolute;
    	top: 0;
    	left: 0;
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
	
	
	.table-attendance {
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
	.naviPath {
		font-size: 27px;
		font-weight: bold;
		margin: -17px 0 0 19px;
	}
	.editable {
		width: 205px;
	}
	
/* 모달 css	 */
.modal-attendance {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-content-attendance {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    width: 400px;
    text-align: center;
}

.modal-buttons-attendance {
    margin-top: 10px;
    display: flex;
    justify-content: space-between;
}

#reasonInput {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    resize: none;
    height: 200px;
}
/* 연차기록 수정 모달	 */
.modal-leaveHistory {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal-content-leaveHistory {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    width: 400px;
    text-align: center;
}

.modal-buttons-leaveHistory {
    margin-top: 10px;
    display: flex;
    justify-content: space-between;
}

#reasonInputLeaveHistory {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    resize: none;
    height: 200px;
}

/* 근태 수정 내역 모달 */
.modal-attendanceHistory {
  display: none; /* 초기에는 숨김 */
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content-attendanceHistory {
  background-color: #fefefe;
  margin: 3% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  height: 78%;
  overflow-y: auto;
}

.close-btn-attendanceHistory {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close-btn-attendanceHistory:hover, .close-btn-attendanceHistory:focus {
  color: black;
  text-decoration: none;
}

.modal-filters-attendanceHistory {
  margin-bottom: 15px;
  display: flex;
  gap: 10px;
  align-items: center;
}

.modal-table-attendanceHistory {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
  max-height: 86%;
}

.modal-table-attendanceHistory th, .modal-table-attendanceHistory td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}

.modal-table-attendanceHistory th {
  background-color: #30005A;
  color: white;
}
.addbtn {
	background-color: #E9396B;
	border-radius: 10px;
	border: 1px solid #E9396B;
	color: white;
	margin: 0 0 0 3px;
	font-size: 16px;
}
.addbtn:hover {
	border: 2px solid #ed8faa;
	background-color: #fe5c8a;
}
.leavEditable {
	width: 55%;
}
/* 연차 수정 내역 모달 */
.modal-leaveHistoryLog {
  display: none; /* 초기에는 숨김 */
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content-leaveHistoryLog {
  background-color: #fefefe;
  margin: 3% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  height: 78%;
  overflow-y: auto;
}

.close-btn-leaveHistoryLog {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close-btn-leaveHistoryLog:hover, .close-btn-leaveHistoryLog:focus {
  color: black;
  text-decoration: none;
}

.modal-filters-leaveHistoryLog {
  margin-bottom: 15px;
  display: flex;
  gap: 10px;
  align-items: center;
}

.modal-table-leaveHistoryLog {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
  max-height: 86%;
}

.modal-table-leaveHistoryLog th, .modal-table-leaveHistoryLog td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: center;
}

.modal-table-leaveHistoryLog th {
  background-color: #30005A;
  color: white;
}



  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 	<div class="body">
	    <div class="naviPath">
		    <c:if test="${ empty empIdx}">
				<span class="lPurple">근태관리</span>
				<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>	
		     	<span class="cPurple">출퇴근 기록</span>
		    </c:if>
		    <c:if test="${not empty empIdx}">
		      <span class="lPurple">근태관리</span>
		      <i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
		      <span class="cPurple" style="color:#8B6AA7;">사원목록</span>
		      <i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
		      <span class="cPurple">${name}님</span>
		    </c:if>
	    </div>
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
							<span class="lPurple wr50 workdays">근무일수</span><span class="wl50">13일</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50 totalOverTime">연장 근무시간</span><span class="wl50">7시간</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50 totalWorkTime">총 근무시간</span><span class="wl50">103시간</span>
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
							<span class="lPurple wr50 lateCount">지각</span><span class="wl50">13회</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50 leaveCount">연차</span><span class="wl50">7회</span>
						</div>
						<div class="w100 m5">
							<span class="lPurple wr50 absentCount">결근</span><span class="wl50">103회</span>
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
							<span class="lPurple wr50 remainLeave">잔여 연차</span><span class="wl50">12일</span>
						</div>
					</div>
				</div>
		</div>
 		
 		
 		<div class="contentBottom purple p1 f24">
 			<div class="h10 bold attendance-b">
				<span><i class="bi bi-clock-history"></i>&nbsp;&nbsp;출퇴근 기록</span>
			    <c:if test="${not empty empIdx}">
			    	<button class="addbtn" onclick="attendanceHistory()">수정내역</button>
			    </c:if>
			    <c:if test="${not empty empIdx}">
			    	<button class="addbtn" onclick="enableEditMode()">수정하기</button>
			    </c:if>
			</div>
			<!-- 출퇴근 기록 -->
			<div class="bgColor h90">
			    <table class="table-attendance">
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
		
 		<div class="contentBottom purple p1 f24">
 			<div class="h10 bold leave">
				<span><i class="bi bi-clock-history"></i>&nbsp;&nbsp;연차 기록</span>
			    <c:if test="${not empty empIdx}">
			    	<button class="addbtn" onclick="leaveHistoryLogList()">수정내역</button>
			    </c:if>
			    <c:if test="${not empty empIdx}">
			    	<button class="addbtn" onclick="leaveHistoryEditMode()">수정하기</button>
			    </c:if>
			</div>
			<!-- 출퇴근 기록 -->
			<div class="bgColor h90">
			    <table class="table-attendance">
			        <thead>
			            <tr>
			                <th>시작 날짜</th>
			                <th>종료 날짜</th>
			                <th>총 사용 일수</th>
			                <th>사유</th>
			            </tr>
			        </thead>
			        <tbody class="leaveHistory">

			        </tbody>
			    </table>
			</div>
			
		</div>
	</div>
	
<div id="reasonModal" class="modal-attendance" style="display: none;">
    <div class="modal-content-attendance">
        <h3>변경 사유 입력</h3>
        <textarea id="reasonInput" placeholder="변경 사유를 입력하세요..." rows="4" maxlength="200"></textarea>
        <div class="modal-buttons-attendance">
            <button id="confirmReason" onclick="saveEditedData()">확인</button>
            <button id="cancelReason" onclick="hideReasonModal()">취소</button>
        </div>
    </div>
</div>

<!-- 연차기록 수정 사유 모달 -->
<div id="reasonLeaveModal" class="modal-leaveHistory" style="display: none;">
    <div class="modal-content-leaveHistory">
        <h3>변경 사유 입력</h3>
        <textarea id="reasonInputLeaveHistory" placeholder="변경 사유를 입력하세요..." rows="4" maxlength="200"></textarea>
        <div class="modal-buttons-leaveHistory">
            <button id="confirmLeaveHistoryReason" onclick="saveLeaveHistoryEditedData()">확인</button>
            <button id="cancelLeaveHistoryReason" onclick="hideLeaveHistoryReasonModal()">취소</button>
        </div>
    </div>
</div>

<div id="attendanceHistoryModal" class="modal-attendanceHistory">
  <div class="modal-content-attendanceHistory">
    <span class="close-btn-attendanceHistory">&times;</span>
    <h2>근태 수정 내역</h2>
    <div class="modal-filters-attendanceHistory">
      <!-- 필터 섹션 -->
      <span>날짜:</span>
      <input type="date" id="dateFilter">
      
      <span>수정자:</span>
      <input type="text" id="userFilter" placeholder="수정자 검색">
      <button class="addbtn" id="filterBtn">필터 적용</button>
      <button class="addbtn" id="reset" onclick="reset()">초기화</button>
    </div>
    <!-- 리스트 테이블 -->
    <table class="modal-table-attendanceHistory">
      <thead>
        <tr>
          <th>일자</th>
          <th>수정 전</th>
          <th>수정 후</th>
          <th>수정자</th>
          <th>수정 사유</th>
          <th>수정 일자</th>
        </tr>
      </thead>
      <tbody id="modalTableBody">
        <tr>
        	<td colspan="6">내역이 없습니다.</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

<!-- 연차 수정내역 모달 -->
<div id="leaveHistoryLogModal" class="modal-leaveHistoryLog">
  <div class="modal-content-leaveHistoryLog">
    <span class="close-btn-leaveHistoryLog">&times;</span>
    <h2>연차 수정 내역</h2>
    <div class="modal-filters-leaveHistoryLog">
      <!-- 필터 섹션 -->
      <span>날짜:</span>
      <input type="date" id="dateLeaveFilter">
      <span>수정자:</span>
      <input type="text" id="userLeaveFilter" placeholder="수정자 검색">
      <button class="addbtn" id="filterLeaveBtn">필터 적용</button>
      <button class="addbtn" id="resetLeave" onclick="resetLeave()">초기화</button>
    </div>
    <!-- 리스트 테이블 -->
    <table class="modal-table-leaveHistoryLog">
      <thead>
        <tr>
          <th>수정 전</th>
          <th>수정 후</th>
          <th>수정자</th>
          <th>수정 사유</th>
          <th>수정 일자</th>
        </tr>
      </thead>
      <tbody id="modalLeaveTableBody">
        <tr>
        	<td colspan="5">내역이 없습니다.</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>

	
</body>

<script>
var key = "${empIdx}";
var empIdx ="";
if (key) {
	empIdx = key;
}else{
	empIdx = loginId;
}
let attendanceData = [];
let leaveHistoryLogData = [];
console.log("empIdx: "+empIdx);

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
    const finish = document.querySelector('.btn-finish-work');
    if (StartTimeCheck && finish.disabled != true ) {
        const [startHour, startMinute] = StartTimeCheck.split(":").map(Number);
        const [currentHour, currentMinute] = timeString.split(":").map(Number);
        const startMinutes = startHour * 60 + startMinute;
        const currentMinutes = currentHour * 60 + currentMinute;
        const diffMinutes = currentMinutes - startMinutes;
        const diffHours = Math.floor(diffMinutes / 60).toString().padStart(2, "0");
        const remainingMinutes = (diffMinutes % 60).toString().padStart(2, "0");
        const currentWorkTime = diffHours + ":" + remainingMinutes;
        console.log("테테종:"+currentWorkTime);
    	$('#clock').text(currentWorkTime)
	}else{
	    $('#clock').text(timeString)
	}
    
    console.log("테테종:"+StartTimeCheck);


    $('#day').text(dateString)

}

updateTime()

function updateTime(){
    $.ajax({
        url: "updateTime.ajax",
        type: "GET",
        data: { loginId:empIdx}, 
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
                        "<td data-attend-idx='" + item.attend_idx + "'>" + (item.date || "*") + "</td>" +
                        "<td>" + (item.start_time?  item.start_time.split(" ")[1] : "*") + "</td>" +
                        "<td>" + (item.end_time? item.end_time.split(" ")[1] : "*") + "</td>" +
                        "<td>" + (item.status || "*") + "</td>" +
                        "<td>" + (item.calculate_time || "*") + "</td>" +
                        "<td>" + (item.over_time || "*") + "</td>" +
                    "</tr>";
                $(".attendanceList").append(row);
            });
            
            // 연차 기록 
            $(".leaveHistory").empty(); 
            if (!response.leaveHistoryList) {
                const row =
                    "<tr>" +
                        "<td colspan='4'> 사용 내역이 없습니다.</td>" +
                    "</tr>";
                $(".leaveHistory").append(row);
			}else{
	            response.leaveHistoryList.forEach(function (item) {
	                const row =
	                    "<tr>" +
	                        "<td data-leave-update-idx='" + item.leave_update_idx+ "'>" + (item.start_date || "*") + "</td>" +
	                        "<td>" + (item.end_date || "*") + "</td>" +
	                        "<td>" + (item.total_days || "*") + "</td>" +
	                        "<td>" + (item.reason || "*") + "</td>" +
	                    "</tr>";
	                $(".leaveHistory").append(row);
	            });
			}

            
            if (response.workdays != null) {
				$(".workdays").next("span").text(response.workdays + "일");
			}else{
				$(".workdays").next("span").text("없음");
			}
            if (response.totalOverTime != null) {
				$(".totalOverTime").next("span").text(response.totalOverTime + "시간");
			}else{
				$(".totalOverTime").next("span").text("없음");
			}
            if (response.totalWorkTime != null) {
				$(".totalWorkTime").next("span").text(response.totalWorkTime + "시간");
			}else{
				$(".totalWorkTime").next("span").text("없음");
			}
            if (response.lateCount != null) {
				$(".lateCount").next("span").text(response.lateCount + "회");
			}else{
				$(".lateCount").next("span").text("없음");
			}
            if (response.leaveCount != null) {
				$(".leaveCount").next("span").text(response.leaveCount + "회");
			}else{
				$(".leaveCount").next("span").text("없음");
			}
            if (response.absentCount != null) {
				$(".absentCount").next("span").text(response.absentCount + "회");
			}else{
				$(".absentCount").next("span").text("없음");
			}
            if (response.remainLeave != null) {
				$(".remainLeave").next("span").text(response.remainLeave + "일");
			}else {
				$(".remainLeave").next("span").text("없음");
			}
           	
            if (response.attendanceHistory) {
				/* console.log("수정내역 확인 데이터 "+JSON.stringify(response.attendanceHistory));   */          	
              	attendanceData = response.attendanceHistory;
                renderTable(attendanceData);
			}
            
            if (response.leaveHistoryLog) {
				console.log("수정내역 확인 데이터 "+JSON.stringify(response.leaveHistoryLog));          	
              	leaveHistoryLogData = response.leaveHistoryLog;
              	renderLeaveHistoryLogTable(leaveHistoryLogData);
			}
            
        },
        error: function (xhr, status, error) {
            console.error("에러:", error);
        }
    });
}

/* 출퇴근기록 수정하기 버튼 클릭시 나오는 저장하기 버튼 취소기능 등*/
function enableEditMode() {
    if ($(".attendanceList input").length > 0) {
			cancle();
        return;
    }
	
    $(".attendanceList tr").each(function () {
        $(this).find("td").each(function (index) {
            if (index === 0) { 
                $(this).append('<input type="checkbox" class="rowCheckbox" />');
            } else if (index === 1 || index === 2) {
                const value = $(this).text().trim();
                $(this).attr("data-original", value);
                $(this).html('<input type="time" value="' + (value ==="*" ?  "00:00": value ) + '" class="editable" />');
            }/*  else if (index === 3) {
            	const value = $(this).text().trim();
            	$(this).attr("data-original", value);

            	const options = ['정상', '지각', '결근', '연차'];
            	let selectHTML = '<select class="editable">';
            	options.forEach(option => {
            	    selectHTML += '<option value="' + option + '" ' + (value == option ? 'selected' : '') + '>' + option + '</option>';
            	});
            	selectHTML += '</select>';

            	$(this).html(selectHTML);
            } */
        });
    });

    // 수정 완료 버튼 표시 (수정 모드에서만 나타남)
    if ($("#saveChanges").length === 0) {
        $(".h10.bold.attendance-b").append('<button class="addbtn" id="saveChanges" onclick="showReasonModal()">저장하기</button>');
    }

}

function saveEditedData() {
    const updatedList = [];
    
    $(".attendanceList tr").each(function () {
        if ($(this).find(".rowCheckbox").is(":checked")) {
                    const attendIdx = $(this).find("td").eq(0).data("attend-idx");
                    const date = $(this).find("td").eq(0).text().trim();
                    const start_time = $(this).find("td").eq(1).find("input").val();
                    const end_time = $(this).find("td").eq(2).find("input").val();
                    /* const status = $(this).find("td").eq(3).find("input").val(); */
                    const content = $("#reasonInput").val();
            		
                    if (!content) {
                        modal.showAlert("변경 사유가 비어있습니다. 입력해 주세요.");
                        return false;
                    }
                    
                    const row = {
                            attendIdx: attendIdx,
                            date: date || "*",
                            start_time: start_time || "*",
                            end_time: end_time || "*",
                            /* status: status || "*", */
                            loginId: loginId,
                            content: content
                        };

                updatedList.push(row); 
        }
    });
    hideReasonModal()
    $("#saveChanges").remove();

    console.log("Updated List:", updatedList);

     // 수정된 데이터를 서버로 전송
     $.ajax({
        url: "updateAttendance.ajax",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ updatedList: updatedList }),
        success: function (response) {
            console.log("response:", response);
            if (response.msg == "성공") {
                updateTime();
	            
			}else{
				modal.showAlert(response.msg);
			}
            

        },
        error: function (xhr, status, error) {
            console.error("에러:", error);
        }
    });  
}

function cancle(){
	$(".attendanceList tr").each(function () {
	    $(this).find("td").each(function (index) {
	        if (index === 0) {
	            $(this).find(".rowCheckbox").remove();
	        } else if (index === 1 || index === 2 || index === 3) {
                // 원래 값 복원
                const originalValue = $(this).attr("data-original") || "*";
                $(this).text(originalValue);
                $(this).removeAttr("data-original");
            }
	    });
	});
    $("#saveChanges").remove();
}

/* 모달 온오프 */
function showReasonModal() {
    const isChecked = $(".attendanceList .rowCheckbox:checked").length > 0;
    if (!isChecked) {
        return modal.showAlert('수정할 항목을 선택하세요.');
    }

    let hasError = false;

    $(".attendanceList tr").each(function () {
        if ($(this).find(".rowCheckbox").is(":checked")) {
            const attendIdx = $(this).find("td").eq(0).data("attend-idx");
            const date = $(this).find("td").eq(0).text().trim();
            const start_time = $(this).find("td").eq(1).find("input").val();
            const end_time = $(this).find("td").eq(2).find("input").val();
            /* const status = $(this).find("td").eq(3).find("input").val(); */
            const content = $("#reasonInput").val();

            if (!start_time) {
                modal.showAlert("출근 시간이 비어있습니다. 입력해 주세요.");
                hasError = true;
                return false; 
            }
            if (!end_time) {
                modal.showAlert("퇴근 시간이 비어있습니다. 입력해 주세요.");
                hasError = true;
                return false;
            }
/*             if (!status) {
                modal.showAlert("근무 상태가 비어있습니다. 입력해 주세요.");
                hasError = true;
                return false;
            } */
            if (typeof loginId === "undefined" || loginId === null || loginId === "") {
                modal.showAlert("로그인 후 이용해 주시기 바랍니다.");
                hasError = true;
                return false;
            }
        }
    });

    if (hasError) {
        return;
    }

    $("#reasonModal").fadeIn();
}


function hideReasonModal() {
    $("#reasonModal").fadeOut();
    $("#reasonInput").val("");
}




/* 수정내역 함수 */
function attendanceHistory() {
  $('#attendanceHistoryModal').fadeIn(); 
}

$('.close-btn-attendanceHistory').on('click', function () {
  $('#attendanceHistoryModal').fadeOut(); 
});


// 필터 적용 버튼 클릭 이벤트
$('#filterBtn').on('click', function () {
  const dateFilter = $('#dateFilter').val(); 
  const userFilter = $('#userFilter').val(); 


  const filteredData = attendanceData.filter((entry) => {
    const isDateMatch = dateFilter ? entry.beforeDate.includes(dateFilter) : true;
    const isUserMatch = userFilter ? entry.name.includes(userFilter) : true;
    return isDateMatch && isUserMatch;
  });

  renderTable(filteredData); 
});


function renderTable(data) {
  const modalTableBody = $('#modalTableBody'); 
  modalTableBody.empty();
	
  if (!data || data.length === 0) {
	  const row = 
		    '<tr>' +
		      '<td colspan="6">내역이 없습니다.</td>'+ 
		    '</tr>';
		  modalTableBody.append(row); 
	  return;
	}
  
  data.forEach((entry) => {
	  const row = 
	    '<tr>' +
	      '<td>' + (entry.beforeDate || '*') + '</td>' + 
	      '<td>' + (entry.prevStart || '*') + ' ~ ' + (entry.prevEnd || '*') + '</td>' + 
	      '<td>' + (entry.newStart || '*') + ' ~ ' + (entry.newEnd || '*') + '</td>' + 
	      '<td>' + (entry.name || '*') + '</td>' + 
	      '<td>' + (entry.content || '*') + '</td>' + 
	      '<td>' + (entry.date || '*') + '</td>' + 
	    '</tr>';
	  modalTableBody.append(row); 
	});

}

$(window).on('click', function (event) {
  if ($(event.target).is('#attendanceHistoryModal')) {
    $('#attendanceHistoryModal').fadeOut();
  }
});


function reset(){
	  $('#dateFilter').val('');
	  $('#userFilter').val('');
	  renderTable(attendanceData);
}

/* 연차 수정내역 함수 */
function leaveHistoryLogList(){
  $('#leaveHistoryLogModal').fadeIn(); 
}

$('.close-btn-leaveHistoryLog').on('click', function () {
  $('#leaveHistoryLogModal').fadeOut(); 
});


// 필터 적용 버튼 클릭 이벤트
$('#filterLeaveBtn').on('click', function () {
  const dateFilter = $('#dateLeaveFilter').val(); 
  const userFilter = $('#userLeaveFilter').val(); 


  const filteredData = leaveHistoryLogData.filter((entry) => {
	const isDateMatch = dateFilter 
	    ? (new Date(entry.prevStartDate) <= new Date(dateFilter) && new Date(dateFilter) <= new Date(entry.prevEndDate))
	    : true;
    const isUserMatch = userFilter ? entry.name.includes(userFilter) : true;
    return isDateMatch && isUserMatch;
  });

  renderLeaveHistoryLogTable(filteredData); 
});


function renderLeaveHistoryLogTable(data) {
  const modalTableBody = $('#modalLeaveTableBody'); 
  modalTableBody.empty();

  if (!data || data.length === 0) {
	  const row = 
		    '<tr>' +
		      '<td colspan="5">내역이 없습니다.</td>'+ 
		    '</tr>';
		  modalTableBody.append(row); 
	  return;
	}
  
  data.forEach((entry) => {
	  const row = 
	    '<tr>' +
	      '<td>' + (entry.prevStartDate || '*') + ' ~ ' + (entry.prevEndDate || '*') + '</td>' + 
	      '<td>' + (entry.newStartDate || '*') + ' ~ ' + (entry.newEndDate || '*') + '</td>' + 
	      '<td>' + (entry.name || '*') + '</td>' + 
	      '<td>' + (entry.content || '*') + '</td>' + 
	      '<td>' + (entry.date || '*') + '</td>' + 
	    '</tr>';
	  modalTableBody.append(row); 
	});

}

$(window).on('click', function (event) {
  if ($(event.target).is('#leaveHistoryLogModal')) {
    $('#leaveHistoryLogModal').fadeOut();
  }
});


function resetLeave(){
	  $('#dateLeaveFilter').val('');
	  $('#userLeaveFilter').val('');
	  renderLeaveHistoryLogTable(leaveHistoryLogData);
}

/* 연차 수정하기 버튼 클릭시 나오는 저장하기 버튼 취소기능 등*/
function leaveHistoryEditMode() {
     if ($(".leaveHistory input").length > 0) {
    	 cancleLeave();
        return;
    } 
 if ($(".leaveHistory tr").find("td").length <= 1) {
	return;
}   
	
 $(".leaveHistory tr").each(function () {
	    const startDateInput = $(this).find("td").eq(0);
	    const endDateInput = $(this).find("td").eq(1);   

	    $(this).find("td").each(function (index) {
	        const value = $(this).text().trim();
	        $(this).attr("data-original", value); 

	        if (index === 0) { 
	        	const tomorrow = new Date();
	        	tomorrow.setDate(tomorrow.getDate() + 1);
	            $(this).empty();
	            $(this).append('<input type="checkbox" class="dowCheckbox" />');
	            $(this).append('<input type="date" value="' + value + '" class="leavEditable" min="' + tomorrow.toISOString().split("T")[0] + '" />');
	        } else if (index === 1) {
	           
	            $(this).empty();
	            const startDate = startDateInput.find("input[type='date']").val() || new Date().toISOString().split("T")[0];
	            $(this).append('<input type="date" value="' + value + '" class="leavEditable" min="' + startDate + '" />');
	            
	            startDateInput.find("input[type='date']").on("change", function () {
	                const updatedStartDate = $(this).val(); 
	                endDateInput.find("input[type='date']").attr("min", updatedStartDate); 
	            });
	        }
	    });
	});


    // 수정 완료 버튼 표시 (수정 모드에서만 나타남)
    if ($("#saveLeave").length === 0) {
        $(".h10.leave").append('<button class="addbtn" id="saveLeave" onclick="showReasonLeaveModal()">저장하기</button>');
    }
}

function cancleLeave() {
    $(".leaveHistory tr").each(function () {
        $(this).find("td").each(function (index) {
            const originalValue = $(this).attr("data-original") || ""; 
            if (index === 0) {
                $(this).find(".dowCheckbox").remove();
                $(this).empty(); 
                $(this).text(originalValue); 
            } else {
                $(this).empty(); 
                $(this).text(originalValue);
            }
            $(this).removeAttr("data-original");
        });
    });
    $("#saveLeave").remove();
}

function showReasonLeaveModal() {
    const isChecked = $(".leaveHistory .dowCheckbox:checked").length > 0;
    if (!isChecked) {
        return modal.showAlert('수정할 항목을 선택하세요.');
    }

    let hasError = false;

    $(".leaveHistory tr").each(function () {
        if ($(this).find(".dowCheckbox").is(":checked")) {
            const leaveUpdateIdx = $(this).find("td").eq(0).data("leave-update-idx");
            const startDate = $(this).find("td").eq(0).find("input[type='date']").val();
            const endDate = $(this).find("td").eq(1).find("input").val();

            if (!startDate) {
                modal.showAlert("시작 날짜가 비어있습니다. 입력해 주세요.");
                hasError = true;
                return false; 
            }
            if (!endDate) {
                modal.showAlert("종료 날짜가 비어있습니다. 입력해 주세요.");
                hasError = true;
                return false;
            }
            if (typeof loginId === "undefined" || loginId === null || loginId === "") {
                modal.showAlert("로그인 후 이용해 주시기 바랍니다.");
                hasError = true;
                return false;
            }
        }
    });

    if (hasError) {
        return;
    }
    
    $("#reasonLeaveModal").fadeIn();
}

/* 리즌 모달 사용후 저장확인로직 */
function saveLeaveHistoryEditedData() {
    const updatedList = [];
    
    $(".leaveHistory tr").each(function () {
        if ($(this).find(".dowCheckbox").is(":checked")) {
		            const leaveUpdateIdx = $(this).find("td").eq(0).data("leave-update-idx");
		            const startDate = $(this).find("td").eq(0).find("input[type='date']").val();
		            const endDate = $(this).find("td").eq(1).find("input").val();
                    const content = $("#reasonInputLeaveHistory").val();
                    
                    if (!content) {
                        modal.showAlert("변경 사유가 비어있습니다. 입력해 주세요.");
                        return false;
                    }
                    
                    const row = {
                    		leaveUpdateIdx: leaveUpdateIdx,
                    		startDate: startDate,
                    		endDate: endDate,
                            loginId: loginId,
                            content: content
                        };

                updatedList.push(row); 
        }
    });
    hideLeaveHistoryReasonModal();
    $("#saveLeave").remove();

    console.log("Updated List:", updatedList);

     // 수정된 데이터를 서버로 전송
     $.ajax({
        url: "updateLeaveHistory.ajax",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ updatedList: updatedList }),
        success: function (response) {
            console.log("response:", response);
            if (response.msg == "성공") {
                updateTime();
			}else{
				modal.showAlert(response.msg);
			}

        },
        error: function (xhr, status, error) {
            console.error("에러:", error);
        }
    });  
}

function hideLeaveHistoryReasonModal() {
    $("#reasonLeaveModal").fadeOut();
    $("#reasonInputLeaveHistory").val("");
}

</script>
</html>
