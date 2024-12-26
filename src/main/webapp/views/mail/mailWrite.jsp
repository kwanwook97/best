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
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script> 
  
  
  
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
	    padding: 10px;
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
	
	.mailForm{
		height: 100%;
	}
	
	table, tr, td{
		color: var(--primary-color);
	}
	
	tr input[type='text']{
		width: 70%;
		background-color: #FFFBF2;
		border: none;
	}
	
	#div_editor{
		height: 100%;
	}
	
	.specialChk{
		color: var(--accent-color) !important;
	}
	
	  /* 버튼 크기와 폰트 크기 통일 */
	  button[type="button"] {
	      height: 40px; /* 버튼 높이 */
	      min-width: 120px; /* 버튼 최소 너비 */
	      padding: 5px 10px; /* 내부 여백 */
	      font-size: 16px; /* 버튼 내부 폰트 크기 */
	      font-weight: bold; /* 폰트 굵기 */
	      background-color: var(--secondary-color); /* 기본 배경색 */
	      border: none; /* 테두리 제거 */
	      border-radius: 5px; /* 둥근 모서리 */
	      color: white; /* 폰트 색상 */
	      display: inline-flex; /* 아이콘과 텍스트 정렬 */
	      align-items: center; /* 수직 정렬 */
	      justify-content: center; /* 텍스트와 아이콘 중앙 정렬 */
	  }
	  button[type="button"]:hover {
	      background-color: var(--primary-color); /* 호버 시 배경색 변경 */
	  }
	  button[type="button"] i {
	      margin-right: 5px; /* 아이콘과 텍스트 간격 */
	      font-size: 18px; /* 아이콘 크기 */
	  }
	
	.btnArea{
		text-align: right;
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
			<form action="mailWrite.do" method="POST">
				<table class="mailForm">
					<tr>
						<td>작성자 : <input type="text" name="name" value="에이스" readonly/></td>
					</tr>
					<tr>
						<td>제목 : <input type="text" name="subject" placeholder="제목을 입력 하세요! 20자 이내 작성" maxlength="20"/>
							<input type="checkbox" name="mailType" id="mailType" value="1">
							<label for="mailType" class="specialChk">&nbsp;&nbsp;중요!</label>
						</td>
					</tr>
					<tr>
						<td>받는사람 : <input type="text" name="mail_receive_idx" placeholder="제목을 입력 하세요! 20자 이내 작성" maxlength="20"/></td>
					</tr>
					<tr>
						<td>참조 : <input type="text" name="mail_receive_idx" placeholder="참조자를 입력 하세요! 20자 이내 작성" maxlength="20"/></td>
					</tr>
					<tr>
						<td>
		                    <input type="file" name="upfile" id="upfile" class="form-control-file" multiple onchange="addFile();">
		                    <small class="form-text text-muted">첨부파일은 최대 5개까지 가능합니다.</small>
		                    <div id="file-list" class="file-list"></div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="div_editor">
							</div>
							<input type="hidden" name="content"/>
						</td>
					</tr>
					<tr>
						<th class="btnArea">
							<button type="button" class="btn btn-primary" onclick="history.go(-1);">
								<i class="fas fa-undo"></i> 취소
							</button>
							<button type="button" class="btn btn-secondary" onclick="saveMail()">
							    <i class="far fa-save"></i> 임시저장
							</button>
							<button type="button" class="btn btn-third" onclick="sendMail()">
							    <i class="fas fa-paper-plane"></i> 메일전송
							</button>
						</th>
					</tr>
				</table>
			</form>
			
		</div>
 	</div>
</body>
<script>
var config = {};
config.toolbar = "basic";
config.editorResizeMode = "none";

// 파일 업로드 핸들러 설정
config.file_upload_handler = function(file, pathReplace) {
    console.log(file);

    if (file.size > (1 * 1024 * 1024)) { // 파일 크기 제한 (1MB)
        alert('2MB 이상의 파일은 올릴 수 없습니다.');
        pathReplace('/img/noimage.png');
    }
};

var editor = new RichTextEditor("#div_editor", config);



//500자 제한
$(document).on('input', '#div_editor', function() {
    var maxLength = 500;
    var text = $(this).text();
    if (text.length > maxLength) {
        $(this).text(text.substring(0, maxLength));
    }
});




// 메일 '전송'시 실행하는 함수
function sendMail() {
	
	var content = editor.getHTMLCode();
	
	if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
    } else {
        $('input[name="content"]').val(content);
        $('form').submit();
    }
	
	
	if ($("#receive").val() == "") {
		// 받는 사람 주소 없는 경우
		alert("받는 사람 주소를 입력해 주세요.");
	} else {
		if ($("#title").val() == "") {
			// 메일 제목이 없는 경우
			let answer = confirm("제목이 지정되지 않았습니다. 제목 없이 메일을 보내시겠습니까?");
			if (answer) {
				$("#mailForm").submit(); // 메일 전송
			} else {
				$("#title").focus();
				return false; // 메일 전송 안됨
			}
		}
		// 제목이 입력된 경우
		// 메일 전송
		$("#mailForm").submit();
	}
}

// 메일 '임시저장'시 실행하는 함수
function saveMail(){
	
	var content = editor.getHTMLCode();
	
	if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
    } else {
        $('input[name="content"]').val(content);
        $('form').submit();
    }
	
	
	let formData = new FormData(document.getElementById("mailForm"));
	
	// 임시저장 값 전달
	formData.append("mailTemporary", "N");

	$.ajax({
		url : "save.ma",
		processData : false,
		contentType : false,
		type : "POST",
		data : formData,
		success : function(result){

			if(result == 'success'){
				location.href="sendMailList.ma";
				alert("메일을 임시보관함에 저장하였습니다.");
				
			} else {
				alert("메일을 임시보관함에 저장하는데 실패했습니다.");
			}

			console.log("임시저장 ajax 성공");
		},
		error : function(){
			console.log("임시저장 ajax 실패");
		}
	})

}




var fileNo = 0; // 첨부파일 번호
var filesArr = new Array(); // 다중 첨부파일 들어갈 파일 배열

/* 첨부파일 추가 */
function addFile() {
	
	// 안내문 삭제
	$(".fileMsg").remove();
	
	var maxFileCnt = 5; // 첨부파일 최대 개수
	var attFileCnt = document.querySelectorAll('.filebox').length; // 기존 추가된 첨부파일 개수
	var remainFileCnt = maxFileCnt - attFileCnt; // 추가로 첨부가능한 개수
	var files = $('#upfile')[0].files; // 현재 선택된 첨부파일 리스트 FileList

	// 첨부파일 개수 확인
	if (files.length > remainFileCnt) {
		alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
		
		fileDataTransfer();
	}else{
		// 파일 배열에 담기
		let currFileArr = Array.from(files); // FileList => Array로 변환
		filesArr = filesArr.concat(currFileArr); // 추가한 fileList에 또 추가할 수 있도록 설정
		
		fileDataTransfer();
	    
	}
	renderingFileDiv(); // 추가 및 삭제할 때 마다 호출해서 index번호 초기화
	
}

/* 첨부파일 목록 html */
function renderingFileDiv(){
	
	let htmlData = '';
	for(let i=0; i<filesArr.length; i++){
		// i => 삭제할 파일 인덱스 번호
		
		// 목록 추가
		htmlData += '<div id="file' + i + '" class="filebox">';
		htmlData += '<span class="name">'+ filesArr[i].name + '</span>';
		htmlData += '<a class="delete" onclick="deleteFile('+ i + ');"><i class="far fa-minus-square"></i></a>';
		htmlData += '</div>';
	}
	
	$(".file-list").html(htmlData); // change가 발생할 때마다 목록 초기화한 뒤 넣어짐

}

/* 첨부파일 삭제 */
function deleteFile(fileNo) { // 매개변수 : 첨부된 파일 번호(fileNo, i)

	console.log(fileNo);
	
	// class="fileMsg"에 있는 문구 삭제
	document.querySelector("#file" + fileNo).remove();
	
    filesArr.splice(fileNo, 1);	// 해당되는 index의 파일을 배열에서 제거(1 : 한개만 삭제하겠다 라는 의미)
	
    fileDataTransfer();

    renderingFileDiv();
}


/* 첨부파일 담는 배열 */
function fileDataTransfer(){
	
	const dataTransfer = new DataTransfer();

    filesArr.forEach(function(file){ 
    //남은 배열을 dataTransfer로 처리(Array -> FileList)
    	dataTransfer.items.add(file); 
    });
    
    $('#upfile')[0].files = dataTransfer.files;	//제거 처리된 FileList를 돌려줌
}




</script>
</html>
