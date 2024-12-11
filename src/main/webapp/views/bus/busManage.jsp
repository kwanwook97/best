<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <style>
    .body {
      height: auto;
      width: 83%;
      margin-top: 110px;
      margin-left: 320px;
    }

    /* 페이지 제목 */
    .naviPath {
      font-size: 36px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .naviPath .lPurple {
      color: #8B6AA7; /* 연보라색 */
    }

    .naviPath .cPurple {
      color: #30005A; /* 진보라색 */
    }

    /* 날짜 네비게이션 */
    .date-navigation {
      position: relative;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 20px 0;
      font-size: 36px;
      font-weight: bold;
      text-align: center;
    }

    .date-content {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .date-button {
      color: #30005A; /* 보라색 글씨 */
      background-color: transparent; /* 배경색 제거 */
      border: none; /* 테두리 제거 */
      cursor: pointer;
      margin: 0 10px;
      font-weight: bold; /* 강조 효과 */
    }

    .date-button:hover {
      text-decoration: underline;
    }

    .current-date {
      margin: 0 20px;
      color: #30005A;
    }

    .search-bar-container {
      position: absolute; /* 부모 요소(date-navigation)를 기준으로 배치 */
      right: 0; /* 오른쪽 끝으로 정렬 */
      top: 50%; /* 수직 가운데 정렬 */
      transform: translateY(-50%);
      display: flex;
      align-items: center;
    }

    .search-bar {
      border: 2px solid #30005A;
      border-radius: 5px;
      padding: 10px 40px 10px 10px;
      font-size: 18px;
      width: 300px;
    }

    .search-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #E9396B; /* 핑크색 */
      font-size: 18px;
      z-index: 1;
    }

    /* 버스 리스트 */
    .bus-list {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 50px;
      margin: 5% 0;
    }

    .bus-card {
	  border: 2px solid #30005A;
	  border-radius: 10px;
	  padding: 15px;
	  display: flex;
	  justify-content: space-between;
	  align-items: flex-start; /* 위쪽 정렬로 변경 */
	  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	  width: 700px;
	}

    .bus-number {
      font-size: 48px;
      font-weight: bold;
      flex: 1;
      text-align: left;
      margin-left: 30px;
    }

    .cGreen {
      color: #1DD20C; /* 초록색 */
    }

    .cBlue {
      color: #2A33DD; /* 파란색 */
    }

    .bus-details {
      flex: 2;
      text-align: left;
      font-size: 18px;
      font-weight: bold;
      color: #30005A;
    }

    .bus-details p {
      display: flex;
      margin: 5px 0;
    }

    .bus-details p strong {
      color: #8B6AA7; /* 연보라색 */
      width: 40%; /* 일정한 너비로 정렬 */
      flex-shrink: 0;
    }

    .bus-details p span {
      color: #30005A; /* 진보라색 */
      margin-left: 10%; /* ':' 이후 간격 */
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath">
      <span class="lPurple">운행정보</span> <span class="cPurple">&gt; 버스관리</span>
    </div>

    <!-- 날짜 선택 영역 -->
    <div class="date-navigation">
      <div class="date-content">
        <button class="date-button">&lt;&lt;</button>
        <button class="date-button">&lt;</button>
        <span class="current-date">2024-12-05 목요일</span>
        <button class="date-button">&gt;</button>
        <button class="date-button">&gt;&gt;</button>
      </div>
      <div class="search-bar-container">
        <input type="text" class="search-bar" placeholder="검색"> 
        <i class="fas fa-search search-icon"></i>
      </div>
    </div>

    <!-- 버스 목록 -->
    <div class="bus-list">
      <div class="bus-card">
        <div class="bus-number cGreen">5714</div>
        <div class="bus-details">
          <p><strong>총 버스:</strong> <span>40</span></p>
          <p><strong>운행 가능 버스:</strong> <span>30</span></p>
          <p><strong>첫 차 시간:</strong> <span>05:00</span></p>
          <p><strong>막 차 시간:</strong> <span>10:30</span></p>
          <p><strong>이용객 수:</strong> <span>489명</span></p>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cGreen">7611</div>
        <div class="bus-details">
          <p><strong>총 버스:</strong> <span>40</span></p>
          <p><strong>운행 가능 버스:</strong> <span>30</span></p>
          <p><strong>첫 차 시간:</strong> <span>05:00</span></p>
          <p><strong>막 차 시간:</strong> <span>10:30</span></p>
          <p><strong>이용객 수:</strong> <span>489명</span></p>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cBlue">503</div>
        <div class="bus-details">
          <p><strong>총 버스:</strong> <span>40</span></p>
          <p><strong>운행 가능 버스:</strong> <span>30</span></p>
          <p><strong>첫 차 시간:</strong> <span>05:00</span></p>
          <p><strong>막 차 시간:</strong> <span>10:30</span></p>
          <p><strong>이용객 수:</strong> <span>489명</span></p>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cBlue">652</div>
        <div class="bus-details">
          <p><strong>총 버스:</strong> <span>40</span></p>
          <p><strong>운행 가능 버스:</strong> <span>30</span></p>
          <p><strong>첫 차 시간:</strong> <span>05:00</span></p>
          <p><strong>막 차 시간:</strong> <span>10:30</span></p>
          <p><strong>이용객 수:</strong> <span>489명</span></p>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
