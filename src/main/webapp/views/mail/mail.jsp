<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- 페이지네이션 -->
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  <link rel="stylesheet" href="resources/css/pagination.css">
  <link href="resources/css/mail/mail.css" rel="stylesheet"/>
  
<style>

</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 <c:set var="empIdx" value="${sessionScope.loginId}" />
 <c:set var="tabData" value="${param.tabData}" />
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="lPurple">메일함</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
			<span class="purple"></span>
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
						<th class="no">No.</th>
						<th class="special-column">중요</th>
						<th class="read-column">읽음</th>
						<th>보낸사람</th>
						<th class="attach-column">첨부파일</th> <!-- 첨부파일 열 추가 -->
						<th>제목</th>
						<th>내용</th>
						<th>수신 시간</th>
						<th class="restore-column">복구</th>
						<th class="delete-column">휴지통</th>
					</tr>
				</thead>
				<tbody class="email-list">
				    <tr class="no-data-row" style="display: none;">
				        <td colspan="10" style="text-align: center;">메일이 없습니다.</td>
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
	var searchFilter = 'sender'; // 검색 필터 값 담을 변수
	var searchKeyword = '';    // 검색 값 담을 변수
	var mailFilterVal = 'all'; // 초기값: 전체메일
	
	
	/* 페이지네이션 관련 전역변수 */
	var empIdx = "${empIdx}"; // 사번
	var delete_flag = 0; // 0: 정상, 1: 휴지통, 2: 완전삭제
	var mailFilter = 0; // 0: 필터X, 1: 중요필터, 2:읽음필터 
	var special_flag = 0; // 중요여부
	var read_flag = 0; // 읽음여부 0: 안읽은메일, 1: 읽은메일
	// 현재 선택된 탭 - URL에서 전달받은 tabData를 사용해 초기 설정
    var tabData = '<c:out value="${tabData}" default="receive" />'; // 기본값은 'receive'

	
	var status = 1; // 0: 임시저장, 1: 발송
	var table = 'mail_receive'
	
	
	// URL에서 전달받은 tabData를 사용해 초기 설정
    $(document).ready(function () {
	    // tabData에 따라 초기 설정
	    updateTabAndTitle(tabData);
	
	    // 초기 페이지네이션 생성
	    pageCall(showPage);
	});

	
	
	
	
	
    updateMailFilterOptions(); // 초기 mailFilter 설정

    /* 메일 필터 옵션 업데이트 함수 */
    function updateMailFilterOptions() {
        const filterDropdown = $('.mailFilter');
        filterDropdown.empty(); // 기존 옵션 제거

        if (table === 'mail_receive') {
            filterDropdown.append('<option value="all">전체메일</option>');
            filterDropdown.append('<option value="special">중요메일</option>');
            filterDropdown.append('<option value="read">읽은메일</option>');
            filterDropdown.append('<option value="notRead">읽지않은메일</option>');
        } else if (table === 'mail_send' || table === 'draft') {
        	filterDropdown.append('<option value="all">전체메일</option>');
            filterDropdown.append('<option value="special">중요메일</option>');
        } else if (table === 'mail_trash') {
            filterDropdown.append('<option value="all">전체메일</option>');
        }
    }
	
	
	
	
	
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
	$('.opt div').click(function () {
	    // 선택된 탭의 데이터를 가져옴
	    tabData = $(this).data('tab');
	
	    // tabData에 따른 탭과 제목 세팅
	    updateTabAndTitle(tabData);
	});

	
	// tabData에 따라 탭 및 제목 설정
	function updateTabAndTitle(tabData) {
	    // 탭 스타일 업데이트
	    $('.opt div').each(function () {
	        if ($(this).data('tab') === tabData) {
	            $(this).css({
	                "color": "var(--primary-color)",
	                "font-weight": "bold",
	                "border-bottom": "3px solid var(--accent-color)"
	            });

	            // 제목 업데이트
	            $('.maintext').find(':last-child').html($(this).text());
	        } else {
	            $(this).css({
	                "color": "var(--secondary-color)",
	                "border-bottom": "none"
	            });
	        }
	    });

	    // 탭에 따라 전역 변수 초기화
	    switch (tabData) {
	        case 'receive': // 받은 메일함
	            table = 'mail_receive';
	            status = 1; // 전송
	            delete_flag = 0; // 삭제되지 않은 메일
	            break;
	        case 'send': // 보낸 메일함
	            table = 'mail_send';
	            status = 1; // 전송
	            delete_flag = 0; // 삭제되지 않은 메일
	            break;
	        case 'draft': // 임시저장
	            table = 'mail_send';
	            status = 0; // 임시저장
	            delete_flag = 0; // 삭제되지 않은 메일
	            break;
	        case 'trash': // 휴지통
	            table = 'mail_trash';
	            status = 1; // 전송
	            delete_flag = 1; // 삭제된 메일
	            break;
	    }

	    // 필터 옵션 업데이트
	    updateMailFilterOptions();

	    // 현재 페이지 1로 초기화
	    showPage = 1;

	    // 해당 탭에 맞는 데이터 호출
	    pageCall(showPage);
	}

	
	
	
	
	 // 메일필터 이벤트
    $('.mailFilter').change(function() {
    	
    	// 변수 초기화
    	mailFilter = 0; // 0: 필터X, 1: 중요필터, 2:읽음필터 
    	special_flag = 0; // 중요여부
    	read_flag = 0; // 읽음여부 0: 안읽은메일, 1: 읽은메일
    	
    	
        // 선택된 값 읽기
        mailFilterVal = $(this).val();

        switch (mailFilterVal) {
        // 전체메일
		case 'all':
			// specail_flag = 0, 1전체
			// read_flag = 0, 1 전체
			mailFilter = 0;
			break;
		// 중요메일
		case 'special':
			mailFilter = 1;
			special_flag = 1;
			break;
		// 읽은메일
		case 'read':
			mailFilter = 2;
			read_flag = 1;
			break;
		// 읽지않은메일
		case 'notRead':
			mailFilter = 2;
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
	        	'cnt' : 12,     // 페이지당 몇개의 게시물을 보여줘?
	        	'status' : status, // 임시저장여부 0:임시저장, 1:발송
	        	'emp_idx' : empIdx, // 사번
	        	'delete_flag' : delete_flag, // 휴지통여부 0: 정상, 1: 휴지통, 2: 완전삭제
	        	'mailFilter' : mailFilter, // // 0: 필터X, 1: 중요필터, 2:읽음필터
	        	'special_flag' : special_flag, // 중요여부
	        	'read_flag' : read_flag, // 읽음여부
	        	'searchFilter' : searchFilter,   // 검색필터
	        	'searchKeyword' : searchKeyword // 검색 키워드
	        },
	        dataType: 'json', 
	        success: function(data) {
				
				// 검색 결과가 없을 경우 modal 창 표시
	            if ((!data.list || data.list.length === 0) && searchKeyword !== '') {
	                modal.showAlert('검색된 값이 없습니다.');
	                searchKeyword = '';    // 검색 값 초기화
	                return;
	            }
				
				listPrint(data.list, table, data.totalCnt);
				
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
				
				searchKeyword = '';    // 검색 값 초기화
	        },
	        error: function(e) {
	        	modal.showAlert('잠시 후 다시 시도해주세요.');         
	        }       
	    });
	}
	
	// 페이지네이션 함수 -> 목록조회 함수
	function listPrint(data, table, totalCnt) {
	    var area = '.email-list';
	
	    // 리스트 초기화
	    $(area).empty();
	
	 	// 읽음 열 및 중요 열 표시 여부 결정
	    var showReadColumn = table === 'mail_receive';
	    var showSpecialColumn = table === 'mail_receive' || table === 'mail_send';
	
	 	// 목록에 따른 열 처리
	    if (showReadColumn) {
	        $('.read-column').show();
	    } else {
	        $('.read-column').hide();
	    }

	    if (showSpecialColumn) {
	        $('.special-column').show();
	    } else {
	        $('.special-column').hide();
	    }
			    
	    // 휴지통목록인경우 완전삭제열 및 복구열 생성
		var showTrashColumn = table === 'mail_trash';
	    
		// 열 제목 변경 및 열추가 (휴지통 목록일 경우)
	    if (showTrashColumn) {
	        $('.delete-column').text('완전삭제');
	        $('.restore-column').show();
	    } else {
	        $('.delete-column').text('휴지통');
	        $('.restore-column').hide();
	    }
	
		
	    // 데이터가 없을 경우 "메일 없음" 메시지 표시
	    if (data.length === 0) {
	        $(area).html(
	            '<tr class="no-data-row">' +
	                '<td colspan="10" style="text-align: center;">메일이 없습니다.</td>' +
	            '</tr>'
	        );
	        return; // 함수 종료
	    }
		
		
	    if (data.length > 0) {
	    	// 페이지네이션에 따른 시작 번호 계산
	    	var startIdx = totalCnt - (showPage - 1) * 12; // 12는 페이지당 항목 수 (cnt)
	    	
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
	            var deleteFlag = 1; // 기본값 : 휴지통으로 이동

	            
	            // 메일 작성자인지 수신자인지 여부에 따라 테이블 선택.
	            if(item.sender_idx === empIdx){ // 내가 메일작성자인 경우  
	            	mailIdx = item.mail_send_idx
	            	mailIdxType = 'mail_send_idx';
	            	specialFlag = item.send_special_flag;
	            }else{
	            	mailIdx = item.mail_receive_idx
	            	mailIdxType = 'mail_receive_idx';
	            	specialFlag = item.receive_special_flag;
	            }
	            
	         	// 중요 아이콘 (받은 메일함 또는 보낸 메일함에서만 표시)
	            var specialIcon = '';
	            if (showSpecialColumn) {
	                specialIcon = '<i class="bi bi-star" title="일반" style="cursor: pointer;" onclick="updateSpecialStatus(\'' 
	                    + mailIdxType + '\', ' 
	                    + mailIdx + ', ' 
	                    + specialFlag + ')"></i>';
	                if (specialFlag !== 0) {
	                    specialIcon = '<i class="bi bi-star-fill" title="중요" style="cursor: pointer;" onclick="updateSpecialStatus(\'' 
	                        + mailIdxType + '\', ' 
	                        + mailIdx + ', ' 
	                        + specialFlag + ')"></i>';
	                }
	            }

	            
	         	// 읽음 아이콘 (받은 메일함에서만 표시)
	            var readIcon = '';
	            if (showReadColumn) {
	                readIcon = '<i class="fas fa-envelope" title="읽지 않음" style="cursor: pointer;" onclick="updateReadStatus(\'' 
	                    + mailIdxType + '\', ' 
	                    + mailIdx + ', ' 
	                    + item.read_flag + ', ' 
                        + item.mail_send_idx+ ')"></i>';
	                if (item.read_flag !== 0) {
	                    readIcon = '<i class="fas fa-envelope-open-text" title="읽음" style="cursor: pointer;" onclick="updateReadStatus(\'' 
	                        + mailIdxType + '\', ' 
	                        + mailIdx + ', ' 
	                        + item.read_flag + ', ' 
	                        + item.mail_send_idx+ ')"></i>';
	                }
	            }
	
	            
	         	// 첨부파일 아이콘
	            var attachIcon = '';
	            if (item.attach_flag === 1) {
	                attachIcon = '<i class="fas fa-paperclip" title="첨부파일 있음"></i>';
	            } else {
	                attachIcon = '<i class="fas fa-paperclip" style="opacity: 0.3;" title="첨부파일 없음"></i>';
	            }
	            
	            
	            
	         	// 삭제 아이콘 (휴지통인 경우 완전 삭제 아이콘으로 표시)
	            var deleteIcon = '<i class="fas fa-trash-alt" onclick="updateDeleteStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' +deleteFlag+ ')"></i>';
	            if (table === 'mail_trash') {
	            	deleteFlag = 2; // 완전삭제
	                deleteIcon = '<i class="bi bi-x-circle-fill text-danger" title="완전 삭제" style="cursor: pointer;" onclick="updateDeleteStatus(\'' 
	                    + mailIdxType + '\', ' 
	                    + mailIdx + ', ' +deleteFlag+ ')"></i>';
	            }
	            
	            
	            // HTML 태그 제거
	            var contentText = $('<div>').html(item.content).text();
	
	         	// 행 생성
	            content = '<tr>';
	            content += '<td>' + (startIdx - idx) + '</td>'; // No. 열에 페이지별 번호 추가
	            if (showSpecialColumn) {
	                content += '<td class="special-column">' + specialIcon + '</td>';
	            }
	            if (showReadColumn) {
	                content += '<td class="read-column">' + readIcon + '</td>';
	            }
	            content += '<td>' + item.sender_name + '</td>' +
	                       '<td class="attach-column">' + attachIcon + '</td>' + // 첨부파일 아이콘 추가
				            '<td>' +
					            '<a href="#" onclick="handleMailClick(event, \'' + mailIdxType + '\', ' + mailIdx + ', ' + item.read_flag +  ', ' +item.mail_send_idx+ '); return false;">' +
					            item.subject +
					            '</a>' +
				            '</td>' +
	                /* '<td><a href="mailDetail.go?idx=' + item.mail_send_idx + '">' + item.subject + '</a></td>' + */ 
	                '<td>' + contentText + '</td>' +
	                '<td>' + formattedDate + '</td>';
	                
	            // 복구행 생성    
                if (showTrashColumn) {
                    deleteFlag = 0; // 복구
                    content += '<td class="restore-column"><i class="bi bi-arrow-counterclockwise" title="복구" style="cursor: pointer;" onclick="updateDeleteStatus(\'' 
                        + mailIdxType + '\', ' 
                        + mailIdx + ', ' 
                        + deleteFlag + ')"></i></td>';
                }
                
	            content += '<td>' + deleteIcon + '</td>' +
	                       '</tr>';
	
	            // 받은메일목록 정보 업데이트        
	            $(area).append(content);
	        });
	    }
	}


	
	// 읽음여부 업데이트
	function updateReadStatus(mailIdxType, mailIdx, readFlag, mail_send_idx) {
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
	            var icon = $('i[onclick="updateReadStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' + readFlag + ', ' +mail_send_idx+ ')"]');
	            /* var subject = $('a[onclick="handleMailClick(event, \'' + mailIdxType + '\', ' + mailIdx + ', ' + readFlag + ', ' + mail_send_idx + ')"]'); */
	            var subject = icon.closest('td').siblings().find('a'); // 같은 행의 a 태그 선택
	            
	            // 아이콘 업데이트
	            if (newReadFlag === 1) {
	                icon.removeClass('fa-envelope').addClass('fa-envelope-open-text').attr('title', '읽음');
	            } else {
	                icon.removeClass('fa-envelope-open-text').addClass('fa-envelope').attr('title', '읽지 않음');
	            }

	            // onclick 속성 업데이트
	            icon.attr('onclick', 'updateReadStatus(\'' + mailIdxType + '\', ' + mailIdx + ', ' + newReadFlag + ', ' +mail_send_idx+ ')');
	            subject.attr('onclick', 'handleMailClick(event, "' + mailIdxType + '", ' + mailIdx + ', ' + newReadFlag + ', ' + mail_send_idx + ');');
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

	
	
	// 메일 휴지통담기(1), 메일완전삭제(2), 메일복구(0)
	function updateDeleteStatus(mailIdxType, mailIdx, deleteFlag) {
	    let actionText = ''; // 사용자에게 보여줄 작업 텍스트
	    switch (deleteFlag) {
	        case 0:
	            actionText = '메일을 복구하시겠습니까?';
	            break;
	        case 1:
	            actionText = '메일을 휴지통으로 이동하시겠습니까?';
	            break;
	        case 2:
	            actionText = '메일을 완전 삭제하시겠습니까?';
	            break;
	        default:
	            modal.showAlert('잘못된 요청입니다.');
	            return;
	    }

	    // Confirm 모달 표시
	    modal.showConfirm(actionText, function () {
	        $.ajax({
	            type: 'POST',
	            url: 'updateDeleteStatus.ajax',
	            data: {
	                'mailIdxType': mailIdxType,
	                'mailIdx': mailIdx,
	                'delete_flag': deleteFlag // 0: 복구, 1: 휴지통, 2: 완전삭제
	            },
	            success: function (response) {
	                // 성공 메시지 표시
	                modal.showAlert('작업이 정상적으로 처리되었습니다.');

	                // 현재 페이지에 대한 데이터를 다시 호출
	                pageCall(showPage);
	            },
	            error: function (e) {
	                console.error('오류 발생:', e);
	                modal.showAlert('작업 처리 중 오류가 발생했습니다.');
	            }
	        });
	    });
	}



	// 메일 상세보기시 링크이동
	// 아직 안읽은 메일인 경우 읽음처리.
	function handleMailClick(event, mailIdxType, mailIdx, readFlag, mail_send_idx) {
	    event.preventDefault(); // 기본 링크 동작 차단

	    // 휴지통 탭일 경우 링크 이동 차단
	    if (tabData === 'trash') {
	        modal.showAlert('휴지통에서는 메일을 열 수 없습니다.');
	        return;
	    }
	    
	    var targetPage = 'mailDetail.go'; // 기본 페이지

	    // 임시저장 탭인경우
	    if (tabData === 'draft') {
	        targetPage = 'mailDraft.go';
	    }

	    
	    // 읽음 상태 업데이트가 필요한 경우 처리
	    if (readFlag === 0) {
	        updateReadStatus(mailIdxType, mailIdx, readFlag, mail_send_idx); // 읽음 상태로 업데이트
	    }

	    // 읽음 처리와 관계없이 상세 페이지로 이동
	    setTimeout(function () {
	        window.location.href = targetPage + '?idx=' + mail_send_idx;
	    }, 300); // AJAX 요청을 기다릴 시간 설정 (필요 시 조정)
	}
	
	
	

		
</script>
</html>
