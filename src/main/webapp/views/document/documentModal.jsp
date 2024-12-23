<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/root.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<style>
input, textarea, #approvalModal{
	pointer-events: auto;  /* input과 textarea는 마우스 이벤트 허용 */
}
.docnav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 0 48px;
	padding: 0 5px;
}

.opt {
    width: 45%;
	display: flex;
	justify-content: space-between;
}

.opt a{
	color: var(--secondary-color);
}

.opt div {
	display: flex;
	align-content: center;
	align-items: center;
	font-size: 20px;
	font-weight: bold;
	height: 60px;
}

.opt div span {
	color: var(--accent-color);
	margin-left: 5px;
}

.searchbox {
	width: 25%;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.search {
	position: relative;
	display: inline-block;
}

.search input {
	border-radius: 10px;
	padding-left: 10px;
	border: 1px solid var(--primary-color);
}

.search i {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 18px;
	pointer-events: none;
	color: var(--accent-color);
}

.editbtn {
	color: white;
	background-color: var(--accent-color);
	border-radius: 10px;
	width: 70px;
}
a.button{
    text-align: center;
    width: 60px;
    margin-right: 10px;
    display: inline-block;
}
/* 모달 기본 스타일 */
.custom-modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
	z-index: 1000;
}
/* 모달 내용 */
.custom-modal-content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 355px;
	height: auto;
	background-color: var(--background-color);
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	padding: 10px 0 0 10px;
}

.docSearch input {
	color: var(--primary-color);
	font-weight: bold;
}

.modal-input {
	width: 160px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.modal-list {
	list-style: none;
	padding: 0;
}

.modal-item {
	padding: 0 0 10 40px !important;
	cursor: pointer;
	border-radius: 4px;
}

.modal-item:hover {
	background-color: var(--secondary-color);
	color: white;
}

/* 모달 */
.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    pointer-events: none;
}
.modal div,
.modal table{
    pointer-events: none;
}
/* 모달 내용 */
.modal-content {
    border: 2px solid var(--primary-color);
	transform: scale(0.8) !important;
    background-color: white;
    padding: 15px;
    border-radius: 5px;
    width: 44vw;
    position: relative;
}
.modal-content input, 
.modal-content textarea, 
.modal-content button,
.close-btn {
	pointer-events: auto;
}
.modal-box{
	margin-bottom: 20px;
}
input[name="doc_subject"]{
    width: 360px;
}
.modal-btn{
    margin-right: 5px;
}
/* 닫기 버튼 */
.close-btn {
    position: absolute;
    top: 5px; /* 위치 조정 */
    right: 5px; /* 위치 조정 */
    cursor: pointer;
    font-size: 14px; /* 글자 크기 줄이기 */
}
	/* 모달 종류 */
	.one div.modal-content{
        left: 6%;
	    transform: scale(0.9) !important;
	}
	.two div.modal-content{
	    left: 6%;
	    transform: scale(0.8) !important;
	}
	.thr div.modal-content{
	    left: 6%;
	    transform: scale(1) !important;
	    color: black !important;
	}
	input.manager, input.today2, input.today3{
	    all: unset; /* 모든 기본 스타일 제거 */
	    width: 7vw; /* 필요에 따라 크기 지정 */
	    border: none; /* 테두리 제거 */
	    background: none; /* 배경 제거 */
	    padding: 0; /* 여백 제거 */
	    font: inherit; /* 상속받은 글꼴 사용 */
	}
</style>
</head>
<body>
	<div class="docnav">
		<div class="opt">
			<div>
				<a href="documentPending.go">대기<span>1</span></a>
			</div>
			<div>
				<a href="documentBoard.go">진행중<span>12</span></a>
			</div>
			<div>
				<a href="documentApproved.go">완료</a>
			</div>
			<div>
				<a href="documentReject.go">반려<span>3</span></a>
			</div>
			<div>
				<a href="documentReference.go">참조<span>3</span></a>
			</div>
			<div>
				<a href="documentDraft.go">임시저장<span>3</span></a>
			</div>
		</div>
		<div class="searchbox">
			<div class="search">
				<input type="text" name=""><i class="fas fa-search"></i>
			</div>
			<button class="editbtn">
				<i class="far fa-edit"></i>작성
			</button>
		</div>
	</div>
	<!-- 모달 -->
	<div id="customModal" class="custom-modal">
		<div class="custom-modal-content">
			<i class="far fa-arrow-alt-circle-left"></i>
			<!-- 입력 필드 -->
			<div class="search docSearch">
				<input type="text" class="modal-input" name="item"
					placeholder="양식 검색"> <i class="fas fa-search"></i>
			</div>
			<hr />
			<!-- 항목 리스트 -->
			<ul class="modal-list">
				<li class="modal-item" onclick="documentForm('연차신청서')">연차신청서</li>
				<li class="modal-item" onclick="documentForm('시말서')">시말서</li>
				<li class="modal-item" onclick="documentForm('구매요청서')">구매요청서</li>
			</ul>
		</div>
	</div>
</body>
<script>

$(document).ready(function() {
	// 작성 버튼 클릭 시 모달 열기
	$(".editbtn").click(function() {
		$("#customModal").fadeIn(); // 모달 열기 (fade 효과)
	});

	// 화살표 뒤로가기
	$(".far.fa-arrow-alt-circle-left").click(function() {
		$("#customModal").fadeOut(); // 뒤로가기 기능 실행
	});
	
   var inputValue = $('input[data-index="1"]').val();
   console.log(inputValue);  // 해당 input의 value를 콘솔에 출력
   

});


function documentForm(form_subject) {
    $.ajax({
        type: 'GET',
        url: 'getForm.ajax',
        data: { form_subject: form_subject },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);  // 서버에서 받은 HTML 확인
            openModal(response, form_subject); 
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}
//모달 열기
function openModal(content, form_subject) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
	var modalClass = '';

    console.log("누른LI "+form_subject);

    // switch 문을 사용하여 텍스트 값에 따라 변수 이름을 설정합니다.
    switch (form_subject) {
        case "연차신청서":
            modalClass = 'one';
            break;
        case "시말서":
            modalClass = 'two';
            break;
        case "구매요청서":
            modalClass = 'thr';
            break;
    }
    // 모달 HTML 생성
    var modalHtml = 
        '<div id="' + modalId + '" class="modal '+modalClass+'" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <button class="modal-btn Approve" onclick="btnAction(\'기안\')">기안</button>' +
        '      <button class="modal-btn save" onclick="btnAction(\'임시저장\')">임시저장</button>' +
        '      <button class="modal-btn append" onclick="addBtn()">결재선 추가</button>' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="content" contenteditable="true">' + content + '</div>' +
        '  </div>' +
        '</div>';

    // body에 추가
    $('body').append(modalHtml);

    // 모달 표시
    $('#' + modalId).show();

    // 닫기 버튼 이벤트 등록 (이벤트 위임)
    $(document).on('click', '.close-btn', function() {
        var targetModalId = $(this).data('modal-id');
        $('#' + targetModalId).remove();
    });
    
    var script = document.createElement('script');
    script.src = 'resources/js/document-call.js';
    script.type = 'text/javascript';
    document.body.appendChild(script);
	// 오늘 날짜를 yyyy-mm-dd 형식으로 가져오기
  	var today = new Date();
   	var dd = String(today.getDate()).padStart(2, '0');
   	var mm = String(today.getMonth() + 1).padStart(2, '0');
   	var yyyy = today.getFullYear();
   	today = yyyy + '-' + mm + '-' + dd;  // 예: 2024-12-22
   
   	// .ipt_editor_date 클래스의 input 요소에 min 속성 설정
   	$('.ipt_editor_date').attr('min', today);
   
   	// 날짜 값이 변경될 때마다 호출되는 함수
   	$('.ipt_editor_date').change(function() {
   		var selectedDate = $(this).val();  // 선택된 날짜 값
       
       	// 선택된 날짜가 오늘 이전이라면
       	if (selectedDate < today) {
           	alert('오늘 이전 날짜는 선택할 수 없습니다.');
           	$(this).val(today);  // 날짜를 오늘로 강제 설정
       	}
   	});
}

// 결재 기안, 임시저장
function btnAction(actionType) {
	
	var form_idx = $('input[name="form_idx"]').val();
	console.log("폼idx "+form_idx);
	var doc_subject = $('input[name="doc_subject"]').val();
	var textareaValue = $('.modal-content:last-child textarea').val(); 
	var updatedHtml = $('.modal-content:last-child').html();
    var start_date = $('input[name="start_date"]').val();
    var end_date = $('input[name="end_date"]').val();
    // input[data-index]의 값들을 values 배열에 저장
    var values = [];
    $('input[data-index]').each(function() {
        values.push($(this).val());    
    });
	// HTML에서 <input name="doc_subject"> 부분 찾아서 그 안의 값을 doc_subject로 변경
	updatedHtml = updatedHtml.replace(
	    /<input([^>]*name=["']doc_subject["'][^>]*)>/,
	    '<input$1 value="' + doc_subject + '">'
	);
	// HTML에서 <textarea> 부분을 찾아서 그 안의 값을 textareaValue로 변경합니다
	updatedHtml = updatedHtml.replace(
	    /<textarea[^>]*>.*?<\/textarea>/,  // 기존 textarea 태그와 그 안의 내용을 찾아냄
	    '<textarea>' + textareaValue + '</textarea>'  // textarea 값을 새로 덮어씌움
	);
	// 수정된 HTML을 다시 modal-content에 적용
	$('.modal-content:last-child').html(updatedHtml);
	var doc_content = $('.modal-content:last-child .content').html();
	console.log("최종"+ doc_content);
	
	var data = {
	    form_idx: form_idx,
	    action: actionType,
	    doc_subject: doc_subject,
        doc_content: doc_content
	};
	
	switch (form_idx) {
	    case '1':
	        // start_date 값 삽입
	        updatedHtml = updatedHtml.replace(
	            /<input([^>]*name=["']start_date["'][^>]*)>/,
	            '<input$1 value="' + start_date + '">'
	        );

	        // end_date 값 삽입
	        updatedHtml = updatedHtml.replace(
	            /<input([^>]*name=["']end_date["'][^>]*)>/,
	            '<input$1 value="' + end_date + '">'
	        );
	    	// 수정된 HTML을 다시 modal-content에 적용
	    	$('.modal-content:last-child').html(updatedHtml);
	    	var doc_content = $('.modal-content:last-child .content').html();
	    	console.log("최종"+ doc_content);
	    	
        	data.start_date = start_date;
            data.end_date = end_date;
            data.doc_content = doc_content;
	        break;
	    case '2':
	        break;
	        
	    case '3':
	        // 동적으로 추가된 input 값들을 updatedHtml에 반영
			for (var i = 0; i < values.length; i++) { 
			    var value = values[i];  // values 배열에서 값 가져오기
			    var dataIndex = i + 1;  // data-index 값은 1부터 시작한다고 가정
			
			    console.log('Data-Index: ' + dataIndex + ', Value: ' + value);  // 값 확인
			
			    // updatedHtml에서 해당 input 값을 수정
			    updatedHtml = updatedHtml.replace(
			        new RegExp('<input([^>]*data-index=["\']' + dataIndex + '["\'][^>]*)>', 'g'),
			        '<input$1 value="' + value + '">'
			    );
			}

	        // 수정된 HTML을 다시 modal-content에 적용
	        $('.modal-content:last-child').html(updatedHtml);
	        break;
	        
	}
	// 마지막으로 doc_content를 업데이트된 HTML에서 추출하여 data 객체에 저장
	var doc_content = $('.modal-content:last-child .content').html();
	data.doc_content = doc_content;  
	
	$.ajax({
        type: 'GET',
        url: 'formType.ajax',
        data: data,
        success: function(response) {
        	alert(response.message);
        	location.reload();
            if (response.success) {
                // 성공 처리
            } else {
                // 실패 처리
            }
        }
    });
}
function addBtn() {
	$.ajax({
        url: 'orgChartGet.ajax',  // 서버에서 필요한 부분만 반환하도록 설정
        type: 'GET',  // GET 방식으로 요청
        success: function(response) {
        	// 이미 모달이 열려있는지 확인
            if ($('.modal').length === 0) {
                // 서버에서 받은 HTML을 모달 창에 삽입
                var modalHtml = 
                    '<div class="modal" style="display: block;">' +
                    '  <div class="modal-content">' +
                    '    <span class="close-btn">X</span>' +
                    '    <div class="userbox">' + response + '</div>' +
                    '  </div>' +
                    '</div>';

                // body에 모달 추가
                $('body').append(modalHtml);

                // 모달 닫기 기능 추가
                $('.close-btn').click(function() {
                    $(this).closest('.modal').remove();
                });
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX 요청 실패:', error);
        }
    });
    // 기존 signBox 테이블을 찾음
/*     var signBox = $('.signBox');
    var managerName1 = '${managerName1}';
    var todayDate3 = '${todayDate3}';
    // 새로운 table HTML 생성
    var newTableHtml = 
        '<table style="width: 7vw; height: 14vh; border: 1px solid black; border-collapse: collapse;">' +
        '  <tr>' +
        '    <td rowspan="3" style="text-align: center; width: 1.2vw; border: 1px solid black; background-color: gainsboro;">결재</td>' +
        '    <td class="managerName1" style="text-align: center; height: 0.5vh; border: 1px solid black;"><input type="text" class="manager" value="'+managerName1+'" readonly/></td>' +
        '  </tr>' +
        '  <tr>' +
        '    <td class="sign" style="text-align: center; border: 1px solid black;"></td>' +
        '  </tr>' +
        '  <tr>' +
        '    <td class="todayDate3" style="text-align: center; height: 0.5vh; border: 1px solid black;"><input type ="text" class="today3" value="'+todayDate3+'"readonly/></td>' +
        '  </tr>' +
        '</table>';

    // signBox 테이블 뒤에 새로운 table 추가
    signBox.after(newTableHtml); */
}

</script>
</html>