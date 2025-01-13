<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <!-- 페이지네이션 -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  <!-- 페이지네이션 CSS -->
  <link rel="stylesheet" href="resources/css/pagination.css">
  
  <!-- 탭기능 -->
  <!-- https://jqueryui.com/tabs/ -->
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  <link href="resources/css/empManage/empList.css" rel="stylesheet"/>
  
<style>

</style>
  
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../modal/modal.jsp"></jsp:include>
  
  <sec:authorize access="!hasAuthority('ROLE_ADMIN')">
  	<c:set var="user_rank_idx" value="${sessionScope.employee.rank_idx}" />
  	<jsp:include page="../main/header.jsp"></jsp:include>
  </sec:authorize>
  <sec:authorize access="hasAuthority('ROLE_ADMIN')">
  	<jsp:include page="../main/adminHeader.jsp"></jsp:include>
  </sec:authorize>
  
  
  <div class="body">
    <!-- 페이지 제목 -->
    <div class="naviPath">
      <span class="lPurple">사원관리</span> <span class="cPurple">&gt; 사원목록</span>
    </div>

    <!-- 검색 필터 및 검색창 -->
    <div class="search-container">
      <div class="search-filter-container">
        <select class="search-filter bold">
          <option value="name" selected>이름</option>
          <option value="department">부서</option>
        </select>
      </div>
      <div style="position: relative;">
        <input type="text" class="search-bar" placeholder="검색">
        <i class="fas fa-search search-icon"></i>
      </div>
    </div>

    <!-- 콘텐츠 박스 -->	
    <div class="content bold">
      <!-- 탭 기능 -->
	  <div id="tabs">
		  <ul>
		    <li><a href="#activ_emp">활성사원</a></li>
		    <li><a href="#inactiv_emp">비활성사원</a></li>
		  </ul>
		  <div id="activ_emp">
			  <!-- 활성화 사원 리스트 -->
		      <div class="employee-list activ">
		        <!-- 사원 카드정보가 들어가는 영역 -->
		        
		      </div>
		
			  <!-- 페이징이 표시될 곳 -->
			 <div class="container">
			     <nav aria-label="Page navigation">
			         <ul class="pagination activ" id="pagination"></ul>
			     </nav>
			 </div>
		  </div>
		  <div id="inactiv_emp">
		  	  <!-- 비활성화 사원 리스트 -->
		      <div class="employee-list inactiv">
		        <!-- 사원 카드정보가 들어가는 영역 -->
		        
		      </div>
		
			  <!-- 페이징이 표시될 곳 -->
			 <div class="container">
			     <nav aria-label="Page navigation">
			         <ul class="pagination inactiv" id="pagination"></ul>
			     </nav>
			 </div>		
		  
		  </div>
		</div>    
    


		
     
    </div>
  </div>
</body>

<script>

	/* 전역변수 */
	var showPage = 1;          // 기본 보여줄 페이지
	var content = '';          // 가공한 리스트 담을 변수
	var pagination = '';       // 페이지네이션 선택자 변수
	var searchFilter = 'name'; // 검색 필터 값 담을 변수
	var searchKeyword = '';    // 검색 값 담을 변수

	
	
	// 유저 팀장여부 체크
	var leaderChk = 0;
	var user_rank_idx = '${user_rank_idx}';
	
	if(user_rank_idx === '3'){
		leaderChk = 1;
	};
	
	
	var adminChk = 0;
	// user_rank_idx가 비어있으면 admin으로 간주
	if(user_rank_idx === ''){
		adminChk = 1;
	}
	
	
	// 페이지 로드 시 tabNum 설정
	// 값이 안담겨 있는경우 1(활성탭) 선택
    var tabNum = sessionStorage.getItem('tabNum') ? parseInt(sessionStorage.getItem('tabNum')) : 1;

    // select 태그의 change 이벤트
    $('.search-container .search-filter').on('change', function () {
	  searchFilter = $(this).val();
	});

	
 	// 검색 아이콘 클릭 이벤트
    $('.search-container .search-icon').on('click', function () {
	  searchKeyword = $('.search-container .search-bar').val().trim();
	  $('.search-container .search-bar').val(''); // 검색창 입력값 초기화
	  executeSearch(); 
	});
	
 	// 검색창 Enter 이벤트
    $('.search-container .search-bar').on('keyup', function (e) {
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
		pageCall(showPage, tabNum);
		
	} 
	

    // 초기 데이터 로드
    pageCall(showPage, tabNum);
    
	
 	// 탭 이벤트 발생시
	$(function () {
	    // 페이지 로드 시 sessionStorage에서 tabNum 읽기
	    var tabNum = sessionStorage.getItem('tabNum') ? parseInt(sessionStorage.getItem('tabNum')) : 1;
	
	    $("#tabs").tabs({
	        active: tabNum === 1 ? 0 : 1, // tabNum에 따라 활성화 탭 설정 (활성 사원이 1번 탭, 비활성 사원이 2번 탭)
	        activate: function (event, ui) {
	            // 현재 활성화된 탭의 ID를 확인
	            var activeTab = ui.newPanel.attr("id");
	
	            if (activeTab === "activ_emp") {
	                // 활성 사원 탭일 때
	                tabNum = 1;
	            } else if (activeTab === "inactiv_emp") {
	                // 비활성 사원 탭일 때
	                tabNum = 0;
	            }
	
	            // 페이지 번호를 초기화
	            showPage = 1;
	
	            // 페이지네이션 초기화
	            var pagination = tabNum === 1 ? '.pagination.activ' : '.pagination.inactiv';
	            if ($(pagination).data("twbs-pagination")) {
	                $(pagination).twbsPagination('destroy');
	            }
	
	            // 데이터 호출
	            pageCall(showPage, tabNum);
	
	            // 현재 탭 상태를 sessionStorage에 저장
	            sessionStorage.setItem('tabNum', tabNum);
	        },
	    });
	
	    // 초기 데이터 로드
	    pageCall(showPage, tabNum);
	});


	
	
	// 페이지네이션 함수
	function pageCall(page, tabNum){
		// 페이지네이션 선택자 초기화
		pagination = '';
		
		if(tabNum == 1){ // 활성사원
			pagination = '.pagination.activ';	
		}else{          // 비활성사원
			pagination = '.pagination.inactiv';
		}
		
		console.log('searchFilter : ' + searchFilter);
		console.log('searchKeyword : ' + searchKeyword);
		
	    $.ajax({
	        type: 'POST',
	        url: 'empList.ajax', 
	        data:{
	        	'page' : page,  // 몇페이지 보여줘?
	        	'cnt' : 16,     // 페이지당 몇개의 게시물을 보여줘?
	        	'enable' : tabNum, // 활성화 or 비활성화 여부
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
				
				// 팀장인경우 사원상세버튼 숨기기
				if (leaderChk === 1) {
				    $(document).ready(function () {
				        $(".action-buttons button:contains('사원상세')").hide();
				    });
				}
				
				// admin인경우 근태관리버튼 숨기기
				if (adminChk === 1) {
				    $(document).ready(function () {
				        $(".action-buttons button:contains('근태관리')").hide();
				    });
				}
	        },
	        error: function(e) {
	        	modal.showAlert('잠시 후 다시 시도해주세요.');         
	        }       
	    });
	}
	
	// 페이지네이션 함수 -> 목록조회 함수
	function listPrint(data, tabNum){
		
		// 리스트표시 영역변수
		var area = '';
		
		// 사원목록 영역
		if(tabNum == 1){ // 활성사원
			area = '.employee-list.activ';	
		}else{          // 비활성사원
			area = '.employee-list.inactiv';
		}
		
		
		// 검색 결과가 없을 때는 그대로 유지
	    if (data.length > 0) {
			// 사원목록 영역 초기화
			$(area).empty();
			
			
			// 사원카드 생성
	      	$.each(data, function(idx, item) {
	      		// 변수 초기화
	            content = '';
	      		
	      	    content =  '<div class="employee-card-container">' +
			    			'<div class="employee-card">' +
				               '<div class="profile-pic"><div class="photo"><img alt="Profile Photo" src="/photo/' + item.photo + '"/></div></div>' +
				               '<div class="employee-details">' +
				                   '<div class="name-title">' + item.depart_name + ' ' + item.name + ' ' + item.rank_name + '</div>' +
				                   '<p><strong>email:</strong> ' + item.email + '</p>' +
				                   '<p><strong>tel:</strong> ' + item.phone + '</p>' +
				                   '<p><strong>mobile:</strong> ' + item.mobile + '</p>' +
				                   '<div class="action-buttons">' +
				                       '<button class="btn1" onclick="location.href=\'empDetail.go?emp_idx=' + item.emp_idx + '\'">사원상세</button>' +
				                       '<button class="btn2" onclick="location.href=\'attendance.go?emp_idx=' + item.emp_idx +
				                           '&name=' + encodeURIComponent(item.name) +
				                           '&depart_name=' + encodeURIComponent(item.depart_name) +
				                           '&rank_name=' + encodeURIComponent(item.rank_name) + '\'">근태관리</button>' +
				                   '</div>' +
				               '</div>' +
				           	 '</div>'
				           '</div>';
	      	                
	 	        // 사원목록의 사원카드 정보 업데이트        
	      	    $(area).append(content);
	      	});
	    }
	
	}

	/***********************  페이징 처리 끝 ****************************/	
	
</script>

</html>
