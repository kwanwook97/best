<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	div.content_emp div.modal-box{
		display: none;
	}
	div.content_emp,
	div.modal div.modal-content{
	    pointer-events: none !important;
	}
	div.content_emp td.sign,
	div.content_emp table.signBox2 td.signTwo {
	    pointer-events: auto !important;
	}	
	div.content_emp td.sign {
		caret-color: transparent;
		cursor: pointer;	
	    user-select: none;
	}
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 22vw;
        width: 70vw;
	    margin-top: 4vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: 10px;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px;
	    margin-bottom: 40px;
	}
	.docbox{
		border: 2px solid var(--primary-color);
	    width: 100%;
	    height: 745px;
	    border-radius: 10px;
	}
	.opt div:nth-child(1){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:nth-child(1) a{
		color: var(--primary-color) !important;
	}
	.opt div:hover{
		cursor: pointer;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div a:hover{
		color: var(--primary-color);
	}
	table.myTable{
		border-collapse: separate !important;
        border-spacing: 0;
	    width: 90%;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin: 0 48px 15px 48px;
	    text-align: center;
	}
	table.myTable caption.caption{
		color: var(--primary-color) !important;
	    font-size: large;
	    font-weight: bold;
	    text-align: left;
	    caption-side: top;
	}
	table.myTable caption.sentCap{
		padding-top: 0;
	}
	table.myTable tr:not(:last-child) td{
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table.myTable tr{
		border-bottom: 1px solid var(--primary-color);
		height: 35px;
	}
	.receivedList tr td:hover:nth-child(4) {
	    color: var(--accent-color);
	    cursor: pointer;
	}
	.sentList tr td:hover:nth-child(4) {
	    color: var(--accent-color);
	    cursor: pointer;
	}
	table.myTable thead tr{
		background-color: var(--primary-color);
		color: white;
	}
	table.myTable thead tr th:first-child{
		border-top-left-radius: 10px;
	}
	table.myTable thead tr th:last-child{
		border-top-right-radius: 10px;
	}
	table.receivedTable th:nth-child(1) {
	    width: 4%;
	}
	table.receivedTable th:nth-child(2) {
	    width: 12%;
	}
	table.receivedTable th:nth-child(3) {
	    width: 10%;
	}
	table.receivedTable th:nth-child(4) {
	    width: 30%;
	}
	table.receivedTable th:nth-child(5) {
	    width: 8%;
	}
	table.receivedTable th:nth-child(6) {
	    width: 10%;
	}
	table.receivedTable th:nth-child(7) {
	    width: 10%;
	}
	table.receivedTable th:nth-child(8) {
	    width: 7%;
	}
	.table1{
	    position: fixed;
	  	width: 100%;
	}
	table.sentTable th:nth-child(1) {
	    width: 4%;
	}
	table.sentTable th:nth-child(2) {
	    width: 12%;
	}
	table.sentTable th:nth-child(3) {
	    width: 10%;
	}
	table.sentTable th:nth-child(4) {
	    width: 30%;
	}
	table.sentTable th:nth-child(5) {
	    width: 10%;
	}
	table.sentTable th:nth-child(6) {
	    width: 10%;
	}
	.table2{
	    position: fixed;
    	top: 30.5rem;
		width: 100%;
	}
    #status{
		background-color: var(--primary-color);
		border: none;
		color: white;
		font-weight: bold;
    }
    #status option{
    	width: 20px;
    	background-color: var(--primary-color);
    	color: white;
    	font-size: 14px;
    	font-weight: bold;
    	text-align: center;
    }
    #status option:hover{
    	background-color: var(--secondary-color) !important;
    }
	.fa-arrow-alt-circle-left{
		font-size: 20px;
	    margin: 5px;
	}
	.fa-arrow-alt-circle-left:hover{
		cursor: pointer;
		font-weight: bold;
	}
	hr {
	  border-top: 1px solid rgba(0, 0, 0, .1) !important;
	  margin: 10px 0;
	}
	.container nav{
		display:flex;
		justify-content: center;
	}
	.pagination .page-link {
		color: var(--primary-color); /* 글자 색상 */
		background-color: var(--background-color); /* 배경 색상 */
		border: var(--background-color) !important; /* 테두리 */
		font-family: 'Arial', sans-serif; /* 폰트 */
		font-size: 16px; /* 글자 크기 */
		box-shadow: none !important;
	}
	/* 호버 시 스타일 */
	.pagination .page-link:hover {
		font-weight: bold;
		color: var(--accent-color) !important;
		background-color: var(--background-color) !important;
	}
	/* 활성화된 페이지 스타일 */
	.pagination .active .page-link {
		font-weight: bold;
		color: var(--accent-color) !important;
		background-color: var(--background-color) !important;
	}
	/* 클릭 시 생기는 테두리 제거 */
	.pagination .page-link:focus {
	  outline: none;
	  box-shadow: none; /* 부가적인 그림자 효과도 제거 */
	}
	/* 비활성화된 페이지 스타일 */
	.pagination .disabled .page-link {
		color: var(--background-color) !important;
		background-color: var(--background-color) !important;
	}	
	@media ( min-width :1200px) {
		.container {
			max-width: 100% !important;
		}
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"/>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">결재문서</h3>
			<h3 class="text">>&nbsp;&nbsp;대기</h3>
			<a href="sign.go">서명</a>
		</div>
		<div class="docbox">
			<jsp:include page="documentModal.jsp"/>
			<!-- 받은 문서 -->
			<div class="table1">
				<table class="receivedTable myTable">
					<caption class="receivedCap caption">받은 문서</caption>
					<thead>
						<tr>
							<th>NO</th>
							<th>문서번호</th>
							<th>분류</th>
							<th>문서 제목</th>
							<th>기안자</th>
							<th>상신 날짜</th>
							<th>결재 상태</th>
							<th>
								<select id="status" onchange="pageCall(1, this.value)">
						          <option value="all">전체</option>
						          <option value="read">읽음</option>
						          <option value="unread">읽지않음</option>
						        </select>
							</th>
						</tr>
					</thead>
					<tbody class="receivedList">
					</tbody>
				</table>
				<div class="container" id="receivedCont">
				    <nav aria-label="Page navigation">
				        <ul class="pagination" id="receivedPage"></ul>
				    </nav>
				</div>
			</div>
			<div class="table2">
				<!-- 보낸 문서 -->
				<table class="sentTable myTable">
					<caption class="sentCap caption">보낸 문서</caption>
					<thead>
						<tr>
							<th>NO</th>
							<th>문서번호</th>
							<th>분류</th>
							<th>문서 제목</th>
							<th>상신 날짜</th>
							<th>결재 상태</th>
						</tr>
					</thead>
					<tbody class="sentList">
					</tbody>
				</table>
				<div class="container" id="sentCont">
				    <nav aria-label="Page navigation">
				        <ul class="pagination" id="sentPage"></ul>
				    </nav>
				</div>
			</div>
		</div>
 	</div>
</body>
<script>
var emp_idx = "${sessionScope.loginId}";
var emp_name = "${sessionScope.loginName}";

var showPage = 1;
var text = "대기";
console.log("시발"+text);
var readStatus = "all";
pageCall(showPage, readStatus);
var receivedData = []; 

function pageCall(page, readStatus){
    console.log('pageCall');
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'readStatus': readStatus,
        	'text': text,
            'page': page,
            'cnt': 6 
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if(data.receivedList.length>0){
            	receivedData = data.receivedList;
                received(data.receivedList);
                
	            $('#receivedPage').twbsPagination({
	                startPage: 1,
	                totalPages: data.receivedTotalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);
	                    console.log("page", page);
	                    receivedPageCall(page, readStatus);
	                }
	            });
            }else{
            	if(readStatus === 'all'){
	            	var content = '<tr>';
	        		content += '<td colspan="8"> 받은 문서가 없습니다. </td>';
	        		content += '</tr>';            	
            	}else if(readStatus === 'read'){
            		var content = '<tr>';
	        		content += '<td colspan="8"> 읽은 문서가 없습니다. </td>';
	        		content += '</tr>';    
            	}else if(readStatus === 'unread'){
            		var content = '<tr>';
	        		content += '<td colspan="8"> 읽지않은 문서가 없습니다. </td>';
	        		content += '</tr>';    
            	}
        		$('.receivedList').html(content);
            }                         
            if(data.sentList.length>0){
	            // 보낸 문서
	            sent(data.sentList);
	            // 보낸 문서 페이징
	            $('#sentPage').twbsPagination({
	                startPage: 1,
	                totalPages: data.sentTotalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);
	                    console.log("page", page);
	                    sentPageCall(page, readStatus);
	                }
	            });
            }else{
            	var content = '<tr>';
        		content += '<td colspan="6"> 보낸 문서가 없습니다. </td>'
        		content += '</tr>';
        		$('.sentList').html(content);
            
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 받은 문서 리스트
function received(document) {
	
    var content = '';
	var i = 1;
	for(var item of document){
		console.log(item.form_subject)
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="receivedDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		content += '<td>' + item.name + '</td>';
		
		var doc_date = new Date(item.doc_date);
		var docDate = doc_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + item.status + '</td>';
		content += '<td>' + 
		    (item.doc_read == false
		        ? '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '" data-approv-num="'+ item.approv_num + '"><i class="fas fa-envelope" title="읽지 않음"></i></a>'
		        : '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '" data-approv-num="'+ item.approv_num + '"><i class="fas fa-envelope-open-text" title="읽음"></i></a>') +
		'</td>';
		
		content += '</tr>';
	}
	$('.receivedList').html(content);
}

// 보낸 문서 리스트
function sent(document) {
	
    var content = '';
	var i = 1;
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
		content += '<td>' + item.status + '</td>';
		content += '</tr>';
	}
	$('.sentList').html(content);
}


// 받은 문서
function receivedPageCall(page, readStatus) {
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'readStatus': readStatus,
        	'text': text,
            'page': page,
            'cnt': 6
        },
        dataType: 'JSON',
        success: function(data) {
        	received(data.receivedList);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}
// 보낸 문서
function sentPageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'readStatus': readStatus,
        	'text': text,
            'page': page,
            'cnt': 6
        },
        dataType: 'JSON',
        success: function(data) {
        	sent(data.sentList);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

//모달 열기
function receivedOpen(content) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
    // 모달 HTML 생성
    var Html = 
        '<div id="' + modalId + '" class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <button class="modal-btn Approve" onclick="docAction(\'승인\')">승인</button>' +
        '      <button class="modal-btn save" onclick="docAction(\'반려\')">반려</button>' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="content_emp" contenteditable="true">' + content + '</div>' +
        '  </div>' +
        '</div>';
        
    // body에 추가
    $('body').append(Html);

    // 모달 표시
    $('#' + modalId).show();

    // 닫기 버튼 이벤트 등록 (이벤트 위임)
    $(document).on('click', '.close-btn', function() {
        var targetModalId = $(this).data('modal-id');
        $('#' + targetModalId).remove();
    });
}

var empSign = false;
var doc_content;

function signAdd(td){
    var tableClass = $(td).closest('table').attr('class');
    console.log("테이블 뭔데;" +tableClass);
    var nameText;
    
    // table이 signBox이면 name을 가져오고, signBox2이면 manager 값을 가져옵니다.
    if (tableClass === 'signBox') {
        nameText = $(td).closest('tr').siblings().find('td[class="name"]').text();
    } else if (tableClass === 'signBox2') {
        nameText = $(td).closest('tr').siblings().find('input[class="manager"]').val();
    }
	console.log("이름 뭔데;" +nameText);
	if(nameText !== emp_name || nameText == null){
		alert("권한이 없습니다.");
	}else{
		$.ajax({
            type: 'GET',
            url: 'getSign.ajax',
            data: { emp_idx: emp_idx },
            dataType: 'json',
            success: function(response) {
                if ($(td).closest('table').hasClass('signBox')) {
                	console.log("1실행");
                	var signBox = $('table.signBox td.sign');
                    
                    // 이미 서명이 있는지 확인
                    if (signBox.find('img').length > 0) {
                    	empSign = false;
                        signBox.empty();
                    } else {
                        // 서명이 없으면 추가
                        if (response.sign != null) {
                        	empSign = true;
                            var signHtml = "<img src='" + response.sign + "' alt='서명' style='max-width: 90px; max-height: 70px;' />";
                            signBox.html(signHtml);
                            
                            // 전체 HTML을 업데이트하여 서버로 전송
                            var updatedHtml = $('.modal-content:last-child').html();  // 모달 콘텐츠의 HTML 가져오기

                            updatedHtml = updatedHtml.replace(
                           	    /(<table class="signBox"[^>]*>[\s\S]*?<td class="sign"[^>]*>)[^<]*<\/td>/,
                           	    '$1' + signHtml + '</td>'
                           	);
                            $('.modal-content:last-child').html(updatedHtml);
                            doc_content = $('.modal-content:last-child').html();
                            console.log("tq~~"+doc_content);
                        }else{
                            alert("서명을 등록해 주세요");
                        }
                   }
                } else if ($(td).closest('table').hasClass('signBox2')) {
                	var signBox2 = $('table.signBox2 td.signTwo');
                	console.log("2실행");
                    // 이미 서명이 있는지 확인
                    if (signBox2.find('img').length > 0) {
                    	empSign = false;
                        signBox2.empty();
                    } else {
                        // 서명이 없으면 추가
                        if (response.sign != null) {
                        	empSign = true;
                            var signHtml = "<img src='" + response.sign + "' alt='서명' style='max-width: 90px; max-height: 70px;' />";
                            signBox2.html(signHtml);
                            
                            // 전체 HTML을 업데이트하여 서버로 전송
                            var updatedHtml = $('.modal-content:last-child').html();  // 모달 콘텐츠의 HTML 가져오기

                            // 여기서 updatedHtml을 수정할 수 있습니다. 예를 들어, 서명 부분만 덮어쓰거나 필요한 부분을 수정할 수 있습니다.
                            updatedHtml = updatedHtml.replace(
							    /(<table class="signBox2"[^>]*>[\s\S]*?<td class="sign"[^>]*>)[^<]*<\/td>/,
							    '$1' + signHtml + '</td>'
							);
                            $('.modal-content:last-child').html(updatedHtml);
                            doc_content = $('.modal-content:last-child').html();
                            
                        } else {
                            alert("서명을 등록해 주세요");
                        }
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error('문서 요청 실패:', error);
            }
        });
	}
}

//승인
function docAction(actionType) {
	if (actionType === '승인') {	
		if(empSign=== true){
	        var nameText = $('table.signBox td[class="name"]').text();
	        console.log("첫번째 "+nameText);
	        var manager = $('input[class="manager"]').val();
	        console.log("두번째 "+manager);
			var doc_idx = $('input[name="doc_idx"]').val();
			console.log("문서번호 "+doc_idx);
			console.log("수정됐냐?"+doc_content);
			
			var approv_order = (manager === emp_name) ? 2 : 1;
			console.log("야 "+approv_order);
			
			$.ajax({
	            type: 'POST',
	            url: 'approveDoc.ajax',
	            data: {
	            	doc_idx: doc_idx,
	            	approv_order: approv_order,
	                actionType: actionType,
	                doc_content: doc_content
	            },
	            success: function(response) {
	            	alert("승인 완료");
		        	location.reload();
	            },
	            error: function(xhr, status, error) {
	                console.error("서버 요청 실패:", error);
	            }
	        });
			
		}else{
			alert("결재란이 비어있습니다.");
		}
		
	}else if(actionType === '반려'){
		
		var newTableHtml = 
			'<br>' +
		    '<table class="remarkComment" style="height: 14vh; border: 1px solid black; border-collapse: collapse;">' +
		    '  <tr>' +
		    '    <td style="text-align: center; width: 95px; border: 1px solid black; background-color: gainsboro; font-size: 14px; font-weight: bold;">반려자</td>' +
		    '    <td class="empIdx" style="text-align: center; height: 24px; border: 1px solid black;">' +
		    '      <input type="text" class="manager" value="'+emp_name+'" readonly/>' +
		    '    </td>' +
		    '  </tr>' +
		    '  <tr>' +
		    '    <td style="text-align: center; width: 95px; border: 1px solid black; background-color: gainsboro; font-size: 14px; font-weight: bold;">반려일자</td>' +
		    '    <td class="todayDate4" style="text-align: center; height: 24px; border: 1px solid black;"></td>' +
		    '  </tr>' +
		    '  <tr>' +
		    '    <td style="text-align: center; width: 95px; border: 1px solid black; background-color: gainsboro; font-size: 14px; font-weight: bold;">반려 사유</td>' +
		    '    <td>' +
		    '      <textarea name="remark" id="reject" maxlength="200" placeholder="반려사유를 입력해주세요. 200자 이내"></textarea>' +
		    '    </td>' +
		    '  </tr>' +
		    '</table>'+
		    '<button class="rejectBtn" onclick="docAction(\'제출\')">제출</button>';

		$('.content_emp').find('table:last').after(newTableHtml);
		
	}else if(actionType === '제출'){
		

		var remark = $('textarea[name="remark"]').val();
		var doc_idx = $('input[name="doc_idx"]').val();
		console.log("사유 "+remark);
		console.log("내 번호 "+emp_idx);
		console.log("문서번호"+doc_idx);
		
		var updatedHtml = $('.modal-content:last-child').html();
		updatedHtml = updatedHtml.replace(
		    /<textarea[^>]*name="remark"[^>]*>.*?<\/textarea>/,
		    function(match) {
		        return match.replace(/(<textarea[^>]*name="remark"[^>]*>)(.*?)(<\/textarea>)/, '$1' + remark + '$3');
		    }
		);
		
        $('.modal-content:last-child').html(updatedHtml);
        doc_content = $('.modal-content:last-child').html();
        
        console.log("바뀌어라 "+doc_content);
		$.ajax({
            type: 'POST',
            url: 'approveDoc.ajax',
            data: {
            	actionType: actionType,
            	doc_idx: doc_idx,
            	emp_idx: emp_idx,
            	remark: remark,
            	doc_content: doc_content
            },
            success: function(response) {
            	alert("반려 완료");
	        	location.reload();
            },
            error: function(xhr, status, error) {
                console.error("서버 요청 실패:", error);
            }
        });
	}
}

</script>
</html>
