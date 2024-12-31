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


  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 	<div class="body">
	    <div class="naviPath">
		    <c:if test="${ empty empIdx}">
				<span class="lPurple">근태관리</span>	
		     	<span class="cPurple">&gt; 출퇴근 기록</span>
		    </c:if>
		    <c:if test="${not empty empIdx}">
		      <span class="lPurple">근태관리</span>
		      <span class="cPurple">&gt; 사원목록</span>
		      <span class="cPurple">&gt; ${name}님</span>
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
 			<div class="h10 bold">
				<span><i class="bi bi-clock-history"></i>&nbsp;&nbsp;출퇴근 기록</span>
			    <c:if test="${not empty empIdx}">
			    	<button onclick="enableEditMode()">수정하기</button>
			    </c:if>
			    <c:if test="${not empty empIdx}">
			    	<button onclick="">수정내역</button>
			    </c:if>
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
	
</body>

<script>
var key = "${empIdx}";
var empIdx ="";
if (key) {
	empIdx = key;
}else{
	empIdx = loginId;
}
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

    $('#clock').text(timeString)
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
           	
            
        },
        error: function (xhr, status, error) {
            console.error("에러:", error);
        }
    });
}

function enableEditMode() {
    if ($(".attendanceList input").length > 0) {
			cancle();
        // 저장 버튼 제거

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
        $(".h10").append('<button id="saveChanges" onclick="showReasonModal()">저장하기</button>');
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





</script>
</html>
