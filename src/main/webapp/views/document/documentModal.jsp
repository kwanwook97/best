<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/root.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="resources/js/document/read-unread.js" type="text/javascript"></script>
<script src="resources/js/document/documentDetail.js" type="text/javascript"></script>
<style>
#plus1{
	cursor: pointer;
}
input, textarea, #approvalModal, button, select, option{
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
.searchSelect, 
.listSelect{
	border: 1px solid var(--primary-color);
	color: var(--primary-color);
	font-weight: bold;
	border-radius: 10px;
}
.searchSelect option, 
.listSelect option{
	width: 20px;
	color: var(--primary-color);
	background-color: white;
	font-size: 14px;
	font-weight: bold;
	text-align: center;
}
.searchbox {
	width: 40%;
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
	cursor: pointer;
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
    left: -255px;
    width: 1844px;
    height: 954px;
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
.modal div.modal-content{
    left: 6%;
    transform: scale(0.8) !important;
}
input.manager, input.today2, input.today3{
    all: unset; /* 모든 기본 스타일 제거 */
    width: 7vw; /* 필요에 따라 크기 지정 */
    border: none; /* 테두리 제거 */
    background: none; /* 배경 제거 */
    padding: 0; /* 여백 제거 */
    font: inherit; /* 상속받은 글꼴 사용 */
}
select option{
	background: white;
}
}
</style>
</head>
<body>
	<div class="docnav">
		<div class="opt">
			<div>
				<a href="documentPending.go">대기</a>
				<span class="total"></span>
			</div>
			<div>
				<a href="documentBoard.go">진행중</a>
			</div>
			<div>
				<a href="documentApproved.go">완료</a>
			</div>
			<div>
				<a href="documentReject.go">반려</a>
			</div>
			<div>
				<a href="documentReference.go">참조</a>
			</div>
			<div>
				<a href="documentDraft.go">임시저장<span></span></a>
			</div>
		</div>
		<div class="searchbox"> 
	   		<select class="listSelect">
	            <option class="listOpt" value="received">받은문서</option>
	            <option class="listOpt" value="sent">보낸문서</option>
	        </select>
			<select class="searchSelect">
	          <option class="searchOpt" value="docNum">문서번호</option>
	          <option class="searchOpt" value="type">분류</option>
	          <option class="searchOpt" value="subject">제목</option>
	          <option class="searchOpt" value="emp">기안자</option>
	        </select>
			<div class="search">
				<input type="text" name="query"><i class="fas fa-search listIcon"></i>
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
					placeholder="양식 검색" onkeyup="searchForm(this.value)"> <i class="fas fa-search"></i>
			</div>
			<hr />
			<!-- 항목 리스트 -->
			<ul class="modal-list">
			</ul>
		</div>
	</div>
	<jsp:include page="findAddD.jsp"></jsp:include>
	<jsp:include page="refFindAdd.jsp"></jsp:include>
</body>
<script>

$(document).ready(function() {
    const currentPage = window.location.pathname; // 현재 페이지의 URL 경로를 가져옵니다.

    if (currentPage.includes('documentReference.go')) {
        $('.listSelect').show(); // listSelect를 보이게 설정
        $('.listSelect').empty(); // 기존 옵션 제거
        $('.listSelect').append('<option class="listOpt" value="received">받은문서</option>'); // 받은문서 옵션만 추가
    } else if (currentPage.includes('documentDraft.go')) {
        $('.listSelect').hide(); // listSelect를 숨김
        $('.listSelect').empty(); // 기존 옵션 제거
        $('.listSelect').append('<option class="listOpt" value="save">받은문서</option>');
        $('.searchbox').css("width", "32%");
    }

    
	// 작성 버튼 클릭 시 모달 열기
	$(".editbtn").click(function() {
		$("#customModal").fadeIn();
		$.ajax({
	        url: 'formList.ajax',
	        type: 'GET',
	        success: function(data) {
	            var ul = $('.modal-list');
	            ul.empty();

	            data.forEach(function(form) {
	                var li = $('<li class="modal-item" onclick="documentForm('+form.form_idx+')"></li>');
	                li.text(form.form_subject);

	                ul.append(li);
	            });
	        },
	        error: function(error) {
	            console.log(error);
	        }
	    });
	});

	// 화살표 뒤로가기
	$(".far.fa-arrow-alt-circle-left").click(function() {
		$("#customModal").fadeOut(); // 뒤로가기 기능 실행
	});
	
   var inputValue = $('input[data-index="1"]').val();
   console.log(inputValue);  // 해당 input의 value를 콘솔에 출력
   
   // 결재양식 검색
   $(".modal-input").on("keyup", function(event) {
       var query = $(this).val();
       searchForm(query);
   });
   
   // 리스트 검색
   $('.listIcon').on('click', function() {
       searchList();   
   });

   // 엔터 키로 검색
   $('input[name="query"]').on('keypress', function(e) {
       if (e.which === 13) { // Enter key
    	   searchList();   
       }
   });
   
   
   // 페이지 로드 시 초기화 (기본값 설정)
   $('.listSelect').trigger('change');

// 임시저장일 때 searchSelect 설정
   function setSearchOptionsForTempSave() {
       $('.searchSelect').empty(); // 기존 옵션 제거

       // 임시저장에 대한 고정 옵션
       const tempSaveOptions = [
           { value: 'subject', text: '제목' },
           { value: 'docNum', text: '문서번호' },
           { value: 'type', text: '분류' } // 기안자(emp) 제외
       ];

       // 옵션 추가
       tempSaveOptions.forEach(optionData => {
           $('.searchSelect').append(
               $('<option>', { value: optionData.value, text: optionData.text })
           );
       });
   }

   // 일반적인 listSelect 변경 이벤트 처리
   $('.listSelect').on('change', function () {
       const selectedValue = $(this).val();

       // searchSelect의 기존 옵션 제거
       $('.searchSelect').empty();

       // listSelect에 따른 옵션 추가
       if (optionsMap[selectedValue]) {
           optionsMap[selectedValue].forEach(optionData => {
               $('.searchSelect').append(
                   $('<option>', { value: optionData.value, text: optionData.text })
               );
           });
       }
   });

   // 페이지 로드 시 초기화
   $(document).ready(function () {
       if (text === '임시저장') {
           console.log("임시저장 상태: searchSelect 옵션을 임시저장에 맞게 설정합니다.");
           setSearchOptionsForTempSave(); // 임시저장 전용 옵션 설정
       } else {
           console.log("일반 상태: listSelect와 연동하여 searchSelect 옵션 설정.");
           $('.listSelect').trigger('change'); // listSelect 변경 이벤트 트리거
       }
   });

   // 각 listSelect 값에 따른 searchSelect의 옵션 정의
   const optionsMap = {
       received: [
           { value: 'docNum', text: '문서번호' },
           { value: 'type', text: '분류' },
           { value: 'subject', text: '제목' },
           { value: 'emp', text: '기안자' }
       ],
       sent: [
           { value: 'docNum', text: '문서번호' },
           { value: 'type', text: '분류' },
           { value: 'subject', text: '제목' }
       ]
   };

   
});


function documentForm(form_idx) {
    $.ajax({
        type: 'GET',
        url: 'getForm.ajax',
        data: { form_idx: form_idx },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);
         	$("#customModal").fadeOut();
            openModal(response, form_idx);
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}
//모달 열기
function openModal(content, form_idx) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
	var modalClass = '';

    // 모달 HTML 생성
    var modalHtml = 
        '<div id="' + modalId + '" class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <button class="modal-btn Approve" onclick="btnAction(\'기안\')">기안</button>' +
        '      <button class="modal-btn save" onclick="btnAction(\'임시저장\')">임시저장</button>' +
        '      <button class="modal-btn append" onclick="refOpenUserBoxModal()">참조자 추가</button>' +
        '      <button class="modal-btn append" onclick="openUserBoxModal()">결재선 추가</button>' +
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
    script.src = 'resources/js/document/document-call.js';
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
   		var selectedDate = $(this).val(); 
       
       	// 선택된 날짜가 오늘 이전이라면
       	if (selectedDate < today) {
           	alert('지난 날짜는 선택할 수 없습니다.');
           	$(this).val(today);
       	}
   	});
   	
 	// 앞선 날짜와 뒤의 날짜 input 요소 지정
   	var $startDate = $('input[name="start_date"]');
   	var $endDate = $('input[name="end_date"]');

   	// 날짜 변경 시 처리
   	$('.ipt_editor_date').change(function () {
   	    var startDate = $startDate.val();
   	    var endDate = $endDate.val();

   	    // 앞선 날짜가 설정되었고 뒤의 날짜가 앞선 날짜 이전이라면
   	    if (startDate && endDate && endDate < startDate) {
   	        alert(''+startDate+' 이후로만 선택 가능합니다.');
   	        $endDate.val(startDate);
   	    }
   	});
}
var isApprovalLineAdded = false;
// 결재 기안, 임시저장
function btnAction(actionType) {
	if (actionType === '기안' && !isApprovalLineAdded || actionType === '기안수정' && !isApprovalLineAdded) {
        alert('결재선을 추가해주세요!');
    } else {
		console.log(actionType);
		var doc_idx = $('input[name="doc_idx"]').val();
		console.log("문서번호 "+doc_idx);
		var form_idx = $('input[name="form_idx"]').val();
		console.log("폼idx "+form_idx);
		var doc_subject = $('input[name="doc_subject"]').val();
		console.log("제목 :"+ doc_subject);
		var textareaValue = $('.modal-content:last-child textarea').val();
		console.log("본문", textareaValue);
		var updatedHtml = $('.modal-content:last-child').html();
		console.log("html : ", updatedHtml);
	    var start_date = $('input[name="start_date"]').val();
	    console.log("연차 시작", start_date);
	    var end_date = $('input[name="end_date"]').val();
	    console.log("연차 끝", end_date);
	   
        var managerName = $('.managerName').html();
        var managerName1 = $('.manager').val();
        
	    //참조 idx
   		var managerIds = [];		
	    $('.refEmps .refEmp').each(function() {
	        var managerIdx = $(this).data('emp-idx');
	        managerIds.push(managerIdx);
	    });
	    console.log("아니!!!!!!!!!!!!!!!!!!"+ managerIds);
	    
	    var values = [];
	    $('input[data-index], select[data-index]').each(function() {
	        if ($(this).is('select')) {
	            values.push($(this).val() || '');
	        } else {
	            values.push($(this).val());
	        }
	    });
	    console.log("잘 쳐 나오라고",values);
	    
	    
	    if(actionType == '수정기안' || actionType == '수정'){
	    	updatedHtml = updatedHtml.replace(
	   		    /(<input[^>]*\bname=["']doc_subject["'][^>]*)\s*value=["'][^"]*["']/i,
	   		    function(match, group) {
	   		        return group + ' value="' + doc_subject + '"';  // 기존 value 속성 덮어쓰기
	   		    }
	   		);
	    	// HTML에서 <textarea> 부분을 찾아서 그 안의 값을 textareaValue로 덮어씁니다
	    	updatedHtml = updatedHtml.replace(
	    	    /<textarea[^>]*>.*?<\/textarea>/,  // 기존 textarea 태그와 그 안의 내용을 찾아냄
	    	    function(match) {
	    	        // 기존 내용이 있을 경우, 그 내용을 덮어씁니다
	    	        return match.replace(/<textarea[^>]*>(.*?)<\/textarea>/, '<textarea>' + textareaValue + '</textarea>');
	    	    }
	    	);
	    }else{    	
			// HTML에서 <input name="doc_subject"> 부분 찾아서 그 안의 값을 doc_subject로 변경
			updatedHtml = updatedHtml.replace(
			    /<input([^>]*\bname=["']doc_subject["'][^>]*)>/i,
			    '<input$1 value="' + doc_subject + '">'
			);
			console.log("After Replace: ", updatedHtml);
			// HTML에서 <textarea> 부분을 찾아서 그 안의 값을 textareaValue로 변경합니다
			updatedHtml = updatedHtml.replace(
			    /<textarea[^>]*>.*?<\/textarea>/,  // 기존 textarea 태그와 그 안의 내용을 찾아냄
			    '<textarea>' + textareaValue + '</textarea>'  // textarea 값을 새로 덮어씌움
			);
	    }
	    
		// 수정된 HTML을 다시 modal-content에 적용
		$('.modal-content:last-child').html(updatedHtml);
		var doc_content = $('.modal-content:last-child .content').html();
	
		console.log("최최종 : "+doc_content);	
		var data = {
			doc_idx: doc_idx,
		    form_idx: form_idx,
		    action: actionType,
		    doc_subject: doc_subject,
	        doc_content: doc_content,
	        managerIds: managerIds,
	        managerName: managerName,
        	managerName1: managerName1
		};
		
		switch (form_idx) {
		    case '1':
		    	if(actionType == '수정기안' || actionType == '수정'){
		    		console.log("이거 누름");
		    		// start_date 값 삽입
		    		updatedHtml = updatedHtml.replace(
					    /(<input[^>]*\bname=["']start_date["'][^>]*)\s*value=["'][^"']*["']/i,
					    function(match, group) {
					        return group + ' value="' + start_date + '"';
					    }
					);
					updatedHtml = updatedHtml.replace(
					    /(<input[^>]*\bname=["']end_date["'][^>]*)\s*value=["'][^"']*["']/i,
					    function(match, group1) {
					        return group1 + ' value="' + end_date + '"';
					    }
					);
			    	$('.modal-content:last-child').html(updatedHtml);
			    	var doc_content = $('.modal-content:last-child .content').html();
			    	
		        	data.start_date = start_date;
		            data.end_date = end_date;
		            data.doc_content = doc_content;
		            data.managerName = $('.managerName').html();
		            data.managerName1 = $('.manager').val();
		    	}else{
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
			    	
		        	data.start_date = start_date;
		            data.end_date = end_date;
		            data.doc_content = doc_content;
		    	}
		        break;
		    case '2':
		        break;
		        
		    case '3':
		    case '4':
		    case '5':
		    	if (actionType == '수정기안' || actionType == '기안') {
		    		for (var i = 0; i < values.length; i++) {
		    		    var value = values[i];
		    		    var dataIndex = i + 1;
		    		    console.log('Processing value:', value);
		    		    console.log('Initial updatedHtml:', updatedHtml);

		    		 	// 정규식으로 찾기 (태그 내용 무시)
						var specificSelectTag1 = updatedHtml.match(
						    new RegExp('<select[^>]*\\bdata-index=["\']2["\'][^>]*>', 'g')
						);
						console.log('Specific select tag for data-index="2" (no content):', specificSelectTag1);
						
						// 정규식으로 찾기 (태그 내용 포함)
						var specificSelectTag2 = updatedHtml.match(
						    new RegExp('<select[^>]*\\bdata-index=["\']2["\'][^>]*>(.*?)<\/select>', 'g')
						);
						console.log('Specific select tag for data-index="2" (with content):', specificSelectTag2);
						
						// 대체 로직으로 찾기
						var allSelectTags = updatedHtml.match(/<select[^>]*>/g);
						var specificSelectTag3 = null;
						
						if (allSelectTags) {
						    specificSelectTag3 = allSelectTags.find(tag => tag.includes('data-index="2"'));
						    console.log('Specific select tag for data-index="2" using alternative logic:', specificSelectTag3);
						}


		    		    // 대체 로직으로 특정 태그 찾기
		    		    var allSelectTags = updatedHtml.match(/<select[^>]*>/g);
		    		    if (allSelectTags) {
		    		        for (var tag of allSelectTags) {
		    		            if (tag.includes('data-index="2"')) {
		    		                console.log('Matched specific select tag using alternative logic:', tag);
		    		            }
		    		        }
		    		    }

		    		    // 태그내용 없음
		    		    var specificSelectTag1 = updatedHtml.match(
		    		    	    new RegExp('<select[^>]*\\bdata-index=["\']2["\'][^>]*>', 'g')
		    		    	);
		    		    	console.log('Specific select tag for data-index="2" (no content):', specificSelectTag1);
		    		    	
		    		    // 태그내용 있음
	    		    	var specificSelectTag2 = updatedHtml.match(
	    		    		    new RegExp('<select[^>]*\\bdata-index=["\']2["\'][^>]*>([\\s\\S]*?)<\\/select>', 'g')
	    		    		);
	    		    		console.log('Specific select tag for data-index="2" (with content):', specificSelectTag2);
		    		    
		    		    // 정규식 확인
		    		    var regex = new RegExp('<select([^>]*data-index=["\']' + dataIndex + '["\'][^>]*)>(.*?)<\/select>', 'g');
		    		    console.log('Testing regex for data-index=' + dataIndex, regex.test(updatedHtml));

		    		    
		    		    // select 태그 처리
		    		    updatedHtml = updatedHtml.replace(
						    new RegExp('<select([^>]*data-index=["\']' + dataIndex + '["\'][^>]*)>([\\s\\S]*?)<\\/select>', 'g'),
						    function (match, group1, group2) {
						        console.log('Processing select with data-index=' + dataIndex);
						        console.log('Value to match:', value);
						
						        // 선택된 option 값을 찾기
						        var selectedText = ''; // 선택된 옵션 텍스트 저장
						        group2.replace(
						            /<option([^>]*value=["\'](.*?)["\']|[^>]*)>(.*?)<\/option>/g,
						            function (optionMatch, optionGroup1, optionValue, optionText) {
						                if (optionMatch.includes('selected')) {
						                    selectedText = optionText.trim(); // 선택된 옵션 텍스트
						                }
						                return optionMatch;
						            }
						        );
						
						        console.log('Selected option text:', selectedText);
						
						        // input 태그로 변환
						        var inputTag = '<input' + group1 + ' value="' + selectedText + '">';
						        console.log('Generated input tag:', inputTag);
						
						        return inputTag;
						    }
						);


		    		    // input 태그 처리
		    		    updatedHtml = updatedHtml.replace(
		    		        new RegExp('<input([^>]*data-index=["\']' + dataIndex + '["\'])([^>]*)>', 'g'),
		    		        function (match, group1, group2) {
		    		            console.log('Processing input with data-index=' + dataIndex);
		    		            if (/value=["\'].*?["\']/.test(group2)) {
		    		                group2 = group2.replace(/value=["\'].*?["\']/, 'value="' + value + '"');
		    		            } else {
		    		                group2 = ' value="' + value + '"' + group2;
		    		            }
		    		            return '<input' + group1 + group2 + '>';
		    		        }
		    		    );
		    		}
		    		
		    		$('.modal-content:last-child').html(updatedHtml);
		    		var doc_content = $('.modal-content:last-child .content').html();
		    		console.log("최종 수정된 HTML: " + doc_content);

		    	}else{
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
					console.log("9999"+doc_content);
			        // 수정된 HTML을 다시 modal-content에 적용
			        $('.modal-content:last-child').html(updatedHtml);
			        var doc_content = $('.modal-content:last-child .content').html();
		    	}
		        break;
		        
		}
		
		if(actionType == '수정기안' || actionType == '기안'){
			$('.modal-content:last-child .content').find('input').each(function () {
			    $(this).attr('readonly', true);
			});
			// 모든 textarea 태그에 readonly 속성 추가
			$('.modal-content:last-child .content').find('textarea').each(function () {
			    $(this).attr('readonly', true);
			});
			data.doc_content = $('.modal-content:last-child .content').html();
			console.log("Ajax 전송 데이터:", data.doc_content);
		}else{			
			// 마지막으로 doc_content를 업데이트된 HTML에서 추출하여 data 객체에 저장
			var doc_content = $('.modal-content:last-child .content').html();
			data.doc_content = doc_content;  
			console.log("최종"+ doc_content);
		}
		
 		$.ajax({
	        type: 'GET',
	        url: 'formType.ajax',
	        data: data,
	        traditional: true,
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
}

// 양식 검색
$(document).ready(function() {
    // keyup 이벤트로 입력 감지
    $(".modal-input").on("keyup", function(event) {
        var query = $(this).val();
        searchForm(query);
    });
});

function searchForm(query) {
    if ($.trim(query) === "") {
        // 입력이 비어 있으면 원래 리스트로 초기화
        resetList(); 
        return;
    }

    $.ajax({
        type: 'POST',
        url: 'searchForm.ajax',
        data: {
            query: query
        },
        dataType: 'JSON',
        success: function (data) {
            var modalList = $(".modal-list");
            modalList.empty(); // 기존 리스트 초기화

            if (data.length > 0) {
                $.each(data, function (index, item) {
                    var li = $("<li></li>")
                        .addClass("modal-item")
                        .text(item.form_subject)
                        .attr("onclick", "documentForm('" + item.form_idx + "')");
                    modalList.append(li);
                });
            } else {
                var li = $("<li></li>")
                    .addClass("modal-item")
                    .text("검색 결과가 없습니다.");
                modalList.append(li);
            }
        },
        error: function (xhr, status, error) {
            console.error("Error:", error);
        }
    });
}

// 원래 리스트를 보여주는 함수
function resetList() {
    var modalList = $(".modal-list");
    modalList.empty();

    $.ajax({
        url: 'formList.ajax',
        type: 'GET',
        success: function(data) {
            var ul = $('.modal-list');
            ul.empty();

            data.forEach(function(form) {
                var li = $('<li class="modal-item" onclick="documentForm('+form.form_idx+')"></li>');
                li.text(form.form_subject);

                ul.append(li);
            });
        },
        error: function(error) {
            console.log(error);
        }
    });
}



//리스트 검색
function searchList() {
	var page = 1;
    var query = $('input[name="query"]').val().trim();
    var searchType = $('.searchSelect').val();
    console.log(searchType);
    var listType = $('.listSelect').val();
    if (query === "") {
        alert("검색어를 입력하세요.");
        return;
    }
    if(text=='참조' || text=='임시저장'){
		var cnt = 15;
	}else{
		var cnt = 6;
	}
    
    console.log("eㅜㅇ"+listType);
	$.ajax({
        type: 'POST',
        url: 'searchList.ajax',
        data: {
        	text: text,
        	page: page,
        	cnt: cnt,
            listType: listType,
            searchType: searchType,
            query: query
        },
        dataType: 'json',
        success: function(data) {
        	var startNumber = (page - 1) * cnt + 1;
        	if(listType=='received'){
	        	if(data.receivedList.length>0){
	            	// 받은 문서
	                searchReceived(data.receivedList,startNumber);
		            // 받은 문서 페이징
		            $('#receivedPage').twbsPagination('destroy');
		            $('#receivedPage').twbsPagination({
		                startPage: 1,
		                totalPages: data.receivedTotalPages,
		                visiblePages: 5,
		                onPageClick: function(evt, page){
		                    console.log("evt", evt);  // 클릭 이벤트
		                    console.log("page", page);  // 클릭한 페이지 번호
		                    searchReceivedPageCall(page, query, searchType, listType);
		                }
		            });
	            }else{
	            	var content = '<tr>';
	        		content += '<td colspan="8"> 검색결과가 없습니다. </td>';
	        		content += '</tr>';
	        		$('.receivedList').html(content);
	        		$('#receivedPage').twbsPagination('destroy');
	            }                         
        	}else if(listType=='sent'){
	       		if(data.sentList.length>0){
		            // 보낸 문서
		            searchSent(data.sentList,startNumber);
		            $('#sentPage').twbsPagination('destroy');
		            // 보낸 문서 페이징
		            $('#sentPage').twbsPagination({
		                startPage: 1,
		                totalPages: data.sentTotalPages,
		                visiblePages: 5,
		                onPageClick: function(evt, page){
		                    console.log("evt", evt);  // 클릭 이벤트
		                    console.log("page", page);  // 클릭한 페이지 번호
		                    searchSentPageCall(page, query, searchType, listType);
		                }
		            });
	            }else{
	            	var content = '<tr>';
	        		content += '<td colspan="6"> 검색결과가 없습니다. </td>'
	        		content += '</tr>';
	        		$('.sentList').html(content);
	        		$('#sentPage').twbsPagination('destroy');
	            }
        	}else{
        		if(data.sentList.length>0){
		            // 보낸 문서
		            searchSent(data.sentList,startNumber);
		            $('#sentPage').twbsPagination('destroy');
		            // 보낸 문서 페이징
		            $('#sentPage').twbsPagination({
		                startPage: 1,
		                totalPages: data.sentTotalPages,
		                visiblePages: 5,
		                onPageClick: function(evt, page){
		                    console.log("evt", evt);  // 클릭 이벤트
		                    console.log("page", page);  // 클릭한 페이지 번호
		                    searchDraftPageCall(page, query, searchType, listType);
		                }
		            });
	            }else if(!data.sentList.length>0 && data.sentList.length==0){
	            	var content = '<tr>';
	        		content += '<td colspan="7"> 검색결과가 없습니다. </td>'
	        		content += '</tr>';
	        		$('.sentList').html(content);
	        		$('#sentPage').twbsPagination('destroy');
	            }else if(data.receivedList.length>0){
	            	// 받은 문서
	                searchReceived(data.receivedList,startNumber);
		            // 받은 문서 페이징
		            $('#receivedPage').twbsPagination('destroy');
		            $('#receivedPage').twbsPagination({
		                startPage: 1,
		                totalPages: data.receivedTotalPages,
		                visiblePages: 5,
		                onPageClick: function(evt, page){
		                    console.log("evt", evt);  // 클릭 이벤트
		                    console.log("page", page);  // 클릭한 페이지 번호
		                    searchReceivedPageCall(page, query, searchType, listType);
		                }
		            });
	            }else if(data.receivedList.length==0){
	            	var content = '<tr>';
	        		content += '<td colspan="8"> 검색결과가 없습니다. </td>';
	        		content += '</tr>';
	        		$('.receivedList').html(content);
	        		$('#receivedPage').twbsPagination('destroy');
	            }
        	}
        },
        error: function(xhr, status, error) {
            console.error("Error:", error);
        }
    });
}
function searchReceived(document,startNumber) {
	
    var content = '';
	var i = startNumber;
	for(var item of document){
		console.log(item.form_subject)
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
		
		var doc_date = new Date(item.doc_date);
		var docDate = doc_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + item.status + '</td>';
 		content += '<td>' + 
		    (item.doc_read == false
		        ? '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '"><i class="fas fa-envelope" title="읽지 않음"></i></a>'
		        : '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '"><i class="fas fa-envelope-open-text" title="읽음"></i></a>') +
		'</td>';
		
		content += '</tr>';
	}
	$('.receivedList').html(content);
}
function searchSent(document,startNumber) {
	
    var content = '';
	var i = startNumber;
	for(var item of document){
		console.log(item.form_subject)
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		
		var doc_date = new Date(item.doc_date);
		var docDate = doc_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + approvDate + '</td>';
		content += '<td>' + item.status + '</td>';
		content += '</tr>';
	}
	$('.sentList').html(content);
}

// 임시저장
function searchDraft(document,startNumber){
	 var content = '';
		var i = startNumber;
		for(var item of document){
			console.log(item.form_subject)
			content += '<tr>';
			content += '<td>' + i++ + '</td>';
			content += '<td>' + item.doc_number + '</td>';
			content += '<td>' + item.form_subject + '</td>';
			if (item.doc_subject && String(item.doc_subject).trim().length > 0) {
			    content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
			} else {
			    content += '<td onclick="draftDetail(' + item.doc_idx + ')">제목 없음</td>';
			}

			var date = new Date(item.doc_date);
			var formattedDate = date.toISOString().split('T')[0];

			content += '<td>' + formattedDate + '</td>';
			content += '<td>' + item.status + '</td>';
			
			content += '<td><a href="javascript:void(0);" class="delete" data-doc-idx="'+item.doc_idx+'"><i class="fas fa-trash-alt delete-icon"></i></a></td>';
			content += '</tr>';
		}
		$('.sentList').html(content);
		
		$('.delete').click(function() {
	        var doc_idx = $(this).data('doc-idx');
	        console.log(doc_idx);
	        $.ajax({
	            type: 'POST',
	            url: 'documentDelete.ajax',
	            data: { doc_idx: doc_idx },
	            success: function(response) {
	                if (response.success) {
	                    console.log('삭제');
	                    pageCall(showPage);
	                } else {
	                	console.log('삭제 실패');
	                }
	            },
	            error: function(e) {
	                console.log(e);
	            }
	        });
	    });
}
//받은 문서
function searchReceivedPageCall(age, query, searchType, listType) {
	if(text=='참조' || text=='임시저장'){
		var cnt = 15;
	}else{
		var cnt = 6;
	}
    $.ajax({
        type: 'POST',
        url: 'searchList.ajax',
        data: {
        	text: text,
            page: page,
            cnt: cnt,
            query: query,
            searchType: searchType,
            listType: listType 
        },
        dataType: 'JSON',
        success: function(data) {
        	var startNumber = (page - 1) * cnt + 1;
        	searchReceived(data.receivedList,startNumber);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}
// 보낸 문서
function searchSentPageCall(page, query, searchType, listType) {
    
	if(text=='참조' || text=='임시저장'){
		var cnt = 15;
	}else{
		var cnt = 6;
	}
    $.ajax({
        type: 'POST',
        url: 'searchList.ajax',
        data: {
        	text: text,
            page: page,
            cnt: cnt,
            query: query,
            searchType: searchType,
            listType: listType
        },
        dataType: 'JSON',
        success: function(data) {
        	var startNumber = (page - 1) * cnt + 1;
        	searchSent(data.sentList,startNumber);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 임시저장
function searchDraftPageCall(page, query, searchType, listType){
	if(text=='참조' || text=='임시저장'){
		var cnt = 15;
	}else{
		var cnt = 6;
	}
    $.ajax({
        type: 'POST',
        url: 'searchList.ajax',
        data: {
        	text: text,
            page: page,
            cnt: cnt,
            query: query,
            searchType: searchType,
            listType: listType 
        },
        dataType: 'JSON',
        success: function(data) {
        	var startNumber = (page - 1) * cnt + 1;
        	searchDraft(data.sentList,startNumber);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}
//검색창 실시간 감지
$('input[name="query"]').on('input', function() {
    var query = $(this).val().trim();

    if (query === "") {
        pageCall(1, "all");
    }
});
    
// 읽음 읽지 않음 필터링
function filterReceivedList() {
    var status = $('#status').val(); // 선택된 값 가져오기
    console.log('Selected Status:', status);

    // Ajax 요청
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
            status: status, // 필터 조건
            page: '1',        // 첫 페이지로 초기화
            cnt: '6'          // 페이지당 게시물 수
        },
        dataType: 'JSON',
        success: function(data) {
            if (data.receivedList && data.receivedList.length > 0) {
                received(data.receivedList); // 리스트 갱신
            } else {
                $('.receivedList').html('<tr><td colspan="8">조건에 맞는 문서가 없습니다.</td></tr>');
            }
        },
        error: function(e) {
            console.log('오류 발생:', e);
        }
    });
}
</script>
</html>