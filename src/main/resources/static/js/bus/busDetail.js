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
                                    <li><strong>운행 가능 : </strong>
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
                    <div class="bus-info-card" onclick="openModal('busManageModal', 'busManage.go?bus_idx=${bus.bus_idx}'); return false;">
                        <input type="hidden" name="bus_idx" value="${bus.bus_idx}"/>
                        <div class="bus-number ${bus.route_name.length == 3 ? 'blue' : 'green'}">
                            ${bus.route_name || "미등록"}
                        </div>
                        <div class="bus-details">
                            <table>
                                <thead>
                                    <tr>
                                        <th colspan="2"><strong>버스 정보</strong></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><strong>차량 번호</strong></td>
                                        <td><span class="purple">${bus.license_plate || "미등록"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>운행 상태</strong></td>
                                        <td><span class="purple">${bus.drive_status || "미등록"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>연비</strong></td>
                                        <td><span class="purple">${bus.fuel_efficiency ? bus.fuel_efficiency + ' km/L' : "미등록"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>구입일</strong></td>
                                        <td><span class="purple">${bus.buy_date || "미등록"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>제조사</strong></td>
                                        <td><span class="purple">${bus.bus_company || "미등록"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>종류</strong></td>
                                        <td><span class="purple">${bus.bus_type || "미등록"}</span></td>
                                    </tr>
                                </tbody>
                            </table>
                            <table>
                                <thead style="border-right: 1px solid #30005A;">
                                    <tr>
                                        <th colspan="2"><strong>정비 내역</strong></th>
                                    </tr>
                                </thead>
                                <tbody style="border-right: 1px solid #8B6AA7;">
                                    <tr>
                                        <td><strong>운행거리</strong></td>
                                        <td><span class="purple">${bus.distance ? bus.distance + ' km' : "정비내용 없음"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>점검 일</strong></td>
                                        <td><span class="purple">${bus.inspect_date || "정비내용 없음"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>다음 점검일</strong></td>
                                        <td><span class="purple">${bus.next_inspect_date || "정비내용 없음"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>담당 정비사</strong></td>
                                        <td><span class="purple">${bus.name || "정비내용 없음"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>정비 비용</strong></td>
                                        <td><span class="purple">${bus.amount ? bus.amount + ' 원' : "정비내용 없음"}</span></td>
                                    </tr>
                                    <tr>
                                        <td><strong>버스 상태</strong></td>
                                        <td><span class="purple">${bus.status || "정비내용 없음"}</span></td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="manage-content">
                                <thead>
                                    <tr>
                                        <th colspan="2"><strong>정비 내용</strong></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="2" rowspan="6"><span class="purple">${bus.content || "정비내용이 없습니다."}</span></td>
                                    </tr>
                                </tbody>
                            </table>
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
