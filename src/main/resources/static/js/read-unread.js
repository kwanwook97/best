$(document).on('click', '.update', function() {
    var doc_idx = $(this).data('doc-idx');
    var icon = $(this).find('i');
    var doc_read = icon.hasClass('fa-envelope') ? 1 : 0;
    var approv_num = $(this).data('approv-num');
    console.log(text);
    
    $.ajax({
        url: 'updateRead.ajax',
        method: 'POST',
        data: {
        	text : text,
        	approv_num: approv_num,
            doc_idx: doc_idx,
            doc_read: doc_read
        },
        success: function(response) {
            if (response.success) {
                // 서버 응답 후, 아이콘을 즉시 업데이트
                if (doc_read == 1) {
                    icon.removeClass('fa-envelope').addClass('fa-envelope-open-text').attr('title', '읽음');
                } else {
                    icon.removeClass('fa-envelope-open-text').addClass('fa-envelope').attr('title', '읽지 않음');
                }
            } else {
                alert('상태 업데이트 실패');
            }
        },
        error: function(error) {
            console.error('에러:', error);
            alert('에러 발생');
        }
    });
});

// 읽음, 읽지 않음 옵션 선택
$('#status').change(function() {
    var status = $(this).val();  // 읽음/안읽음 상태
    var filteredData = [];

    // 상태에 맞춰서 데이터 필터링
    if (status == 'read') {
        filteredData = filterRead(receivedData, 1);
    } else if (status == 'unread') {
        filteredData = filterRead(receivedData, 0);
    } else {
        filteredData = receivedData;  // 전체 보기
    }

    // 필터링된 데이터를 화면에 갱신
    received(filteredData);

    // 필터링된 데이터에 맞는 전체 페이지 수 갱신
    var totalPages = Math.ceil(filteredData.length / 6);  // 6개씩 페이지 나누기
    $('#receivedPage').twbsPagination('destroy');  // 기존 페이지네이션 초기화
    $('#receivedPage').twbsPagination({
        startPage: 1,
        totalPages: totalPages,  // 필터링된 데이터에 맞는 페이지 수
        visiblePages: 5,
        onPageClick: function(evt, page) {
            console.log("page", page);
            receivedPageCall(page);
        }
    });
});
//필터링 함수 (읽음 상태에 맞는 필터링)
function filterRead(data, readStatus) {
    var result = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].doc_read == readStatus) {
            result.push(data[i]);
        }
    }
    return result;
}