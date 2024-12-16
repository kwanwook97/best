<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <style>
    .body {
	height: auto;
	width: 83%;
	margin-top: 80px;
    margin-left: 300px;
	margin-right: 100%;
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
    .green{
		color: #1DD20C;
	}
	.blue{
		color: #2A33DD;
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

.bus-drive-info {
	color: #30005A;
}
.lPurple {
	color: #8B6AA7;
}
.tm2 {
	margin-top: 2%;
	width: 29%;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.5rem;
}
.f32 {
	font-size: 32px;
}
.bold {
	font-weight: bold;
}
.content {
	width: 100%;
	height: 80%;
}
.docnav{
	    width: 100%;
	    display: flex;
	    justify-content: flex-end;
	        margin-bottom: 0.5rem;
	}
	.searchbox{
		width: 24%;
		display: flex;
		align-items: center;
		justify-content: space-evenly;
	}
	.drop{
	    font-size: 14px;
	    border: 1px solid #30005A;
	    border-radius: 4px;
	    color: #30005A;
	}
	select option{
		background-color: white !important;
		border-radius: 5px;
	}
	.search{
		position: relative;
    	display: inline-block;
	}
	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid #30005A;
	}
	.search i{
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 18px;
		pointer-events: none;
		color: #E9396B;
	}
	.editbtn{
		color: #FFFBF2;
		background-color: #E9396B;
		border-radius: 10px;
		width: 70px;
	}
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
     <div class="naviPath bold f32 w100 tm2">
		<span class="lPurple">버스정보</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
		<span class="lPurple">버스관리</span>
			<i class="fa-solid fa-angle-right" style="color:#30005A;"></i>
		<span class="purple">버스수정</span>
		<div class="bus-drive-info">
				
		</div>
	</div>
		<div class="docnav">
			<div>
				<button class="editbtn" onclick="location.href='busUpdate.go'"><i class="far fa-edit"></i>&nbsp;수정</button>
			</div>
		</div>
    <!-- 버스 정보 리스트 -->
    <div class="content">
      <!-- 버스 정보 카드 -->
      <div class="bus-info-card">
       	<div class="bus-details">
      		<p><strong>차량 번호:</strong> <span class="purple"><input type="text"/></span></p>
          	<p><strong>운행 상태:</strong> <span class="purple"><input type="text"/></span></p>
          	<p><strong>버스 상태:</strong> <span class="purple"><input type="text"/></span></p>
          	<p><strong>연비:</strong> <span class="purple"><input type="text"/></span></p>
          	<p><strong>구입일:</strong> <span class="purple"><input type="text"/></span></p>
        	<p><strong>제조사:</strong> <span class="purple"><input type="text"/></span></p>
        	<p><strong>운행거리:</strong> <span class="purple"><input type="text"/></span></p>
        	<p><strong>좌석 수:</strong> <span class="purple"><input type="text"/></span></p>
        </div>
        <div class="bus-details">
        	<p><strong>점검 일:</strong> <span class="purple"><input type="text"/></span></p>
        	<p><strong>다음 점검일:</strong> <span class="purple"><input type="text"/></span></p>
        	<p><strong>담당 정비사:</strong> <span class="purple"><input type="text"/></span></p>
    		<p><strong>정비 내용:</strong> <span class="purple"><input type="text"/></span></p>
    	</div>
      </div>
    </div>
  </div>
</body>
</html>
