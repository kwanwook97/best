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
	    margin-top: 7.5vh;
	    flex-wrap: nowrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 90%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: center;
	    justify-content: center;
	}
	.maintext{
		width: 20%;
	    display: flex;
	    margin-left: -68vw;
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
	    width: 1000px;
        height: 711px;
	    border-radius: 10px;
	    flex-direction: column;
	    align-items: center;
	}
	.dropBox{
	    margin-top: 8px;
	    width: 85%;
	    display: flex;
	    justify-content: flex-end;
	}
	.docnav{
	    width: 55vw;
	    display: flex;
	    margin: 0 55px 10px 0;
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
		position: fixed;
	    width: 935px;
        top: 155px;
		border-collapse: separate !important;
        border-spacing: 0;
		border-radius: 10px;
    	margin: 22px 48px 6px 48px;
		border: 2px solid var(--primary-color);
	}
	table.my-table i{
	    color: var(--accent-color);
	}
	table.my-table tr:not(:last-child) td, table.my-table th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
    table.my-table thead tr{
   	    background-color: var(--primary-color);
    	color: white;
    }
    table.my-table thead tr th{
   	   	padding: 3px 0 4px 0;
    }
	table.my-table thead tr th:first-child {
    border-top-left-radius: 5px;
	}
	
	table.my-table thead tr th:last-child {
	    border-top-right-radius: 5px;
	}
	table.my-table tbody tr{
		height: 30px;
	}
	table.my-table td:hover{
		cursor: pointer;
		color: var(--accent-color);
	}
	table.my-table th{
		text-align: center;
	}
	table.my-table td{
		padding: 3px 0 4px 0;
	    text-align: center;
	    font-size: 14px;
	}
    table.my-table td:nth-child(1) {
        width: 1%;
    }
    table.my-table td:nth-child(2) {
        width: 10%;
    }
    table.my-table td:nth-child(3) {
        width: 3%;
    }
    table.my-table td:nth-child(4) {
        width: 2%;
    }
    table.my-table td:nth-child(5) {
        width: 2%;
    }
    .container{
    	position: absolute;
    	bottom: 39px;
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
	    .my-table{
            width: 83vw;
	        top: 120px;
	        left: 0px;
    	}	    
  	}
  	@media (max-width: 959px) {
	    .container {
	        max-width: 100vw !important;
	    }
	    #freeCont{
	    	top: 19rem;
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
			<span>자유 게시판</span>
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
				<button class="editbtn"><i class="far fa-edit"></i>작성</button>
			</div>
		</div>
		<div class="docbox">
<!-- 			<div class="dropBox">
				<div class="drop">
				    <select class="drop cntSelector">
				        <option value="5">5개씩 보기</option>
				        <option value="10">10개씩 보기</option>
				        <option value="15" selected>15개씩 보기</option>
				        <option value="20">20개씩 보기</option>
				    </select>
				</div>
			</div> -->
			<table class="my-table">
				<thead>
					<tr>
						<th>NO</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody class="freeBoard">
				</tbody>
			</table>
			<div class="container" id="freeCont">
			    <nav aria-label="Page navigation">
			        <ul class="pagination" id="freePagination"></ul>
			    </nav>
			</div>
		</div>
 	</div>
</body>
<script>

var page = 1;
var itemsPerPage = 20;

pageCall(page);

//페이지 호출 함수
function pageCall(page) {
    console.log('pageCall');
    console.log("itemsPerPage: " + itemsPerPage);

    $.ajax({
        type: 'GET',
        url: 'freeBoardList.ajax',
        data: {
            'page': page,
            'cnt': itemsPerPage
        },
        dataType: 'JSON',
        success: function(data) {
            var startNumber = (page - 1) * itemsPerPage + 1;
            printList(data.freeList, startNumber);
            
            $('#freePagination').twbsPagination('destroy');
            
            $('#freePagination').twbsPagination({
                startPage: 1,
                totalPages: data.totalPages,
                visiblePages: 5,
                onPageClick: function(evt, page) {
                    pageCallList(page);
                }
            });
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 항목 개수 변경 이벤트
/* $('.cntSelector').on('change', function() {
    itemsPerPage = parseInt($(this).val()); // 사용자가 선택한 개수
    page = 1; // 첫 페이지로 초기화
    pageCall(page); // 첫 페이지 데이터 로드
}); */

// 리스트 출력 함수
function printList(list, startNumber) {
	console.log("뿌리기", list);
    var content = '';
    var i = startNumber; // 시작 번호 설정
    for (var item of list) {
        content += '<tr onclick="window.location.href=\'freeDetail.go?idx=' + item.board_idx + '\'">';
        content += '<td>' + i++ + '</td>';
        content += '<td>' + item.subject + '</td>';
        content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
        var date = new Date(item.date);
        var formattedDate = date.toISOString().split('T')[0];

        content += '<td>' + formattedDate + '</td>';
        content += '<td>' + item.bhit + '</td>';
        content += '</tr>';
    }
    $('.freeBoard').html(content);
}

// 페이지 클릭 시 호출 함수
function pageCallList(page) {
    var startNumber = (page - 1) * itemsPerPage + 1;
    $.ajax({
        type: 'GET',
        url: 'freeBoardList.ajax',
        data: {
            'page': page,
            'cnt': itemsPerPage
        },
        dataType: 'JSON',
        success: function(data) {
            printList(data.freeList, startNumber);
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
        
        if (searchText.trim() !== '') {
        	$.ajax({
                type: 'GET',
                url: 'freeSearch.ajax',
                data: {
                    searchText: searchText,
                    searchOption: searchOption,
                    page: 1,
                    cnt: itemsPerPage 
                },
                dataType: 'JSON',
                success: function(data) {
                	console.log("tq",data.freeList);
                	var startNumber = (page - 1) * itemsPerPage + 1;
                	if(data.freeList.length>0){
	                	printSearchList(data.freeList, startNumber);
	                	
	                    $('#freePagination').twbsPagination({
	                        startPage: 1,
	                        totalPages: data.totalPages,
	                        visiblePages: 5,
	                        onPageClick: function(evt, page) {
	                            console.log("evt", evt);
	                            console.log("page", page);
	                            pageCallSearchList(page,searchText,searchOption);
	                        }
	                    });
                	}else{
                		var content = '<tr>';
    	        		content += '<td colspan="5"> 검색결과가 없습니다. </td>';
    	        		content += '</tr>';
    	        		$('.freeBoard').html(content);
    	        		$('#freePagination').twbsPagination('destroy');
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

$('input[name="search"]').on('input', function() {
    var query = $(this).val().trim();

    if (query === "") {
        pageCall(1);
    }
});

function printSearchList(list, startNumber){
	var content = '';
    var i = startNumber;
    for (var item of list) {
        content += '<tr onclick="window.location.href=\'freeDetail.go?idx=' + item.board_idx + '\'">';
        content += '<td>' + i++ + '</td>';
        content += '<td>' + item.subject + '</td>';
        content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
        var date = new Date(item.date);
        var formattedDate = date.toISOString().split('T')[0];

        content += '<td>' + formattedDate + '</td>';
        content += '<td>' + item.bhit + '</td>';
        content += '</tr>';
    }
    $('.freeBoard').html(content);
}
function pageCallSearchList(page,searchText,searchOption) {
    var startNumber = (page - 1) * itemsPerPage + 1;
    $.ajax({
    	type: 'GET',
        url: 'freeSearch.ajax',
        data: {
            searchText: searchText,
            searchOption: searchOption,
            page: 1,
            cnt: itemsPerPage 
        },
        dataType: 'JSON',
        success: function(data) {
            printList(data.freeList, startNumber);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 공지 작성
$('.editbtn').on('click', function(){
	window.location.href="freeWrite.go";
});


var config = {}
config.editorResizeMode = "none";
//config.toolbar = "basic";

//data:imgae - 이미지를 base64 형태로 문자열화 한것이다.
//장점 : 별도의 파일처리 없이 파일을 다룰 수 있다. 사용이 간단하다.
//단점 : 용량제어가 안되며, 기존파일보다 용량이 커진다. 
config.file_upload_handler = function(file,pathReplace){ // 파일객체, 경로변경 함수, 자바스크립트는 함수를 매개변수로 넘길수있음
	console.log(file);

	if(file.size>(1*1024*1024)){
		alert('2MB이상의 파일은 올릴 수 없습니다.');
		pathReplace('/img/noimage.png');
	}
}

var editor = new RichTextEditor("#div_editor", config);

function save() {
	var content = editor.getHTMLCode(); // 에디터의 HTML 포함 내용 가져오기
    var textOnly = $('<div>').html(content).text(); // HTML 태그 제거하고 순수 
    
    console.log("sdf"+content);
    console.log("qudㄴ병신"+textOnly);
    
    var content = editor.getHTMLCode(); // 에디터 내용 가져오기
    console.log(content);
    console.log("전체 문서의 크기 :" + (content.length / 1024 / 1024) + "MB");

    // 제목 입력 확인
    var subject = $('input[name="subject"]').val().trim(); // 제목 필드 값 가져오기
    if (!subject) {
        alert("제목을 입력해주세요.");
        return;
    }

    // 500자 제한 확인
    if (content.length > 500) {
        alert("내용이 500자를 초과할 수 없습니다.");
        return;
    }

    // 체크박스 상태에 따라 importance 값 설정
    if ($('#check').prop('checked')) {
        $('input[name="importance"]').val('1');
    } else {
        $('input[name="importance"]').val('0');
    }

    // 100MB 초과 확인
    if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
        return; // 폼 제출 중단
    }

    // 폼 데이터 설정 및 제출
    $('input[name="content"]').val(content);
    $('form').submit();
}

</script>
</html>
