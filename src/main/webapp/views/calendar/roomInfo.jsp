<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
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
       height: 857px;
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
            width: 341px;
            height: 286px;

        }
        .room-card img {
            object-fit: cover;
        	width: 335px;
            height: 228px;
            padding: 16px 16px;
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
            font-size: 17px;
        }
        .delete-btn {
            color: red;
            font-size: 20px;
            cursor: pointer;
        }
        .btn-addRoom {
        	margin: 21px 0 0 40px;
        	font-size: 14px;
        }
        .p-maxCapacity {
        	margin: 0 -21px 0 0;
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
    width: 35%;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.3);
    max-height: 68%;
    overflow-y: auto;
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
/* .btn-submite {
    background-color: #3474c6;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
}

.btn-submite:hover {
    background-color: #3d8ff8;
} */

.button-area {
    text-align: center;
    margin-top: 15px;
}

#material-input {
	width: 100px;
}

.upload-container {
	width: 100px;
	height: 100px;
}
.preview-roomImgBox {
	width: 300px;
	height: 200px;
	border: 1px solid #00000030;
}
.form-table td:first-child {
    width: 29%; /* 원하는 너비 설정 */
    text-align: left; /* 필요에 따라 텍스트 정렬 */
    vertical-align: top; /* 필요에 따라 텍스트 정렬 */
}
.file-size {
	width: 300px;
}
.room-name {
	width: 141px;
}
#equipment-list {
	color: blue;
}
.lPurple {
	color: #8B6AA7;
}
.cPurple {
	color: #30005A;
}
.headerBox {
	font-size: 32px;
}
.headerBox {
	margin-top: 0%;
	width: 22%;
	display: flex;
	flex-direction: row;
	align-items:center;
	justify-content: space-between;
	margin-bottom: 1.5rem;
}
.headerBox {
	font-weight: bold;
}
.btnadd {
	position: absolute;
	top: 86%;
	left: -1%;
	background-color: #6C0F6C;
	color: #FFF5E2;
	border: 2px solid #6C0F6C;
	border-radius: 10px;
	z-index: 100;
}	
.btnadd:hover {
	opacity: 0.5;
}
.reserveBtn {
	width: 100px;
	color: white;
	border: 1px solid;
	border-radius: 10px;
	padding: 5px;
}
.reserveBtn.first {
	background-color: #6C0F6C;
}
.reserveBtn:hover {
	opacity: 0.5;
}
.modal.modal_alert {
	z-index: 9999 !important;
}
	
  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 	<div class="title-name">
		<div class="headerBox">
			<span class="lPurple">회의실</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
			<span class="cPurple">회의실 관리</span>
		</div>
	    <button class="btn-addRoom btnadd" onclick="addRoom()">회의실 등록</button>
	</div>
 	<div class="dashboard-body">
	    <div class="room-container">

	    </div>

 	</div>

    <!-- 모달 창 -->
    <div id="roomModal" class="modal">
        <div class="room-modal-content">
            <span class="close">&times;</span>
            <h3>회의실 추가</h3>
            <table class="form-table">
                <tr>
                    <td><label>회의실 이름</label></td>
                    <td><input class="room-name" type="text" placeholder="회의실 이름을 입력하세요"></td>
                </tr>
                <tr>
                    <td><label>회의실 대표 이미지</label></td>
                    <td class="upload-container">
                    	<div class="preview-roomImgBox"></div>
                    	<input type="file" class="file-size">
                    </td>
                </tr>
				<tr>
				    <td class="align-top"><label>기자재 리스트</label></td>
				    <td id="equipment-list">
				    	<p> 회의실 기본 기자재를 등록해 주세요
				        <c:forEach var="material" items="${materialList}">
				            <div>
				                <!-- 체크박스 -->
				                <label>
				                    <input type="checkbox" name="selectedMaterials" value="${material.material_idx}" class="material-checkbox">
				                    ${material.material_name} (전체 수량: ${material.remain_quantity})
				                </label>
				                <!-- 수량 입력 -->
				                <input id="material-input" type="number" name="quantity_${material.material_idx}" min="0" max="${material.remain_quantity}" placeholder="수량 입력" class="quantity-input">
				            </div>
				        </c:forEach>
				    </td>
				</tr>
                <tr>
                    <td><label>수용 가능 인원:</label></td>
                    <td>
                    	<input type="number" class="max-capacity">
                    </td>
                </tr>
            </table>
            <div class="button-area">
                <button class="btn-submite reserveBtn first" onclick="saveRoomInfo()">등록</button>
            </div>
        </div>
    </div>

 	
</body> 
<script>
roomCard(); 

function roomCard() {
    $.ajax({
        type: 'GET',
        url: 'roomList.ajax',
        data: {},
        dataType: 'JSON',
        success: function(data) {
            //console.log('AJAX 데이터:', data);
            if (data && data.length) {
            	drawRoomCard(data);

            } else {
                noList();
            }
        },
        error: function(e) {
            //console.log(e);
        }
    });
}



function addRoom() {
    document.querySelector('#roomModal').style.display = 'block';
}

document.querySelector('.close').addEventListener('click', function() {
	closeModel();
});

function closeModel(){
    document.querySelector('#roomModal').style.display = 'none';
    
    document.querySelectorAll('#roomModal input').forEach(function(input) {
        if (input.type === 'checkbox' || input.type === 'radio') {
            input.checked = false; 
        } else {
            input.value = '';
        }
    });
   
    const previewBox = document.querySelector('.preview-roomImgBox');
    if (previewBox) {
        previewBox.style.backgroundImage = '';
    }
	
}

function drawRoomCard(roomList) {
    const container = document.querySelector('.room-container'); // room-container 선택
    container.innerHTML = ''; // 기존 내용 초기화

    roomList.forEach(function(room) {
    	//console.log("테스트 룸: " , room.room_idx);
        const encodedImageUrl = encodeURI(room.photo); // URL 인코딩

        container.innerHTML += 
            '<div class="room-card">' +
                '<img src="/photo/' + encodedImageUrl + '" alt="회의실 이미지">' +
                '<div class="room-info">' +
                    '<h3>' + room.name + '</h3>' +
                    '<p class="p-maxCapacity">' +'수용 가능 인원: ' + '</p>' +
                    '<span class="span-maxCapacity">'+ room.max_capacity +'</span>' +
                    '<span class="delete-btn" onclick="deleteRoom(' + room.room_idx + ')">삭제</span>' +
                '</div>' +
            '</div>';
    });
}

//데이터가 없을 때 실행할 함수
function noList() {
    const container = document.querySelector('.room-container');
    container.innerHTML = '<p>회의실 정보가 없습니다.</p>';
}

// 회의실 정보 저장
function saveRoomInfo() {
    const formData = new FormData();

    const roomName = document.querySelector('.room-name').value;
    if (roomName == null || roomName.trim() === '') {
    	return modal.showAlert("회의실 이름이 등록되지 않았습니다 다시 확인해 주세요!");
	}
    formData.append('roomName', roomName);

    const fileInput = document.querySelector('.file-size');
    const file = fileInput.files[0]; 
    if (file) {
        formData.append('photo', file);
    }else{
    	return modal.showAlert('회의실 사진이 등록되지 않았습니다.');
    }

    const checkboxes = document.querySelectorAll('.material-checkbox:checked');
    if (checkboxes.length === 0) {
        return modal.showAlert('기본기자재가 등록되지 않았습니다.');
    }

    for (const checkbox of checkboxes) {
        const materialIdx = checkbox.value;
        const quantityInput = document.querySelector('input[name="quantity_' + materialIdx + '"]');
        
        if (!quantityInput) {
            return modal.showAlert('기본기자재 입력 필드가 등록되지 않았습니다.');
        }

        const quantity = quantityInput.value;
        console.log("qwe", quantity);
        console.log("quantity value:", quantity, "type:", typeof quantity);

        if (quantity === null || quantity.trim() === '' || parseInt(quantity, 10) <= 0) {
            return modal.showAlert('기본기자재가 등록되지 않았습니다.');
        }

        formData.append('materialIdx', materialIdx);
        formData.append('quantity', quantity);
    }


    const maxCapacity = document.querySelector('.max-capacity').value;
    if (maxCapacity == 0 || maxCapacity == null ) {
    	return modal.showAlert('수용 가능인원이 등록되지 않았습니다.');
	}
    formData.append('maxCapacity', maxCapacity);
    
    

    $.ajax({
        type: 'POST',
        url: 'saveRoomInfo.ajax', 
        data: formData,
        processData: false, 
        contentType: false, 
        success: function(response) {
            modal.showAlert(response.response);
        	closeModel();
            roomCard();
        },
        error: function(error) {
            console.error('저장 실패:', error);
            modal.showAlert('저장 중 오류가 발생했습니다.');
        }
    });
}

function deleteRoom(roomIdx) {
	modal.showConfirm('삭제 하시겠습니까?', function () {
		//console.log("roomIdx: " + roomIdx);
	    $.ajax({
	        type: 'POST',
	        url: 'delRoomInfo.ajax', 
	        data: {
	        	"roomIdx":roomIdx
	        },
	        dataType: 'json',
	        success: function(data) {
	        	//modal.showAlert(data.response);
	        	modal.showAlert("회의실 삭제가 완료되었습니다.");
	            roomCard();
	        },
	        error: function(error) {
	            console.error('저장 실패:', error);
	            modal.showAlert('삭제 중 오류가 발생했습니다.');
	        }
	    });
	});
}


//이미지 미리보기
document.querySelector('.file-size').addEventListener('change', function(event) {
    const file = event.target.files[0];
    const previewBox = document.querySelector('.preview-roomImgBox');

    if (file && file.type.startsWith('image/')) { 
        const reader = new FileReader();


        reader.onload = function(e) {
        	previewBox.style.backgroundImage = "url('" + e.target.result + "')";
            previewBox.style.backgroundSize = 'cover'; 
            previewBox.style.backgroundPosition = 'center';
        };

        reader.readAsDataURL(file); 
    } else {
        modal.showAlert('이미지 파일만 업로드 가능합니다.');
        previewBox.style.backgroundImage = ''; 
        event.target.value = '';
    }
});

</script>
</html>
