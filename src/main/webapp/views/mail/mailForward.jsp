<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<link rel="stylesheet" href="<c:url value='/resources/richtexteditor/res/style.css' />" />
	<link rel="stylesheet" href="<c:url value='/resources/richtexteditor/rte_theme_default.css' />" />
	<link rel="stylesheet" href="<c:url value='/resources/richtexteditor/runtime/richtexteditor_content.css' />" />

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
	    margin-left: 12vw;
	    width: 85vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    height: 100%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
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
		height: 85%;
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
		border-collapse: collapse; /* 테이블 셀 간 간격 제거 */
		margin-bottom: 0 !important;
	}
	
	table, tr, td{
		color: var(--primary-color);
	}
	
	tr input[type='text']{
		width: 70%;
		background-color: #FFFBF2;
		border: none;
	}
	
	
	
	
	table {
    border-collapse: collapse; /* 셀 간격 제거 */
    width: 100%; /* 테이블 전체 너비 */
    height: 100% !important;
	}

td {
    padding: 5px 10px; /* 상하 padding 조정 */
    vertical-align: middle; /* 내용 수직 정렬 */
    line-height: 1.2; /* 텍스트 줄 간격 조정 */
}

tr input[type='text'] {
    height: auto; /* 기본 높이 자동 */
    padding: 3px; /* 입력 필드 padding 조정 */
    font-size: 14px; /* 입력 필드 텍스트 크기 */
    background-color: #FFFBF2;
    border: none;
}
	
	
	
	label{
		font-size: 18px !important;
		color: var(--primary-color) !important;
		width: 100%;
		margin-bottom: 0 !important;
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
	      background-color: #8B6AA7;
	      border: none; /* 테두리 제거 */
	      border-radius: 5px; /* 둥근 모서리 */
	      color: white; /* 폰트 색상 */
	      display: inline-flex; /* 아이콘과 텍스트 정렬 */
	      align-items: center; /* 수직 정렬 */
	      justify-content: center; /* 텍스트와 아이콘 중앙 정렬 */
	  }
	  button[type="button"]:hover {
	      background-color: var(--primary-color); /* 호버 시 배경색 변경 */
	      color: white; /* 폰트 색상 */
	  }
	  button[type="button"] i {
	      margin-right: 5px; /* 아이콘과 텍스트 간격 */
	      font-size: 18px; /* 아이콘 크기 */
	  }
	
	.btnArea{
		text-align: right;
	}
	
  /* Placeholder 스타일 적용 */
  input::placeholder {
    color: #888 !important; /* 원하는 색상으로 변경 */
    opacity: 1 !important;  /* 투명도 조정 */
  }

  textarea::placeholder {
    color: #888 !important; /* 텍스트 영역 placeholder 색상 */
    opacity: 1 !important;
  }
  
  
  
  
  
  
.receiver-item {
    display: inline-block !important;
    background-color: #d1badb !important; /* 바이올렛? 배경 */
    padding: 5px 10px !important; /* 내부 여백 */
    border-radius: 15px !important; /* 둥근 모서리 */
    margin: 5px !important; /* 항목 간 여백 */
    color: #30005A !important; /* 글자 색상 */
    font-weight: bold !important; /* 글자 굵기 */
}
  
.receiver-item button {
    background: none !important; /* 배경 제거 */
    border: none !important; /* 테두리 제거 */
    color: #d32f2f !important; /* 빨간색 글자 */
    font-weight: bold !important; /* 글자 굵기 */
    cursor: pointer !important; /* 마우스 포인터 변경 */
    margin-left: 10px !important; /* 버튼과 텍스트 간격 */
}

.receiver-item button:hover {
    color: #b71c1c !important; /* 호버 시 더 진한 빨간색 */
}  
  

  

  
/* #receiver-container, #refer-container{
  display: flex;
  align-items: center;
  justify-content: space-between;
} */

#receiver-container, #refer-container, #subject-container{
  display: flex;
  align-items: center;
  justify-content: flex-start;
}


#add-receiver-btn, #add-refer-btn {
    min-width: fit-content !important;
    width: fit-content !important;
}



.chkArea{
	margin-right: 20px;
}



.form-group{
	margin: 0 !important;
}

.filebox {
    display: flex;
    align-items: center;
}

.file-content {
    display: inline-flex;
    align-items: center;
    gap: 5px; /* 아이콘과 텍스트 사이 간격 */
}

.delete-icon {
    cursor: pointer;
    color: #d32f2f;
}

.delete-icon:hover {
    color: #b71c1c;
}


.editor-td {
    height: 100% !important; /* 원하는 높이로 설정 */
    vertical-align: top; /* 콘텐츠를 상단에 정렬 */
}

#div_editor {
    width: 100%; /* 에디터의 너비 */
    height: 100%; /* 원하는 고정 높이 */
    overflow-y: auto; /* 세로 스크롤바 추가 */
    overflow-x: hidden; /* 가로 스크롤바 숨김 */
    border: 1px solid #ccc; /* 경계선 추가 */
    border-radius: 5px; /* 경계선 둥글게 */
    padding: 10px; /* 내부 여백 */
    box-sizing: border-box; /* 패딩 포함 */
    background-color: #fff; /* 배경색 */
}
	
	
	
.autoComplete {
    position: absolute;
    z-index: 1000;
    width: 15%;
    background-color: white;
    border: 1px solid #ccc;
    border-radius: 5px;
    max-height: 200px; /* 스크롤을 위한 최대 높이 */
    overflow-y: auto; /* 스크롤 활성화 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

autoComplete div {
    padding: 10px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
}

autoComplete div:hover {
    background-color: #f0f0f0; /* 항목에 마우스를 올렸을 때 */
    color: #30005A;
}	

#sender_name {
	width: auto !important;
}
#sender_email {
	width: auto !important;
}

	
.mailForm td:first-child {
    width: 10%; /* 작성자, 제목 등 첫 번째 열 */
    background-color: #FFFBF2;
}

.mailForm td:not(:first-child) {
    width: 90%; /* 입력 필드가 들어갈 두 번째 열 */
    background-color: #FFFBF2;
}	

  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <jsp:include page="../modal/findAdd.jsp"></jsp:include>
  <c:set var="empIdx" value="${sessionScope.loginId}" />
  <div class="dashboard-body">
    <div class="maintext">
      <h3 class="mail">메일함</h3>
      <h3>>&nbsp;&nbsp;메일전달</h3>
    </div>
    <div class="mailbox">
      <form action="mailWrite.do" method="POST" enctype="multipart/form-data">
	    <table class="mailForm">
	    	
	        <!-- 작성자 -->
	        <tr>
	            <td class="purple">
	                <label>작성자</label>
	            </td>
	            <td>
	                <input type="text" id="sender_info" readonly />
	            </td>
	            <input type="hidden" id="sender_name" name="sender_name" />
	            <input type="hidden" id="sender_email" name="sender_email" />
	            <input type="hidden" id="sender_idx" name="sender_idx" />
	        </tr>
	
	        <!-- 제목 -->
	        <tr>
	            <td>
	                <label>제목</label>
	            </td>
	            <td>
	                <div id="subject-container">
	                    <input type="text" name="subject" id="subject" placeholder="제목을 입력하세요! 50자 이내 작성" maxlength="50" />
	                    <div class="chkArea">
	                        <input type="hidden" name="special_flag" id="hidden_special_flag" />
	                        <input type="checkbox" id="mailType" value="1" onclick="setSpecialFlag(this);" />
	                        <span class="specialChk">&nbsp;&nbsp;중요!</span>
	                    </div>
	                </div>
	            </td>
	        </tr>
	
	        <!-- 받는 사람 -->
	        <tr>
	            <td>
	                <label>받는사람</label>
	            </td>
	            <td>
	                <div class="form-group">
	                    <div id="receiver-container">
	                        <input type="text" id="receiver-input" placeholder="이름 또는 이메일을 입력하세요" maxlength="50" />
	                        <div id="autocomplete-list0" class="autoComplete" style="display:none; position:absolute;"></div>
	                        <button type="button" id="add-receiver-btn" onclick="findAdd(0)"><i class="bi bi-person-add"></i></button>
	                    </div>
	                    <div id="receiver-list" class="mt-3"></div>
	                </div>
	            </td>
	        </tr>
	
	        <!-- 참조 -->
	        <tr>
	            <td>
	                <label>참조</label>
	            </td>
	            <td>
	                <div class="form-group">
	                    <div id="refer-container">
	                        <input type="text" id="refer-input" placeholder="이름 또는 이메일을 입력하세요" maxlength="50" />
	                        <div id="autocomplete-list1" class="autoComplete" style="display:none; position:absolute;"></div>
	                        <button type="button" id="add-refer-btn" onclick="findAdd(1)"><i class="bi bi-person-add"></i></button>
	                    </div>
	                    <div id="refer-list" class="mt-3"></div>
	                </div>
	            </td>
	        </tr>
	        
	        <!-- 수신자와 참조자의 통합 JSON 데이터 -->
			<input type="hidden" name="receiver_data" id="receiver-data" />
	        <!-- 파일 첨부 -->
	        <tr>
	            <td>
	                <label>파일 첨부</label>
	            </td>
	            <td>
	                <div class="form-group">
	                    <input type="file" name="files" id="upfile" class="form-control-file" multiple onchange="addFile();" />
	                    <div id="file-list" class="file-list mt-2"></div>
	                </div>
	                <span><small>첨부파일은 최대 5개까지 가능합니다.</small></span>
	            </td>
	        </tr>
	
	        <!-- 본문 -->
	        <tr>
	            <td class="editor-td" colspan="2">
	                <div id="div_editor"></div>
	                <input type="hidden" name="content" id="hidden_content" />
	            </td>
	        </tr>
	
	        <!-- 버튼 -->
	        <tr>
	            <td class="btnArea" colspan="2">
	                <button type="button" onclick="location.href='mail.go'">
			        	<i class="fas fa-th-list"></i> 목록으로
			        </button>
	                <button type="button" class="btn btn-third" onclick="sendMail(1)">
	                    <i class="fas fa-paper-plane"></i> 메일전송
	                </button>
	            </td>
	            <!-- 0: 발송 1: 임시저장 -->
				<input type="hidden" name="status"/>
	        </tr>
	    </table>
	</form>

    </div>
  </div>
</body>
<script>
/* 전역 변수 */
var receiverList = []; // 수신자 및 참조자 데이터를 담을 배열
var emp_idx = "${empIdx}"; // 작성자 사번
var filesArr = []; // 첨부파일 데이터를 담을 배열
var mailIdx = '${param.idx}'; // 메일 인덱스

/* 페이지 초기세팅 */
$(document).ready(function () {
    empInfo(emp_idx, 2, 'sender'); // 작성자 정보 가져오기
    loadForwardData(); // 포워딩 데이터 가져오기

    // RichTextEditor 설정
    var config = {};
    config.toolbar = "basic";
    config.editorResizeMode = "none";

    config.file_upload_handler = function (file, pathReplace) {
        console.log(file);
        if (file.size > 1 * 1024 * 1024) {
            alert('2MB 이상의 파일은 올릴 수 없습니다.');
            pathReplace('/img/noimage.png');
        }
    };

    // RichTextEditor 초기화
    editor = new RichTextEditor("#div_editor", config);

    // 에디터 변경 시 hidden_content와 동기화
    editor.attachEvent("change", function () {
        $('#hidden_content').val(editor.getHTMLCode());
    });
});

/* 발신자 데이터 가져오기 및 포워딩 데이터 설정 */
function loadForwardData() {
    $.ajax({
        type: "POST",
        url: "mailDetail.ajax",
        data: { 'idx': mailIdx },
        dataType: "json",
        success: function (response) {
            var senderDto = response.senderDto; // 발신자 정보
            var fileList = response.fileList || []; // 기존 첨부파일

            // 제목에 'FW:' 추가
            $('#subject').val('FW: ' + senderDto.subject);

            // 본문 구성
            var contentWithDivider =
            	"<p><br></p>" +
                "<p><br></p>" +
                "<p><br></p>" +
                "<p>-----Original Message-----</p>" +
                "<p><strong>보낸사람: </strong>" + senderDto.sender_name + " &lt;" + senderDto.sender_email + "&gt;</p>" +
                "<p><strong>수신날짜: </strong>" + senderDto.date + "</p>" +
                "<p><strong>내용: </strong>" +senderDto.content+ "</p>";

            $('#hidden_content').val(contentWithDivider); // hidden 필드에 값 설정
            editor.setHTMLCode(contentWithDivider); // 에디터에 내용 설정

            // 첨부파일 유지
            fileList.forEach(function (file) {
                filesArr.push({
                    name: file.file_name,
                    newfile_name: file.newfile_name
                });
            });
            renderFileList();
        },
        error: function (error) {
            console.error("포워딩 데이터 로드 중 오류 발생:", error);
        }
    });
}

/* 첨부파일 목록 렌더링 */
function renderFileList() {
    var fileListDiv = $("#file-list").empty();
    filesArr.forEach(function (file, index) {
        var fileDiv = $("<div>").addClass("filebox").attr("id", "file" + index);
        var fileContent = $("<span>").addClass("file-content").text(file.name);
        var fileLink = $("<a>")
            .attr("href", "mailAttachDown.do?newfile_name=" + encodeURIComponent(file.newfile_name) + "&file_name=" + encodeURIComponent(file.name))
            .text(" 다운로드")
            .attr("target", "_blank");
        fileDiv.append(fileContent).append(fileLink);
        fileListDiv.append(fileDiv);
    });
}

//메일 '전송'시 실행하는 함수
function sendMail(status) {
    // RichTextEditor 내용 가져오기
    var content = editor.getHTMLCode();

    // 에디터 내용이 100MB 이상인 경우 처리
    if (content.length > 100 * 1024 * 1024) {
        alert("100MB 이상의 크기는 전송이 불가능합니다.");
        return;
    }

    // 에디터 내용을 hidden input 필드에 설정
    $('input[name="content"]').val(content);

    // 필수 항목 검증
    if (receiverList.length === 1) {
        alert("받는 사람 주소를 입력해 주세요.");
        return;
    }

    if ($('input[name="subject"]').val().trim() === "") {
        let confirmResult = confirm("제목이 지정되지 않았습니다. 제목 없이 메일을 보내시겠습니까?");
        alert("제목을 입력해 주세요.");
        return;
    }

    
 	// 메일의 상태를 hidden input 필드에 설정
    $('input[name="status"]').val(status);
    
    // 폼 전송
    $('form').submit();
}

/* 작성자, 수신자, 참조자 정보를 가져오는 함수 */
function empInfo(inputVal, type, listContainerId) {
    var name = '', email = '', dataType = '';
    if (type !== 2) {
        if (!validateEmail(inputVal)) {
            name = inputVal;
            dataType = 'name';
        } else {
            email = inputVal;
            dataType = 'email';
        }
    } else {
        dataType = 'emp_idx';
    }

    $.ajax({
        url: 'empInfo.ajax',
        method: 'POST',
        dataType: 'JSON',
        data: { name, email, emp_idx, dataType },
        success: function (list) {
            if (list.length > 0) {
                if (type !== 2) {
                    var $list = $("#autocomplete-list" + type).empty().show();
                    list.forEach(item => {
                        var $option = $("<div>").text(item.name + " <" + item.email + ">").data(item);
                        $option.on("click", function () {
                            var selected = $(this).data();
                            var newEntry = {
                                email: selected.email,
                                type,
                                name: selected.name,
                                emp_idx: selected.emp_idx
                            };
                            receiverList.push(newEntry);
                            addReceiverOrRefer(newEntry, listContainerId);
                            $("#receiver-input").val('');
                            $list.hide();
                        });
                        $list.append($option);
                    });
                } else {
                    var item = list[0];
                    $("#" + listContainerId + "_info").val(item.name + " <" + item.email + ">");
                    $("#" + listContainerId + "_name").val(item.name);
                    $("#" + listContainerId + "_email").val(item.email);
                    $("#" + listContainerId + "_idx").val(item.emp_idx);
                }
            } else {
                alert("해당 사원을 찾을 수 없습니다.");
            }
        },
        error: function (e) {
            console.error("정보 가져오기 중 오류 발생:", e);
        }
    });
}

/* 첨부파일 추가 */
function addFile() {
    var maxFileCnt = 5;
    var remainFileCnt = maxFileCnt - filesArr.length;
    var files = $('#upfile')[0].files;

    let duplicateFiles = Array.from(files).filter(file =>
        filesArr.some(existingFile => existingFile.name === file.name && existingFile.size === file.size)
    );

    if (duplicateFiles.length > 0) {
        alert("이미 추가된 파일이 있습니다.");
        return;
    }

    if (files.length > remainFileCnt) {
        alert("첨부파일은 최대 " + maxFileCnt + "개까지 가능합니다.");
        return;
    }

    filesArr = filesArr.concat(Array.from(files));
    renderFileList();
}

/* 이메일 형식 검증 */
function validateEmail(email) {
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}
</script>
