<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <script src="resources/js/bus/busDetail.js"></script>
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
      margin: 0.5rem;
      overflow: auto;
      cursor: pointer;
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
	width: 21%;
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
	display: flex;
    flex-direction: row;
    justify-content: space-around;
	
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
        padding: 3 10 3 10px;
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
		color: #E9396B;
		cursor: pointer;
	}
	.editbtn{
		color: #FFFBF2;
		background-color: #E9396B;
		border-radius: 10px;
		width: 100%;
	    height: 4vh;
	}
	.bus-header {
	width: 92%;
	height: 11vh;
	border: 2px solid #30005A;
	border-radius: 10px;
    padding: 0.4rem;
	background-color: #FFFBF2;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	overflow: hidden; /* 넘치는 텍스트 숨기기 */
	text-overflow: ellipsis; /* ...으로 표시 (옵션) */
	margin-top: 1vh;
    display: flex;
    align-items: center;
	
}
.bus-main-info {
	display: flex;
    justify-content: flex-start;
    cursor: pointer;
}
.bus-detail-card{
	width: 80%;
    height: 93%;
    overflow-y: auto;
}
.bus-detail-card::-webkit-scrollbar {
	display: none;
}
.bus-info{
    width: 18%;
    border: 2px solid #30005A;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    background-color: #30005A;
    justify-content: space-between;
    height: 94%;
}
.bus-info2{
	width: 100%;
	display: flex;
    flex-direction: column;
    align-items: center;
}
.editbtn-div{
	width: 94%;
	margin: 0.5rem;
}


.modal {
  display: none; /* 기본적으로 숨김 */
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 50%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4); /* 반투명 배경 */
}

/* 모달 내용 */
.modal-content {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%); /* 중앙 정렬 */
  background-color: #FFFBF2;
  padding: 10px;
  border: 1px solid #888;
  width: 50%;
  height: 92%;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}

/* 닫기 버튼 */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
.bus-sum{
    margin-top: 1vh;
}
.bus-sum ul{
	padding: 0;
    width: 6vw;
}
.bus-sum li{
	list-style: none;
	display: flex;
    justify-content: space-between;
    font-weight: bold;
}
.bus-sum li strong{
	color: #8B6AA7;
}

  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <div class="body">
     <div class="naviPath bold f32 w100 tm2">
		<span class="lPurple">버스정보</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
		<span class="purple">버스관리</span>
		<div class="bus-drive-info">
				
		</div>
	</div>
		<div class="docnav">
			<div class="searchbox">
				<select class="drop">
				  <option value="busPlateNo">차량 번호</option>
				  <option value="busNo">노선 번호</option>
				</select>
				<div class="search">
					<input type="text" name="keyword" value=""/>
					<i class="fas fa-search"></i>
				</div>
			</div>
		</div>
    <!-- 버스 정보 리스트 -->
    <div class="content">
    <!-- 노선 정보 영역 -->
    <div class="bus-info">
        <div class="bus-info2"></div>
        <div class="editbtn-div">
            <button class="editbtn" onclick="location.href='busInsert.go'"><i class="far fa-edit"></i>&nbsp;등록</button>
        </div>
    </div>

    <!-- 버스 상세 정보 영역 -->
    <div class="bus-detail-card"></div>
</div>
  </div>
</body>
<div id="busUpdateModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <iframe src="busUpdate.go" frameborder="0" style="width: 100%; height: 98%;"></iframe>
  </div>
</div>
<script>

</script>
</html>
