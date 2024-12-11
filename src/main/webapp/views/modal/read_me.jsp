<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>BEST</title>
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

    <!-- 검색 입력창 -->
    <div class="search-input-container">
        <input type="text" class="search-input" placeholder="검색어를 입력하세요" />
        <i class="bi bi-search search-icon"></i>
    </div>
	
	
    <!-- 작은 버튼 -->
    <div class="list">
        <button type="button" class="small-btn">
            <i class="bi bi-pencil"></i> 작성
        </button>
    </div>

	
    <!-- 모달 (경고창) -->
    <!-- message : 모달창의 body 부분에 뿌려지는 문장 -->
    <button type="button" onclick="modal.showAlert('message')" class="mainbtn full">
        경고창 <!-- message: 경고창에 띄울 메시지 -->
    </button>
    <!-- //모달 (경고창) -->
    
    <!-- 모달 (확인창) -->
    <!-- message : 모달창의 body 부분에 뿌려지는 문장 -->
    <!-- addr : 모달창의 확인 버튼클릭시 이동되는 페이지 -->
    <button type="button" onclick="modal.showConfirm('message', 'addr')" class="mainbtn full">
        확인창 <!-- addr: 확인 버튼을 누르면 이동할 경로 -->
    </button>
    <!-- //모달 (확인창) -->
    
    <c:import url="./modal.jsp"></c:import>
</body>
</html>
