<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <style>
.body {
  width: 83%;
  margin-top: 110px;
  margin-left: 320px;
}

.naviPath {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
}

.lPurple {
  color: #8B6AA7;
}

.cPurple {
  color: #30005A;
}

button {
  background-color: #30005A;
  color: #fff;
  font-weight: bold;
  padding: 10px 20px;
  border: none;
  border-radius: 8px !important;
}

.register-btn {
  width: 10%;
  height: auto;
}

.notbtn {
  background-color: #8B6AA7;
  color: #fff;
  font-weight: bold;
  padding: 10px 20px;
  border: none;
  border-radius: 8px !important;
}

button:hover {
  background-color: #8B6AA7;
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
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
    <div class="naviPath">
      <span class="lPurple">사원관리</span> <span class="cPurple">&gt; 사원상세</span>
    </div>
<!-- 
    <div class="btn_area">
      <button class="registerBtn">등록 하기</button>
    </div>
 -->
    <div class="content">
      <div class="top-section">
      	<div class="photo-container">
		    <div class="photo">
		        <img src="profile.jpg" alt="Profile Photo">
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
              <td>${detail.name}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
              <th>부서</th>
              <td>${detail.depart_name}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
            </tr>
            <tr>
              <th>사원번호</th>
              <td>${detail.emp_idx}</td>
              <th>직급</th>
              <td>${detail.rank_name}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
            </tr>
            <tr>
              <th>주민번호</th>
              <td>${detail.resident_number}</td>
              <th>연봉</th>
              <td>${detail.salary}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
            </tr>
            <tr>
              <th>성별</th>
              <td>${detail.gender}</td>
              <th>계좌번호</th>
              <td>${detail.account_number}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
            </tr>
            <tr>
              <th>주소</th>
              <td>${detail.address}</td>
              <th>전화번호</th>
              <td>${detail.phone}</td>
            </tr>
            <tr>
              <th>이메일</th>
              <td>${detail.email}</td>
              <th>핸드폰번호</th>
              <td>${detail.mobile}</td>
            </tr>
            <tr>
              <th>입사일</th>
              <td>${detail.start_date}</td>
              <th>면허번호</th>
              <td>${detail.license}</td>
            </tr>
            <tr>
              <th>퇴사일</th>
              <td>${detail.end_date}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
              <th>면허유효기간</th>
              <td>${detail.license_period}<div class="btn_area"><button class="normalBtn">변경하기</button></div></td>
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
            <tr><th>이번 달 근무일수</th><td>${detail.work_cnt}</td></tr>
            <tr><th>이번 달 연장근로 시간</th><td></td></tr>
          </table>
        </div>
        <div class="history-info">
          <h2>인사 변경 내역</h2>
          <table>
            <tr><th>부서</th><th>직급</th><th>근무 시작일</th><th>근무 종료일</th><th>연봉</th></tr>
            <tr><td>개발팀</td><td>사원</td><td>2022-01-01</td><td>2023-01-01</td><td>3000만원</td></tr>
            <tr><td>개발팀</td><td>사원</td><td>2022-01-01</td><td>2023-01-01</td><td>3000만원</td></tr>
            <tr><td>개발팀</td><td>사원</td><td>2022-01-01</td><td>2023-01-01</td><td>3000만원</td></tr>
            <tr><td>개발팀</td><td>사원</td><td>2022-01-01</td><td>2023-01-01</td><td>3000만원</td></tr>
            <tr><td>개발팀</td><td>사원</td><td>2022-01-01</td><td>2023-01-01</td><td>3000만원</td></tr>
            <tr><td>개발팀</td><td>사원</td><td>2022-01-01</td><td>2023-01-01</td><td>3000만원</td></tr>
            <c:forEach items="${detail.list}" var="item">
            	<tr>
	            	<td>${detail.depart_name}</td>
	            	<td>${detail.rank_name}</td>
	            	<td>${detail.start_date}</td>
	            	<td>${detail.end_date}</td>
	            	<td>${detail.salary}</td>
            	</tr>
			</c:forEach>
          </table>
        </div>
        <div class="attachment-info">
		  <h2>첨부 파일</h2>
		  <table>
		    <tr><th>파일명</th><th>업로드 날짜</th></tr>
		    <tr><td>인사기록.pdf</td><td>2024-01-15</td></tr>
		    <tr><td></td><td></td></tr>
		    <tr><td></td><td></td></tr>
		    <tr><td></td><td></td></tr>
		    <tr><td></td><td></td></tr>
		    <tr class="file-upload">
		      <td><div class="notBtn">파일을 등록 해주세요</div></td>
		      <td><button class="normalBtn">파일첨부</button></td>
		    </tr>
		  </table>
		</div>
      </div>
    </div>
  </div>
</body>
</html>
