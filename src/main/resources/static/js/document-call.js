$(document).ready(function() {
    let rowCount = 1;  // 최초 행 번호는 1부터 시작

    // 추가 버튼 클릭 시
    $('#plus1').click(function() {
        if (rowCount < 5) {  // 최대 5개의 행만 추가 가능
            rowCount++;  // 새로운 행 추가 시 번호 증가
            var newRow = $('tr.copyRow1:first').clone(); // 첫 번째 행을 복사
            newRow.removeClass('copyRow1'); // 기존의 복사된 클래스 제거
            newRow.addClass('copyRow' + rowCount); // 새로운 행에 고유 클래스 추가

            // 각 입력 필드의 name 속성 및 ID 수정
            newRow.find('input').each(function(index) {
                var id = $(this).attr('id');
                if (id) {
                    // '_숫자'를 제거하고 행 번호 + 순서 번호를 추가
                    $(this).attr('id', id.replace(/_\d+$/, '') + '_' + rowCount);  // 행 번호 + 순서 번호 추가
                    
                    // data-index 값을 순차적으로 설정
                    $(this).attr('data-index', (index + 1) + (rowCount - 1) * 5); // 1부터 시작해서 순차적으로 부여
                }
            });

            // <p> 태그 안의 숫자 업데이트
            newRow.find('.rowNumber').text(rowCount);  // 새로운 행의 숫자를 업데이트

            // 테이블에 새로운 행 추가
            $('#dynamic_table1').append(newRow);
        } else {
            alert("최대 5개 행만 추가 가능합니다.");
        }
    });

    // 삭제 버튼 클릭 시 (맨 뒤의 tr 삭제)
    $(document).on('click', '.deleteRow', function() {
        // 마지막 tr 요소 삭제
        var lastRow = $('#dynamic_table1 tr:last');
        if (lastRow.length > 0) {
            lastRow.remove();
            rowCount--;  // 삭제 후 rowCount 갱신
        }
    });
});
