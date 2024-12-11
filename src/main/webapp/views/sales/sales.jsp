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

    /* 콘텐츠 박스 */
    .content {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 80%;
    }

    /* 날짜 네비게이션 */
    .date-navigation {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 20px;
      font-size: 20px;
      font-weight: bold;
      color: #30005A;
    }

    .date-navigation .date-content {
      display: flex;
      align-items: center;
      justify-content: center; /* 중앙 정렬 */
      flex: 1; /* 남은 공간 차지 */
      font-size: 36px;
      font-weight: bold;
    }

    .date-navigation .date-button {
      background: transparent;
      border: none;
      cursor: pointer;
      font-weight: bold;
      color: #30005A;
    }

    .date-navigation .date-button:hover {
      text-decoration: underline;
    }

    /* 검색 및 등록 */
    .search-container {
      display: flex;
      align-items: center;
      gap: 10px;
      height: 45px; /* 높이를 줄임 */
    }

    .search-filter {
      font-size: 16px;
      font-weight: bold;
      padding: 8px;
      border: 2px solid #30005A;
      border-radius: 10px;
      color: #30005A;
      background-color: #fff;
      cursor: pointer;
      position: relative;
      height: 100%; /* 높이 통일 */
    }
    
    .search-filter-container {
      position: relative;
    }

    .search-filter-container::after {
      content: '\f078'; /* FontAwesome 다운 화살표 */
      font-family: 'Font Awesome 5 Free';
      font-weight: 900;
      position: absolute;
      top: 50%;
      right: 15px;
      transform: translateY(-50%);
      color: #30005A;
      pointer-events: none;
    }

    .search-filter option {
      background-color: #F9F6F1; /* 베이지색 배경 */
      color: #30005A;
    }

    .search-bar {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 0 40px 0 10px; /* 패딩 조정 */
      width: 300px;
      height: 100%; /* 높이 통일 */
      font-weight: bold; /* 글씨 굵게 */
    }

    .search-icon {
      position: absolute;
      top: 50%;
      right: 15px;
      transform: translateY(-50%); /* 수직 중앙 정렬 */
      color: #E9396B;
      font-size: 16px;
      cursor: pointer;
    }

    .register-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #E9396B;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      padding: 8px 20px; /* 높이 축소 */
      border: none;
      border-radius: 10px;
      cursor: pointer;
      height: 100%; /* 높이 통일 */
    }

    .register-btn i {
      margin-right: 5px;
    }

    .register-btn:hover {
      background-color: #D02C5A;
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath">
      <span class="lPurple">매출현황</span> <span class="cPurple">&gt; 2024-12-05</span>
    </div>

    <!-- 콘텐츠 박스 -->
    <div class="content">
      <!-- 날짜 네비게이션 -->
      <div class="date-navigation">
        <!-- 중앙 정렬된 날짜 컨텐츠 -->
        <div class="date-content">
          <button class="date-button">&lt;&lt;</button>
          <button class="date-button">&lt;</button>
          <span>2024-12-05 목요일</span>
          <button class="date-button">&gt;</button>
          <button class="date-button">&gt;&gt;</button>
        </div>

        <!-- 검색 필터 및 등록 버튼 -->
        <div class="search-container">
          <select class="search-filter">
            <option value="name">이름</option>
            <option value="date">날짜</option>
          </select>
          <div style="position: relative;">
            <input type="text" class="search-bar" placeholder="검색">
            <i class="fas fa-search search-icon"></i>
          </div>
          <button class="register-btn">
            <i class="fas fa-edit"></i>등록
          </button>
        </div>
      </div>
      
      <!-- 그래프 내용 여기작성.-->
      
      
      
    </div>
  </div>
</body>
</html>
