<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    width: 85vw;
	    margin-top: 6vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 86%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: center;
	    justify-content: center;
	}
	.maintext{
        width: 20%;
	    display: flex;
	    margin-left: -67vw;
	    margin-bottom: -12px;
	    justify-content: space-between;
	    align-items: baseline;	
	}
	.maintext i,
	.maintext span{
		font-size: 32px !important;
		font-weight: bold !important;
	}
	.maintext span:first-child{
		color: var(--secondary-color);
	}
	.docbox{
    	display: flex;
    	justify-content: center;
		border: 2px solid var(--primary-color);
	    width: 50vw;
		height: 89%;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
        align-content: center;
	}
	.docnav{
	    width: 55vw;
	    display: flex;
	    padding: 0 55px 5px 0;
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
	.editbtn{
		color: white;
		background-color: var(--accent-color);
		border-radius: 10px;
		width: 70px;
	}
	table.my-table{
		border-collapse: separate !important;
        border-spacing: 0;
	}
	table{
		width: 45vw;
		border-radius: 10px;
		margin: 33px 48px 55px 48px;
	}
	table.my-table tr:not(:last-child) td, table.my-table th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table.my-table tr{
		height: 30px;
	}
	table.my-table tr td:nth-child(2):hover{
		cursor: pointer;
		color: var(--accent-color);
	}
	td{
		padding-left: 21px;
	    font-size: small;
	}
    td:nth-child(1) {
        width: 5%;
    }
    td:nth-child(2) {
        width: 10%;
    }
    td:nth-child(3) {
        width: 0%;
    }
    td:nth-child(4) {
        width: 5%;
    }
    td:nth-child(5) {
        width: 2%;
    }
    td:nth-child(6) {
        width: 2%;
    }
	.container nav{
		display:flex;
		justify-content: center;
	}
	.table1{
		border: 2px solid var(--primary-color);
	    position: fixed;
    	top: 10rem;
	}
	#importCont{
	    position: fixed;
	    top: 22rem;
	}
	.table2{
		border: 1px solid var(--primary-color);
	    position: fixed;
    	top: 23rem;
	}
	.table1 i{
	    color: var(--accent-color);
	}
	#generalCont{
	    position: fixed;
        top: 48rem;
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
	@media (min-width: 1200px) {
	    .container {
	        max-width: 80vw !important;
	    }
	}
	@media (max-width: 960px) {
	    .dashboard-body {
            transform: scale(0.7);
	        margin-left: 18vw;
	        margin-top: 0;
	        height: 102vh;
	        width: 93vw;
	    }
	    .table1{
            width: 83vw;
	        top: 120px;
	        left: 0px;
    	}
	    .table2{
	    	width: 83vw;
	    	top: 342px;
	    	left: 0px;
	    }
	    
  	}
  	@media (max-width: 959px) {
	    .container {
	        max-width: 100vw !important;
	    }
	    #importCont{
	    	top: 19rem;
	    }
	    #generalCont {
		    top: 46rem;
		}
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="document">게시판</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span>공지 게시판</span>
		</div>
		<div class="docnav">
			<div class="searchbox">
				<div class="searchCont">
					
				</div>
				<select class="drop">
				  <option value="subject">제목</option>
				  <option value="name">작성자</option>
				</select>
				<div class="search">
					<input type="text" name="search" class="searchInp">
					<i class="fas fa-search"></i>
				</div>
				<c:if test="${sessionScope.employee.depart_idx == 2 || sessionScope.employee.depart_idx == 3 || sessionScope.employee.depart_idx == 6}">
				    <button class="editbtn"><i class="far fa-edit"></i>작성</button>
				</c:if>
			</div>
		</div>
		<div class="docbox">
			<!-- 중요 공지 -->
			<table class="table1 my-table">
				<tbody class="import">
				</tbody>
			</table>
			<div class="container" id="importCont">
			    <nav aria-label="Page navigation">
			        <ul class="pagination" id="importantPagination"></ul>
			    </nav>
			</div>
			<!-- 일반 공지 -->
			<table class="table2 my-table">
				<tbody class="general">
				</tbody>
			</table>
			<div class="container" id="generalCont">
			    <nav aria-label="Page navigation">
			        <ul class="pagination" id="generalPagination"></ul>
			    </nav>
			</div>
		</div>
 	</div>
</body>
<script>

/* 공지 게시판 중요 */
var showPage = 1; // 기본으로 보여줄 페이지
var emp_idx = "${sessionScope.loginId}";
var depart_idx = "${sessionScope.employee.depart_idx}";

pageCall(showPage);

function pageCall(page){
    $.ajax({
        type: 'GET',
        url: 'noticeList.ajax',
        data: {
            'page': page,  // 몇 페이지 보여줄지
            'cnt': 5       // 페이지당 보여줄 게시물 수
        },
        dataType: 'JSON',
        success: function(data) {
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
                    console.log("evt", evt);
                    console.log("page", page);
                    pageCallImportant(page);
                }
            });

            // 일반 공지
            $('#generalPagination').twbsPagination({
                startPage: 1,
                totalPages: data.generalTotalPages,
                visiblePages: 5,
                onPageClick: function(evt, page){
                    console.log("evt", evt);
                    console.log("page", page);
                    pageCallGeneral(page);
                }
            });
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}


function PrintImport(notices) {
	
    var content = '';
	
    for (var item of notices) {
        content += '<tr>';
        if (item.depart_idx == depart_idx) {
            content += '<td><i class="bi bi-megaphone-fill" style="cursor: pointer;" onclick="handleIconClick(' + item.board_idx + ',1)"></i></td>';
        } else {
            content += '<td><i class="bi bi-megaphone-fill"></i></td>';
        }
        content += '<td onclick="window.location.href=\'noticeDetail.go?idx=' + item.board_idx + '\'">' + item.subject + '</td>';
        content += '<td><input type="hidden" value="' + item.emp_idx + '"></td>';
        content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
        
        var date = new Date(item.date);
        var formattedDate = date.toISOString().split('T')[0];
        
        content += '<td>' + formattedDate + '</td>';
        content += '<td>' + item.bhit + '</td>';
        content += '</tr>';
    }
    $('.import').html(content);

}


function PrintGeneral(notices) {
    var content = '';
	
    for (var item of notices) {
        content += '<tr>';
        if (depart_idx==2 || depart_idx==3) {
            content += '<td><i class="bi bi-megaphone-fill" style="cursor: pointer;" onclick="handleIconClick(' + item.board_idx + ',0)"></i></td>';
        } else {
            content += '<td><i class="bi bi-megaphone-fill"></i></td>';
        }
        content += '<td onclick="window.location.href=\'noticeDetail.go?idx=' + item.board_idx + '\'">' + item.subject + '</td>';
        content += '<td><input type="hidden" value="' + item.emp_idx + '"></td>';
        content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
        
        var date = new Date(item.date);
        var formattedDate = date.toISOString().split('T')[0];
        
        content += '<td>' + formattedDate + '</td>';
        content += '<td>' + item.bhit + '</td>';
        content += '</tr>';
    }
    $('.general').html(content);

    // 클릭 핸들러 함수
    function handleIconClick(boardIdx) {
        alert('아이콘 클릭! 게시글 ID2: ' + boardIdx);
        // 필요한 로직 추가 (예: 페이지 이동, 팝업 등)
    }

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
                    searchText: searchText,
                    searchOption: searchOption,
                    page: 1,
                    cnt: 5 
                },
                dataType: 'JSON',
                success: function(data) {
                    if (data.importantNotices.length === 0) {
                        $('.searchCont').append('<div class="Msg">중요 공지 없음</div>');
                    }
                    if (data.generalNotices.length === 0) {
                        $('.searchCont').append('<div class="Msg">일반 공지 없음</div>');
                    }
                    if (data.importantNotices.length > 0) {
                        searchImport(data.importantNotices);

                        $('#importantPagination').twbsPagination({
                            startPage: 1,
                            totalPages: data.importTotalPages,
                            visiblePages: 5,
                            first: '<i class="fas fa-angle-double-left"></i>',
                            prev: '<i class="fas fa-angle-left"></i>',
                            next: '<i class="fas fa-angle-right"></i>',
                            last: '<i class="fas fa-angle-double-right"></i>',
                            onPageClick: function(evt, page) {
                                console.log("evt", evt);
                                console.log("page", page);
                                searchCallImportant(page);
                            }
                        });
                    }
                    if (data.generalNotices.length > 0) {
                    	searchGeneral(data.generalNotices);

                        $('#generalPagination').twbsPagination({
                            startPage: 1,
                            totalPages: data.generalTotalPages,
                            visiblePages: 5,
                            first: '<i class="fas fa-angle-double-left"></i>',
                            prev: '<i class="fas fa-angle-left"></i>',
                            next: '<i class="fas fa-angle-right"></i>',
                            last: '<i class="fas fa-angle-double-right"></i>',
                            onPageClick: function(evt, page) {
                                console.log("evt", evt);
                                console.log("page", page); 
                                searchCallGeneral(page);
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

//검색창 실시간 감지
$('input[name="search"]').on('input', function() {
    var query = $(this).val().trim();

    if (query === "") {
        pageCall(1);
    }
});
    
function searchCallImportant(page){
	$.ajax({
        type: 'GET',
        url: 'noticeSearch.ajax',
        data: {
            searchText: searchText,
            searchOption: searchOption,
            page: 1,
            cnt: 5 
        },
        dataType: 'JSON',
        success: function(data) {
            searchImport(data.importantNotices);
        },
        error: function(e) {
            console.log("검색 오류 발생", e);
        }
    });
}

function  searchImport(notices){
	 var content = '';
	    for (var item of notices) {
	        content += '<tr>';
	        if (depart_idx==2 || depart_idx==3){
	            content += '<td><i class="bi bi-megaphone-fill" style="cursor: pointer;" onclick="handleIconClick(' + item.board_idx + ',1)"></i></td>';
	        } else {
	            content += '<td><i class="bi bi-megaphone-fill"></i></td>';
	        }
	        content += '<td onclick="window.location.href=\'noticeDetail.go?idx=' + item.board_idx + '\'">' + item.subject + '</td>';
	        content += '<td><input type="hidden" value="' + item.emp_idx + '"></td>';
	        content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
	        
	        var date = new Date(item.date);
	        var formattedDate = date.toISOString().split('T')[0];
	        
	        content += '<td>' + formattedDate + '</td>';
	        content += '<td>' + item.bhit + '</td>';
	        content += '</tr>';
	    }
	    $('.import').html(content);

}
        
function searchCallGeneral(page){
	$.ajax({
        type: 'GET',
        url: 'noticeSearch.ajax',
        data: {
            searchText: searchText,
            searchOption: searchOption,
            page: 1,
            cnt: 5 
        },
        dataType: 'JSON',
        success: function(data) {
            searchGeneral(data.generalNotices);
        },
        error: function(e) {
            console.log("검색 오류 발생", e);
        }
    });
}
        
function searchGeneral(notices){
	
    var content = '';

    for (var item of notices) {
        content += '<tr>';
        if (depart_idx==2 || depart_idx==3){
            content += '<td><i class="bi bi-megaphone-fill" style="cursor: pointer;" onclick="handleIconClick(' + item.board_idx + ',0)"></i></td>';
        } else {
            content += '<td><i class="bi bi-megaphone-fill"></i></td>';
        }
        content += '<td onclick="window.location.href=\'noticeDetail.go?idx=' + item.board_idx + '\'">' + item.subject + '</td>';
        content += '<td><input type="hidden" value="' + item.emp_idx + '"></td>';
        content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
        
        var date = new Date(item.date);
        var formattedDate = date.toISOString().split('T')[0];
        
        content += '<td>' + formattedDate + '</td>';
        content += '<td>' + item.bhit + '</td>';
        content += '</tr>';
    }
    $('.general').html(content);

}
        
function handleIconClick(board_idx, status) {
    
	var importance = status === 1 ? 0 : 1;
	
	 $.ajax({
        type: 'POST',
        url: 'toggleImportant.ajax',
        data: {
        	board_idx: board_idx,
        	importance: importance
        },
        dataType: 'JSON',
        success: function(response) {
        	 pageCall(1);
        },
        error: function(xhr, status, error) {
            console.error('오류 발생:', error);
        }
    });
}


// 공지 작성
$('.editbtn').on('click', function(){
	window.location.href="noticeWrite.go";
});



</script>
</html>
