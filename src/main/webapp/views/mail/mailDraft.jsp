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
	    margin-left: 16%;
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
      <h3>>&nbsp;&nbsp;메일작성</h3>
    </div>
    <div class="mailbox">
      <form action="mailWrite.do" method="POST" enctype="multipart/form-data">
	    <table class="mailForm">
	    	<!-- 불러온 메일의 mail_send_idx -->
	    	<input type="hidden" name="mail_send_idx" value="${param.idx}">
	    	
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
	                <button type="button" class="btn btn-secondary" onclick="sendMail(0)">
	                    <i class="far fa-save"></i> 임시저장
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
/* 전역변수 */
var receiverList = []; // 수신자 데이터 저장용 배열

var emp_idx = "${empIdx}"; // 작성자 사번
var receiver_idx = []; // 수신자 또는 참조자의 사번

var mailIdx = '${param.idx}';


/* 임시저장 데이터 불러오기 */
// AJAX 요청으로 데이터 가져오기
$.ajax({
    type: 'POST',
    url: 'mailDetail.ajax',
    data: { idx: mailIdx },
    dataType: 'json',
    success: function (response) {
        var senderDto = response.senderDto;
        var receiverData = response.receiverList; // 불러온 수신자 데이터
        var fileList = response.fileList; // 첨부파일 데이터

        // 작성자 정보 채우기
        $('#sender_info').val(senderDto.sender_name + ' <' + senderDto.sender_email + '>');
        $('#sender_name').val(senderDto.sender_name);
        $('#sender_email').val(senderDto.sender_email);
        $('#sender_idx').val(senderDto.sender_idx);

        // 제목 및 중요 표시
        $('#subject').val(senderDto.subject);
        $('#hidden_special_flag').val(senderDto.special_flag);
        if (senderDto.special_flag == 1) {
            $('#mailType').prop('checked', true);
        }

        // 수신자 목록 업데이트
        $.each(receiverData, function (index, receiver) {
            var newEntry = {
                name: receiver.receiver_name,
                email: receiver.receiver_email,
                emp_idx: receiver.receiver_idx,
                type: receiver.receiver_type // 0: 수신자, 1: 참조자
            };

            // receiverList에 추가
            receiverList.push(newEntry);

            // UI 업데이트
            addReceiverOrRefer(newEntry, newEntry.type === 0 ? 'receiver-list' : 'refer-list');
        });

        // 첨부파일 데이터 처리
        if (fileList && fileList.length > 0) {
            fileList.forEach(function (file) {
                filesArr.push({
                    name: file.file_name,
                    size: 0,
                    newfile_name: file.newfile_name
                });
            });
            renderFileList();
        }

        // 본문 내용 업데이트 및 hidden_content 동기화
        editor.setHTMLCode(senderDto.content);
        $('#hidden_content').val(senderDto.content);
    },

    error: function (error) {
        console.error('메일 상세 정보 로드 중 오류 발생:', error);
        alert('메일 상세 정보를 가져오는 중 문제가 발생했습니다.');
    },
});





// 사원 이메일, idx, 이름가져오기
// type 0: 받는사람, 1: 참조, 2: 작성자
function empInfo(inputVal, type, listContainerId) {
    var name = '', email = '', dataType = '';

    if (type !== 2) { // 받는 사람, 참조일 경우
        if (!validateEmail(inputVal)) { // 이름이 입력된 경우
            name = inputVal;
            dataType = 'name';
        } else { // 이메일이 입력된 경우
            email = inputVal;
            dataType = 'email';
        }
    } else { // 작성자일 경우
        dataType = 'emp_idx';
    }

    $.ajax({
        url: 'empInfo.ajax',
        method: 'POST',
        dataType: 'JSON',
        data: {
            name: name,
            email: email,
            emp_idx: emp_idx,
            dataType: dataType
        },
        success: function (list) {
            var $list = $("#autocomplete-list" + type);
            $list.empty().hide(); // 기존 리스트 초기화 및 숨김

            if (list.length > 0) {
                // 중복 항목 제거
                var filteredList = list.filter(function (item) {
                    return !receiverList.some(function (existing) {
                        return existing.email === item.email; // 이메일이 이미 추가된 항목인지 검사
                    });
                });

                // 필터링된 리스트 렌더링
                if (filteredList.length > 0) {
                    $.each(filteredList, function (index, item) {
                        var $option = $("<div>")
                            .text(item.name + " <" + item.email + ">")
                            .data(item) // 항목 데이터 저장
                            .addClass("autocomplete-item");

                        // 클릭 이벤트 추가
                        $option.on("click", function () {
                            var selected = $(this).data();
                            var newEntry = {
                                name: selected.name,
                                email: selected.email,
                                emp_idx: selected.emp_idx,
                                type: type
                            };

                            // UI 업데이트 및 데이터 추가
                            receiverList.push(newEntry);
                            addReceiverOrRefer(newEntry, listContainerId);

                            // 입력 초기화 및 리스트 숨김
                            $("#" + listContainerId + "-input").val('');
                            $list.hide();
                        });

                        $list.append($option);
                    });
                    $list.show(); // 필터링된 데이터가 있을 경우 표시
                }
            }
        },
        error: function (e) {
            console.error("정보 가져오기 중 오류 발생:", e);
        }
    });
}

		 


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

//에디터 변경 시 hidden_content와 동기화
editor.attachEvent("change", function () {
    $('#hidden_content').val(editor.getHTMLCode());
});




function findAdd(type) {
    console.log("findAdd 호출됨. 타입:", type);

    openUserBoxModal();

    // 선택된 사원 정보 확인
    $("#addEmployeeButton").off("click").on("click", function () {
        if (window.selectedEmployee) {
            console.log("선택된 사원 정보:", window.selectedEmployee);

            addReceiverOrReferHandler(
                window.selectedEmployee, // 전역 변수에서 가져오기
                type === 0 ? "receiver-list" : "refer-list",
                type
            );

            $(".modalD").fadeOut();
            // 검색창 값 비워주기
            $("#searchInput").val('');
        } else {
            console.error("선택된 사원 정보가 없습니다.");
        }
    });
}

//수신자 입력 필드에 대한 엔터 키 이벤트 핸들러
$("#receiver-input").keypress(function (e) {
    if (e.which === 13) { // Enter 키
        e.preventDefault(); // 기본 동작 방지
        addReceiverOrReferHandler("#receiver-input", "receiver-list", 0); // 수신자 추가
    }
});

$("#refer-input").keypress(function (e) {
    if (e.which === 13) { // Enter 키
        e.preventDefault(); // 기본 동작 방지
        addReceiverOrReferHandler("#refer-input", "refer-list", 1); // 참조자 추가
    }
});

//수신자 및 참조자 추가 핸들러
function addReceiverOrReferHandler(input, listContainerId, type) {
    var inputVal, isObjectInput = typeof input === "object";

    if (isObjectInput) { // 사원목록에서 추가한 경우
        inputVal = input.email;
    } else { // 텍스트로 추가한 경우
        inputVal = $(input).val().trim();
    }

    // 입력값 유효성 검사
    if (inputVal === "") {
        alert("이름 또는 이메일을 입력하세요.");
        return;
    }

    // 중복 확인 (기존 receiverList 배열에서 중복 검사)
    var isDuplicate = receiverList.some(function (item) {
        return (
            item.name === inputVal || item.email === inputVal
        );
    });

    if (isDuplicate) {
        alert("이미 추가된 항목입니다.");
        return; // 중복 시 추가 중단
    }


    // 입력값 처리
    var newEntry;

    if (isObjectInput) { // 사원목록에서 추가한 경우
        newEntry = {
            'name': input.name,
            'email': input.email,
            'emp_idx': input.emp_idx,
            'type': type
        };

        // 배열에 추가
        receiverList.push(newEntry);
        console.log('receiverList : ', receiverList);

        // UI 업데이트
        addReceiverOrRefer(newEntry, listContainerId);

    } else { // 텍스트로 추가한 경우
        // 사원정보 가져오기
        empInfo(inputVal, type, listContainerId);
    }

    // 입력 필드 초기화
    if (!isObjectInput) {
        $(input).val("");
    }
}

function addReceiverOrRefer(entry, listContainerId) {
	
    if (!entry || !entry.name || !entry.email) {
        return; // 잘못된 entry가 전달되면 함수 종료
    }else{
    	var displayText = entry.name + " <" + entry.email + ">";
    }
	
    
 // 항목 표시를 위한 텍스트 생성
    // HTML 요소 생성
    var $newDiv = $("<div>").addClass("receiver-item").text(displayText);

    // 삭제 버튼 생성 및 클릭 이벤트 핸들러 추가
    var $removeBtn = $("<button>").text("x");
    $removeBtn.on("click", function () {
        // 배열에서 해당 항목 제거
        for (var i = 0; i < receiverList.length; i++) {
            if (receiverList[i].name === entry.name && receiverList[i].email === entry.email) {
                receiverList.splice(i, 1);
                break;
            }
        }
        // HTML 요소 제거
        $newDiv.remove();

        // hidden input 데이터 갱신
        updateHiddenField();
    });

    // 삭제 버튼을 div에 추가하고 컨테이너에 추가
    $newDiv.append($removeBtn);
    $("#" + listContainerId).append($newDiv);

    // hidden input 데이터 갱신
    updateHiddenField();
}

/* 수신자/참조자 데이터를 hidden input으로 업데이트 */
function updateHiddenField() {
    var jsonData = JSON.stringify(receiverList);
    $("#receiver-data").val(jsonData);
    console.log("Receiver Data JSON:", jsonData);
}






//전역 변수 선언
var receiverList = []; // 수신자 및 참조자 정보를 담을 배열

// 이메일 형식 확인 함수
function validateEmail(email) {
    // 이메일 형식을 확인하기 위한 정규식
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}




//500자 제한
$(document).on('input', '#div_editor', function() {
    var maxLength = 500;
    var text = $(this).text();
    if (text.length > maxLength) {
        $(this).text(text.substring(0, maxLength));
    }
});



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
    if (receiverList.length === 0) {
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



var fileNo = 0; // 첨부파일 번호
var filesArr = new Array(); // 다중 첨부파일 들어갈 파일 배열



function renderFileList() {
    var fileListDiv = document.getElementById("file-list");
    if (!fileListDiv) {
        console.error('#file-list element not found.');
        return;
    }

    fileListDiv.innerHTML = ""; // 기존 내용 초기화

    if (filesArr.length === 0) {
        fileListDiv.innerHTML = "<p>첨부파일 없음</p>"; // 파일이 없는 경우 메시지 표시
        return;
    }

    for (var i = 0; i < filesArr.length; i++) {
        var fileDiv = document.createElement("div");
        fileDiv.id = "file" + i;
        fileDiv.className = "filebox";

        // 파일명 및 다운로드 링크 생성
        var fileContent = document.createElement("span");
        fileContent.className = "file-content";

        var fileLink = document.createElement("a");
        fileLink.href = "mailAttachDown.do?newfile_name=" + encodeURIComponent(filesArr[i].newfile_name) + "&file_name=" + encodeURIComponent(filesArr[i].name);
        fileLink.target = "_blank";
        fileLink.textContent = filesArr[i].name;

        // 삭제 버튼 생성
        var deleteIcon = document.createElement("i");
        deleteIcon.className = "far fa-minus-square delete-icon";
        deleteIcon.style.cursor = "pointer";
        deleteIcon.onclick = (function (index) {
            return function () {
                deleteFile(index);
            };
        })(i);

        // 요소 결합
        fileContent.appendChild(fileLink);
        fileContent.appendChild(deleteIcon);
        fileDiv.appendChild(fileContent);
        fileListDiv.appendChild(fileDiv);
    }

    console.log('Rendered file list:', fileListDiv.innerHTML); // 디버깅용 출력
}





/* 첨부파일 추가 */
function addFile() {
    var maxFileCnt = 5; // 첨부파일 최대 개수
    var attFileCnt = document.querySelectorAll('.filebox').length; // 기존 추가된 첨부파일 개수
    var remainFileCnt = maxFileCnt - attFileCnt; // 추가 가능 파일 수
    var files = $('#upfile')[0].files;

    // 중복 파일 확인
    var duplicateFiles = Array.from(files).filter(function (file) {
        return filesArr.some(function (existingFile) {
            return existingFile.name === file.name && existingFile.size === file.size;
        });
    });

    if (duplicateFiles.length > 0) {
        alert('이미 추가된 파일이 있습니다: ' + duplicateFiles.map(function (file) { return file.name; }).join(', '));
        return; // 중복 방지
    }

    // 파일 개수 초과 확인
    if (files.length > remainFileCnt) {
        alert('첨부파일은 최대 ' + maxFileCnt + '개까지 첨부 가능합니다.');
        return;
    }

    // 새로운 파일 추가
    let currFileArr = Array.from(files);
    filesArr = filesArr.concat(currFileArr);

    fileDataTransfer();
    renderingFileDiv();
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




//체크박스 상태에 따라 hidden input 값을 업데이트
function setSpecialFlag(checkbox) {
    if (checkbox.checked) {
        $("#hidden_special_flag").val("1");
    } else {
        $("#hidden_special_flag").val("0");
    }
}



</script>
</html>
