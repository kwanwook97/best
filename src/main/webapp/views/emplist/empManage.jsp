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

    /* 검색 및 필터 */
    .search-container {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      gap: 10px;
      margin-bottom: 20px;
    }

    .search-filter-container {
      position: relative;
    }

    .search-filter {
      font-size: 16px;
      padding: 8px;
      border: 2px solid #30005A;
      border-radius: 10px;
      color: #30005A;
      background-color: #fff;
      cursor: pointer;
      appearance: none; /* 기본 화살표 제거 */
      position: relative;
      width: auto; /* 폭을 내용에 맞게 조정 */
      min-width: 100px; /* 최소 너비 */
    }

    .search-filter option {
      background-color: #F9F6F1; /* 베이지색 배경 */
      color: #30005A; /* 텍스트 색상 */
      padding: 8px;
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

    .search-bar {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 10px 40px 10px 10px;
      width: 300px;
    }

    .search-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #E9396B; /* 돋보기 색 */
      font-size: 18px;
      cursor: pointer;
    }

    /* 콘텐츠 박스 */
    .content {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 20px;
      height: 75%;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    /* 사원 리스트 */
    .employee-list {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-top: 30px;
    }

    .employee-card {
      border: 2px solid #30005A;
      border-radius: 10px;
      display: flex;
      align-items: flex-start;
      padding: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .profile-pic {
      width: 80px;
      height: 80px;
      background-color: #E0E0E0;
      border-radius: 10px;
      border: 2px solid #30005A; /* 테두리 추가 */
      flex-shrink: 0;
    }

    .employee-details {
      margin-left: 20px;
      font-size: 16px;
      color: #30005A; /* 진보라색 */
      width: 100%; /* 넓이를 지정 */
    }

    .employee-details .name-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 10px;
    }

    .employee-details p {
      margin: 5px 0;
      display: flex;
    }

    .employee-details p strong {
      flex-shrink: 0;
      color: #30005A; /* 진보라색 */
      width: 120px; /* 모든 강제 정렬 */
      text-align: left;
    }

    .employee-details p span {
      color: #8B6AA7; /* 연보라색 */
      flex-grow: 1;
    }

    /* 페이징 */
    .pagination {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 20px;
      gap: 10px;
      font-size: 40px;
    }

    .pagination a {
      text-decoration: none;
      color: #30005A;
      font-weight: bold;
      padding: 0 10px;
    }

    .pagination a.active {
      color: #8B6AA7; /* 연보라색 */
      text-decoration: underline;
    }

    .pagination a:hover {
      color: #8B6AA7;
      text-decoration: underline;
    }
    
    .bold{
    	font-weight: bold;
    }
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath">
      <span class="lPurple">사원관리</span> <span class="cPurple">&gt; 윤석렬</span>
    </div>

    <!-- 검색 필터 및 검색창 -->
    <div class="search-container">
      <div class="search-filter-container">
        <select class="search-filter bold">
          <option value="name">이름</option>
          <option value="department">부서</option>
          <option value="team">팀</option>
        </select>
      </div>
      <div style="position: relative;">
        <input type="text" class="search-bar" placeholder="검색">
        <i class="fas fa-search search-icon"></i>
      </div>
    </div>

    <!-- 콘텐츠 박스 -->
    <div class="content bold">
      <!-- 사원 리스트 -->
      <div class="employee-list">
        <!-- 사원 카드 -->
        <div class="employee-card">
          <div class="profile-pic"></div>
          <div class="employee-details">
            <div class="name-title">운영팀 윤석렬 팀장</div>
            <p><strong>email:</strong> <span>oppa@gmail.com</span></p>
            <p><strong>tel:</strong> <span>02-1234-1234</span></p>
            <p><strong>mobile:</strong> <span>010-1234-1234</span></p>
          </div>
        </div>
        <!-- 사원 카드 -->
        <div class="employee-card">
          <div class="profile-pic"></div>
          <div class="employee-details">
            <div class="name-title">운영팀 윤석렬 팀장</div>
            <p><strong>email:</strong> <span>oppa@gmail.com</span></p>
            <p><strong>tel:</strong> <span>02-1234-1234</span></p>
            <p><strong>mobile:</strong> <span>010-1234-1234</span></p>
          </div>
        </div>
        <!-- 사원 카드 -->
        <div class="employee-card">
          <div class="profile-pic"></div>
          <div class="employee-details">
            <div class="name-title">운영팀 윤석렬 팀장</div>
            <p><strong>email:</strong> <span>oppa@gmail.com</span></p>
            <p><strong>tel:</strong> <span>02-1234-1234</span></p>
            <p><strong>mobile:</strong> <span>010-1234-1234</span></p>
          </div>
        </div>
        <!-- 사원 카드 -->
        <div class="employee-card">
          <div class="profile-pic"></div>
          <div class="employee-details">
            <div class="name-title">운영팀 윤석렬 팀장</div>
            <p><strong>email:</strong> <span>oppa@gmail.com</span></p>
            <p><strong>tel:</strong> <span>02-1234-1234</span></p>
            <p><strong>mobile:</strong> <span>010-1234-1234</span></p>
          </div>
        </div>
        <!-- 사원 카드 -->
        <div class="employee-card">
          <div class="profile-pic"></div>
          <div class="employee-details">
            <div class="name-title">운영팀 윤석렬 팀장</div>
            <p><strong>email:</strong> <span>oppa@gmail.com</span></p>
            <p><strong>tel:</strong> <span>02-1234-1234</span></p>
            <p><strong>mobile:</strong> <span>010-1234-1234</span></p>
          </div>
        </div>
      </div>

      <!-- 페이징 -->
      <div class="pagination">
        <a href="#">&lt;&lt;</a>
        <a href="#">&lt;</a>
        <a href="#" class="active">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">&gt;</a>
        <a href="#">&gt;&gt;</a>
      </div>
    </div>
  </div>
</body>
</html>
