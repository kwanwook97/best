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

    .lPurple {
      color: #8B6AA7; /* 연보라색 */
    }

    .cPurple {
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

    /* 버스 카드 스타일 */
    .bus-list {
      display: flex;
      flex-direction: column;
      gap: 20px;
      margin: 5% 0;
      height: 70%;
      max-height: 70%;
      overflow-y: auto; /* 높이를 초과하면 스크롤 생성 */
      
    }

    .bus-card {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 3%;
      display: flex;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      height: 230px;
      font-weight: bold;
    }
    


    .bus-number {
      font-size: 48px;
      font-weight: bold;
      flex: 0 0 10%; /* 비율 10% */
      text-align: left;
      margin: auto 0;
    }

	/* 초록색 글씨 */
	.cGreen {
		color: #1DD20C;
	}

	/* 파란색 글씨 */
	.cBlue {
		color: #2A33DD;
	}

    .bus-details {
      flex: 0 0 15%; /* 비율 15% */
      font-size: 18px;
      font-weight: bold;
      color: #30005A;
      margin: auto 0;
    }

    .bus-details p strong {
      color: #8B6AA7; /* 연보라색 */
    }

    .driver-list {
	  display: grid; /* grid를 사용 */
	  grid-template-columns: repeat(12, 1fr); /* 12개의 열 */
	  gap: 10px; /* 각 요소 간 간격 */
	  font-size: 18px;
	  color: #30005A;
	}


    .driver-list span {
      display: inline-block;
      margin-right: 10px;
      white-space: nowrap;
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath">
      <span class="lPurple">운행정보</span> <span class="cPurple">&gt; 배차정보</span>
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
          <p><strong>현재 운행:</strong> 27</p>
          <p><strong>배차 기사:</strong> 32</p>
        </div>
        <div class="driver-list">
          <span>이종원 기사,</span> <span class="lPurple">전미경 기사,</span> <span>강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span>이혜연 기사,</span> <span class="lPurple">이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
          <span>이종원 기사,</span> <span>전미경 기사,</span> <span>강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span class="lPurple">이혜연 기사,</span> <span>이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
          <span>이종원 기사,</span> <span>전미경 기사,</span> <span class="lPurple">강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span>이혜연 기사,</span> <span>이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cGreen">7611</div>
        <div class="bus-details">
          <p><strong>현재 운행:</strong> 27</p>
          <p><strong>배차 기사:</strong> 32</p>
        </div>
        <div class="driver-list">
          <span>이종원 기사,</span> <span>전미경 기사,</span> <span>강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span>이혜연 기사,</span> <span>이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cBlue">503</div>
        <div class="bus-details">
          <p><strong>현재 운행:</strong> 27</p>
          <p><strong>배차 기사:</strong> 32</p>
        </div>
        <div class="driver-list">
          <span>이종원 기사,</span> <span>전미경 기사,</span> <span>강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span>이혜연 기사,</span> <span>이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cBlue">652</div>
        <div class="bus-details">
          <p><strong>현재 운행:</strong> 27</p>
          <p><strong>배차 기사:</strong> 32</p>
        </div>
        <div class="driver-list">
          <span>이종원 기사,</span> <span>전미경 기사,</span> <span>강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span>이혜연 기사,</span> <span>이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
        </div>
      </div>

      <div class="bus-card">
        <div class="bus-number cBlue">999</div>
        <div class="bus-details">
          <p><strong>현재 운행:</strong> 27</p>
          <p><strong>배차 기사:</strong> 32</p>
        </div>
        <div class="driver-list">
          <span>이종원 기사,</span> <span>전미경 기사,</span> <span>강관욱 기사,</span> <span>장희재 기사,</span>
          <span>이진형 기사,</span> <span>이혜연 기사,</span> <span>이경언 기사,</span> <span>황수인 기사,</span>
          <span>류경민 기사,</span> <span>서승범 기사,</span> <span>한범희 기사,</span> <span>김진형 기사</span>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
