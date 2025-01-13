$(document).ready(function () {
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(37.4765376, 126.8801748),
        level: 3
    };

    var map = new kakao.maps.Map(container, options);

    // **전역에 버스 마커 배열 선언**
    var busMarkers = [];
    var polyline; // 노선 폴리라인 변수 선언

    $('.bus-header').click(function () {
    var busID = $(this).find('input[type="hidden"]').val();
    var $clickedRoute = $(this);
    
    $('.cPurple').removeClass('cPurple').addClass('lPurple');
            	console.log("테스트212:");
    $.ajax({
        url: 'bus.ajax',
        method: 'GET',
        data: { busID: busID },
        success: function (data) {
        	console.log("테스트:"+data);
            // 기존 Polyline 제거
            if (polyline) {
                polyline.setMap(null);
            }
            
            // busNo 추출
        	var busNo = data.busDetails.result.busNo; // busNo 확인
            // 실시간 버스 위치 및 기존 정보 렌더링 (기존 기능 유지)
            renderRouteInfo(data.busDetails.result, $clickedRoute);
            renderRealtimeBusIcons(data.realtimeRoute.result, $clickedRoute, busNo);
            
            
            renderBusLocations(data.realtimeRoute.result, busNo);
            
			
            updateBusNumber(data.busDetails.result);

			
            // 보간점 데이터로 Polyline 그리기
            if (data.laneData && data.laneData.result && data.laneData.result.lane) {
    		// lane 배열에서 graphPos 추출
    			var routeCoords = [];
    			data.laneData.result.lane.forEach(function (lane) {
        		lane.section.forEach(function (section) {
        		routeCoords = routeCoords.concat(parseGraphPos(section.graphPos));
    		});
    	});

    			if (routeCoords.length > 0) {
        			drawRoutePolyline(routeCoords); // Polyline 생성
    			} else {
        			console.warn("보간점 데이터가 없습니다.");
    			}
			} else {
    			console.warn("보간점 데이터가 없습니다.");
			}
        },
        error: function () {
            alert('데이터를 가져오는 데 실패했습니다.');
        }
    });
});

function updateBusNumber(bus) {
    // 글자 수에 따라 색상 결정
    let colorClass = "";
    if (bus.busNo.length <= 3) {
        colorClass = "cBlue"; // 3자 이하일 때 클래스
    } else if (bus.busNo.length <= 5) {
        colorClass = "cGreen"; // 4~5자일 때 클래스
    } else {
        colorClass = "long-bus"; // 6자 이상일 때 클래스
    }

    // HTML 업데이트
    $('.bus-drive-info').html(`
        <i class="fa-solid fa-angle-right"></i>
        <span class="${colorClass}">
            ${bus.busNo}
        </span>
    `);
}


// 보간점 데이터 파싱 함수
function parseGraphPos(graphPos) {
    if (!graphPos || graphPos.length === 0) {
        console.warn("graphPos 데이터가 없습니다.");
        return [];
    }

    return graphPos.map(function (pos) {
        if (pos.x && pos.y) {
            return new kakao.maps.LatLng(pos.y, pos.x); // x, y 값을 LatLng로 변환
        } else {
            console.warn("유효하지 않은 graphPos 데이터:", pos);
            return null; // 잘못된 데이터 무시
        }
    }).filter(coord => coord !== null); // 유효한 좌표만 반환
}


// Polyline을 지도에 그리는 함수
function drawRoutePolyline(routeCoords) {
    if (!routeCoords || routeCoords.length === 0) {
        console.warn("routeCoords 데이터가 없습니다.");
        return;
    }

    polyline = new kakao.maps.Polyline({
        path: routeCoords, // 보간점 좌표
        strokeWeight: 5,
        strokeColor: '#30005A', // 선 색깔
        strokeOpacity: 0.8,
        strokeStyle: 'solid'
    });

    polyline.setMap(map);

    // 지도 경계 조정
    var bounds = new kakao.maps.LatLngBounds();
    routeCoords.forEach(function (coord) {
        bounds.extend(coord);
    });
    map.setBounds(bounds);
}





    // 실시간 버스 위치를 지도에 표시하는 함수
	function renderBusLocations(busData, busNo) {
    // busData가 객체 형태이고 real 속성을 포함할 경우
    	if (busData && busData.real) {
        	busData = busData.real; // busData를 real 배열로 대체
    	}

    // 기존 마커 제거
    	busMarkers.forEach(function (marker) {
        	marker.setMap(null);
    	});
    	busMarkers = []; // 배열 초기화

    // busData가 배열인지 확인
    	if (!Array.isArray(busData)) {
        	console.warn("유효하지 않은 데이터 형식입니다:", busData);
        	return;
    	}

    // 새 마커 추가
    busData.forEach(function (bus) {
    if (bus.positionX && bus.positionY) {
        var position = new kakao.maps.LatLng(bus.positionY, bus.positionX);
        
        var spriteOrigin;
            if (busNo.length <= 3) {
                spriteOrigin = new kakao.maps.Point(0, 0); // blue
            } else if (busNo.length === 4) {
                spriteOrigin = new kakao.maps.Point(0, 56); // green
            }

        // 마커 이미지 설정
        var imageSrc = 'https://ssl.pstatic.net/sstatic/keypage/outside/scui/bus/img/ico_bus_set_v5.png'; // 이미지 URL
        var imageSize = new kakao.maps.Size(27, 25); // 마커 이미지 크기
        var imageOption = {
            spriteOrigin: spriteOrigin, // 이미지 자를 시작 좌표
            spriteSize: new kakao.maps.Size(28, 453), // 전체 스프라이트 이미지 크기
        };

        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // 마커 생성
        var marker = new kakao.maps.Marker({
            map: map,
            position: position,
            image: markerImage // 커스텀 마커 이미지 설정
        });
        
         var overlay = new kakao.maps.CustomOverlay({
            content: `<div class="bus-tooltip2">${bus.busPlateNo}</div>`,
            position: position,
            xAnchor: 0.5, // 수평 기준점 (중앙)
    		yAnchor: 1.5, // 수직 기준점 (마커 위쪽)
            zIndex: 3,
            map: null // 초기에는 숨겨진 상태
        });

		
		 // 차량 번호 추가 (마커에 직접 데이터 저장)
            marker.busPlateNo = bus.busPlateNo;
            
        // 마커에 hover 이벤트 등록
        kakao.maps.event.addListener(marker, 'mouseover', function () {
            overlay.setMap(map); // CustomOverlay 표시
        });

        kakao.maps.event.addListener(marker, 'mouseout', function () {
            overlay.setMap(null); // CustomOverlay 숨김
        });

		// 마커 클릭 이벤트 추가
        kakao.maps.event.addListener(marker, 'click', function () {
            moveToBusIcon(bus.busPlateNo);
        });
        
        
        // 생성된 마커를 배열에 추가
        busMarkers.push(marker);
    } else {
        console.warn("유효하지 않은 버스 위치:", bus);
    }
});
}

function moveToBusIcon(busPlateNo) {
    // 해당 차량 번호에 맞는 bus-icon 찾기
    var $busIcon = $('.bus-icon[data-bus-plate="' + busPlateNo + '"]');

    // bus-icon이 존재하면 이동
    if ($busIcon.length) {
        var $rContent = $('.rContent'); // rContent 요소 선택

        // rContent 내부에서 bus-icon의 위치 계산
        var rContentOffset = $rContent.offset().top; // rContent의 상단 위치
        var busIconOffset = $busIcon.offset().top; // bus-icon의 문서 기준 위치
        var relativeTop = busIconOffset - rContentOffset; // rContent 내부 상대 위치

        var scrollOffset = $rContent.height() / 2; // 중앙에 위치하도록 조정

        // rContent 스크롤 이동
        $rContent.animate({
            scrollTop: $rContent.scrollTop() + relativeTop - scrollOffset
        }, 500); // 스크롤 애니메이션 지속 시간 (500ms)
    } else {
        console.warn("해당 bus-icon을 찾을 수 없습니다:", busPlateNo);
    }
}


    // 정류장 정보를 렌더링하는 함수
    function renderRouteInfo(result, $clickedRoute) {
    
    	// HTML 구성
		var content = '<p><span class="lPurple">첫차: </span><span class="cPurple">' + result.busFirstTime + '</span></p>';
		content += '<p><span class="lPurple">막차: </span><span class="cPurple">' + result.busLastTime + '</span></p>';
		content += '<p><span class="lPurple">배차 간격: </span><span class="cPurple">' + result.busInterval + '분</span></p>';

		$clickedRoute.find('.route-summary').html(content);

		// 나머지 station 관련 정보는 기존 영역에 추가
		var stationContent = '<div class="station-container">';
		stationContent += '<div class="station-list">';

		(result.station || []).forEach(function (station) {
    		stationContent += '<div class="station-item" data-station-id="' + station.stationID + '" data-station-seq="' + station.idx + '">';
    		stationContent += '<div class="station-info">';
    		stationContent += '<p class="station-name">' + station.stationName + '</p>';
    		stationContent += '<p class="station-id">' + station.arsID + '</p>';
    		stationContent += '</div>';
    		stationContent += '<i class="bi bi-caret-down-square"></i>';
    		stationContent += '</div>';
		});

		stationContent += '</div>';
		stationContent += '</div>';

		// 기존 "bus-api-container"에 station 정보만 추가
		$('.bus-api-container').html(stationContent);

}


function renderRealtimeBusIcons(result, $clickedRoute, busNo) {
    $('.bus-icon').remove(); // 기존 아이콘 제거

    var totalBuses = 0; // 운행 중인 총 버스 대수 초기화
	
	
    (result.real || []).forEach(function (bus) {
        var fromStationId = bus.fromStationId; // 이전 정류장 ID
        var toStationId = bus.toStationId;     // 다음 정류장 ID
        var busPosition = bus.busPosition;     // 버스 위치 (1: 이전 정류장 도착, 2: 중간)

        // 정류장 탐색
        var $fromStation = $('.station-item[data-station-id="' + fromStationId + '"]');
        var $toStation = $('.station-item[data-station-id="' + toStationId + '"]');

        // 정류장 정보 유효성 확인
        if ($fromStation.length && $toStation.length) {
            var isEndOfLine = $fromStation.next('.station-item').length === 0; // 다음 정류장이 없는 경우
            var fromStationArsID = $fromStation.find('.station-id').text().trim(); // 종점의 arsID
            var isStartingFromEnd = isEndOfLine && fromStationArsID === bus.fromStationArsID;

            if (busPosition === "2") {
                placeBusIconBetweenStations($fromStation, $toStation, bus.busPlateNo, busNo);
            } else if (busPosition === "1" && (!isEndOfLine || isStartingFromEnd)) {
                placeBusIconNextToStation($fromStation, bus.busPlateNo, busNo);
            }
            totalBuses++; // 버스 대수 합산
        }
    });

    addBusIconClickEvents();
    addBusIconHoverEvents();

    // UI에 표시 (예: #busCount 요소에 표시)
    $clickedRoute.find('.route-summary.total').html(
        `<p><span class="lPurple">현재 운행 버스: </span><span class="cPurple">${totalBuses}대</span></p>`
    );
}
    
    
    
function placeBusIconNextToStation($station, busPlateNo, busNo) {
	busNo = String(busNo).trim();
	var iconClass = '';
    	if (busNo.length <= 3) {
        	iconClass = 'blue'; // 3글자 이하
    	} else if (busNo.length === 4) {
        	iconClass = 'green'; // 4글자
    	}
    var $icon = $('<span class="bus-icon ' + iconClass + '" data-bus-plate="' + busPlateNo + '"></span>');

    if ($station.length) {
        // 부모 .station-item 기준으로 상대 위치 설정
        var iconTop = 12; // 위쪽 위치 고정
        var iconRight = 30; // 오른쪽 위치 고정

        $icon.css({
            position: 'absolute',
            top: iconTop + 'px',
            right: iconRight + 'px',
        });

        // .station-item 안에 추가
        $station.append($icon);
    } else {
        console.warn(`Station not found for bus: ${busPlateNo}`);

    }
}

function placeBusIconBetweenStations($fromStation, $toStation, busPlateNo, busNo) {
	busNo = String(busNo).trim();
    // 글자 수에 따라 클래스 설정
    var iconClass = '';
    if (busNo.length <= 3) {
        iconClass = 'blue'; // 3글자 이하
    } else if (busNo.length === 4) {
        iconClass = 'green'; // 4글자
    }
	
    if ($fromStation.length) {
        var $icon = $('<span class="bus-icon ' + iconClass + '" data-bus-plate="' + busPlateNo + '"></span>');

        // 이전 정류장의 높이 기준으로 아이콘 배치
        var iconTop = $fromStation.outerHeight() / 2; // 중간 위치
        var iconRight = 30; // 오른쪽 위치 고정

        $icon.css({
            position: 'absolute',
            top: (iconTop + 12) + 'px',
            right: iconRight + 'px',
        });

        // $fromStation에 position: relative 추가
        if ($fromStation.css('position') === 'static') {
            $fromStation.css('position', 'relative');
        }

        $fromStation.append($icon); // $fromStation에 아이콘 추가
    } else {
        console.warn(`Failed to find station for bus: ${busPlateNo}`);
    }
}






function addBusIconClickEvents() {
    $('.bus-icon').off('click'); // 기존 클릭 이벤트 제거
    $('.bus-icon').on('click', function () {
        var busPlateNo = $(this).data('bus-plate'); // 클릭된 아이콘의 차량 번호
        moveToMapMarker(busPlateNo); // 차량 번호를 사용해 마커로 이동
    });
}
function moveToMapMarker(busPlateNo) {
    var targetMarker = null;

    // busMarkers 배열에서 차량 번호와 일치하는 마커를 찾음
    busMarkers.forEach(function (marker) {
        if (marker.busPlateNo === busPlateNo) {
            targetMarker = marker;
        }
    });

    if (targetMarker) {
        // 지도 중심을 마커 위치로 이동
        map.setCenter(targetMarker.getPosition());
        map.setLevel(3); // 지도의 확대/축소 레벨 설정
    } else {
        console.warn("해당 차량 번호에 맞는 마커를 찾을 수 없습니다:", busPlateNo);
    }
}



    function addBusIconHoverEvents() {
        $('.bus-icon').hover(
            function () {
                var busPlateNo = $(this).data('bus-plate');
                var tooltip = $('<div class="bus-tooltip">' + busPlateNo + '</div>');
                $('body').append(tooltip);

                tooltip.css({
                    top: $(this).offset().top - tooltip.outerHeight() - 10,
                    left: $(this).offset().left - tooltip.outerWidth() / 2 + $(this).width() / 2,
                });
            },
            function () {
                $('.bus-tooltip').remove();
            }
        );
    }
});