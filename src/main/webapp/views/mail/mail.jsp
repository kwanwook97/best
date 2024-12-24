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
	.searchbox{
		width: 20%;
		display: flex;
		align-items: center;
		justify-content: space-between;
	}
	.search{
		position: relative;
    	display: inline-block;
	}
	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid var(--primary-color);
	}
	.search i{
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 18px;
		pointer-events: none;
		color: var(--accent-color);
	}
	.editbtn{
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
	}
	th, td{
		padding-left: 15px;
	}
	
  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <c:set var="emp_idx" value="${param.emp_idx}" />
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="mail">메일함</h3>
			<h3>>&nbsp;&nbsp;받은 메일함</h3>
		</div>
		<div class="mailbox">
			<div class="mailnav">
				<div class="opt">
					<div>받은 메일함</div>
					<div>보낸 메일함</div>
					<div>임시저장</div>
					<div>휴지통</div>
					<select class="drop">
					  <option value="subject">전체메일</option>
					  <option value="content">중요메일</option>
					  <option value="subject">읽은메일</option>
					  <option value="content">읽지않은메일</option>
					</select>
				</div>
				<div class="searchbox">
					<div class="search">
						<input type="text" name="">
						<i class="fas fa-search"></i>
					</div>
					<button class="editbtn" onclick="location.href='mailWrite.go'"><i class="far fa-edit"></i>작성</button>
				</div>
			</div>
			<table class="my-table">
				<thead>
					<tr>
						<th>보낸 사람</th>
						<th>제목</th>
						<th>내용</th>
						<th colspan="2">수신 시간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>example1@example.com</td>
						<td>읽지 않은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-07 10:30</td>
						<td><i class="fas fa-trash-alt"></i></td>
					</tr>
					
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

$('.opt div').click(function(){
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
});



	/* 전역변수 */
	var showPage = 1;          // 기본 보여줄 페이지
	var content = '';          // 가공한 리스트 담을 변수
	var tabNum = 1;            // 선택한 탭번호 변수
	var pagination = '';       // 페이지네이션 선택자 변수
	var searchFilter = 'name'; // 검색 필터 값 담을 변수
	var searchKeyword = '';    // 검색 값 담을 변수

	
	/* 페이지네이션 관련 전역변수 */
	var empIdx = '${emp_idx}'; // 사번
	var category = 0; // 0: 수신자, 1: 참조자
	var delete_flag = 0; // 0: 정상, 1: 휴지통, 2: 완전삭제
	var status = 1; // 0: 임시저장, 1: 발송

	
	
	
	// 페이지네이션 함수
	function pageCall(page, tabNum){
		/* 
		// 페이지네이션 선택자 초기화
		pagination = '';
		
		
		if(tabNum == 1){ // 활성사원
			pagination = '.pagination.activ';	
		}else{          // 비활성사원
			pagination = '.pagination.inactiv';
		}
		 */
		
		console.log('searchFilter : ' + searchFilter);
		console.log('searchKeyword : ' + searchKeyword);
		
	    $.ajax({
	        type: 'POST',
	        url: 'mailList.ajax', 
	        data:{
	        	'page' : page,  // 몇페이지 보여줘?
	        	'cnt' : 16,     // 페이지당 몇개의 게시물을 보여줘?
	        	'status' : status, // 임시저장여부 0:임시저장, 1:발송
	        	'emp_idx' : empIdx, // 사번
	        	'category' : category, // 0: 수신자, 1: 참조자
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
				
				listPrint(data.list, tabNum);
				
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
	                        pageCall(page, tabNum); // 페이지 재호출
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
	function listPrint(data, tabNum){
		
		// 리스트표시 영역변수
		var area = '.my-table tbody';
		
		
		/* 
		// 사원목록 영역
		if(tabNum == 1){ // 활성사원
			area = '.employee-list.activ';	
		}else{          // 비활성사원
			area = '.employee-list.inactiv';
		}
		 */
		 
		
		// 검색 결과가 없을 때는 그대로 유지
	    if (data.length > 0) {
			// 사원목록 영역 초기화
			$(area).empty();
			
			
			// 받은메일목록 생성
	      	$.each(data, function(idx, item) {
	      		// 변수 초기화
	            content = '';
	      		
	      	    content =  '<tr>' +
		      	    		   '<td>' + item.email + '</td>'    /* 보낸사람 */
		      	                    '<td><a>' +item.subject+ '</a></td>' +
		      	                    '<td><a>' +item.content+ '</a></td>' + /* 내용 미리보기 */
		      	                    '<td>' +item.date+ '</td>' +
		    	     				'<td><i class="fas fa-trash-alt"></i></td>' +
		    	     			'</tr>';
  	            
	 	        // 받은메일목록 정보 업데이트        
	      	    $(area).append(content);
	      	});
	    }
	
	}

</script>
</html>
