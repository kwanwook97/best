<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
.body {
  width: 83%;
  margin-top: 110px;
  margin-left: 320px;
}
 body .body {
    transform: scale(0.56); /* 67%로 축소 */
    transform-origin: top left; /* 화면의 왼쪽 상단을 기준으로 축소 */
    width: 150%; /* 축소에 따른 여백 보정 */
    overflow-x: hidden; /* 가로 스크롤 제거 */
    position: absolute;
    top: 1px;
    left: -37px;
    height: 187%;
  }

.naviPath {
  font-size: 49px;
  font-weight: bold;
  margin-bottom: 20px;
}

.lPurple {
  color: #8B6AA7;
}

.cPurple {
  color: #30005A;
}

.normalBtn {
  background-color: #30005A;
  color: #fff;
  font-weight: bold;
  padding: 10px 20px;
  border: none;
  border-radius: 8px !important;
}

.normalBtn:hover {
  background-color: #8B6AA7;
}

.notbtn {
  width: 100%;
  background-color: #E9396B;
  color: #fff;
  font-weight: bold;
  padding: 10px 20px;
  border: none;
  border-radius: 8px !important;
}


.content {
  height: 78%;
  position: relative;
  border: 2px solid #30005A;
  border-radius: 10px;
  padding: 20px;
  display: grid;
  grid-template-rows: 5fr 5fr;
  gap: 20px;
}

.top-section {
  display: grid;
  grid-template-columns: 22% 77%;
  gap: 1%;
}

.personal-info {
  border: 2px solid #8B6AA7;
  border-radius: 10px;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.personal-info h2 {
  background-color: #30005A;
  color: #fff;
  padding: 10px;
  margin: 0;
  flex-shrink: 0;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}

.personal-info table {
  width: 100%;
  border-collapse: collapse;
  margin: 0;
  table-layout: fixed;
  flex-grow: 1;
  overflow: auto;
  border-radius: 8px;
  display: table;
}

.personal-info tr {
  display: table-row;
  height: calc(100% / 8);
}

.personal-info colgroup col:nth-child(1),
.personal-info colgroup col:nth-child(3) {
  width: 30%;
}

.personal-info colgroup col:nth-child(2),
.personal-info colgroup col:nth-child(4) {
  width: 70%;
}

.personal-info th,
.personal-info td {
  border: 1px solid #8B6AA7;
  padding: 8px;
  text-align: left;
  vertical-align: middle;
}

.personal-info th {
  background-color: #8B6AA7;
  color: #30005A;
  font-weight: bold;
}

.bottom-section {
  display: grid;
  grid-template-columns: 30% 41% 23%;
  gap: 3%;
  height: 100%;
}

.status-info,
.history-info,
.attachment-info {
  border: 2px solid #8B6AA7;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.status-info h2,
.history-info h2,
.attachment-info h2 {
  background-color: #30005A;
  color: #fff;
  padding: 10px;
  margin: 0;
  flex-shrink: 0;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
}

.status-info table,
.history-info table,
.attachment-info table {
  width: 100%;
  border-collapse: collapse;
  flex-grow: 1;
  overflow: auto;
  border-radius: 0 0 8px 8px;
  display: table;
  height: 100%;
}

.status-info tr,
.history-info tr,
.attachment-info tr {
  display: table-row;
  height: calc(100% / 8);
}

.status-info table colgroup col:nth-child(1) {
  width: 40%;
}

.status-info table colgroup col:nth-child(2) {
  width: 60%;
}


.history-info th,
.attachment-info th {
  border: 2px solid #8B6AA7;
  background-color: #8B6AA7;
  color: #30005A;
  font-weight: bold;
  padding: 8px;
  text-align: center;
}

.status-info th{
  border: 2px solid #8B6AA7;
  background-color: #8B6AA7;
  color: #30005A;
  font-weight: bold;
  padding: 8px;
  text-align: left;
}


.history-info td,
.attachment-info td {
  border: 2px solid #8B6AA7;
  padding: 8px;
  text-align: center;
  vertical-align: middle;
}

.status-info td{
	border: 2px solid #8B6AA7;
  padding: 8px;
  text-align: left;
  vertical-align: middle;
}

th, td {
  font-size: 20px;
}

.btn_area {
	float: right;
}

.photo-container {
  display: flex;
  flex-direction: column; /* 세로 배치 */
  align-items: center; /* 가운데 정렬 */
  justify-content: flex-start; /* 위쪽부터 배치 */
}

.photo {
  border: 2px solid #30005A;
  border-radius: 10px;
  background-color: #E0E0E0;
  overflow: hidden;
  aspect-ratio: 1 / 1; /* 정사각형 비율 */
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.photo img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.photo-bottom {
  font-size: 24px;
  display: flex;
  flex-direction: column; /* 세로로 정렬 */
  align-items: center; /* 가운데 정렬 */
  justify-content: center;
  margin-top: 5%;
  gap: 10px; /* 내부 요소 간의 간격 */
}

.photo-bottom .state {
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

.photo-bottom .enable {
  display: inline-block;
  margin-right: 10px; /* 텍스트 사이 여백 */
  font-weight: bold;
}

/* 드롭다운 관련 CSS */
select {
    color: #30005A; /* 글자색: 진한 보라색 */
    border: 1px solid #8B6AA7; /* 테두리색: 연한 보라색 */
    padding: 5px;
    font-size: 18px;
}

/* 옵션 스타일 */
select option {
    background-color: #FFFFFF !important; /* 옵션 배경색: 흰색 */
    color: #8B6AA7; /* 글자색: 연한 보라색 */
    font-weight: bold; /* 굵은 글자 */
}

/* Hover된 옵션 스타일 */
select option:hover {
    background-color: #F5F5F5; /* Hover 시 배경색: 연한 회색 */
    color: #30005A; /* Hover 시 글자색: 진한 보라색 */
}

form{
	margin: 0;
}

.driver_area{
	width: 100%;
}
  .sign-modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }


.addbtn {
	background-color: #E9396B;
	border-radius: 10px;
	border: 1px solid #E9396B;
	color: white;
	margin: 0 0 0 3px;
	font-size: 26px;
}
.addbtn:hover {
	border: 2px solid #ed8faa;
	background-color: #fe5c8a;
}
.sign-margin {
	height: 44px;
	margin: 17px 0 0 0;
	padding: 4px 0 0 0;
}
.close-btn-sign {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close-btn-sign:hover, .close-btn-sign:focus {
  color: black;
  text-decoration: none;
}

  </style>
</head>
<body class="bg-theme bg-theme1">
  <c:set var="emp_idx" value="${param.emp_idx}" />

  <jsp:include page="../main/header.jsp"></jsp:include>
  <!-- 기본 모달, 사원정보 변경 모달 -->
  <jsp:include page="../modal/modal.jsp"></jsp:include>
  <!-- 기사정보 관리 모달 -->
	<div class="driver_modal modal_change">
	  <div class="driver_modal_container">
	    <!-- 제목을 동적으로 설정할 부분 -->
	    <h2 id="modalTitle" class="driver_modal_title">기사 정보 관리</h2>
	    <table class="modal_table">
	      <tr>
	        <th>면허번호</th>
	        <td>
	          <input type="text" id="license" class="input_field" placeholder="면허번호를 입력하세요." readonly>
	        </td>
	      </tr>
	      <tr>
	        <th>면허유효기간</th>
	        <td>
	          <input type="date" id="license_period" class="input_field" readonly>
	        </td>
	      </tr>
	      <tr>
	        <th>자격증번호</th>
	        <td>
	          <input type="text" id="certificate" class="input_field" placeholder="자격증번호를 입력하세요." readonly>
	        </td>
	      </tr>
	    </table>
	    <div class="driver_modal_footer">
	      <button class="full_btn_cancel">닫기</button>
	    </div>
	  </div>
	</div>
	
	
<div class="sign-modal">
  <div class="modal_container">
  <span class="close-btn-sign">&times;</span>
    <div class="modal_body">
      <div id="signatureContainer">
	<canvas id="signatureCanvas" width="100" height="100" style="border:2px solid #30005A;background-color: white;"></canvas>
      </div>
    </div>
    <div class="modal_footer">
	  <button class="btn_confirm btn_confirm_sign" onclick="saveSignature()">등록</button>
	  <button class="btn_cancel" onclick="clearCanvas()">삭제</button>
    </div>
  </div>
</div>
  
  
  
  <div class="body">
    <div class="naviPath">
    <span class="cPurple">나의 정보 상세</span>
    </div>
    <div class="content">
      <div class="top-section">
      	<div class="photo-container">
		    <div class="photo">
		        <img alt="Profile Photo" src="/photo/${detail.photo}"/>
		    </div>
		    <div class="photo-bottom">
		    	<div class="state">
			    	<c:choose>
					    <c:when test="${detail.state == true}">
					        <span style="color: #00FF11;">●</span>&nbsp;&nbsp;근무 중
					    </c:when>
					    <c:when test="${detail.state == false}">
					        <span style="color: red;">●</span>&nbsp;&nbsp;부재 중
					    </c:when>
					</c:choose>
		            
		        </div>
		        <div>
		        	<c:choose>
					    <c:when test="${detail.enable == true}">
					    	<span class="enable lPurple">로그인 제한</span>
					        <span class="enable cPurple">정상</span>
					    </c:when>
					    <c:when test="${detail.enable == false}">
					        <span class="enable cPurple">로그인 제한</span>
					        <span class="enable lPurple">정상</span>
					    </c:when>
					</c:choose>
		        </div>
		    </div>
		    <div class="sign-margin">
		    	<button class="addbtn" onclick="showSignatureModal()">사인관리</button>
		    </div>
		</div>
        <div class="personal-info">
          <h2>개인 정보</h2>
          <table>
            <colgroup>
              <col>
              <col>
              <col>
              <col>
            </colgroup>
            <tr>
              <th>이름</th>
              <td>${detail.name}</td>
              <th>부서</th>
              <td>${detail.depart_name}</td>
            </tr>
            <tr>
              <th>사원번호</th>
              <td>${detail.emp_idx}</td>
              <th>직급</th>
              <td>${detail.rank_name}</td>
            </tr>
            <tr>
              <th>주민번호</th>
              <td>${detail.resident_number}</td>
              <th>연봉</th>
              <td>${detail.salary}</td>
            </tr>
            <tr>
              <th>성별</th>
              <td>${detail.gender}</td>
              <th>계좌번호</th>
              <td>${detail.account_number}</td>
            </tr>
            <tr>
              <th>이메일</th>
              <td>${detail.email}<div class="btn_area"><button class="normalBtn" id="email">변경하기</button></div></td>
              <th>전화번호</th>
              <td>${detail.phone}<div class="btn_area"><button class="normalBtn" id="phone">변경하기</button></div></td>
            </tr>
            <tr>
              <th>주소</th>
              <td>${detail.address}<div class="btn_area"><button class="normalBtn" id="address">변경하기</button></div></td>
              <th>핸드폰번호</th>
              <td>${detail.mobile}<div class="btn_area"><button class="normalBtn" id="mobile">변경하기</button></div></td>
              
            </tr>
            <tr>
              <th>입사일</th>
              <td>${detail.start_date}</td>
              <th>퇴사일</th>
              <td>${detail.end_date}</td>
            </tr>
            <tr>
              <th>IP주소</th>
              <td>${detail.ip}</td>
              <td colspan="2"><div class="driver_area">
				<c:if test="${detail.depart_name == '기사팀'}">
	              	<button class="notbtn" id="driver_manage">기사정보 관리하기</button>
				</c:if>
              </div></td>
            </tr>
          </table>
        </div>
      </div>

      <div class="bottom-section">
        <div class="status-info">
          <h2>근무 상태 및 연차</h2>
          <table>
            <colgroup>
              <col>
              <col>
            </colgroup>
            <tr>
            	<th>근무상태</th>
            	<td>
            		<c:choose>
					    <c:when test="${detail.state == true}">
					        근무 중
					    </c:when>
					    <c:when test="${detail.state == false}">
					        부재 중
					    </c:when>
					</c:choose>
            	</td>
           	</tr>
            <tr><th>총 연차</th><td>${detail.total_leave}</td></tr>
            <tr><th>잔여 연차</th><td>${detail.remain_leave}</td></tr>
            <tr><th>연차 시작일</th><td>${detail.lv_start_date}</td></tr>
            <tr><th>연차 종료일</th><td>${detail.lv_end_date}</td></tr>
            <tr><th>이번 달 근무일수</th><td>${attendance.workDays}&nbsp;일</td></tr>
            <tr><th>이번 달 연장근로 시간</th><td>${attendance.totalOverTime} &nbsp;시간</td></tr>
          </table>
        </div>
        <div class="history-info">
          <h2>인사 변경 내역</h2>
          <table>
            <tr><th>부서</th><th>직급</th><th>근무 시작일</th><th>근무 종료일</th><th>연봉</th></tr>
            <c:set var="maxRows" value="6" /> <!-- 최대 행 개수 설정 -->
			<c:set var="rowCount" value="${fn:length(detail.list)}" />
			
			<c:set var="prevDepart" value="${detail.depart_name}" />
			<c:set var="prevRank" value="${detail.rank_name}" />
			<c:set var="prevSalary" value="${detail.salary}" />
			
			<c:forEach items="${detail.list}" var="item">
			  <tr>
			    <!-- 부서 -->
			    <td>
			      <c:choose>
			        <c:when test="${item.category == 'depart_idx'}">
			          ${item.after_update}
			          <c:set var="prevDepart" value="${item.before_update}" />
			        </c:when>
			        <c:otherwise>
			          ${prevDepart}
			        </c:otherwise>
			      </c:choose>
			    </td>
			    <!-- 직급 -->
			    <td>
			      <c:choose>
			        <c:when test="${item.category == 'rank_idx'}">
			          ${item.after_update}
			          <c:set var="prevRank" value="${item.before_update}" />
			        </c:when>
			        <c:otherwise>
			          ${prevRank}
			        </c:otherwise>
			      </c:choose>
			    </td>
			    <!-- 근무 시작일과 종료일 -->
			    <td>${detail.start_date}</td>
			    <td>${detail.end_date}</td>
			    <!-- 연봉 -->
			    <td>
			      <c:choose>
			        <c:when test="${item.category == 'salary'}">
			          <fmt:formatNumber value="${item.after_update}" type="number" groupingUsed="true" /> 원
			          <c:set var="prevSalary" value="${item.before_update}" />
			        </c:when>
			        <c:otherwise>
			          <fmt:formatNumber value="${prevSalary}" type="number" groupingUsed="true" /> 원
			        </c:otherwise>
			      </c:choose>
			    </td>
			  </tr>
			</c:forEach>

			
			<!-- 빈 행 추가 -->
			<c:forEach begin="${rowCount}" end="${maxRows - 1}" var="i">
			  <tr>
			    <td></td>
			    <td></td>
			    <td></td>
			    <td></td>
			    <td></td>
			  </tr>
			</c:forEach>
          </table>
        </div>
        <div class="attachment-info">
        	
		  <h2>첨부 파일</h2>
		  <table>
		    <tr><th>파일명</th><th>업로드 날짜</th><th>삭제</th></tr>
			
			<c:set var="index" value="0" />
			<c:set var="maxRows" value="5" />
			<c:forEach items="${detail.fileList}" var="file">
		        <tr>
		            <td><a href="fileDownload.do?file_name=${file.file_name}">${file.file_name}</a></td>
		            <td>${file.date}</td>
		            <td><button onclick="delFile(this)" class="normalBtn"><i class="bi bi-trash-fill"></i></button></td>
		        </tr>
		        <c:set var="index" value="${index + 1}" />
			</c:forEach>
			
			<!-- 부족한 행만큼 빈 행 추가 -->
			<c:forEach begin="${fn:length(detail.fileList)}" end="${maxRows - 1}" var="i">
			    <tr>
			        <td></td>
			        <td></td>
			        <td></td>
			    </tr>
			</c:forEach>
			   

		  </table>
		</div>
      </div>
    </div>
  </div>
</body>

<script>
	/* 전역변수 */
	var col = '';              // 변경할 컬럼
	var empIdx = '${emp_idx}'; // 사번
	var currentVal = '';    // 현재 값
	var newVal = '';        // 변경 값
	var newText = '';        // 변경 값(부서, 직급 Text)
	var fileName = '';      // 삭제할 파일이름
	var fileCnt = ${index};    // 첨부파일 개수
	var license = '${detail.license}';         // 면허번호
    var license_period = '${detail.license_period}';  // 면허유효기간
    var certificate = '${detail.certificate}';     // 자격증번호
	
	/* 직원정보 변경 모달창 관련 기능 */
	// 1. 모달 띄우기
	$('.normalBtn').on('click', function() {
	    // 클릭한 버튼의 컬럼 값 가져오기
	    col = $(this).attr('id');
	    console.log('col:값'+col);
	    // 변경할 항목 이름 가져오기
	    var changeName = $(this).closest('td').prev('th').text();
	    // 현재 값 (버튼태그 값 제거)
	    currentVal = $(this).closest('td').clone().children().remove().end().text().trim();
	    
	 	// 날짜수정인 경우(퇴사일, 면허유효기간)
	    if (changeName == '퇴사일' || changeName == '면허유효기간') {
	        // date선택 기능
	        var dateInput = $('<input type="date" id="new" class="input_field" value="' + currentVal + '">');
	        $('#newVal').html(dateInput);
	    }
	    // 부서나 직급인 경우 DROPDOWN 추가
	    else if(changeName == '부서' || changeName == '직급'){
	    	var table = changeName == '부서' ? 'department' : 'rank_emp'; 
	    	
			$.ajax({
				method: 'POST',
				url: 'empDrop.ajax',
				data: {
					'table': table
				},
				dataType: 'JSON',
				success: function(list){
					
					// select 태그 동적 생성
		            var dropdown = $('<select id="new" class="input_field"></select>');
					
		            $.each(list, function (index, item) {
		                var value = changeName === '부서' ? item.depart_name : item.rank_name;
		                var idx = changeName === '부서' ? item.depart_idx : item.rank_idx;
		                if(currentVal == value){
		                	dropdown.append('<option value="' + idx + '" selected>' + value + '</option>');	
		                }else{
		                	dropdown.append('<option value="' + idx + '">' + value + '</option>');
		                }
		                
		            });

		
		            // 모달에 dropdown 삽입
		            $('#newVal').html(dropdown); // 변경할 값 부분을 교체
					
				},
				error: function(e){
					modal.showAlert('잠시 후 다시 시도해주세요.');
				}
			});	    	
	    }else{
	    	// 모달에 input태그 삽입
	    	var inputTag = $('<input type="text" id="new" class="input_field" value="' +currentVal+ '"/>');
	        $('#newVal').html(inputTag); // 변경할 값 부분을 교체
	    }
	    	
	 	
        
	    // 모달 타이틀과 현재 값 설정
	    showChangeModal(changeName + ' 변경', currentVal, '담당자입니다.(sessionId로 교체 예정)');
	});
	
	// 2. 직원정보 값 변경
	$('.full_btn_change').on('click', function() {
	    // 변경할 값 저장
	    newVal = $('#new').val();
	    newText = $('#new option:selected').text();
	    
	    // 확인 모달 띄우기
	    modal.showConfirm('정말로 수정하시겠습니까?', function () {
	        empUpdate(); // 확인 버튼 클릭 시 수정 함수 실행
	    });
	});
	
	// 3. 모달창 닫기
	$('.full_btn_cancel').on('click', function() {
	    hideChangeModal();
	    hideDriverModal();
	});
	
	
	
	// 직원정보 수정 함수
	function empUpdate() {
		
		// 상급자 정보를 찾기 위한 변수
		var parentFind = ''; 
		
		if(col == 'depart_idx'){
			parentFind = '${detail.depart_idx}';
		}else if(col == 'rank_idx'){
			parentFind = '${detail.rank_idx}';
		}
		
	    $.ajax({
	        method: 'POST',
	        url: 'updateMyDetail.ajax',
	        data: {
	            'loginId': loginId,           // 사번
	            'col': col,                  // 컬럼 값
	            'currentVal': currentVal,    // 현재 값
	            'newVal': newVal,            // 변경할 값
	            'newText': newText,          // 부서,직급 Text값
	            'parentFind': parentFind     // 상급자정보를 찾기위한 값
	        },
	        dataType: 'JSON',
	        success: function(data) {
	        	if(data.success == '성공'){
	        	    modal.showConfirm('정보수정에 성공했습니다.', function () {
	        	    	location.reload(); // 페이지 새로고침
	        	    });
	        		
	        	}else{
	        		modal.showAlert('정보수정에 실패했습니다.');
	        	}
	            
	        },
	        error: function(e) {
	            modal.showAlert('잠시 후 다시 시도해주세요.');
	        }
	    });
	}
	
	
	/* 기사정보 관리 */
	// 'driver_manage' 버튼 클릭 시 모달창 띄우기
	$('#driver_manage').on('click', function() {
		// 모달 표시
	    document.querySelector('.driver_modal.modal_change').style.display = 'flex';
		
		// 기사정보 가져오기
		$('#license').val(license);                 // 면허번호
        $('#license_period').val(license_period); // 면허유효기간
        $('#certificate').val(certificate);       // 자격증번호
	    	
	});

	// 기사정보 관리 모달창 닫기	
	function hideDriverModal() {
	  document.querySelector('.driver_modal.modal_change').style.display = 'none';
	}
	
	// 기사정보 수정하기
	$('.full_btn_regist').on('click', function() {
	    // 변경할 값 저장
	    license = $('#license').val();               // 면허번호
        license_period = $('#license_period').val(); // 면허유효기간
        certificate = $('#certificate').val();       // 자격증번호
	    
     	// 입력값 검증
        if (!license || !license_period || !certificate) {
            modal.showAlert('모든 항목을 입력해주세요.'); // 경고창 표시
            return;
        }
        
	    // 확인 모달 띄우기
	    modal.showConfirm('정말로 수정하시겠습니까?', function () {
	    	driverUpsert(); 
	    });
	});
	
	
	// 기사정보 수정 함수
	function driverUpsert(){
		$.ajax({
			method: 'POST',
			url: 'driverUpsert.ajax',
			data: {
				'emp_idx': empIdx,
				'license': license,
				'license_period': license_period,
				'certificate': certificate
			},
			dataType: 'JSON',
			success: function(data){
				if(data.success == '성공'){
	        	    modal.showConfirm('기사정보가 등록되었습니다.', function () {
        	    		location.reload(); // 페이지 새로고침 
	        	    });
	        		
	        	}else{
	        		modal.showAlert('정보수정에 실패했습니다.');
	        	}
			},
			error: function(e){
				modal.showAlert('잠시 후 다시 시도해주세요.');
			}
		});
	}
	
	
	/* 파일 관련 기능 */
	// 파일 선택 이벤트
    $('#fileUpload').on('change', function () {
        var selectedFiles = this.files; // 새로 선택된 파일 목록
        var totalFiles = fileCnt + selectedFiles.length; // 총 파일 개수 계산

        // 파일 개수 초과 여부 확인
        if (totalFiles > 5) {
        	modal.showAlert("파일은 최대 5개까지 업로드 가능합니다.");
            $(this).val(''); // 선택된 파일 초기화
        }
        
    });
	
	
	// 파일삭제 함수
	function delFile(button) {
		// 삭제할 파일이름 세팅
		fileName = $(button).closest('tr').find('td').eq(0).text();
		// ajax를 이용한삭제
		$.ajax({
	        method: 'POST',
	        url: 'fileDel.ajax',
	        data: {
	            'idx_num': empIdx,    // 사번
	            'file_name': fileName // 파일이름
	        },
	        dataType: 'JSON',
	        success: function(data) {
	        	if(data.success == '성공'){
	        	    modal.showConfirm('파일삭제에 성공했습니다.', function () {
        	    		location.reload(); // 페이지 새로고침 
	        	    });
	        		
	        	}else{
	        		modal.showAlert('정보수정에 실패했습니다.');
	        	}
	        },
	        error: function(e) {
	            modal.showAlert('잠시 후 다시 시도해주세요.');
	        }
	    });
	}
	

	

function showSignatureModal(signatureUrl) {
	$(".sign-modal").css("display","flex").hide().fadeIn();
	checkSign()
	
}

function clearCanvas() {
	
	   $.ajax({
		    type: 'get',
		    url: 'delSign.ajax',
		    data: {
		        loginId:loginId
		    },
		    dataType: 'json', 
		    success: function(response) {
		    	if (response.msg == '성공') {
		    	    ctx.clearRect(0, 0, canvas.width, canvas.height);
		    	    $('.btn_confirm_sign').prop('disabled', false);
	        		$('.btn_confirm_sign').css('background-color', '#30005A');
					modal.showAlert('삭제가 완료되었습니다.');
		    		checkSign();
				}else {
					modal.showAlert('시스템 에러 발생 ! 잠시 후 다시 시도해주세요.');
				}
		    	
		    },
		    error: function(xhr, status, error) {
		        console.error(error);
		    }
		});
	

}
var canvas = document.getElementById("signatureCanvas");
var ctx = canvas.getContext("2d");

let isSigning = false;

canvas.addEventListener("mousedown", () => (isSigning = true));
canvas.addEventListener("mousemove", (event) => {
    if (!isSigning) return;
    ctx.lineWidth = 2;
    ctx.lineCap = "round";
    ctx.strokeStyle = "black";

    ctx.lineTo(event.offsetX, event.offsetY);
    ctx.stroke();
    ctx.beginPath();
    ctx.moveTo(event.offsetX, event.offsetY);
});
canvas.addEventListener("mouseup", () => {
    isSigning = false;
    ctx.beginPath();
});

// 서명 저장
function saveSignature() {
/* 	   const link = document.createElement("a");
	   link.download = "canvas_image.png"; // 저장될 파일 이름
	   link.href = canvas.toDataURL(); // Canvas 내용을 Base64로 변환
	   link.click(); // 다운로드 실행 */
	   
	   var base64Image = canvas.toDataURL(); // 캔버스의 내용을 Base64 이미지로 변환

	   $.ajax({
		    type: 'POST',
		    url: 'saveSignature.ajax',
		    data: {
		        sign: base64Image // 서버로 보낼 데이터
		    },
		    dataType: 'json', // 서버에서 반환할 데이터 타입
		    success: function(data) {
		    	 if (data.status === "success") {
		    		 modal.showAlert(data.message);
		    		 checkSign();
		    		 
		            } else {
		                alert(data.message);
		            }
		    },
		    error: function(xhr, status, error) {
		        console.error(error); // 오류 처리
		    }
		});
	}
	
$('.close-btn-sign').on('click', function () {
	$(".sign-modal").fadeOut(); 
});


checkSign()
function checkSign(){
    $.ajax({
        type: 'GET',
        url: 'checkSign.ajax',
        data: {
        	loginId:loginId,
        },
        dataType:'json',
        success: function(response) {
        		console.log("response.sign 사인값 확인용:"+response.sign);
        		console.log("response.msg 사인값 확인용:"+response.msg);
        		console.log("response 사인값 확인용:"+response);
        	if (response.msg === '성공') {
        		  $('#signatureContainer').empty();
        		  const row = 
        		    '<img src="/photo/' + response.sign + '" width="100" height="100" style="border:2px solid #30005A; background-color: white;">';
        		  $('#signatureContainer').append(row);
        		  $('.btn_confirm_sign').prop('disabled', true);
        		  $('.btn_confirm_sign').css('background-color', '#939393');
        		  
        		} else {
        		  $('#signatureContainer').empty();
        		  const row = 
        		    '<canvas id="signatureCanvas" width="100" height="100" style="border:2px solid #30005A; background-color: white;"></canvas>';
        		  $('#signatureContainer').append(row);
        		  
                  canvas = document.getElementById("signatureCanvas");
                  ctx = canvas.getContext("2d");

                  canvas.addEventListener("mousedown", () => (isSigning = true));
                  canvas.addEventListener("mousemove", (event) => {
                      if (!isSigning) return;
                      ctx.lineWidth = 2;
                      ctx.lineCap = "round";
                      ctx.strokeStyle = "black";

                      ctx.lineTo(event.offsetX, event.offsetY);
                      ctx.stroke();
                      ctx.beginPath();
                      ctx.moveTo(event.offsetX, event.offsetY);
                  });
                  canvas.addEventListener("mouseup", () => {
                      isSigning = false;
                      ctx.beginPath();
                  });
        		}
         
        },
        error: function() {
          alert('에러');
        }
      });
}


	
</script>

</html>
