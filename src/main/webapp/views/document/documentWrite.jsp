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
	    margin-top: 6vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
        height: 100%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
	    top: 78px;
	    position: absolute;
	    width: 21%;
	    display: flex;
	    margin-left: -10px;
	    margin-bottom: 10px;
	    justify-content: space-between;
	    align-items: baseline;
	}
	.maintext i,
	.maintext span{
		font-size: 32px !important;
		font-weight: bold !important;
	}
	.maintext span:last-child{
		color: var(--primary-color);
	}
	.maintext span:first-child{
		color: var(--secondary-color);
	}
	.docBox{
		display: flex;	
	}
	.documentListBox{
		display: flex;
		justify-content: center;
	    width: 180px;
	    height: 300px;
	    margin-right: 20px;
	}
	.documentList{
	    border-radius: 9px;
	    color: white;
	    background: var(--secondary-color);
	    text-align: center;
	    min-width: 160px;
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
	ul.modal-list li.modal-item{
		cursor: pointer;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin-bottom: 5px;
	}
	ul.modal-list li.modal-item:hover{
		color: white;
		background-color: var(--secondary-color);
	}
	.formBorder{    
		display: flex;
	    align-items: center;
	    justify-content: space-evenly;
    	width: 950px;
    	min-height: 616px;
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
	table:not([border]) td{
		border: none;
	}
	.deleteBtn,
	.reBtn{
		display: none;
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 		<div class="maintext">
			<span class="document">결재문서</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span class="text">결재 문서 등록</span>
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
						<td>제목 : <input type="text" name="form_subject" placeholder="양식이름을 작성하세요! 20자 이내" maxlength="20"/></td>
					</tr>
					<tr>
						<td>
							<div id="div_editor">
							</div>
							<input type="hidden" name="form_content"/>
						</td>
					</tr>
					<tr>
						<td class="changeBtn"><input type="button" value="문서 등록하기" onclick="saveForm()"/></td>
					</tr>
					<tr>
						<td class="deleteBtn"><input type="button" value="문서 삭제하기" onclick="deleteForm()"/></td>
					</tr>
					<tr>
						<td class="reBtn"><input type="button" value="수정 취소" onclick="reForm()"/></td>
					</tr>
				</table>
				</form>
			</div>
		</div>
 	</div>
</body>
<script>
function changeButtonToUpdate() {
    // 버튼 요소 선택
    var button = document.querySelector(".changeBtn input[type='button']");
	var form_idx = $('#div_editor input[name="form_idx"]');
	console.log("뭔데뒤질라고",form_idx);
    if (button) {
        // 버튼 텍스트 및 onclick 속성 변경
        $(button).val("문서 수정하기").attr("onclick", "updateForm()");

        $("tr .deleteBtn").css("display", "block");
        $("tr .reBtn").css("display", "block");
    } else {
        console.error("버튼을 찾을 수 없습니다.");
    }

}
function changeFormActionToUpdate() {
    // 폼 요소 선택
    var form = document.querySelector("form[action='documentWrite.do']");

    if (form) {
        // action 속성 변경
        form.setAttribute("action", "documentUpdate.do");
        console.log("폼의 action이 'documentUpdate.do'로 변경되었습니다.");
    } else {
        console.error("폼을 찾을 수 없습니다.");
    }
}


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
	
	var subject = $('input[name="form_subject"]').val().trim();
    if (subject === "") {
        alert("제목을 입력해주세요.");
        return;
    }
    
    var content = editor.getHTMLCode();
    console.log(content);
    console.log("전체 문서의 크기 :" + (content.length / 1024 / 1024) + "MB");

	if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
    } else {
        $('input[name="form_content"]').val(content);
        $('form').submit();
    }
}

function updateForm() {
	
	var subject = $('input[name="form_subject"]').val().trim();
    if (subject === "") {
        alert("제목을 입력해주세요.");
        return;
    }
    
    var content = editor.getHTMLCode();
    console.log(content);
    console.log("전체 문서의 크기 :" + (content.length / 1024 / 1024) + "MB");

	if (content.length > 100 * 1024 * 1024) {
        alert("100MB이상 크기는 전송이 불가능 합니다.");
    } else {
        $('input[name="form_content"]').val(content);
        $('form').submit();
    }
}


$.ajax({
    url: 'formList.ajax',
    type: 'GET',
    success: function(data) {
        var ul = $('.modal-list');
        ul.empty();

        data.forEach(function(form) {
            var li = $('<li class="modal-item" onclick="documentFormUp('+form.form_idx+')"></li>');
            li.text(form.form_subject);

            ul.append(li);
        });
    },
    error: function(error) {
        console.log(error);
    }
});


function documentFormUp(form_idx) {
    $.ajax({
        type: 'GET',
        url: 'getForm.ajax',
        data: { form_idx: form_idx },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);
        	if (editor) {
        		editor.setHTML(response);
                changeFormActionToUpdate();
                changeButtonToUpdate();
                
                $('#div_editor input[name="form_idx"]').remove();
                
                var hiddenInput = $('<input>', {
                    type: 'hidden',
                    name: 'form_idx',
                    value: form_idx
                });
                $('#div_editor').append(hiddenInput);
                $(".maintext .text").text("결재 문서 수정");
            } else {
                console.error('RichTextEditor 인스턴스가 없습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}

function deleteForm(){
	var form_idx = $('input[name="form_idx"]').val().trim();
	console.log("지움?"+form_idx);
	 $.ajax({
         type: 'POST',
         url: 'formDelete.ajax',
         data: { form_idx: form_idx },
         success: function(response) {
             if (response) {
            	 alert(response);
                 location.reload(true);
             } else {
             	console.log('삭제 실패');
             }
         },
         error: function(e) {
             console.log(e);
         }
     });
}


function reForm(){
	location.reload(true);
}
</script>
</html>
