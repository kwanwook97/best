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
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  	
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    width: 85vw;
	    margin-top: 7vh;
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
		display: flex;
		margin-left: 10px;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px;
	    margin-bottom: 40px;
	}
	.docBox{
		display: flex;	
	}
	.documentListBox{
		display: flex;
		justify-content: center;
	    width: 180px;
	    height: 300px;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	    margin-right: 20px;
	}
	.documentList{
		border-radius: 9px;
	    color: white;
	    background: var(--secondary-color);
		text-align: center;
		width: 130px;
	    height: 30px;
	    margin-top: 10px;
	}
	.documentList span.boxSub{
		font-size: 20px;
	}
	.modal-list{
		list-style:none;
	    margin-top: 8px;
        padding-left: 0;
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
	.modal {
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5);
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    z-index: 1000;
	    pointer-events: none;
	}
	.modal-content:not(:nth-child(2)) {
	    border: 2px solid var(--primary-color);
		transform: scale(0.8) !important;
	    background-color: white;
	    padding: 15px;
	    border-radius: 5px;
	    width: 44vw;
        position: absolute;
	    left: 635px;
	    top: 128px;
	}
	.modal-content:nth-child(2){
	    border: 2px solid var(--primary-color);
		transform: scale(0.8) !important;
	    background-color: white;
	    padding: 15px;
	    border-radius: 5px;
	    width: 44vw;
        position: absolute;
	    left: 635px;
	    top: 0px;
	}
	.close-btn {
	    position: absolute;
	    top: 5px;
	    right: 5px;
	    cursor: pointer;
	    font-size: 14px;
	    pointer-events: auto;
	}
	.modal-box input{
		all: unset;
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 		<div class="maintext">
			<h3 class="document">결재 문서</h3>
			<h3 class="text">>&nbsp;&nbsp;결재 문서 생성</h3>
		</div>
		<div class="docBox">
			<div class="documentListBox">
				<div class="documentList">
					<span class="boxSub">양식 리스트</span>
					<ul class="modal-list">
					</ul>
				</div>
			</div>
			<div class="formBorder">
				<form action="documentWrite.do" method="POST">
				<table>
					<tr>
						<td>제목 : <input type="text" name="subject" placeholder="양식이름을 작성하세요! 20자 이내" maxlength="20"/></td>
					</tr>
					<tr>
						<td>
							<div id="div_editor">
							</div>
							<input type="hidden" name="content"/>
						</td>
					</tr>
					<tr>
						<th><input type="button" value="문서 등록하기" onclick="saveForm()"/></th>
					</tr>
				</table>
				</form>
			</div>
		</div>
 	</div>
</body>
<script>
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

function saveForm() {
    var content = editor.getHTMLCode();
    console.log(content);
    console.log("전체 문서의 크기 :" + (content.length / 1024 / 1024) + "MB");

	if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
    } else {
        $('input[name="content"]').val(content);
        $('form').submit();
    }
}

// 에디터 초기화
var editor = new RichTextEditor("#div_editor", config);


$.ajax({
    url: 'formList.ajax',
    type: 'GET',
    success: function(data) {
        var ul = $('.modal-list');
        ul.empty();

        data.forEach(function(form) {
            var li = $('<li class="modal-item" onclick="documentForm('+form.form_idx+')"></li>');
            li.text(form.form_subject);

            ul.append(li);
        });
    },
    error: function(error) {
        console.log(error);
    }
});

function documentForm(form_idx) {
    $.ajax({
        type: 'GET',
        url: 'getForm.ajax',
        data: { form_idx: form_idx },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);
         	$("#customModal").fadeOut();
            openModal(response, form_idx);
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}
//모달 열기
function openModal(content, form_idx) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
	var modalClass = '';

    // 모달 HTML 생성
    var modalHtml = 
        '<div id="' + modalId + '"class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="content" contenteditable="true">' + content + '</div>' +
        '  </div>' +
        '</div>';

    // body에 추가
    $('body').append(modalHtml);

    // 모달 표시
    $('#' + modalId).show();

    // 닫기 버튼 이벤트 등록 (이벤트 위임)
    $(document).on('click', '.close-btn', function() {
        var targetModalId = $(this).data('modal-id');
        $('#' + targetModalId).remove();
    });
}
</script>
</html>
