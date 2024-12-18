<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  
  <style>
    .body {
      width: 83%;
      margin-top: 110px;
      margin-left: 320px;
    }

    /* 페이지 제목 */
    .naviPath {
      font-size: 36px;
      font-weight: bold;
      margin-bottom: 20px;
    }

    .naviPath .lPurple {
      color: #8B6AA7; /* 연보라색 */
    }

    .naviPath .cPurple {
      color: #30005A; /* 진보라색 */
    }

    /* 검색 및 필터 */
    .search-container {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      gap: 10px;
      margin-bottom: 20px;
    }

    .search-filter-container {
      position: relative;
    }

    .search-filter {
      font-size: 16px;
      padding: 8px;
      border: 2px solid #30005A;
      border-radius: 10px;
      color: #30005A;
      background-color: #fff;
      cursor: pointer;
      appearance: none; /* 기본 화살표 제거 */
      position: relative;
      width: auto; /* 폭을 내용에 맞게 조정 */
      min-width: 100px; /* 최소 너비 */
    }

    .search-filter option {
      background-color: #F9F6F1; /* 베이지색 배경 */
      color: #30005A; /* 텍스트 색상 */
      padding: 8px;
    }

    .search-filter-container::after {
      content: '\f078'; /* FontAwesome 다운 화살표 */
      font-family: 'Font Awesome 5 Free';
      font-weight: 900;
      position: absolute;
      top: 50%;
      right: 15px;
      transform: translateY(-50%);
      color: #30005A;
      pointer-events: none;
    }

    .search-bar {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 10px 40px 10px 10px;
      width: 300px;
    }

    .search-icon {
      position: absolute;
      right: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #E9396B; /* 돋보기 색 */
      font-size: 18px;
      cursor: pointer;
    }

    /* 콘텐츠 박스 */
    .content {
      border: 2px solid #30005A;
      border-radius: 10px;
      padding: 5px;
      height: 75%;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

  /* 사원 리스트 */
  .employee-list {
    display: flex; /* 플렉스 레이아웃 사용 */
    flex-wrap: wrap; /* 줄바꿈 허용 */
    gap: 20px; /* 카드 간격 조정 */
    margin-top: 30px;
    height: 80%;
    width: 100%; /* 전체 너비 사용 */
    overflow: auto;
    justify-content: flex-start; /* 왼쪽 정렬 */
    align-content: flex-start; /* 위쪽 정렬 */
    padding-left: 20px; /* 왼쪽 시작 지점에 gap 추가 */
  }
  .employee-list a{
  	width: 24%;
  	height: 23%;
  	
  }
	
  /* 사원 카드 */
  .employee-card {
    border: 2px solid #30005A;
    border-radius: 10px;
    display: flex;
    align-items: flex-start;
    padding: 5%;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    width: 100%;
    height: 90%;
    flex-grow: 0; /* 고정 크기 */
  }

  /* 프로필 사진 */
  .profile-pic {
    width: 80px;
    height: 80px;
    background-color: #E0E0E0;
    border-radius: 10px;
    border: 2px solid #30005A;
    flex-shrink: 0;
    overflow: hidden;
  }

  /* 사원 정보 */
  .employee-details {
    margin-left: 20px;
    font-size: 16px;
    color: #30005A;
    flex: 1; /* 가변 너비 */
  }

  .employee-details .name-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
  }

  .employee-details p {
    color: #8B6AA7;
    margin: 5px 0;
    display: flex;
  }

  .employee-details p strong {
    flex-shrink: 0;
    color: #30005A;
    width: 120px;
    text-align: left;
  }

  .employee-details p span {
    flex-grow: 1;
  }

	.bold{
    	font-weight: bold;
    }

    
    /* 탭 CSS */
    #tabs {
      height: 100%;
      width: 100%;
      background-color: #FFFBF2; /* 베이지색 */
    }

    #tabs ul {
      list-style: none;
      padding-left: 20px;
      margin-top: 10px;
      display: flex;
      background-color: #FFFBF2; /* 탭 영역 배경색 */
      border: none; /* 테두리 제거 */
      box-shadow: none; /* 그림자 제거 */
    }

    [role="tablist"] {
      background-color: #FFFBF2; /* 베이지색 배경 */
      height: 5%;
    }
    
	#tabs ul li a{
	  color: #30005A;	
	  font-size: 24px;
	}
		
    #tabs ul li {
      margin: 0;
      padding: 10px 20px;
      font-size: 18px;
      font-weight: bold;
      color: #30005A;
      cursor: pointer;
      border: none; /* 테두리 제거 */
      background: none; /* 배경 제거 */
    }

    #tabs ul li.ui-tabs-active {
      border-bottom: 3px solid #E9396B; /* 핑크색 밑줄 */
    }

    #tabs ul li:hover {
      background-color: transparent; /* 호버 효과 제거 */
    }
    
    #tabs ul li a:hover {
	  color: inherit; /* 글씨색 변경 효과 제거 */
	  text-decoration: none; /* 밑줄 제거 */
	}
	
	
  </style>
  
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../modal/modal.jsp"></jsp:include>
  <jsp:include page="../main/header.jsp"></jsp:include>
  
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
	var tabNum = 1;            // 선택한 탭번호 변수
	var pagination = '';       // 페이지네이션 선택자 변수
	var searchFilter = 'name'; // 검색 필터 값 담을 변수
	var searchKeyword = '';    // 검색 값 담을 변수
	

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
	
	
 	// 활성사원 리스트 가져오기
	pageCall(showPage, tabNum);
	
	// 탭 이벤트 발생시
	$( function() {
	    $( "#tabs" ).tabs({
	    	activate: function(event, ui) {
	            // 현재 활성화된 탭의 ID를 확인
	            var activeTab = ui.newPanel.attr('id');

	            if (activeTab === 'activ_emp') {
	                // 활성 사원 탭일 때
	                tabNum = 1;
	                pageCall(showPage, tabNum); // 초기 페이지는 1로 호출
	            } else if (activeTab === 'inactiv_emp') {
	                // 비활성 사원 탭일 때
	                tabNum = 0;
	                pageCall(showPage, tabNum);
	            }
	        }
	    });
	} );
	
	
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
	        	'state' : tabNum, // 활성화 or 비활성화 여부
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
	      		
	      	    content =  '<a href="empDetail.go?emp_idx=' + item.emp_idx + '">' +
		      	    		   '<div class="employee-card">' +
		      	                    '<div class="profile-pic">' + item.photo + '</div>' +
		      	                    '<div class="employee-details">' +
		      	                        '<div class="name-title">' + item.depart_name + ' ' + item.name + ' ' + item.rank_name + '</div>' +
		      	                        '<p><strong>email:</strong> ' + item.email + '</p>' +
		      	                        '<p><strong>tel:</strong> ' + item.phone + '</p>' +
		      	                        '<p><strong>mobile:</strong> ' + item.mobile + '</p>' +
		      	                    '</div>' +
		      	               '</div>' +
	      	               '</a>';
	      	                
	 	        // 사원목록의 사원카드 정보 업데이트        
	      	    $(area).append(content);
	      	});
	    }
	
	}

	/***********************  페이징 처리 끝 ****************************/	
	
</script>

</html>
