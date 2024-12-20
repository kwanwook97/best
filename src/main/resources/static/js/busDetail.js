$(document).ready(function() {
    // 페이지 로드 시 AJAX로 데이터 가져오기
    loadBusDetails(null, null, null);
    
    // 노선 클릭 이벤트 (이벤트 위임)
    $(document).on('click', '.bus-header', function() {
        var routeName = $(this).find('input[name="route_name"]').val();
        loadBusDetails(routeName, null, null);
    });

    // 검색창 엔터 이벤트
    $('.search input').on('keypress', function(e) {
        if (e.which === 13) { 
            triggerSearch();
        }
    });

    // 검색 아이콘 클릭 이벤트
    $(document).on('click', '.fas.fa-search', function() { 
        triggerSearch();
    });

    // 검색 실행 함수
    function triggerSearch() {
        var filterType = $('.drop').val();
        var keyword = $('.search input').val().trim();
        loadBusDetails(null, filterType, keyword);
    }

    function loadBusDetails(routeName, filterType, keyword) {
    $.ajax({
        url: 'busDetail.ajax',
        type: 'GET',
        dataType: 'json',
        data: {
            route_name: routeName || '',   // 노선명
            filterType: filterType || '', // 검색 타입
            keyword: keyword || ''        // 검색어
        },
        success: function(data) {
            // 기존 영역 초기화
            $('.bus-info2').empty();
            $('.bus-detail-card').empty();

            // 노선 통계 데이터 (busSum) 출력
            $.each(data.busSum, function(index, sum) {
                var routeHtml = `
                    <div class="bus-header">
                        <div class="bus-main-info">
                            <div style="width: 6.5vw;">
                                ${sum.route_name.length == 3 ? 
                                    '<span class="bus-number blue">' + sum.route_name + '</span>' :
                                    '<span class="bus-number green">' + sum.route_name + '</span>'}
                            </div>
                            <input type="hidden" name="route_name" value="${sum.route_name}"/>
                            <div class="bus-sum">
                                <ul>
                                    <li><strong>총 버스 : </strong>
                                        <span>${sum.total_buses}</span>
                                    </li>
                                    <li><strong>운행가능 : </strong>
                                        <span>${sum.normal_count}</span>
                                    </li>
                                    <li><strong>정비 중 : </strong>
                                        <span>${sum.maintenance_count}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>`;
                $('.bus-info2').append(routeHtml);
            });

            // 버스 상세 데이터 (busData) 출력
            $.each(data.busData, function(index, bus) {
                var detailHtml = `
                    <div class="bus-info-card" onclick="busUpdate(this)">
                        <input type="hidden" name="bus_idx" value="${bus.bus_idx}"/>
                        <div class="bus-number ${bus.route_name.length == 3 ? 'blue' : 'green'}">
                            ${bus.route_name}
                        </div>
                        <div class="bus-details">
                            <p><strong>차량 번호:</strong> <span class="purple">${bus.license_plate}</span></p>
                            <p><strong>운행 상태:</strong> <span class="purple">${bus.drive_status}</span></p>
                            <p><strong>연비:</strong> <span class="purple">${bus.fuel_efficiency} km/L</span></p>
                            <p><strong>구입일:</strong> <span class="purple">${bus.buy_date}</span></p>
                            <p><strong>제조사:</strong> <span class="purple">${bus.bus_company}</span></p>
                            <p><strong>좌석 수:</strong> <span class="purple">${bus.seat_number} 석</span></p>
                            <p><strong>운행거리:</strong> <span class="purple">${bus.distance} km</span></p>
                            <p><strong>점검 일:</strong> <span class="purple">${bus.inspect_date}</span></p>
                            <p><strong>다음 점검일:</strong> <span class="purple">${bus.next_inspect_date}</span></p>
                            <p><strong>담당 정비사:</strong> <span class="purple">${bus.emp_idx}</span></p>
                            <p><strong>정비 내용:</strong> <span class="purple">${bus.content}</span></p>
                            <p><strong>버스 상태:</strong> <span class="purple">${bus.status}</span></p>
                        </div>
                    </div>`;
                $('.bus-detail-card').append(detailHtml);
            });
        },
        error: function() {
            alert('버스 정보를 불러오는데 실패했습니다.');
        }
    });
}
});

function busUpdate(element) {
    // 클릭한 요소에서 bus_idx 값을 가져오기
    const busIdx = $(element).find('input[name="bus_idx"]').val();
    console.log('busIdx:', busIdx); // bus_idx 값을 확인
    
    if (!busIdx) {
        alert('bus_idx 값을 가져올 수 없습니다.');
        return;
    }

    // 모달 열기
    const modal = document.getElementById('busUpdateModal');
    modal.style.display = 'block';

    // bus_idx 값을 포함한 URL로 iframe을 업데이트
    const iframe = modal.querySelector('iframe');
    iframe.src = 'busUpdate.go?bus_idx=' + busIdx;
}

	// 모달 닫기
	function closeModal() {
	  const modal = document.getElementById('busUpdateModal');
	  modal.style.display = 'none';
	}

	// 모달 외부 클릭 시 닫기
	window.onclick = function (event) {
	  const modal = document.getElementById('busUpdateModal');
	  if (event.target === modal) {
	    modal.style.display = 'none';
	  }
	};