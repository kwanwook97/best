<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css" rel="stylesheet">
  <script src="/BEST/resources/js/index.global.js"></script>
  <script src="resources/jquery.twbsPagination.js"></script>
  <link rel="stylesheet" href="/BEST/resources/css/pagination.css">
  
  
  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
   }
    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: 7vh;
       flex-wrap: wrap;
       padding: 2vh;
       color: var(--primary-color);
       border: 1px solid #00000000;
       height: 92%;
       display: flex;
       flex-direction: column;
       align-content:center;
       justify-content: center;
   }
   
/*  기본 css   */
	.title-name{
		display: block;
		position: absolute;
		top: 12%;
		left: 17%;
		width: 79%;
	}
	.title-line{
		width: 100%;
		height: 1px;
		background-color: #100f0f4a;
	}
/* 회의실 정보 css */
        .room-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            width: 90%;
            height: 72%;
            margin: 6% 0 0 0;
        }
        .room-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);

        }
        .room-card img {
            object-fit: cover;
        	width: 100%;
            height: 84%;
            padding: 3% 2%;
            border-bottom: 1px solid #00000014;
            border-radius: 0 0 0 0px;
        }
        .room-info {
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .room-info h3 {
            margin: 0;
            font-size: 22px;
        }
        .delete-btn {
            color: red;
            font-size: 20px;
            cursor: pointer;
        }
        .btn-addRoom {
        	margin: 2% 0 0 3%;
        	font-size: 20px;
        }
/* 모달 css  */        
/* 모달 배경 스타일 */
.modal {
    display: none; /* 초기에는 숨김 */
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
}

/* 모달 내용 스타일 */
.room-modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 20px;
    border: 1px solid #ddd;
    width: 50%;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.3);
}

/* 닫기 버튼 스타일 */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover {
    color: black;
}

/* 테이블 스타일 */
.form-table {
    width: 100%;
    border-collapse: collapse;
}

.form-table td {
    padding: 8px;
    vertical-align: middle;
}
.form-table td label{
	color: black;
}

.align-top {
    vertical-align: top;
}

input[type="text"], input[type="number"], input[type="file"] {
    width: 24%;
    padding: 0px;
    box-sizing: border-box;
}

/* 체크박스 간격 */
input[type="checkbox"] {
    margin-right: 5px;
}

label {
    display: inline-block;
    margin-bottom: 5px;
    margin-right: 10px;
}

/* 버튼 스타일 */
.btn {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
}

.btn:hover {
    background-color: #0056b3;
}

.button-area {
    text-align: center;
    margin-top: 15px;
}
	
  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="title-name">
	    <h1>회의실 정보</h1>
	    <div class="title-line"></div>
	    <button class="btn-primary btn-addRoom" onclick="addRoom()">회의실 등록</button>
	</div>
 	<div class="dashboard-body">
	    <div class="room-container">

	    </div>

 	</div>

    <!-- 모달 창 -->
    <div id="roomModal" class="modal">
        <div class="room-modal-content">
            <span class="close">&times;</span>
            <h2>회의실 추가</h2>
            <table class="form-table">
                <tr>
                    <td><label>회의실 이름</label></td>
                    <td><input type="text" placeholder="회의실 이름을 입력하세요"></td>
                </tr>
                <tr>
                    <td><label>회의실 대표 이미지</label></td>
                    <td><input type="file"></td>
                </tr>
                <tr>
                    <td class="align-top"><label>회의실 기본 장비</label></td>
                   	<td>
                   		<select>
                   			<option>없음</option>
                   			<option></option>
                   		</select>
                   	</td>
                </tr>
            </table>
            <div class="button-area">
                <button class="btn">저장</button>
            </div>
        </div>
    </div>

 	
</body> 
<script>
/* roomCard(); */

function roomCard() {
    $.ajax({
        type: 'GET',
        url: 'roomList.ajax',
        data: {},
        dataType: 'JSON',
        success: function(data) {
            console.log('AJAX 데이터:', data);

            if (data.list && data.list.length) {
                drawRoomCard(data.list);
				

            } else {
                noList();
            }
        },
        error: function(e) {
            console.log(e);
        }
    });
}



function addRoom() {
    document.querySelector('#roomModal').style.display = 'block';
}

function closeModal() {
    document.querySelector('.meetingmodal').style.display = 'none';
}

</script>
</html>
