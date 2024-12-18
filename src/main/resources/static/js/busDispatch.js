window.onload = function () {
    console.log("Window loaded!");

    // 노선 데이터 불러오기
    $.ajax({
        url: "busDispatch.ajax",
        method: "GET",
        success: function (routes) {
            let select = $("#routeSelect");
            select.empty();
            select.append('<option value="">선택</option>');
            routes.forEach(function (route) {
                let option = $('<option></option>');
                option.val(route);
                option.text(route);
                select.append(option);
            });
        },
        error: function () {
            alert("노선 데이터를 불러오는 데 실패했습니다.");
        }
    });

    // 운행 시간 데이터 불러오기
    $.ajax({
        url: "shift.ajax",
        method: "GET",
        success: function (shifts) {
            const shiftSelect = $(".shift");
            shiftSelect.append('<option value="">선택</option>');
            shifts.forEach(function (shift) {
                let option = $('<option></option>');
                option.val(shift.shift_idx);
                option.text(shift.shift);
                shiftSelect.append(option);
            });
        },
        error: function () {
            alert("운행 시간 데이터를 불러오는 데 실패했습니다.");
        }
    });

    // 노선 선택 시 차량 번호 및 운행 기사 불러오기
    $("#routeSelect").on("change", function () {
        const selectedRoute = $(this).val();

        if (selectedRoute) {
            // 차량 번호 불러오기
            $.ajax({
                url: "license.ajax",
                method: "GET",
                data: { route_name: selectedRoute },
                success: function (licensePlates) {
                    const licensePlateSelect = $("#licensePlateSelect");
                    licensePlateSelect.empty();
                    licensePlateSelect.append('<option value="">선택</option>');
                    licensePlates.forEach(function (plate) {
                        let option = $('<option></option>');
                        option.val(plate.bus_idx);
                        option.text(plate.license_plate);
                        licensePlateSelect.append(option);
                    });
                }
            });

            // 운행 기사 불러오기
            $.ajax({
                url: "driver.ajax",
                method: "GET",
                data: { route_name: selectedRoute },
                success: function (drivers) {
                    const driverSelect = $("#driverSelect");
                    driverSelect.empty();
                    driverSelect.append('<option value="">선택</option>');
                    drivers.forEach(function (driver) {
                        let option = $('<option></option>');
                        option.val(driver.emp_idx);
                        option.html(driver.name + ' / ' + driver.emp_idx);
                        driverSelect.append(option);
                    });
                },
                error: function () {
                    alert("운행 기사 데이터를 불러오는 데 실패했습니다.");
                }
            });
        } else {
        }
    });

    const loadDispatchList = function (date) {
    $.ajax({
        url: "dispatchList.ajax",
        method: "GET",
        data: { date: date },
        success: function (response) {
            const $busList = $(".bus-list");
            if (response.success) {
                $busList.empty();

                // 데이터를 차량 번호 기준으로 그룹화
                const groupedData = {};
                response.result.forEach(function (info) {
                    const routeName = info.route_name;
                    const licensePlate = info.license_plate;

                    // routeName 초기화
                    if (!groupedData[routeName]) {
                        groupedData[routeName] = {};
                    }

                    // 차량 번호 초기화
                    if (!groupedData[routeName][licensePlate]) {
                        groupedData[routeName][licensePlate] = { shift_1: '-', shift_2: '-' };
                    }

                    // shift_idx에 따라 데이터 추가
                    if (info.shift_idx === 1) {
                        groupedData[routeName][licensePlate].shift_1 = info.driver_name + ' / ' + info.emp_idx;
                        groupedData[routeName][licensePlate].dispatch_1_idx = info.dispatch_idx;
                    } else if (info.shift_idx === 2) {
                        groupedData[routeName][licensePlate].shift_2 = info.driver_name + ' / ' + info.emp_idx;
                        groupedData[routeName][licensePlate].dispatch_2_idx = info.dispatch_idx;
                    }
                });

                console.log("Grouped Data:", groupedData); // 디버깅: 데이터 확인

                // HTML 생성
                for (const routeName in groupedData) {
                    const licensePlates = groupedData[routeName];

                    const cardHeader =
                        '<div class="bus-card">' +
                        '<div class="bus-number ' + (routeName.length === 4 ? 'cGreen' : 'cBlue') + '">' + routeName + '</div>' +
                        '<div class="bus-details">' +
                        '<table>' +
                        '<thead>' +
                        '<tr>' +
                        '<th>차량 번호</th>' +
                        '<th>첫 차 ~ 14:00</th>' +
                        '<th>14:00 ~ 막차</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody>';

                    let cardBody = '';

                    // 각 차량 번호에 대한 데이터 생성
                    for (const licensePlate in licensePlates) {
    const shifts = licensePlates[licensePlate];
    cardBody +=
        '<tr>' +
        '<td>' + licensePlate + '</td>' +
        '<td class="editable" data-dispatch-idx="' + (shifts.dispatch_1_idx || '') + '">' +
        (shifts.shift_1 || '-') + '</td>' +
        '<td class="editable" data-dispatch-idx="' + (shifts.dispatch_2_idx || '') + '">' +
        (shifts.shift_2 || '-') + '</td>' +
        '</tr>';
}

                    const cardFooter =
                        '</tbody>' +
                        '</table>' +
                        '</div>' +
                        '</div>';

                    $busList.append(cardHeader + cardBody + cardFooter);
                }
            } else {
                alert("리스트를 불러오는 데 실패했습니다.");
            }
        },
        error: function () {
            alert("서버와 통신 중 오류가 발생했습니다.");
        }
    });
};




$("body").on("click", ".editable", function () {
    const dispatchIdx = $(this).data("dispatch-idx");

    if (!dispatchIdx) {
        alert("수정할 데이터가 없습니다.");
        return;
    }

    // 서버 요청
    $.ajax({
        url: "getDispatchByIdx.ajax",
        method: "GET",
        data: { dispatch_idx: dispatchIdx },
        success: function (response) {
            console.log("AJAX 응답 데이터:", response);

            const data = response.data;
            if (!data) {
                alert("데이터를 가져오는 데 실패했습니다.");
                return;
            }
			
			$("#dispatchIdx").val(dispatchIdx);
            // 1. route_name 설정 및 하위 데이터 요청
            $("#routeSelect")
                .val(data.route_name) // route_name 설정
                .trigger("change"); // 이벤트 트리거로 하위 데이터 로드

            // 2. route_name 변경으로 새로 로드된 옵션을 기반으로 값 설정
            $.when(
                loadLicensePlates(data.route_name), // 차량 번호 옵션 로드
                loadDrivers(data.route_name) // 운행 기사 옵션 로드
            ).done(function () {
                // 하위 데이터 로드 후 값 설정
                $("#licensePlateSelect").val(data.bus_idx); // 차량 번호 선택
                $("#driverSelect").val(data.driver_idx); // 운행 기사 선택
            });

            // 3. 나머지 데이터 설정
            $("#operation_date").val(data.date);
            $(".shift").val(data.shift_idx);
            $("#dispatchIdx").val(data.dispatch_idx);
        },
        error: function () {
            alert("데이터를 가져오는 데 실패했습니다.");
        }
    });
});

// 차량 번호 옵션 로드
function loadLicensePlates(routeName) {
    const deferred = $.Deferred();
    $.ajax({
        url: "license.ajax",
        method: "GET",
        data: { route_name: routeName },
        success: function (licensePlates) {
            const licensePlateSelect = $("#licensePlateSelect");
            licensePlateSelect.empty();
            licensePlateSelect.append('<option value="">선택</option>');
            licensePlates.forEach(function (plate) {
                const option = $('<option></option>');
                option.val(plate.bus_idx);
                option.text(plate.license_plate);
                licensePlateSelect.append(option);
            });
            deferred.resolve(); // 성공적으로 로드
        },
        error: function () {
            alert("차량 번호를 불러오는 데 실패했습니다.");
            deferred.reject(); // 실패
        }
    });
    return deferred.promise();
}

// 운행 기사 옵션 로드
function loadDrivers(routeName) {
    const deferred = $.Deferred();
    $.ajax({
        url: "driver.ajax",
        method: "GET",
        data: { route_name: routeName },
        success: function (drivers) {
            const driverSelect = $("#driverSelect");
            driverSelect.empty();
            driverSelect.append('<option value="">선택</option>');
            drivers.forEach(function (driver) {
                const option = $('<option></option>');
                option.val(driver.emp_idx);
                option.html(driver.name + ' / ' + driver.emp_idx);
                driverSelect.append(option);
            });
            deferred.resolve(); // 성공적으로 로드
        },
        error: function () {
            alert("운행 기사를 불러오는 데 실패했습니다.");
            deferred.reject(); // 실패
        }
    });
    return deferred.promise();
}








$(".updatebtn").on("click", function (e) {
    e.preventDefault(); // 기본 동작 중지

    // 현재 선택된 값
    const dispatchIdx = $("#dispatchIdx").val();
    const busIdx = $("#licensePlateSelect").val();
    const driverIdx = $("#driverSelect").val();
    const date = $("#operation_date").val();
    const shiftIdx = $(".shift").val();

    // 데이터 확인
    if (!busIdx || !driverIdx || !date || !shiftIdx) {
        alert("모든 필드를 채워주세요.");
        return;
    }

    // 전송 데이터 생성
    const formData = {
        dispatch_idx: dispatchIdx,
        bus_idx: busIdx,
        driver_idx: driverIdx,
        date: date,
        shift_idx: shiftIdx,
    };

    console.log("업데이트 데이터:", formData); // 디버깅용 로그

    // AJAX 요청
    $.ajax({
        url: "dispatchUpdate.ajax",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function (response) {
            console.log("서버 응답:", response); // 응답 로그

            if (response.success) {
                alert("수정이 완료되었습니다!");
                loadDispatchList(date); // 수정된 날짜로 리스트 갱신
            } else {
                alert(response.message || "수정에 실패했습니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("서버 오류:", xhr.responseText); // 오류 로그
            alert("서버와 통신 중 오류가 발생했습니다.");
        }
    });
});




    // 현재 날짜 설정 및 초기 데이터 로드
    const today = new Date();
    const $currentDate = $(".current-date");
    $currentDate.text(today.toISOString().split("T")[0]);
    $("#operation_date").val($currentDate.text()); // 초기화
    loadDispatchList($currentDate.text());

    // 날짜 이동 버튼 이벤트
    $(".date-button").on("click", function () {
        const currentDate = new Date($currentDate.text());
        const buttonClass = $(this).find("i").attr("class");

        if (buttonClass.includes("fa-angle-double-left")) {
            currentDate.setDate(currentDate.getDate() - 7);
        } else if (buttonClass.includes("fa-angle-left")) {
            currentDate.setDate(currentDate.getDate() - 1);
        } else if (buttonClass.includes("fa-angle-right")) {
            currentDate.setDate(currentDate.getDate() + 1);
        } else if (buttonClass.includes("fa-angle-double-right")) {
            currentDate.setDate(currentDate.getDate() + 7);
        }

        const newDate = currentDate.toISOString().split("T")[0];
        $currentDate.text(newDate);
        $("#operation_date").val(newDate); // 날짜 갱신
        loadDispatchList(newDate);
    });

    // 데이터 삽입 및 리스트 갱신
    $("#dispatchForm").on("submit", function (e) {
        e.preventDefault(); // 기본 동작 중지

        const formData = {
            bus_idx: $("#licensePlateSelect").val(),
            driver_idx: $("#driverSelect").val(),
            date: $("#operation_date").val(),
            shift_idx: $(".shift").val()
        };

        if (!$("#routeSelect").val() || !formData.bus_idx || !formData.driver_idx || !formData.date || !formData.shift_idx) {
            alert("모든 항목을 선택해주세요.");
            return;
        }

        $.ajax({
            url: "dispatchInsert.ajax",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function (response) {
                if (response.success) {
                    alert("배차 등록이 완료되었습니다!");
                    loadDispatchList(formData.date); // 삽입된 날짜로 리스트 갱신
                } else {
                    alert(response.message || "배차 등록에 실패했습니다.");
                }
            },
            error: function () {
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    });
};
