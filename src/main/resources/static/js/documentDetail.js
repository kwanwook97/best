// 상세보기
function draftDetail(doc_idx) {
	console.log("누른거 idx : ",doc_idx);
    $.ajax({
        type: 'GET',
        url: 'draftDetail.ajax',
        data: { doc_idx: doc_idx },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);  // 서버에서 받은 HTML 확인
        	open(response); 
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}
//모달 열기
function open(content) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
    // 모달 HTML 생성
    var Html = 
        '<div id="' + modalId + '" class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="content none" contenteditable="true">' + content + '</div>' +
        '  </div>' +
        '</div>';

    // body에 추가
    $('body').append(Html);

    // 모달 표시
    $('#' + modalId).show();

    // 닫기 버튼 이벤트 등록 (이벤트 위임)
    $(document).on('click', '.close-btn', function() {
        var targetModalId = $(this).data('modal-id');
        $('#' + targetModalId).remove();
    });
}


function receivedDetail(doc_idx) {
	console.log("누른거 idx : ",doc_idx);
    $.ajax({
        type: 'GET',
        url: 'draftDetail.ajax',
        data: { doc_idx: doc_idx },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);  // 서버에서 받은 HTML 확인
        	receivedOpen(response); 
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}