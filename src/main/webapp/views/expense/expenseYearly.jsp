<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    margin-top: 10vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: baseline;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: -34vw;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px !important;
	}
	.docnav{
	    width: 1290px;
    	display: flex;
    	padding: 0 0 15px 0;
	    justify-content: flex-end;
	}
	.searchbox{
		display: flex;
		align-items: center;
		justify-content: space-evenly;
	}
	.searchbox div{
		margin: 0 5px;
	}
	.searchCont{
		display: flex;
	}
	.drop{
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	}
	select option{
		background-color: white !important;
		border-radius: 5px;
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
	.docbox{
    	display: flex;
    	justify-content: space-evenly;
        align-items: center;
		border: 2px solid var(--primary-color);
	    width: 1300px;
	    height: 680px;
	    border-radius: 10px;
	}
	.itemList{
		border: 1px solid var(--primary-color);
	    width: 35%;
    	height: 620px;
	}
	.expenseChart{
		border: 1px solid var(--primary-color);
	    width: 55%;
	    height: 620px;
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
	@media (max-width: 960px) {
	    .dashboard-body {
            transform: scale(0.7);
	        margin-left: 18vw;
	        margin-top: 0;
	        height: 102vh;
	        width: 93vw;
	    }
  	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">지출정산</h3>
			<h3>>&nbsp;&nbsp;월별현황</h3>
		</div>
		<div class="docnav">
			<div class="searchbox">
				<div class="searchCont">
				</div>
				<select class="drop">
				  <option value="month">월</option>
				  <option value="category">품목</option>
				</select>
				<div class="search">
					<input type="text" name="search" class="searchInp">
					<i class="fas fa-search"></i>
				</div>
			</div>
		</div>
		<div class="docbox">
			<div class="itemList"></div>
			<div class="expenseChart"></div>
		</div>
 	</div>
</body>
<script>

/* 공지 게시판 중요 */
var showPage = 1; // 기본으로 보여줄 페이지

pageCall(showPage);

function pageCall(page){
    console.log('pageCall');

    $.ajax({
        type: 'GET',
        url: 'noticeList.ajax',
        data: {
            'page': page,  // 몇 페이지 보여줄지
            'cnt': 5       // 페이지당 보여줄 게시물 수
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);

            // 중요 공지
            PrintImport(data.importantNotices);
        	// 일반 공지
            PrintGeneral(data.generalNotices);

            // 페이징 플러그인 처리 - 중요 공지
            $('#importantPagination').twbsPagination({
                startPage: 1,
                totalPages: data.importTotalPages,
                visiblePages: 5,
                onPageClick: function(evt, page){
                    console.log("evt", evt);  // 클릭 이벤트
                    console.log("page", page);  // 클릭한 페이지 번호
                    pageCallImportant(page);  // 중요 게시판 페이지 정보 받아서 수행
                }
            });

            // 일반 공지
            $('#generalPagination').twbsPagination({
                startPage: 1,
                totalPages: data.generalTotalPages,
                visiblePages: 5,
                onPageClick: function(evt, page){
                    console.log("evt", evt);  // 클릭 이벤트
                    console.log("page", page);  // 클릭한 페이지 번호
                    pageCallGeneral(page);  // 일반 게시판 페이지 정보 받아서 수행
                }
            });
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 중요 게시판 글 출력 함수
function PrintImport(notices) {
	
    var content = '';
	
	for(var item of notices){
		content += '<tr onclick="window.location.href=\'noticeDetail.go?idx=' + item.board_idx + '\'">';
		content += '<td><i class="bi bi-megaphone-fill"></i></td>';
		content += '<td>'+item.subject+'</td>';
		content += '<td>'+item.name+'</td>';
		
		var date = new Date(item.date);
		var formattedDate = date.toISOString().split('T')[0];
		
		content += '<td>'+formattedDate+'</td>';
		content += '<td>'+item.bhit+'</td>';
		content += '</tr>';
	}
	$('.import').html(content);
    
}

// 일반 게시판 글 출력 함수
function PrintGeneral(notices) {
    
	var content = '';
	
	for(var item of notices){
		content += '<tr onclick="window.location.href=\'noticeDetail.go?idx=' + item.board_idx + '\'">';
		content += '<td><i class="bi bi-megaphone-fill"></i></td>';
		content += '<td>'+item.subject+'</td>';
		content += '<td>'+item.name+'</td>';
		
		var date = new Date(item.date);
		var formattedDate = date.toISOString().split('T')[0];
		
		content += '<td>'+formattedDate+'</td>';
		content += '<td>'+item.bhit+'</td>';
		content += '</tr>';
	}
	$('.general').html(content);
}

// 중요 공지
function pageCallImportant(page) {
    $.ajax({
        type: 'GET',
        url: 'noticeList.ajax',
        data: {
            'page': page,
            'cnt': 5
        },
        dataType: 'JSON',
        success: function(data) {
        	PrintImport(data.importantNotices);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 일반 공지
function pageCallGeneral(page) {
    $.ajax({
        type: 'GET',
        url: 'noticeList.ajax',
        data: {
            'page': page,
            'cnt': 5
        },
        dataType: 'JSON',
        success: function(data) {
        	PrintGeneral(data.generalNotices);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 검색
$('.searchInp').keydown(function(event) {
    if (event.key === 'Enter') {
       	var searchText = $(this).val();
        var searchOption = $('.drop').val();
        $('.Msg').remove();
        
        if (searchText.trim() !== '') {
        	$.ajax({
                type: 'GET',
                url: 'noticeSearch.ajax',
                data: {
                    'searchText': searchText,
                    'searchOption': searchOption,
                    'page': 1,
                    'cnt': 5 
                },
                dataType: 'JSON',
                success: function(data) {
                    console.log(data);
                    if (data.importantNotices.length === 0) {
                        $('.searchCont').append('<div class="Msg">중요 공지 없음</div>');
                    }
                    if (data.generalNotices.length === 0) {
                        $('.searchCont').append('<div class="Msg">일반 공지 없음</div>');
                    }
                    if (data.importantNotices.length > 0) {
                        PrintImport(data.importantNotices);

                        $('#importantPagination').twbsPagination({
                            startPage: 1,
                            totalPages: data.importTotalPages,
                            visiblePages: 5,
                            first: '<i class="fas fa-angle-double-left"></i>',
                            prev: '<i class="fas fa-angle-left"></i>',
                            next: '<i class="fas fa-angle-right"></i>',
                            last: '<i class="fas fa-angle-double-right"></i>',
                            onPageClick: function(evt, page) {
                                console.log("evt", evt);  // 클릭 이벤트
                                console.log("page", page);  // 클릭한 페이지 번호
                                pageCallImportant(page);  // 중요 게시판 페이지 정보 받아서 수행
                            }
                        });
                    }
                    if (data.generalNotices.length > 0) {
                        PrintGeneral(data.generalNotices);

                        $('#generalPagination').twbsPagination({
                            startPage: 1,
                            totalPages: data.generalTotalPages,
                            visiblePages: 5,
                            first: '<i class="fas fa-angle-double-left"></i>',
                            prev: '<i class="fas fa-angle-left"></i>',
                            next: '<i class="fas fa-angle-right"></i>',
                            last: '<i class="fas fa-angle-double-right"></i>',
                            onPageClick: function(evt, page) {
                                console.log("evt", evt);  // 클릭 이벤트
                                console.log("page", page);  // 클릭한 페이지 번호
                                pageCallGeneral(page);  // 일반 게시판 페이지 정보 받아서 수행
                            }
                        });
                    }
                },
                error: function(e) {
                    console.log("검색 오류 발생", e);
                }
            });
        } else {
            alert('검색어를 입력해주세요!');
        }
    }
});


// 공지 작성
$('.editbtn').on('click', function(){
	window.location.href="noticeWrite.go";
});

</script>
</html>
