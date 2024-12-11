<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <style>
    .body {
      width: 83%;
      margin-top: 110px;
      margin-left: 320px;
    }

    .naviPath {
      font-weight: bold;
      font-size: 32px;
      margin-bottom: 20px;
    }

    .search-bar-container {
      position: relative;
      display: flex;
      justify-content: flex-end;
      align-items: center;
      margin-bottom: 20px;
    }

    .search-bar {
      border: 2px solid #30005A;
      border-radius: 5px;
      padding: 10px 40px 10px 10px;
      width: 300px;
    }

    .search-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #E9396B; /* 돋보기 색 변경 */
      font-size: 16px;
      z-index: 1;
      cursor: pointer;
    }

    .bus-info-list {
      display: flex;
      flex-direction: column;
      gap: 20px;
      font-weight: bold;
    }

    .bus-info-card {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 20px;
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      height: 200px;
    }

    .bus-number {
      font-size: 48px;
      font-weight: bold;
      color: #1DD20C;
      margin-right: 20px;
      flex: 0 0 10%;
    }

    .purple {
      color: #30005A; /* 보라색 */
    }

    .light-purple {
      color: #8B6AA7; /* 연한 보라색 */
    }

    .bus-details {
      display: grid;
      grid-template-columns: repeat(3, 1fr); /* 3열 형식 */
      gap: 10px 20px;
      font-size: 16px;
      color: #8B6AA7; /* 연보라색 */
      flex: 1;
      margin: auto 0;
      margin-right: 15%;
    }

    .bus-details p {
      display: flex;
      align-items: center;
      margin: 0;
    }

    .bus-details p strong {
      min-width: 100px; /* 제목 너비 고정 */
      margin-right: 10px; /* 제목과 내용 사이 간격 */
      text-align: left; /* 제목 왼쪽 정렬 */
      color: #8B6AA7; /* 연한 보라색 */
      font-weight: bold; /* Bold 효과 추가 */
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
     <div class="naviPath">
      <span class="light-purple">운행정보</span>
      <span class="light-purple"> > 버스관리</span>
      <span class="purple"> > 5714</span>
    </div>

    <!-- 검색창 -->
    <div class="search-bar-container">
      <input type="text" class="search-bar" placeholder="검색">
      <i class="fas fa-search search-icon"></i>
    </div>

    <!-- 버스 정보 리스트 -->
    <div class="bus-info-list">
      <!-- 버스 정보 카드 -->
      <div class="bus-info-card">
        <div class="bus-number">5714</div>
        <div class="bus-details">
          <p><strong>차량 번호:</strong> <span class="purple">12 가 1234</span></p>
          <p><strong>운행 상태:</strong> <span class="purple">운행 중</span></p>
          <p><strong>버스 상태:</strong> <span class="purple">정상</span></p>
          <p><strong>연비:</strong> <span class="purple">6 km/L</span></p>
          <p><strong>점검 일:</strong> <span class="purple">2024-10-31</span></p>
          <p><strong>구입일:</strong> <span class="purple">2023-03-28</span></p>
          <p><strong>다음 점검일:</strong> <span class="purple">2025-02-31</span></p>
          <p><strong>제조사:</strong> <span class="purple">현대</span></p>
          <p><strong>운행거리:</strong> <span class="purple">70000km</span></p>
          <p><strong>좌석 수:</strong> <span class="purple">28 석</span></p>
          <p><strong>담당 정비사:</strong> <span class="purple">윤석태 대리</span></p>
          <p><strong>정비 내용:</strong> <span class="purple">정기 점검</span></p>
        </div>
      </div>
      
      <!-- 버스 정보 카드2 -->
      <div class="bus-info-card">
        <div class="bus-number">5714</div>
        <div class="bus-details">
          <p><strong>차량 번호:</strong> <span class="purple">12 가 1234</span></p>
          <p><strong>운행 상태:</strong> <span class="purple">운행 중</span></p>
          <p><strong>버스 상태:</strong> <span class="purple">정상</span></p>
          <p><strong>연비:</strong> <span class="purple">6 km/L</span></p>
          <p><strong>점검 일:</strong> <span class="purple">2024-10-31</span></p>
          <p><strong>구입일:</strong> <span class="purple">2023-03-28</span></p>
          <p><strong>다음 점검일:</strong> <span class="purple">2025-02-31</span></p>
          <p><strong>제조사:</strong> <span class="purple">현대</span></p>
          <p><strong>운행거리:</strong> <span class="purple">70000km</span></p>
          <p><strong>좌석 수:</strong> <span class="purple">28 석</span></p>
          <p><strong>담당 정비사:</strong> <span class="purple">윤석태 대리</span></p>
          <p><strong>정비 내용:</strong> <span class="purple">정기 점검</span></p>
        </div>
      </div>
      
      <!-- 버스 정보 카드3 -->
      <div class="bus-info-card">
        <div class="bus-number">5714</div>
        <div class="bus-details">
          <p><strong>차량 번호:</strong> <span class="purple">12 가 1234</span></p>
          <p><strong>운행 상태:</strong> <span class="purple">운행 중</span></p>
          <p><strong>버스 상태:</strong> <span class="purple">정상</span></p>
          <p><strong>연비:</strong> <span class="purple">6 km/L</span></p>
          <p><strong>점검 일:</strong> <span class="purple">2024-10-31</span></p>
          <p><strong>구입일:</strong> <span class="purple">2023-03-28</span></p>
          <p><strong>다음 점검일:</strong> <span class="purple">2025-02-31</span></p>
          <p><strong>제조사:</strong> <span class="purple">현대</span></p>
          <p><strong>운행거리:</strong> <span class="purple">70000km</span></p>
          <p><strong>좌석 수:</strong> <span class="purple">28 석</span></p>
          <p><strong>담당 정비사:</strong> <span class="purple">윤석태 대리</span></p>
          <p><strong>정비 내용:</strong> <span class="purple">정기 점검</span></p>
        </div>
      </div>
      
      <!-- 버스 정보 카드4 -->
      <div class="bus-info-card">
        <div class="bus-number">5714</div>
        <div class="bus-details">
          <p><strong>차량 번호:</strong> <span class="purple">12 가 1234</span></p>
          <p><strong>운행 상태:</strong> <span class="purple">운행 중</span></p>
          <p><strong>버스 상태:</strong> <span class="purple">정상</span></p>
          <p><strong>연비:</strong> <span class="purple">6 km/L</span></p>
          <p><strong>점검 일:</strong> <span class="purple">2024-10-31</span></p>
          <p><strong>구입일:</strong> <span class="purple">2023-03-28</span></p>
          <p><strong>다음 점검일:</strong> <span class="purple">2025-02-31</span></p>
          <p><strong>제조사:</strong> <span class="purple">현대</span></p>
          <p><strong>운행거리:</strong> <span class="purple">70000km</span></p>
          <p><strong>좌석 수:</strong> <span class="purple">28 석</span></p>
          <p><strong>담당 정비사:</strong> <span class="purple">윤석태 대리</span></p>
          <p><strong>정비 내용:</strong> <span class="purple">정기 점검</span></p>
        </div>
      </div>
      
      <!-- 버스 정보 카드5 -->
      <div class="bus-info-card">
        <div class="bus-number">5714</div>
        <div class="bus-details">
          <p><strong>차량 번호:</strong> <span class="purple">12 가 1234</span></p>
          <p><strong>운행 상태:</strong> <span class="purple">운행 중</span></p>
          <p><strong>버스 상태:</strong> <span class="purple">정상</span></p>
          <p><strong>연비:</strong> <span class="purple">6 km/L</span></p>
          <p><strong>점검 일:</strong> <span class="purple">2024-10-31</span></p>
          <p><strong>구입일:</strong> <span class="purple">2023-03-28</span></p>
          <p><strong>다음 점검일:</strong> <span class="purple">2025-02-31</span></p>
          <p><strong>제조사:</strong> <span class="purple">현대</span></p>
          <p><strong>운행거리:</strong> <span class="purple">70000km</span></p>
          <p><strong>좌석 수:</strong> <span class="purple">28 석</span></p>
          <p><strong>담당 정비사:</strong> <span class="purple">윤석태 대리</span></p>
          <p><strong>정비 내용:</strong> <span class="purple">정기 점검</span></p>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
