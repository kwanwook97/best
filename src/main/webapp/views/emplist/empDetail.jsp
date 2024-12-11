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
      justify-content: space-between;
      align-items: flex-start;
    }

    .profile-pic {
      width: 300px;
      height: 300px;
      border: 2px solid #30005A; /* 테두리 추가 */
      border-radius: 10px;
      background-color: #E0E0E0;
      flex-shrink: 0;
    }

    .employee-info {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      margin-left: 20px;
      font-size: 18px;
      font-weight: bold;
      color: #30005A;
      width: 65%;
    }

    .employee-info p {
      margin: 15px 0;
      display: flex;
    }

    .employee-info strong {
      flex-shrink: 0;
      color: #30005A;
      width: 150px; /* 고정 너비로 정렬 */
      text-align: left;
    }

    .employee-info span {
      color: #8B6AA7; /* 연보라색 */
    }

    /* 등록 버튼 */
    .register-btn {
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #E9396B;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      padding: 10px 20px;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      position: absolute;
      top: 20px;
      right: 20px;
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
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath">
      <span class="lPurple">사원관리</span> <span class="cPurple">&gt; 사원등록</span>
    </div>

    <!-- 콘텐츠 박스 -->
    <div class="content">
      <!-- 프로필 사진 -->
      <div class="profile-pic"></div>

      <!-- 사원 정보 -->
      <div class="employee-info">
        <p><strong>이름:</strong> <span>홍길동</span></p>
        <p><strong>입사일:</strong> <span>2024-12-09</span></p>
        <p><strong>주민번호:</strong> <span>900101-1234567</span></p>
        <p><strong>이메일:</strong> <span>hong@example.com</span></p>
        <p><strong>전화번호:</strong> <span>02-1234-5678</span></p>
        <p><strong>주소:</strong> <span>서울특별시 강남구</span></p>
        <p><strong>연봉:</strong> <span>50,000,000원</span></p>
        <p><strong>계좌번호:</strong> <span>123-456-7890</span></p>
        <p><strong>발령 부서:</strong> <span>운영팀</span></p>
        <p><strong>발령 팀:</strong> <span>1팀</span></p>
        <p><strong>직책:</strong> <span>팀장</span></p>
      </div>

      <!-- 등록 버튼 -->
      <button class="register-btn">
        <i class="fas fa-edit"></i>등록
      </button>
    </div>
  </div>
</body>
</html>
