<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
<style>
/* 폴더 영역 스타일 */
.userbox {
    border: 1px solid #ddd; /* 선택적: 폴더 영역의 테두리 */
    padding: 15px;
    overflow-y: auto; /* 스크롤 */
    height: 100%;
}

/* 모달 스타일 */
.modalD {
    display: none;
    position: fixed; /* 뷰포트를 기준으로 중앙 정렬 */
    top: 50%; /* 화면의 세로 중앙 */
    left: 50%; /* 화면의 가로 중앙 */
    transform: translate(-50%, -50%); /* 정확히 가운데 위치하도록 이동 */
    background: rgba(0, 0, 0, 0.4); /* 배경 어둡게 처리 */
    z-index: 999; /* 모달창 위로 보이게 */
    width: 100%;
    height: 100%;
    justify-content: center;
    align-items: center;
}

/* 모달 다이얼로그 */
.modalD-dialog {
    max-width: 500px;
    width: 100%;
    background-color: #FFFBF2;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    padding: 20px;
    box-sizing: border-box;
}



.modalD-content {
    display: flex;
    flex-direction: column;
    gap: 20px; /* 검색창과 폴더 영역 간의 간격 */
}

#userBoxModal .modalD-content {
    background-color: #FFFBF2;
    border: none;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    padding: 20px;
    width: 40%;
    height: 50%;
    max-height: 50%; /* 높이를 화면의 80%로 제한 */
    overflow-y: auto; /* 높이를 초과할 경우 스크롤 생성 */
    box-sizing: border-box; /* 패딩과 경계를 포함한 너비/높이 계산 */
}


/* 상단 섹션: 사진과 기본 정보 */
.modalD-header-section {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
}

.modalD-photo {
    width: 120px;
    height: 120px;
    border-radius: 10px;
    border: 3px solid var(--primary-color);
    margin-right: 20px;
}

.modalD-basic-info {
    text-align: left;
}

.modalD-name {
    color: var(--primary-color);
    font-weight: bold;
    font-size: 1.5rem;
    margin: 0;
}

/* 사원 상세 모달 전용 스타일 */
#employeeModal {
    display: none;
    position: fixed; /* 뷰포트를 기준으로 중앙 정렬 */
    top: 50%; /* 화면의 세로 중앙 */
    left: 50%; /* 화면의 가로 중앙 */
    transform: translate(-50%, -50%); /* 정확히 중앙으로 이동 */
    z-index: 999; /* 최상위 레이어 */
}

#employeeModal .modalD-dialog {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 세로 중앙 */
    left: 50%; /* 가로 중앙 */
    transform: translate(-50%, -50%); /* 정확히 중앙으로 이동 */
    max-width: 500px; /* 최대 너비 */
    width: 100%;
    background-color: #FFFBF2; /* 밝은 배경 */
    border-radius: 12px; /* 모서리 둥글게 */
    padding: 20px;
    box-sizing: border-box; /* 패딩 포함 크기 계산 */
    overflow-y: auto; /* 내용 초과 시 스크롤 추가 */
    max-height: 80vh; /* 화면 높이의 80% 제한 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 */
}

/* 모달창 스크롤바 디자인 */
#employeeModal .modalD-dialog::-webkit-scrollbar {
    width: 8px; /* 스크롤바 너비 */
}

#employeeModal .modalD-dialog::-webkit-scrollbar-thumb {
    background-color: #30005A; /* 스크롤바 색상 */
    border-radius: 10px; /* 스크롤바 둥글게 */
}

#employeeModal .modalD-dialog::-webkit-scrollbar-track {
    background-color: #f0f0f0; /* 스크롤 트랙 색상 */
}

#employeeModal .modalD-content {
    background-color: #FFFBF2; /* 밝은 배경 */
    border-radius: 12px;
    padding: 20px;
    width: 100%;
    box-sizing: border-box;
}

#employeeModal .modalD-header-section {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
}

#employeeModal .modalD-photo {
    width: 120px;
    height: 120px;
    border-radius: 10px;
    border: 3px solid #30005A;
    margin-right: 20px;
}

#employeeModal .modalD-basic-info {
    text-align: left;
}

#employeeModal .modalD-name {
    color: #30005A;
    font-weight: bold;
    font-size: 1.5rem;
    margin: 0;
}

#employeeModal .modalD-status {
    color: #30005A;
    font-size: 1rem;
    margin: 5px 0;
}

#employeeModal .status-dot {
    display: inline-block;
    width: 12px;
    height: 12px;
    background-color: #00C851;
    border-radius: 50%;
    margin-right: 5px;
}

/* 테이블 스타일 */
#employeeModal .modalD-table-wrapper {
    margin-top: 10px;
    text-align: center;
}

#employeeModal .modalD-table {
    width: 100%;
    border-radius: 12px;
    border-collapse: collapse;
}


#employeeModal .modalD-table tr {
    border-bottom: 1px solid #8B6AA7;
}

#employeeModal .modalD-table td {
    padding: 12px 15px;
    font-size: 1rem;
    text-align: left;
    color: #30005A;
    background-color: #FFFBF2;
}

#employeeModal .modalD-label {
    background-color: #30005A;
    color: white;
    font-weight: bold;
    text-align: center;
}

#employeeModal .modalD-value {
    color: #30005A;
    text-align: left;
    background-color: #FFFBF2;
}

/* 닫기 버튼 */
#employeeModal .modalD-button {
    background-color: #E9396B;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    font-size: 1rem;
    margin-top: 10px;
}

#employeeModal .modalD-button:hover {
    background-color: #FF6373;
}



.status-dot {
    display: inline-block;
    width: 12px;
    height: 12px;
    background-color: #00C851;
    border-radius: 50%;
    margin-right: 5px;
}


/* 검색창 스타일 */
.search-bar-container {
    display: flex;
    position: relative;
    margin-bottom: 20px; /* 검색창과 아래 요소 간격 */
}

.search-bar {
    border: 2px solid #30005A;
    border-radius: 10px;
    padding: 10px 40px 10px 10px;
    width: 100%; /* 가로 크기를 채우도록 수정 */
    box-sizing: border-box;
}

.search-icon {
    position: absolute;
    right: 10px; /* 검색창 안에서 위치 */
    top: 50%;
    transform: translateY(-50%);
    color: #E9396B !important; /* 돋보기 색 */
    font-size: 18px;
    cursor: pointer;
}

.search-bar::placeholder {
    color: #aaa !important;
    font-style: italic !important;
    opacity: 1 !important;
}

#searchInput{
	margin: 0;
}


#closeUserBoxModal {
    background-color: #E9396B;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 8px;
    cursor: pointer;
    font-weight: bold;
    font-size: 1rem;
}

#closeUserBoxModal:hover {
    background-color: #FF6373;
}

</style>
</head>
<body>
<!-- 조직도 모달 -->
<div id="userBoxModal" class="modalD" style="display:none;">
    <div class="modalD-content">
        <div class="modalD-header">
        	사원검색
        	<button id="closeUserBoxModal" class="modalD-button" style="float: right;">닫기</button> <!-- 닫기 버튼 추가 -->
        </div>
        <div style="position: relative;">
		    <input type="text" id="searchInput" class="search-bar" placeholder="사원명을 검색하세요.">
		    <i class="fas fa-search search-icon"></i>
		</div>

        <div class="userbox">
            <!-- 폴더 구조 -->
        </div>
    </div>
</div>

<!-- 사원 상세 모달 -->
<div id="employeeModal" class="modalD">
    <div class="modalD-dialog">
        <div class="modalD-content">
            <div class="modalD-header-section">
                <img id="modalPhoto" src="" alt="직원 사진" class="modalD-photo">
                <div class="modalD-basic-info">
                    <h3 class="modalD-name">
                        <span id="modalName"></span> / <span id="modalRank"></span>
                    </h3>
                    <p class="modalD-status">
                        <span class="status-dot"></span> 근무 중
                    </p>
                </div>
            </div>
            <div class="modalD-table-wrapper">
                <table class="modalD-table">
                    <tr>
                        <td class="modalD-label">부서</td>
                        <td id="modalDepartment" class="modalD-value">운영 2팀</td>
                    </tr>
                    <tr>
                        <td class="modalD-label">이메일</td>
                        <td id="modalEmail" class="modalD-value">example@example.com</td>
                    </tr>
                    <tr>
                        <td class="modalD-label">전화번호</td>
                        <td id="modalPhone" class="modalD-value">02-123-4567</td>
                    </tr>
                    <tr>
                        <td class="modalD-label">핸드폰번호</td>
                        <td id="modalMobile" class="modalD-value">010-1234-5678</td>
                    </tr>
                </table>
            </div>
            <div style="text-align: right; margin-top: 20px;">
                <button id="closeEmployeeModal" class="modalD-button">닫기</button>
                <button id="addEmployeeButton" class="modalD-button">추가</button>
            </div>
        </div>
    </div>
</div>

</body>
<script>
$(document).ready(function () {
    var employees = []; // 사원 데이터를 저장할 배열
    var departments = []; // 부서 데이터를 저장할 배열
    var ranks = []; // 직급 데이터를 저장할 배열
    var routes = []; // 노선 데이터를 저장할 배열
    var selectedEmployee = null; // 현재 선택된 사원 정보 저장
    var selectedEmployees = [];  // 선택된 사원정보 쌓기.
    
    // 데이터 로드
    function loadData() {
        $.when(
            $.ajax({
                method: 'POST',
                url: 'orgStruct.ajax',
                dataType: 'JSON',
                data: { table: 'department' },
                success: function (list) {
                    departments = list;
                }
            }),
            $.ajax({
                method: 'POST',
                url: 'orgStruct.ajax',
                dataType: 'JSON',
                data: { table: 'rank_emp' },
                success: function (list) {
                    ranks = list;
                }
            }),
            $.ajax({
                method: 'POST',
                url: 'orgStruct.ajax',
                dataType: 'JSON',
                data: { table: 'route' },
                success: function (list) {
                    routes = list;
                }
            }),
            $.ajax({
                method: 'POST',
                url: 'orgChart.ajax',
                dataType: 'JSON',
                success: function (list) {
                    employees = list;
                }
            })
        ).then(function () {
            generateFolders();
        });
    }

    // 폴더 생성
    function generateFolders() {
        var userbox = $(".userbox");
        userbox.empty(); // 기존 폴더 초기화

        // 부서별 폴더 생성
        $.each(departments, function (deptIndex, dept) {
            var deptFolder = $('<div class="folder">' +
                '<span class="folder-icon">📁</span> ' + dept.depart_name +
                '<div class="subfolders" style="display:none;"></div>' +
                '</div>');

            var deptSubfolders = deptFolder.find(".subfolders");

            if (dept.depart_idx === 4) {
                // 기사팀인 경우 버스 팀별로 정리
                $.each(routes, function (routeIndex, route) {
                    var teamFolder = $('<div class="folder">' +
                        '<span class="folder-icon">🚍</span> ' + route.route_name +
                        '<div class="subfolders" style="display:none;"></div>' +
                        '</div>');

                    var teamSubfolders = teamFolder.find(".subfolders");

                    // 팀에 속한 사원 추가
                    $.each(employees, function (empIndex, emp) {
                        if (emp.route_name === route.route_name && emp.depart_idx === 4) {
                            var empDiv = $('<div class="folder" data-id="' + emp.emp_idx + '">' +
                                '<span class="folder-icon">👤</span> ' + emp.name +
                                '</div>');
                            teamSubfolders.append(empDiv);
                        }
                    });

                    // 팀에 사원이 있을 경우에만 추가
                    if (teamSubfolders.children().length > 0) {
                        deptSubfolders.append(teamFolder);
                    }
                });
            } else {
                // 일반 부서의 경우 직급별로 정리
                $.each(ranks, function (rankIndex, rank) {
                    var rankFolder = $('<div class="folder">' +
                        '<span class="folder-icon">📂</span> ' + rank.rank_name +
                        '<div class="subfolders" style="display:none;"></div>' +
                        '</div>');

                    var rankSubfolders = rankFolder.find(".subfolders");

                    // 직급별 사원 추가
                    $.each(employees, function (empIndex, emp) {
                        if (emp.rank_idx === rank.rank_idx && emp.depart_idx === dept.depart_idx) {
                            var empDiv = $('<div class="folder" data-id="' + emp.emp_idx + '">' +
                                '<span class="folder-icon">👤</span> ' + emp.name +
                                '</div>');
                            rankSubfolders.append(empDiv);
                        }
                    });

                    // 직급 폴더에 사원이 있을 경우에만 추가
                    if (rankSubfolders.children().length > 0) {
                        deptSubfolders.append(rankFolder);
                    }
                });
            }

            // 부서 폴더를 사용자 박스에 추가
            userbox.append(deptFolder);
        });

        bindFolderEvents();
    }

    // 폴더 이벤트 바인딩
    function bindFolderEvents() {
        $(".userbox").on("click", ".folder", function (e) {
            e.stopPropagation(); // 이벤트 전파 방지
            $(this).children(".subfolders").slideToggle(); // 하위 폴더 토글
        });

        $(".userbox").on("click", ".folder[data-id]", function (e) {
            e.stopPropagation();
            var empId = $(this).data("id");
            var employee = employees.find(emp => emp.emp_idx === empId);
            if (employee) {
                showEmployeeModal(employee);
            }
        });

    }

    // 검색 함수
    function executeSearch() {
        var searchKeyword = $('#searchInput').val().trim(); // 검색어 읽기
        if (!searchKeyword) {
            alert('검색어를 입력해주세요.');
            return;
        }
        var employee = employees.find(emp => emp.name.includes(searchKeyword));
        if (employee) {
            showEmployeeModal(employee); // 검색된 사원 정보 표시
        } else {
            alert('검색된 사원이 없습니다.');
        }
    }

    // 사원 상세 정보 모달 표시
    function showEmployeeModal(employee) {
    	window.selectedEmployee = employee; // 선택된 사원 정보를 저장
        $("#modalPhoto").attr("src", "/photo/" + (employee.photo || "default_photo.jpg"));
        $("#modalName").text(employee.name);
        $("#modalRank").text(employee.rank_name);
        $("#modalDepartment").text(employee.depart_name);
        $("#modalEmail").text(employee.email);
        $("#modalPhone").text(employee.phone);
        $("#modalMobile").text(employee.mobile);
        $("#employeeModal").fadeIn();
    }

    $("#closeEmployeeModal").on("click", function () {
        $("#employeeModal").fadeOut();
    });

    // 검색 모달의 검색 버튼
    $('.search-icon').on('click', function () {
        executeSearch();
    });

    $('#searchInput').on('keyup', function (e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
            executeSearch();
        }
    });
    
    
    // 닫기 버튼 이벤트
    $("#closeEmployeeModal").on("click", function () {
        $("#employeeModal").fadeOut();
    });

 	// 추가 버튼 이벤트
    $("#addEmployeeButton").on("click", function () {
	    if (selectedEmployee) {
	    	console.log("추가된 사원 정보:", selectedEmployee);
	    	window.selectedEmployee = selectedEmployee;
	        // 배열에 이미 존재하는지 확인
	        var isDuplicate = selectedEmployees.some(emp => emp.emp_idx === selectedEmployee.emp_idx);

	        if (!isDuplicate) {
	            // 중복이 아니면 추가
	            selectedEmployees.push(selectedEmployee);
	            console.log("현재까지 추가된 사원목록:", selectedEmployees);
	        } else {
	            console.log("이미 추가된 사원입니다:", selectedEmployee.name);
	        }

	        $(".modalD").fadeOut();
	        
	    } else {
	        console.error("선택된 사원 정보가 없습니다.");
	    }
	});
    

    loadData();
});

function openUserBoxModal() {
    $("#userBoxModal").css("display", "flex").hide().fadeIn();
}

function openEmployeeModal(employee) {
    // 직원 정보를 받아와 모달에 데이터를 세팅
    $("#modalPhoto").attr("src", "/photo/" + (employee.photo || "default_photo.jpg"));
    $("#modalName").text(employee.name);
    $("#modalRank").text(employee.rank_name);
    $("#modalDepartment").text(employee.depart_name);
    $("#modalEmail").text(employee.email);
    $("#modalPhone").text(employee.phone);
    $("#modalMobile").text(employee.mobile);

    $("#employeeModal").css("display", "flex").hide().fadeIn();
}

/* function closeModals() {
    $(".modalD").fadeOut();
} */


//초창기 모달 닫기 버튼 이벤트
$("#closeUserBoxModal").on("click", function () {
    $("#userBoxModal").fadeOut(); // userBoxModal 닫기
});

// 기존의 employeeModal 닫기 이벤트 유지
$("#closeEmployeeModal").on("click", function () {
    $("#employeeModal").fadeOut(); // employeeModal만 닫기
});
</script>
</html>
