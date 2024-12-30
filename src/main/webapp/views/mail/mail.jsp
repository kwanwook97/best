<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- 페이지네이션 -->
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  <link rel="stylesheet" href="resources/css/pagination.css">
  
  
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
	    height: 92%;
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
	.mail{
		color: var(--secondary-color);
		margin-right: 30px;
	    margin-bottom: 40px;
	}
	.mailbox{
		border: 2px solid var(--primary-color);
	    width: -webkit-fill-available;
		height: 75%;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	}
	.mailnav{
		display: flex;
    	justify-content: space-between;
		align-items: center;
		margin: 0 48px;
		padding: 0 5px;
	}
	.opt{
		width: 42%;
		display: flex;
		justify-content: space-between;
	    align-items: center;
	    color: var(--secondary-color);
	}
	.opt div{
		align-content: center;
	}
	.opt div:first-child{
		color: var(--primary-color);
		font-weight: bold;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:not(:last-child){
		font-size: 20px;
		font-weight: bold;
		height: 60px;
	}
	.opt div:hover{
		cursor: pointer;
		color: var(--primary-color);
		font-weight: bold;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:last-child:hover {
	    border-bottom: none;
	}
	.drop{
	    height: 28px;
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	    cursor: pointer;
	}
	.drop option{
		background-color: white !important;
	}
	.drop option:hover{
		cursor: pointer;
		background-color:var(--secondary-color);
	}
	/* 검색창과 필터 컨테이너 */
.searchbox {
    display: flex;
    align-items: center; /* 높이 기준으로 중앙 정렬 */
    gap: 10px; /* 검색창과 필터 사이 간격 */
}
	.search{
		position: relative;
    	display: inline-block;
	}
/* 검색창 스타일 */
.search input {
    border-radius: 10px;
    padding: 0 10px; /* 좌우 패딩 */
    border: 1px solid var(--primary-color);
    height: 42px; /* 필터와 동일한 높이 */
    font-size: 16px;
    font-weight: bold;
    line-height: 42px; /* 높이와 텍스트 정렬 */
    box-sizing: border-box; /* 내부 패딩 포함 */
}

/* 검색 아이콘 위치 조정 */
.search i {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 18px;
    pointer-events: none;
    color: var(--accent-color);
}

/* 기본 select 스타일 */
select {
    font-size: 16px;
    font-weight: bold;
    padding: 0 10px; /* 좌우 패딩 */
    border: 2px solid var(--primary-color);
    border-radius: 10px;
    color: var(--primary-color);
    background-color: #fff;
    height: 42px; /* 검색창과 동일한 높이 */
    line-height: 42px; /* 높이와 텍스트 정렬 */
    cursor: pointer;
    -webkit-appearance: menulist; /* 기본 화살표 유지 */
    -moz-appearance: menulist;
    appearance: menulist;
}

/* 드롭다운 옵션 스타일 */
select option {
    background-color: #fff !important; /* 옵션 배경 흰색 */
    color: var(--primary-color); /* 텍스트 색상 */
}

/* 드롭다운 옵션 호버 */
select option:hover {
    background-color: #fff; /* 호버 시 배경색 */
    color: var(--primary-color); /* 호버 시 텍스트 색상 */
}

/* 드롭다운 선택 시 */
select option:checked {
    background-color: #F9F6F1; /* 선택된 옵션 배경 */
    color: var(--primary-color); /* 선택된 텍스트 색상 */
}


	
	.editbtn{
		height: 42px; /* 검색창과 필터와 동일한 높이 */
		color: white;
		background-color: var(--accent-color);
		border-radius: 10px;
		width: 70px;
	}
	.fa-trash-alt:hover{
		color: var(--accent-color);
		cursor: pointer;
	}
	table.my-table{
		border-collapse: separate !important;
        border-spacing: 0;
	}
	table{
		width: -webkit-fill-available;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin: 0 48px;
	}
	
	
	table.my-table tr:not(:last-child) td, table.my-table th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table.my-table tr{
		height: 36px;
		text-align: center; /* 텍스트 중앙 정렬 */
    	vertical-align: middle; /* 세로 중앙 정렬 */
		box-sizing: border-box; /* 패딩 포함하여 크기 계산 */
	}
	
	
	th, td{
		padding-left: 15px;
		height: 36px;
		text-align: center; /* 텍스트 중앙 정렬 */
    	vertical-align: middle; /* 세로 중앙 정렬 */
		box-sizing: border-box; /* 패딩 포함하여 크기 계산 */
	}
	.read-column {
	    display: table-cell; /* 숨기거나 보이더라도 높이 유지 */
	    text-align: center;
    	vertical-align: middle;
	}
	
  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 <c:set var="emp_idx" value="${param.emp_idx}" />
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="mail">메일함</h3>
			<h3>>&nbsp;&nbsp;받은 메일함</h3>
		</div>
		<div class="mailbox">
			<div class="mailnav">
				<div class="opt">
					<div data-tab="receive">받은 메일함</div>
				    <div data-tab="send">보낸 메일함</div>
				    <div data-tab="draft">임시저장</div>
				    <div data-tab="trash">휴지통</div>
				    <!-- 메일필터 -->
					<select class="mailFilter">
					  <option value="all">전체메일</option>
					  <option value="special">중요메일</option>
					  <option value="read">읽은메일</option>
					  <option value="notRead">읽지않은메일</option>
					</select>
				</div>
				<div class="searchbox">
					<!-- 검색필터 -->
					<select class="searchFilter">
					  <option value="sender">보낸사람</option>
					  <option value="receiver">받는사람</option>
					  <option value="subject">제목</option>
					  <option value="content">내용</option>
					</select>
					
					<div class="search">
						<input type="text" class="searchBar" placeholder="검색">
						<i class="fas fa-search"></i>
					</div>
					<button class="editbtn" onclick="location.href='mailWrite.go'"><i class="far fa-edit"></i>작성</button>
				</div>
			</div>
			<table class="my-table">
				<thead>
					<tr>
						<th>중요</th>
						<th class="read-column">읽음</th>
						<th>보낸사람</th>
						<th>제목</th>
						<th>내용</th>
						<th>수신 시간</th>
						<th>휴지통</th>
					</tr>
				</thead>
				<tbody class="email-list">
					<tr>
						<td><i class="bi bi-star" title="일반"></i></td>
						<td><i class="fas fa-envelope" title="읽지 않음"></i></td>
						<td>example1@example.com</td>
						<td>읽지 않은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-07 10:30</td>
						<td><i class="fas fa-trash-alt"></i></td>
					</tr>
					
					
		          <!-- 이메일 데이터가 들어가는 영역 -->
			          
				</tbody>
			</table>
		</div>
		<!-- 페이징이 표시될 곳 -->
		 <div class="container">
		     <nav aria-label="Page navigation">
		         <ul class="pagination activ" id="pagination"></ul>
		     </nav>
		 </div>
 	</div>
</body>
<script>

	/* 전역변수 */
	var showPage = 1;          // 기본 보여줄 페이지
	var content = '';          // 가공한 리스트 담을 변수
	var pagination = '';       // 페이지네이션 선택자 변수
	var searchFilter = 'receiver'; // 검색 필터 값 담을 변수
	var searchKeyword = '';    // 검색 값 담을 변수
	var mailFilter = 'all'; // 초기값: 전체메일
	
	
	/* 페이지네이션 관련 전역변수 */
	var empIdx = 1; // 사번
	var delete_flag = 0; // 0: 정상, 1: 휴지통, 2: 완전삭제
	var special_flag = 0; // 중요여부
	var read_flag = 0; // 읽음여부 0: 안읽은메일, 1: 읽은메일
	
	var status = 1; // 0: 임시저장, 1: 발송
	var table = 'mail_receive'
	
	
	
	
	
	// 초기 페이지네이션 생성.
	pageCall(showPage);
	
	
	
	// select 태그의 change 이벤트
    $('.searchbox .searchFilter').on('change', function () {
	  searchFilter = $(this).val();
	});

	
 	// 검색 아이콘 클릭 이벤트
    $('.searchbox .search-icon').on('click', function () {
	  searchKeyword = $('.searchbox .searchBar').val().trim();
	  $('.searchbox .searchBar').val(''); // 검색창 입력값 초기화
	  executeSearch(); 
	});
	
 	// 검색창 Enter 이벤트
    $('.searchbox .searchBar').on('keyup', function (e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
            searchKeyword = $(this).val().trim();
            $(this).val(''); // 검색창 입력값 초기화
            executeSearch();
        }
    });
 	
 	
    // 검색 함수
	function executeSearch(){
		if (searchKeyword === '') {
			modal.showAlert('검색어를 입력하세요.');
	        return;
	    }
		
		// 페이지 번호를 항상 1로 초기화
	    showPage = 1;
		
		// 검색로직
		pageCall(showPage);
		
	}
	

	/* 탭 클릭시 이벤트 */
	$('.opt div').click(function(){
		// 선택된 탭의 데이터를 가져옴
	    var tabData = $(this).data('tab');
		
		$('.maintext').find(':last-child').html('>&nbsp;&nbsp;' + $(this).text());
		$(this).css({
			"color": "var(--primary-color)",
			"font-weight": "bold",
			"border-bottom": "3px solid var(--accent-color)"
		});
		$(this).siblings().not(':last-child').css({
			"color": "var(--secondary-color)",
			"border-bottom": "none"
		});
		
		
		
		// 전역 변수 업데이트
	    switch (tabData) {
	 		// 받은 메일함
	        case 'receive':
	            table = 'mail_receive'; // 테이블 설정
	            status = 1; // 전송
	            delete_flag = 0; // 휴지통상태
	            break;
	         // 보낸 메일함
	        case 'send':
	            table = 'mail_send';
	            status = 1; // 전송
	            delete_flag = 0; // 휴지통상태
	            break;
	         // 임시저장 메일함
	        case 'draft':
	            table = 'mail_send';
	            status = 0; // 임시저장
	            delete_flag = 0; // 휴지통상태
	            break;
	         // 휴지통 함
	        case 'trash':
	        	table = 'mail_trash'; // 테이블 설정
	            // table mail_receive, mail_send 둘다 뒤져야힘 
	            status = 1; // 전송
	            delete_flag = 1; // 휴지통상태
	            break;
	    }

	    // 현재 페이지 1로 초기화
	    showPage = 1;

	    // 해당 탭에 맞는 데이터를 호출
	    pageCall(showPage);
		
		
	});	
	
	
	
	 // 메일필터 이벤트
    $('.mailFilter').change(function() {
    	
        // 선택된 값 읽기
        mailFilter = $(this).val();

        switch (mailFilter) {
        // 전체메일
		case 'all':
			// specail_flag = 0, 1전체
			// read_flag = 0, 1 전체
			break;
		// 중요메일
		case 'special':
			special_flag = 1;
			break;
		// 읽은메일
		case 'read':
			read_flag = 1;
			break;
		// 읽지않은메일
		case 'notRead':
			read_flag = 0;
			break;
		}
        
        
     	// 현재 페이지 1로 초기화
	    showPage = 1;
        
		// 해당 필터에 맞는 데이터를 호출
	    pageCall(showPage);
    });
	

	 
	// 페이지네이션 함수
	function pageCall(page){
		
		console.log('searchFilter : ' + searchFilter);
		console.log('searchKeyword : ' + searchKeyword);
		
		var pagination = '#pagination'; // 페이지네이션 선택자
		
	    $.ajax({
	        type: 'POST',
	        url: 'mailList.ajax', 
	        data:{
	        	'table' : table, // 어떤.. 테이블... 보낸사람..? 받는사람..?
	        	'page' : page,  // 몇페이지 보여줘?
	        	'cnt' : 16,     // 페이지당 몇개의 게시물을 보여줘?
	        	'status' : status, // 임시저장여부 0:임시저장, 1:발송
	        	'emp_idx' : empIdx, // 사번
	        	'delete_flag' : delete_flag, // 휴지통여부 0: 정상, 1: 휴지통, 2: 완전삭제
	        	'searchFilter' : searchFilter,   // 검색필터
	        	'searchKeyword' : searchKeyword // 검색 키워드
	        },
	        dataType: 'json', 
	        success: function(data) {
				console.log(data);
				searchKeyword = '';    // 검색 값 초기화
				
				// 검색 결과가 없을 경우 modal 창 표시
				if (!data.list || data.list.length === 0) {
	                modal.showAlert('검색된 값이 없습니다.');
	                return;
	            }
				
				listPrint(data.list, table);
				
				// 페이징 플러그인 처리
	    		// 기존 페이지네이션 초기화 (이미 초기화된 경우에만 destroy 호출)
	            if ($(pagination).data("twbs-pagination")) {
	                $(pagination).twbsPagination('destroy');
	            }
				$(pagination).twbsPagination({
					startPage: showPage,          //현재 보여지는 페이지
					totalPages: data.totalPages,  // 최대 페이지 수
					visiblePages : 5,             // 보여줄 페이지의 수
					initiateStartPageClick: false, // 첫 번째 클릭 방지
					
					onPageClick:function(evt, page){
						if (page !== showPage) {
	                        showPage = page; // 전역변수 업데이트
	                        pageCall(page); // 페이지 재호출
	                    }
					}
				});
				
				
	        },
	        error: function(e) {
	        	modal.showAlert('잠시 후 다시 시도해주세요.');         
	        }       
	    });
	}
	
	// 페이지네이션 함수 -> 목록조회 함수
	function listPrint(data, table) {
	    var area = '.email-list';
	
	    // 리스트 초기화
	    $(area).empty();
	
	    // 읽음 열 표시 여부 결정
	    var showReadColumn = table === 'mail_receive';
	
	    // 헤더에서 읽음 열 숨김 처리
	    if (showReadColumn) {
	        $('.read-column').show();
	    } else {
	        $('.read-column').hide();
	    }
	
	    if (data.length > 0) {
	        $.each(data, function (idx, item) {
	            var content = '';
	
	            var date = new Date(item.date);
	            var year = date.getFullYear();
	            var month = ('0' + (date.getMonth() + 1)).slice(-2);
	            var day = ('0' + date.getDate()).slice(-2);
	            var hours = ('0' + date.getHours()).slice(-2);
	            var minutes = ('0' + date.getMinutes()).slice(-2);
	
	            var formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
	
	            var mailIdx = 0;
	            var mailIdxType = '';
	            var specialFlag = 0;

	            if (table === 'mail_receive') {
	                mailIdx = item.mail_receive_idx;
	                mailIdxType = 'mail_receive_idx';
	                specialFlag = item.receive_special_flag;
	            } else if (table === 'mail_send') {
	                mailIdx = item.mail_send_idx;
	                mailIdxType = 'mail_send_idx';
	                specialFlag = item.send_special_flag;
	            }
	            
	            // 중요 아이콘
	            var specialIcon = '<i class="bi bi-star" title="일반" style="cursor: pointer;" onclick="updateSpecialStatus(\'' 
	                + mailIdxType + '\', ' 
	                + mailIdx + ', ' 
	                + specialFlag + ')"></i>';
	            if (specialFlag !== 0) {
	                specialIcon = '<i class="bi bi-star-fill" title="중요" style="cursor: pointer;" onclick="updateSpecialStatus(\'' 
	                    + mailIdxType + '\', ' 
	                    + mailIdx + ', ' 
	                    + specialFlag + ')"></i>';
	            }
	
	            // 읽음 아이콘 (받은 메일함에서만 표시)
	            var readIcon = '';
	            if (showReadColumn) {
	                readIcon = '<i class="fas fa-envelope" title="읽지 않음" style="cursor: pointer;" onclick="updateReadStatus(\'' 
	                    + mailIdxType + '\', ' 
	                    + mailIdx + ', ' 
	                    + item.read_flag + ')"></i>';
	                if (item.read_flag !== 0) {
	                    readIcon = '<i class="fas fa-envelope-open-text" title="읽음" style="cursor: pointer;" onclick="updateReadStatus(\'' 
	                        + mailIdxType + '\', ' 
	                        + mailIdx + ', ' 
	                        + item.read_flag + ')"></i>';
	                }
	            }
	
	            // HTML 태그 제거
	            var contentText = $('<div>').html(item.content).text();
	
	            // 행 생성
	            content = '<tr>' +
	                '<td>' + specialIcon + '</td>';
	            if (showReadColumn) {
	                content += '<td>' + readIcon + '</td>';
	            }
	            content += '<td>' + item.sender_name + '</td>' +
	                '<td><a href="mailDetail.go?idx=' + item.mail_send_idx + '">' + item.subject + '</a></td>' +
	                '<td>' + contentText + '</td>' +
	                '<td>' + formattedDate + '</td>' +
	                '<td><i class="fas fa-trash-alt" onclick="moveToTrash(\'' + mailIdxType + '\', ' + mailIdx + ')"></i></td>' +
	                '</tr>';
	
	            // 받은메일목록 정보 업데이트        
	            $(area).append(content);
	        });
	    }
	}


	
	// 읽음여부 업데이트
	function updateReadStatus(mailIdxType, mailIdx, readFlag) {
	    // 반대로 변경할 읽음 상태 결정
	    var newReadFlag = readFlag === 0 ? 1 : 0;
	
	    // AJAX 요청으로 읽음 상태 업데이트
	    $.ajax({
	        type: 'POST',
	        url: 'updateReadStatus.ajax',
	        data: {
	        	'mailIdxType': mailIdxType,
	            'mailIdx': mailIdx,
	            'read_flag': newReadFlag // 반대 상태로 변경
	        },
	        success: function () {
	            // 선택자를 동적으로 찾기
	            var icon = $('i[onclick="updateReadStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' + readFlag + ')"]');

	            // 아이콘 업데이트
	            if (newReadFlag === 1) {
	                icon.removeClass('fa-envelope').addClass('fa-envelope-open-text').attr('title', '읽음');
	            } else {
	                icon.removeClass('fa-envelope-open-text').addClass('fa-envelope').attr('title', '읽지 않음');
	            }

	            // onclick 속성 업데이트
	            icon.attr('onclick', 'updateReadStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' + newReadFlag + ')');
	        },
	        error: function (e) {
	            console.error('오류 발생:', e);
	        }
	    });
	}
	    
	// 중요여부 업데이트
	function updateSpecialStatus(mailIdxType, mailIdx, specialFlag) {
	    // 반대로 변경할 상태 결정
	    var newSpecialFlag = specialFlag === 0 ? 1 : 0;
	
	    // AJAX 요청으로 상태 업데이트
	    $.ajax({
	        type: 'POST',
	        url: 'updateSpecialStatus.ajax',
	        data: {
	            'mailIdxType': mailIdxType,
	            'mailIdx': mailIdx,
	            'special_flag': newSpecialFlag, // 반대 상태로 변경
	        },
	        success: function () {
	            // 선택자를 동적으로 찾기
	            var icon = $('i[onclick="updateSpecialStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' + specialFlag + ')"]');
	
	            // 아이콘 클래스 업데이트
	            if (newSpecialFlag === 1) {
	                icon.removeClass('bi-star').addClass('bi-star-fill').attr('title', '중요');
	            } else {
	                icon.removeClass('bi-star-fill').addClass('bi-star').attr('title', '일반');
	            }
	
	            // onclick 속성 업데이트
	            icon.attr('onclick', 'updateSpecialStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' + newSpecialFlag + ')');
	        },
	        error: function (e) {
	            console.error('오류 발생:', e);
	            modal.showAlert('중요 상태를 변경하는 중 오류가 발생했습니다.');
	        }
	    });
	}

	
	
	// 메일 휴지통에 담기
	function moveToTrash(mailIdxType, mailIdx) {
	    $.ajax({
	        type: 'POST',
	        url: 'moveToTrash.ajax',
	        data: { 
	        	'mailIdxType': mailIdxType,
	            'mailIdx': mailIdx,
	            'delete_flag': 1           // 0: 정상, 1: 휴지통, 2: 완전삭제
        	},
	        success: function (response) {
	            // 성공 메시지 표시
	            modal.showAlert('메일이 정상적으로 삭제되었습니다.');
	
	            
	            // UI에서 해당 메일 삭제
	            $('i[onclick="moveToTrash(' +mailIdxType+ ', '+ mailIdx + ')"]').closest('tr').remove();
	        },
	        error: function (e) {
	            console.error('오류 발생:', e);
	            modal.showAlert('메일을 휴지통으로 이동하는 중 오류가 발생했습니다.');
	        }
	    });
	}

	
</script>
</html>
