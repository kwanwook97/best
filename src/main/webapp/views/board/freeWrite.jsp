<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<link rel="stylesheet" href="resources/richtexteditor/res/style.css" />
	<link rel="stylesheet" href="resources/richtexteditor/rte_theme_default.css" />
	<link rel="stylesheet" href="resources/richtexteditor/runtime/richtexteditor_content.css" />
	<script type="text/javascript" src="resources/richtexteditor/rte.js"></script>
	<script type="text/javascript" src='resources/richtexteditor/plugins/all_plugins.js'></script>	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    width: 85vw;
	    margin-top: 5vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
	    width: 25%;
	    display: flex;
	    margin-left: -17vw;
	    margin-bottom: 42px;
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
		cursor: pointer;
	}
	.maintext span:last-child{
		color: var(--primary-color);
	}
	.formBorder{    
		display: flex;
	    align-items: center;
	    justify-content: center;
    	width: 950px;
    	height: 660px;	
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	}
	form{
	    width: 47vw;
	}
	table{
		border-radius: 10px;
	}
	th, td{
		border: none !important;
	}
	input[type="text"]{
		width: 47%;
		border: 1px solid lightgray;
		font-size: 14px;
	}
	input[name="name"]{
	    all: unset;
	    -webkit-appearance: none;
	    -moz-appearance: none;
	    appearance: none;
	    pointer-events: none;
	}
	input::placeholder {
	    color: var(--primary-color) !important;
	    font-size: 14px;
	    opacity: 1;
	}
	label{
		color : var(--accent-color) !important;
	}
	label, input[type="checkbox"]{
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    user-select: none;
	}
	#check{
	    width: 10px;
    	height: 10px;
	}
	#div_editor{
	    height: 55vh;
	}
	rte-content{
		border-radius: 10px;
	}
	rte-bottom{
		display: none !important;
	}
	input[type="button"]{
		width:100%;
		height: 30px;
		background-color: var(--secondary-color);
		border: none;
		border-radius: 5px;
		color: white;
	}
	input[type="button"]::hover{
		background-color: var(--accent-color);
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 		<div class="maintext">
			<span class="document" onclick="location.href='freeBoard.go'">자유 게시판</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span>게시글 작성</span>
		</div>
		<div class="formBorder">
			<form action="freeWrite.do" method="POST">
			<table>
				<tr>
					<td>제목 : <input type="text" name="subject" placeholder="제목을 입력 하세요! 20자 이내 작성" maxlength="20"/></td>
				</tr>
				<tr style="display: none;">
					<td><input type="text" name="name" value="${sessionScope.loginName}" readonly/></td>
				</tr>
				<tr>
					<td>
						<div id="div_editor">
						</div>
						<input type="hidden" name="content"/>
						<p id="charCount">0 / 500</p>
					</td>
				</tr>
				<tr>
					<th><input type="button" value="글쓰기" onclick="save()"/></th>
				</tr>
			</table>
			</form>
		</div>
 	</div>
</body>
<script>

var emp_idx = "${sessionScope.loginId}";
var emp_name = "${sessionScope.loginName}";
var config = {}
config.editorResizeMode = "none";
//config.toolbar = "basic";

//data:imgae - 이미지를 base64 형태로 문자열화 한것이다.
//장점 : 별도의 파일처리 없이 파일을 다룰 수 있다. 사용이 간단하다.
//단점 : 용량제어가 안되며, 기존파일보다 용량이 커진다. 
config.file_upload_handler = function(file,pathReplace){
	if(file.size>(1*1024*1024)){
		alert('2MB이상의 파일은 올릴 수 없습니다.');
		pathReplace('/img/noimage.png');
	}
}
var editor = new RichTextEditor("#div_editor", config);
var maxLength = 500; // 최대 글자 수

// 에디터 내용 변경 감지 함수
function updateCharCount() {
    var content = editor.getHTMLCode(); // HTML 포함 내용 가져오기
    var textOnly = $('<div>').html(content).text(); // HTML 태그 제외한 순수 텍스트 추출

    // 글자 수 업데이트
    $('#charCount').text(textOnly.length + ' / ' + maxLength);

    // 글자 수 초과 처리
    if (textOnly.length > maxLength) {
        alert("내용이 500자를 초과할 수 없습니다.");

        // 초과된 글자를 잘라내기
        var truncatedText = textOnly.substring(0, maxLength);
        editor.setHTMLCode(truncatedText); // 잘린 텍스트로 업데이트

        // 글자 수 다시 업데이트
        $('#charCount').text(maxLength + ' / ' + maxLength);
    }
}

// MutationObserver 설정
function observeEditorChanges() {
    var targetNode = document.querySelector('#div_editor iframe').contentDocument.body; // RichTextEditor 내부 콘텐츠
    var observer = new MutationObserver(function () {
        updateCharCount(); // DOM 변화 시 글자 수 업데이트
    });

    // MutationObserver 옵션
    observer.observe(targetNode, {
        characterData: true, // 텍스트 변화 감지
        subtree: true,       // 하위 노드 포함 감지
        childList: true,     // 자식 노드 추가/삭제 감지
    });

    // 초기 글자 수 업데이트
    updateCharCount();
}

// 페이지 로드 시 MutationObserver 초기화
observeEditorChanges();



function save() {
    var content = editor.getHTMLCode();
    // 제목 입력 확인
    var subject = $('input[name="subject"]').val().trim(); // 제목 필드 값 가져오기
    if (!subject) {
        alert("제목을 입력해주세요.");
        return;
    }    
 	
    // 체크박스 상태에 따라 importance 값 설정
    if ($('#check').prop('checked')) {
        $('input[name="importance"]').val('true');
    } else {
        $('input[name="importance"]').val('false');
    }

    if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
    } else {
        $('input[name="content"]').val(content);
        $('form').submit();
    }
}
</script>
</html>
