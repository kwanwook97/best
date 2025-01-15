loginId = parseInt(loginId);


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

                // 로그인한 사용자의 프로필을 리스트에서 분리
                var myProfile = null;
                var otherEmployees = [];

                response.employeeList.forEach(function (employee) {
                    if (Number(employee.emp_idx) === Number(loginId)) {
                        myProfile = employee;
                    } else {
                        otherEmployees.push(employee);
                    }
                });

                // 로그인한 사용자 프로필을 상단에 추가
                if (myProfile) {
                    var myProfileItem =
                        '<div class="image-label-wrapper my-profile member-item" data-emp-idx="' + myProfile.emp_idx + '">' +
                        '<img src="/photo/' + myProfile.photo + '" alt="프로필 사진" class="custom-image">' +
                        '<span class="custom-label">' + myProfile.name + ' / </span>' +
                        '<div class="mySelf"><span>나</span></div>' + 
                        '</div>';
                    memberListWrapper.append(myProfileItem);
                }

                // 나머지 사원 추가
                otherEmployees.forEach(function (employee) {
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

                    // 프로필 모달 열기
                    openProfileModal(empIdx, empName);
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
    
    
    function openProfileModal(empIdx, empName) {
        openModal("profileModal", function () {
            // AJAX를 통해 데이터 가져오기
            $.ajax({
                url: "profile.ajax",
                type: "GET",
                data: { emp_idx: empIdx },
                success: function (profile) {
                    $("#profileModal .modal-body").html(
                   		'<div class="profile-header">' +
                        	'<img src="/photo/' + profile.photo + '" alt="프로필 사진" class="custom-image">' +
                        	'<div>' +
                        		'<span>' + empName + '</span>' +
                        		'<span>' + (profile.state == 1 ?  '<i class="fas fa-circle" style="color: #1DD20C;"></i> 근무 중' : '<i class="fas fa-circle" style="color: red"></i> 부재 중') + '</span>' +
                        	'</div>' +
                        '</div>' +
                        '<ul>' +
                        	'<li><span>부서</span><span>'  + profile.depart_name + '</span></li>' +
                        	'<li><span>이메일</span><span>'  + profile.email + '</span></li>' +
                        	'<li><span>연락처</span><span>'  + profile.phone + '</span></li>' +
                        	'<li><span>핸드폰</span><span>'  + profile.mobile + '</span></li>' +
                        '</ul>'
                    );
                    $("#profileChat").off("click").on("click", function () {
                        openConfirmModal(profile.name + " 님과 대화를 시작하시겠습니까?", function () {
                            createChat("", [empIdx]); // 확인 후 방 생성
                        });
                    });
                },
                error: function () {
                    alert("프로필 정보를 가져오는 데 실패했습니다.");
                }
            });
        });
    }
    
    function openConfirmModal(message, onConfirm) {
        $("#confirmMessage").text(message); // 메시지 설정
        $("#confirmYes")
            .on("click", function () {
                onConfirm(); // 확인 작업 실행
                closeModal("confirmModal"); // 모달 닫기
            });
        openModal("confirmModal"); // 모달 열기
    }
    
    $("#createChatButton").off("click").on("click", function () {
        var chatSubject = $("#chatSubject").val().trim();
        var selectedMembers = [];

        // 체크된 체크박스의 emp_idx 값을 수집
        $("input[name='member']:checked").each(function () {
            selectedMembers.push(parseInt($(this).val())); // emp_idx를 숫자로 변환
        });

        if (!chatSubject && selectedMembers.length === 0) {
            return;
        }

        // 확인 모달 열기
        openConfirmModal("대화방을 생성하시겠습니까?", function () {
            createChat(chatSubject, selectedMembers); // 확인 후 대화방 생성
        });
    });
    // 대화방 생성 함수
    function createChat(chat_subject, emp_idx_list) {
    $.ajax({
        type: "POST",
        url: "createChat.do",
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify({
            chat_subject: chat_subject,
            emp_idx_list: emp_idx_list
        }),
        success: function (response) {
            if (response.success) {
                if (response.existing) {
                    // 기존 대화방으로 이동
                    location.href = "chat.go?chat_idx=" + response.chatIdx;
                } else {
                    // 새로 생성된 대화방으로 이동
                    location.href = "chat.go?chat_idx=" + response.chatIdx;
                }
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



function openModal(modalId, contentUpdater) {
    // 필요한 데이터 업데이트 (contentUpdater는 콜백 함수)
    if (typeof contentUpdater === "function") {
        contentUpdater();
    }

    // 모달 열기
    $("#" + modalId).fadeIn(200); // 단순히 fadeIn으로 모달 표시
}

function closeModal(modalId) {
    $("#" + modalId).fadeOut(); // fadeOut으로 모달 숨김
}

$(document).on("click", function (e) {
    $(".modal").each(function () {
        if ($(e.target).is(this)) {
            closeModal($(this).attr("id"));
        }
    });
});



function openMemberModal() {
    openModal("memberModal", function () {
        loadMemberList(null); // 회원 리스트 로드
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
                    // 로그인한 사용자는 리스트에서 제외
                    if (Number(member.emp_idx) === Number(loginId)) {
                        return; // 해당 항목을 건너뜀
                    }

                    // 다른 멤버 정보 생성
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



$(document).ready(function () {
    // 체크박스 상태 변경 이벤트
    $(document).on("change", "input[name='member']", function () {
        var selectedMembersContainer = $("#selectedMembersContainer"); // 선택된 회원 표시 영역
        var memberName = $(this).closest("label").find("span").text(); // 체크박스 옆의 회원 이름
        var memberId = $(this).val(); // 체크박스의 값 (emp_idx)
        var memberPhoto = $(this).closest("label").find("img").attr("src"); // 회원 프로필 사진 경로

        if ($(this).is(":checked")) {
            // 체크박스 선택 시
            var memberElement = 
            	'<div class="selected-member-container" data-member-id="' + memberId + '">' +
                    '<span><img src="' + memberPhoto + '" class="custom-image">' +
                    '<i class="fas fa-times remove-member" data-member-id="' + memberId + '"></i></span>' +
                	'<span class="selected-member" data-member-id="' + memberId + '">' + memberName +
                	'</span>' +
                '</div>';
            selectedMembersContainer.append(memberElement);
        } else {
            // 체크박스 선택 해제 시
        	selectedMembersContainer.find('.selected-member-container[data-member-id="' + memberId + '"]').remove();
        }
    });

    // 선택된 회원의 제거 아이콘 클릭 이벤트
    $(document).on("click", ".remove-member", function () {
        var memberId = $(this).data("member-id");
        // 체크박스 선택 해제
        $('input[name="member"][value="' + memberId + '"]').prop("checked", false).trigger("change");
        // 선택된 멤버 제거
        $(this).closest('.selected-member-container').remove();
    });
    $(document).on("click", ".close-modal", function () {
        $(".selected-member-container").empty(); // 선택된 멤버 표시 영역 초기화
        $("input[name='member']").prop("checked", false).trigger("change"); // 모든 체크박스 선택 해제
    });

    // 바깥 영역 클릭 시 모달 닫히는 경우 처리
    $(document).on("click", function (e) {
        if ($(e.target).is("#memberModal")) {
            $(".selected-member-container").empty(); // 선택된 멤버 표시 영역 초기화
            $("input[name='member']").prop("checked", false).trigger("change"); // 모든 체크박스 선택 해제
            $("#memberModal").fadeOut();
        }
    });
});


$(document).ready(function () {
    // 제목 글자 수 제한
    $("#chatSubject").on("input", function () {
        const maxLength = 50;
        const currentLength = $(this).val().length;

        if (currentLength > maxLength) {
            alert("제목은 최대 50글자까지 입력 가능합니다.");
            $(this).val($(this).val().substring(0, maxLength)); // 초과된 내용 제거
        }
    });
});