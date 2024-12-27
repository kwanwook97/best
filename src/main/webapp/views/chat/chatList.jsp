<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="resources/css/chatList.css" rel="stylesheet" />

<style>
</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="dashboard-body">

		<div class="naviPath bold f32 w100 tm2">
			<span style="var(- -primary-color);">메신져</span>
		</div>

		<div class="content-size">
			<div class="chat-controls">
				<button class="start-chat-button" onclick="openModal();">
					<i class="fas fa-comment-alt"></i> 대화하기
				</button>
				<div class="searchbar">
					<input type="text" name="keyword" id="searchBar" placeholder="검색"> 
					<i class="fas fa-search"></i>
				</div>
		 </div>
		


		<div class="messenger-container">
			<div class="line-box">
				<div class="sidebar">


				</div>

				<!-- 사용자 리스트 -->
				<div class="member-list-wrapper">
					<div class="member-list">
						<div class="image-label-wrapper">
							<img src="" alt="이미지" class="custom-image">
							<!-- 사용자 프로필 사진 -->
							<span class="custom-label">
								<!-- 사용자 이름 -->
							</span>
						</div>
					</div>
				</div>

			</div>
			</div>
		</div>
	</div>
</body>
<div id="memberModal" class="modal" style="display: none;">
  <div class="modal-content">
  	<div class="modal-header">
    	<span class="close-modal" onclick="closeModal();">&times;</span>
    	<h5>메신져 생성</h5>
    	<button id="createChatButton">확인</button>
    </div>
    <div class="subject-div">
    	<input type="text" id="chatSubject" name="chat_subject" placeholder="제목을 작성하세요. " value=""/>
    	<i class="fas fa-edit"></i>
    </div>
    <div class="search_bar-container">
        <input type="text" id="memberSearchBar" name="keyword" class="search_bar" placeholder="이름 검색" value=""> 
        <i class="fas fa-search search-icon"></i>
      </div>
    <div class="member-list-container">
      <ul id="memberList">
        <!-- 회원 리스트가 여기에 추가됩니다 -->
      </ul>
    </div>
  </div>
</div>

<script>
window.updateChatList = function(messageDataList) {
    const sidebar = $(".sidebar");

    for (const messageData of messageDataList) {
        const chatIdx = messageData.chat_idx;
        const chatTitle = messageData.chat_subject ? messageData.chat_subject : messageData.participants;

        // chat_idx에 해당하는 대화방 항목 찾기
        const chatItem = sidebar.find('.chat-item[data-chat-idx="' + chatIdx + '"]');

        if (chatItem.length > 0) {
            // 기존 항목 업데이트
            chatItem.find(".chat-preview").text(messageData.latest_message);
            chatItem.find(".chat-time").text(formatTime(messageData.latest_time));

            // 읽지 않은 메시지 숫자 업데이트
            const unreadCountContainer = chatItem.find(".unread-message-count");
            if (messageData.unread_count && messageData.unread_count > 0) {
                if (unreadCountContainer.length > 0) {
                    unreadCountContainer.text(messageData.unread_count); // 기존 엘리먼트가 있으면 업데이트
                } else {
                    const unreadCountText = '<div class="unread-count-list"><span class="unread-message-count" id="unread-count-' + chatIdx + '">' 
                                            + messageData.unread_count + '</span></div>';
                    chatItem.find(".chat-preview").append(unreadCountText); // 없으면 새로 추가
                }
            } else {
                unreadCountContainer.remove(); // 읽지 않은 메시지가 없으면 제거
            }

            // 항목을 리스트 맨 위로 이동
            chatItem.prependTo(sidebar);
			
            
            // 새로운 항목 추가
            const newChatItem =
                '<div class="chat-item" data-chat-idx="' + chatIdx + '">' +
                    '<div class="chat-avatar">' +
                        '<img src="/photo/' + messageData.photo + '" alt="Avatar">' +
                    '</div>' +
                    '<div class="chat-details">' +
                        '<div class="chat-header">' +
                            '<span class="chat-title">' + chatTitle + '</span>' +
                            '<span class="chat-time">' + formatTime(messageData.latest_time) + '</span>' +
                        '</div>' +
                        '<div class="chat-preview">' + messageData.latest_message + '</div>' +
                        unreadCountText +
                    '</div>' +
                '</div>';
            sidebar.prepend(newChatItem);
        }
    }
};



// 시간 포맷팅 함수
function formatTime(timestamp) {
    var options = { hour: "numeric", minute: "numeric", hour12: true };
    var formattedTime = new Date(timestamp).toLocaleTimeString("ko-KR", options);
    return formattedTime.replace("AM", "오전").replace("PM", "오후");
}

var loginId = ${sessionScope.loginId};
loginId = parseInt(loginId);


$(document).ready(function () {
	
	chatList(null);
	
	$(document).on('click', '.fa-search', function() {
	    executeSearch();
	});

	// 엔터키 이벤트
	$(document).on("keypress", "#searchBar", function (e) {
	    if (e.which === 13) {
	        executeSearch();
	    }
	});

	//검색 실행 함수
	function executeSearch() {
	    var keyword = $("#searchBar").val().trim(); // 검색어 가져오기
	    chatList(keyword); // 검색 실행
	}
	
    // 대화방 및 사원 목록 가져오기
    function chatList(keyword){
    $.ajax({
        type: "GET",
        url: "chatList.ajax",
        data: {emp_idx : loginId,
        	keyword : keyword || ''},
        success: function (response) {
            var sidebar = $(".sidebar");
            var memberListWrapper = $(".member-list-wrapper .member-list");

            // 날짜 및 시간 포맷팅 함수
            function formatDateTime(latestTime) {
                if (!latestTime) return "";

                const now = new Date();
                const messageDate = new Date(latestTime);

                const isToday =
                    now.getFullYear() === messageDate.getFullYear() &&
                    now.getMonth() === messageDate.getMonth() &&
                    now.getDate() === messageDate.getDate();

                const isThisYear = now.getFullYear() === messageDate.getFullYear();

                if (isToday) {
                    return messageDate.toLocaleString("ko-KR", {
                        hour: "numeric",
                        minute: "numeric",
                        hour12: true,
                    });
                } else if (isThisYear) {
                    return (messageDate.getMonth() + 1) + "월 " + messageDate.getDate() + "일";
                } else {
                    return messageDate.getFullYear() + ". " + (messageDate.getMonth() + 1) + ". " + messageDate.getDate();
                }
            }

            // 대화방 리스트 렌더링
            if (response.chatList && response.chatList.length > 0) {
                sidebar.empty();
                response.chatList.forEach(function (chat) {
                    var latestMessage = chat.latest_message || "메시지가 없습니다.";
                    var latestTime = chat.latest_time ? formatDateTime(chat.latest_time) : "";

                    // 제목이 null인지 확인하여 제목 또는 참여자 표시
                    var chatTitle;
                    if (chat.chat_subject === null || chat.chat_subject === "") {
                        chatTitle = chat.participants;
                    } else {
                        chatTitle = chat.chat_subject;
                    }
                    
                    var unreadCountText = "";
                    if (chat.unread_count > 0) {
                        unreadCountText = '<div class="unread-count-list"><span class="unread-message-count">' + chat.unread_count + '</span></div>';
                    } else {
                        unreadCountText = '<span class="unread-message-count"></span>';
                    }

                    var chatItem =
                        '<div class="chat-item" data-chat-idx="' + chat.chat_idx + '" onclick="location.href=\'chat.go?chat_idx=' + chat.chat_idx + '\'">' +
                        '<div class="chat-avatar">' +
                        '<img src="/photo/' + chat.photo + '" alt="프로필 사진" class="custom-image">' +
                        '</div>' +
                        '<div class="chat-details">' +
                        '<div class="chat-header">' +
                        '<span class="chat-title">' + chatTitle + '</span>' +
                        '<span class="chat-time">' + latestTime + '</span>' +
                        '</div>' +
                        '<div class="chat-preview">' +
                        '<span>' + chat.latest_message + '</span>' +
                        unreadCountText +
                    	'</div>' +
                        '</div>' +
                        '</div>';
                    sidebar.append(chatItem);
                });
            } else {
                sidebar.html("<p>참여 중인 대화방이 없습니다.</p>");
            }

            // 사원 목록 렌더링
            if (response.employeeList && response.employeeList.length > 0) {
                memberListWrapper.empty();
                response.employeeList.forEach(function (employee) {
                    var memberItem =
                        '<div class="image-label-wrapper member-item" data-emp-idx="' + employee.emp_idx + '">' +
                        '<img src="/photo/' + employee.photo + '" alt="프로필 사진" class="custom-image">' +
                        '<span class="custom-label">' + employee.name + ' / ' + employee.rank_name + '</span>' +
                        '</div>';
                    memberListWrapper.append(memberItem);
                });

                // 사원 클릭 이벤트 추가
                $(".member-item").on("click", function () {
                    var empIdx = $(this).data("emp-idx");
                    var empName = $(this).find(".custom-label").text();

                    modal.showConfirm(
                        empName + "님과 대화를 시작하시겠습니까?",
                        function () {
                            createChat(null, empIdx); // 사원의 emp_idx 전달
                        }
                    );
                });
            } else {
                memberListWrapper.html("<p>등록된 사원이 없습니다.</p>");
            }
        },
        error: function () {
            alert("대화방 및 사원 목록을 불러오는 데 실패했습니다.");
        }
    });
    }
    
    $("#createChatButton").on("click", function () {
        var chatSubject = $("#chatSubject").val().trim();
        var selectedMembers = [];

        // 체크된 체크박스의 emp_idx 값을 수집
        $("input[name='member']:checked").each(function () {
            selectedMembers.push(parseInt($(this).val())); // emp_idx를 숫자로 변환
        });

        if (!chatSubject && selectedMembers.length === 0) {
            alert("대화방 제목을 입력하거나 회원을 선택하세요.");
            return;
        }

        // 대화방 생성 함수 호출
        createChat(chatSubject, selectedMembers);
    });
    // 대화방 생성 함수
    function createChat(chat_subject, emp_idx_list) {
    $.ajax({
        type: "POST",
        url: "createChat.do",
        contentType: "application/json; charset=UTF-8", // Content-Type을 JSON으로 설정
        data: JSON.stringify({
            chat_subject: chat_subject, 
            emp_idx_list: emp_idx_list // 선택된 사용자 리스트 전달
        }),
        success: function (response) {
            if (response.success) {
                alert("대화방이 생성되었습니다!");
                location.href = "chat.go?chat_idx=" + response.chatIdx; // 생성된 방으로 이동
            } else {
                alert("대화방 생성에 실패했습니다. 다시 시도해주세요.");
            }
        },
        error: function () {
            alert("서버와 통신 중 문제가 발생했습니다.");
        }
    });
}
});

//모달 열기
function openModal() {
    $("#memberModal").fadeIn(200, function () { 
        centerModal(); // 애니메이션 완료 후 중앙 정렬
    });
    loadMemberList(null);
}

function closeModal() {
    $("#memberModal").fadeOut();
}

$(document).on("click", function (e) {
    if ($(e.target).is("#memberModal")) {
        closeModal();
    }
});

$(window).on("resize", function () {
    if ($("#memberModal").is(":visible")) {
        centerModal();
    }
});

function centerModal() {
    var modal = $("#memberModal .modal-content");
    var top = Math.max(($(window).height() - modal.outerHeight()) / 2, 0); 
    var left = Math.max(($(window).width() - modal.outerWidth()) / 2, 0); 
    modal.css({
        top: top + "px",
        left: left + "px",
    });
}

$(document).on('click', '.search-icon', function () {
    executeSearch();
});

$(document).on("keypress", "#memberSearchBar", function (e) {
    if (e.which === 13) {
        executeSearch();
    }
});

function executeSearch() {
    var keyword = $("#memberSearchBar").val().trim(); // 검색어 가져오기
    loadMemberList(keyword); // 검색 실행
}

function loadMemberList(keyword) {
    $.ajax({
        type: "GET",
        url: "memberList.ajax",
        data: { keyword: keyword || '' }, // 검색어 전달
        success: function (members) {
            var memberList = $("#memberList");
            memberList.empty(); // 기존 리스트 초기화

            if (members && members.length > 0) {
                members.forEach(function (member) {
                    var memberItem = 
                        '<div class="radio-container">' +
                            '<label>' +
                                '<div>' +
                                    '<img src="/photo/' + member.photo + '" alt="프로필 사진" class="custom-image"> ' +
                                    '<span>' + member.name + ' / ' + member.rank_name + '</span>' +
                                '</div>' +
                                '<div>' +
                                    '<input type="checkbox" name="member" value="' + member.emp_idx + '">' +
                                '</div>' +
                            '</label>' +
                        '</div>';
                    memberList.append(memberItem);
                });
            } else {
                memberList.html("<p>검색된 회원이 없습니다.</p>");
            }
        },
        error: function () {
            alert("회원 리스트를 불러오는 데 실패했습니다.");
        }
    });
}





</script>
</html>
