<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
:root {
	--primary-color: #30005A;
	--secondary-color: #8B6AA7;
	--accent-color: #E9396B;
	--background-color: #FFFBF2;
}

.dashboard-body {
	margin-left: 14vw;
	width: 85vw;
	margin-top: 7vh;
	flex-wrap: wrap;
	padding: 2vh;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-content: center;
	align-items: flex-start;
	justify-content: center;
}

.textbox {
	position: relative;
	display: flex;
	width: 100%;
	height: 10%;
	align-items: center;
	justify-content: space-between;
}

.maintext {
	display: flex;
	margin-left: 0.625rem;
}

.document {
	color: var(--secondary-color);
	margin-right: 1.875rem;
	margin-bottom: 1.75rem;
}

.mainbox {
	display: flex;
	width: 100%;
	height: 90%;
}
/* 
.userbox {
	border: 2px solid var(--primary-color);
	width: 16%;
	height: 90%;
	border-radius: 0.625rem;
    padding: 1% !important;
}
 */
.userbox {
    border: 2px solid var(--primary-color);
    width: 16%;
    height: 90%;
    border-radius: 0.625rem;
    padding: 1% !important;
    overflow-y: auto; /* 세로 스크롤바 추가 */
    overflow-x: hidden; /* 가로 스크롤 숨김 */
    scrollbar-width: thin; /* 스크롤바 두께를 얇게 설정 (Firefox) */
}

/* 웹킷 브라우저 (Chrome, Edge, Safari)용 스크롤바 스타일 */
.userbox::-webkit-scrollbar {
    width: 8px; /* 스크롤바 너비 */
}

.userbox::-webkit-scrollbar-thumb {
    border-radius: 10px; /* 스크롤바 둥글게 */
}

.userbox::-webkit-scrollbar-track {
    background: var(--background-color); /* 스크롤바 배경 */
}


.contentbox {
	position: relative;
	border: 2px solid var(--primary-color);
	width: 84%;
	height: 90%;
	border-radius: 0.625rem;
	margin-left: 0.5rem;
    padding: 3% !important;
}

.docnav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 0 3rem;
	padding: 0 0.3125rem;
}

.fa-arrow-alt-circle-left {
	font-size: 20px;
	margin: 5px;
}

.fa-arrow-alt-circle-left:hover {
	cursor: pointer;
	font-weight: bold;
}

/* 기본 폴더 스타일 */
.folder {
    cursor: pointer;
    margin-bottom: 10px;
    padding: 5px;
    position: relative;
    background-color: transparent;
    transition: background-color 0.3s ease;
}


/* 하위 폴더 스타일 */
.folder .subfolders {
    margin-left: 20px;
}


/* 기존 스타일 */
#tooltipContainer {
	padding: 15px;
	background-color: #f9f9f9;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	max-width: 300px;
	margin-top: 20px;
	font-family: Arial, sans-serif;
}

.tooltip {
	background-color: #ffffff;
	padding: 12px;
	margin-bottom: 10px;
	border-left: 5px solid #ffcc00;
	border-radius: 6px;
	cursor: pointer;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, background-color 0.3s ease;
}

.tooltip div {
	font-size: 14px;
	color: #333;
	margin: 5px 0;
	cursor: pointer;
	transition: color 0.2s ease;
}

.tooltip div:hover {
	color: #ff9900;
}

.tooltip .phone, .tooltip .email {
	font-weight: bold;
	color: #007BFF;
}

.tooltip div:active {
	color: #ff5733;
}

.google-visualization-orgchart-node-medium {
	border: none !important;
	background: var(--primary-color) !important;
	color: white;
	
	/* width: 11%; */
}

.google-visualization-orgchart-table {
    border-spacing: 15px !important; /* 테이블 전체 간격 조정 */
}

.google-visualization-orgchart-linebottom {
    border-bottom: 1px solid var(--primary-color) !important;
}
.google-visualization-orgchart-lineleft {
    border-left: 1px solid var(--primary-color) !important;
}
.google-visualization-orgchart-lineright{
	border-right: 1px solid var(--primary-color) !important;
}


.emp{
	border-radius: 3px;
	color:var(--primary-color); 
	background: white;
	height: fit-content;
}


.google-visualization-orgchart-node-medium:has(.rank-node) {
    background-color: #6A4C93 !important;
}

.google-visualization-orgchart-node-medium:has(.emp-node) {
    /* .emp-node 요소를 포함한 부모 요소에 스타일 적용 */
    background-color: #8B6AA7 !important;
}


@media ( max-width : 960px) {
	.dashboard-body {
		transform: scale(0.8);
		margin-left: 17vw;
		width: 93vw;
	}
	.opt {
		width: 60%;
		flex-wrap: wrap;
	}
	.searchbox {
		width: 40%;
	}
	.editbtn {
		width: 100%;
		margin-top: 10px;
	}
	table {
		margin: 0 10px 55px 10px;
	}
}


/* 모달창 CSS */
/* 전체 모달 스타일 */
/* 모달 전체 스타일 */
.modal {
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4); /* 배경 어둡게 처리 */
    z-index: 1050; /* 모달창이 위에 보이도록 설정 */
}

/* 모달 다이얼로그 */
.modal-dialog {
    position: relative;
    max-width: 500px;
    margin: auto;
    transform: translateY(-50%);
    top: 50%;
}


.modal-content {
    background-color: #FFFBF2;
    border: none;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    max-width: 500px;
    margin: auto;
    padding: 20px;
}

/* 상단 섹션: 사진과 기본 정보 */
.modal-header-section {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
}

.modal-photo {
    width: 120px;
    height: 120px;
    border-radius: 10px;
    border: 3px solid #30005A;
    margin-right: 20px;
}

.modal-basic-info {
    text-align: left;
}

.modal-name {
    color: #30005A;
    font-weight: bold;
    font-size: 1.5rem;
    margin: 0;
}

.modal-status {
    color: #30005A;
    font-size: 1rem;
    margin: 5px 0;
}

.status-dot {
    display: inline-block;
    width: 12px;
    height: 12px;
    background-color: #00C851;
    border-radius: 50%;
    margin-right: 5px;
}

/* 하단 테이블 섹션 */
.modal-table-wrapper {
    margin-top: 10px;
    text-align: center;
}

/* 테이블 전체 스타일 */
/* 테이블 스타일 */
.modal-table {
    width: 100%;
    border: 2px solid #8B6AA7; /* 바깥쪽 테두리 */
    border-radius: 12px; /* 바깥 테두리 둥글게 */
    border-collapse: separate; /* 테두리 겹침 방지 */
    border-spacing: 0; /* 셀 간 간격 제거 */
    overflow: hidden; /* 내용 넘침 방지 */
}

.modal-table tr {
    border-bottom: 1px solid #8B6AA7; /* 행 구분선 */
}

.modal-table tr:last-child {
    border-bottom: none; /* 마지막 행은 구분선 제거 */
}

.modal-table td {
    padding: 12px 15px;
    font-size: 1rem;
    border: 1px solid #8B6AA7; /* 셀 안쪽 테두리 */
    background-color: #FFFBF2; /* 셀 배경색 */
}

.modal-label {
    background-color: #30005A !important; /* 라벨 배경색 유지 */
    color: white !important; /* 라벨 글자색 */
    font-weight: bold;
    text-align: center;
    border-right: 1px solid #8B6AA7; /* 라벨과 값 구분선 */
}

.modal-value {
    color: #30005A;
    text-align: left;
    background-color: #FFFBF2; /* 값 배경 */
}


.bi-box-arrow-in-right, .fa-id-card{
	font-size: 12px;
	color: white;
}



.backBtn{
	all: unset; /* 기본 스타일 모두 초기화 */
    box-shadow: none; /* 그림자 제거 */
    display: inline-block; /* 버튼 형태 유지 */
    padding: 1%; /* 버튼 패딩 */
    background-color: #E9396B;
    border: 3px solid #E9396B;
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 클릭 가능한 포인터 */
    font-size: 16px;
    color: #FFFBF2;
	
}


.search-bar {
    border: 2px solid #30005A;
    border-radius: 10px;
    padding: 10px 40px 10px 10px;
    width: 300px;
    margin: 0 auto; /* 가운데 정렬 */
    display: block;
}

.search-icon {
    position: absolute;
    right: calc(50% - 140px); /* 검색창 중앙 정렬에 맞춰 아이콘 위치 조정 */
    top: 50%;
    transform: translateY(-50%);
    color: #E9396B; /* 돋보기 색 */
    font-size: 18px;
    cursor: pointer;
}

.search-bar::placeholder {
    color: #aaa !important;
    font-style: italic !important;
    opacity: 1 !important;
}


</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<jsp:include page="../modal/modal.jsp"></jsp:include>
	
<!-- 모달창 -->
<div id="employeeModal" class="modal" tabindex="-1" role="dialog" style="display:none;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <!-- 상단: 프로필 이미지 및 기본 정보 -->
        <div class="modal-header-section">
          <img id="modalPhoto" src="" alt="직원 사진" class="modal-photo">
          <div class="modal-basic-info">
            <h3 class="modal-name"><span id="modalName"></span> / <span id="modalRank"></span></h3>
            <p class="modal-status">
              <span class="status-dot"></span> 근무 중
            </p>
          </div>
        </div>

        <!-- 하단: 상세 정보 테이블 -->
        <div class="modal-table-wrapper">
          <table class="modal-table">
            <tr>
              <td class="modal-label">부서</td>
              <td id="modalDepartment" class="modal-value">운영 2팀</td>
            </tr>
            <tr>
              <td class="modal-label">이메일</td>
              <td id="modalEmail" class="modal-value">chockchock@gmail.com</td>
            </tr>
            <tr>
              <td class="modal-label">전화번호</td>
              <td id="modalPhone" class="modal-value">02-336-3333</td>
            </tr>
            <tr>
              <td class="modal-label">핸드폰번호</td>
              <td id="modalMobile" class="modal-value">010-1234-1234</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>




		
	
	
	<div class="dashboard-body">
		<div class="textbox">
			<div class="maintext">
				<h3 class="document">조직도</h3>
				<h3>>&nbsp;&nbsp;조직도</h3>
			</div>
			<div style="position: relative;">
		        <input type="text" class="search-bar" placeholder="사원명을 검색하세요.">
		        <i class="fas fa-search search-icon"></i>
	        </div>
		</div>
		
		<div class="mainbox">
			<div class="userbox">
			<!-- 폴더 계층구조 들어가는 곳 -->
			</div>
			<div class="contentbox">
				<div id="chart_div"></div>
			</div>
		</div>
	</div>
</body>
<script>
/* 전역변수 */
var orgChartHistory = []; // 조직도 상태를 저장할 스택

//전역에 drawChart 선언
var drawChart;
var drawTeamChart;

var isDepartmentsLoaded = false; // 부서 데이터 로드 상태 플래그
var isRanksLoaded = false;      // 직급 데이터 로드 상태 플래그
var isEmployeesLoaded = false; // 사원 데이터 로드 상태 플래그
var isRoutesLoaded = false; // 사원 데이터 로드 상태 플래그
var isteamEmpLoaded = false; // 사원 데이터 로드 상태 플래그

var departments = []; // 부서 데이터를 저장할 배열
var ranks = [];       // 직급 데이터를 저장할 배열
var routes = [];       // 노선 데이터를 저장할 배열
var employees = [];   // 사원 데이터를 저장할 배열
var teamEmp = [];   // 사원 데이터를 저장할 배열
var nodeInfo = {};    // 조직도 노드 정보를 저장할 객체
var routeNames = [];   // 기사부서 팀정보
var groupedRoutes = []; // 기사부서 팀별 직원그룹

var departIdx;      // 부서idx
var routeName = '';     // 버스경로이름

$(document).ready(function () {
    
    /* Google Charts 초기화 */
    google.charts.load('current', { packages: ["orgchart"] });
	google.charts.setOnLoadCallback(function () {
	    console.log("Google Charts 로드 완료");
	
	    // 부서, 직급, 직원 데이터를 로드
	    loadDepartments();
	    loadRanks();
	    loadRoutes();
	    loadEmployees();
	
	    // 데이터가 모두 로드된 후 drawChart 호출
	    checkAndGenerate();
	});

    /* 부서 데이터 로드 함수 */
    function loadDepartments() {
        $.ajax({
            method: 'POST',
            url: 'orgStruct.ajax',
            dataType: 'JSON',
            data: { table: 'department' },
            success: function (list) {
            	console.log("부서 데이터 로드 성공:", list);
            	$.each(list, function(index, item) {
            	    departments.push({ 
            	    	id: item.depart_idx, 
            	    	name: item.depart_name 
           	    	});
            	});

                isDepartmentsLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(); // 데이터 로드 상태 확인
            },
            error: function () {
                modal.showAlert('부서 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }

    /* 직급 데이터 로드 함수 */
    function loadRanks() {
        $.ajax({
            method: 'POST',
            url: 'orgStruct.ajax',
            dataType: 'JSON',
            data: { table: 'rank_emp' },
            success: function (list) {
            	console.log("직급 데이터 로드 성공:", list);
            	$.each(list, function(index, item) {
            		ranks.push({ 
            	    	id: item.rank_idx, 
            	    	name: item.rank_name 
           	    	});
            	});
            	
                isRanksLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(); // 데이터 로드 상태 확인
            },
            error: function () {
            	modal.showAlert('직급 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }

    /* 노선 데이터 로드 함수 */
    function loadRoutes() {
        $.ajax({
            method: 'POST',
            url: 'orgStruct.ajax',
            dataType: 'JSON',
            data: { table: 'route' },
            success: function (list) {
            	console.log("노선 데이터 로드 성공:", list);
            	$.each(list, function(index, item) {
            		routes.push({ 
            	    	id: item.route_idx, 
            	    	name: item.route_name 
           	    	});
            	});
            	
            	isRoutesLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(); // 데이터 로드 상태 확인
            },
            error: function () {
            	modal.showAlert('노선 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }
    

    /* 사원 데이터 로드 함수 */
    function loadEmployees() {
        $.ajax({
            method: 'POST',
            url: 'orgChart.ajax',
            dataType: 'JSON',
            data: {
            },
            success: function (list) {
            	console.log("사원 데이터 로드 성공:", list);
            	// 조직도를 그리기 위한 값 저장.
            	$.each(list, function(index, item) {
            		employees.push({ 
            			id: item.emp_idx,
                        name: item.name,
                        rankId: item.rank_idx,
                        rank: item.rank_name,
                        departmentId: item.depart_idx,
                        department: item.depart_name,
                        route_name: item.route_name
           	    	});
            		
            		
            		// 노드 정보를 nodeInfo 객체에 저장
                    nodeInfo[item.emp_idx] = {
                        name: item.name,
                        phone: item.phone,
                        email: item.email,
                        status: item.state,
                        department: item.depart_name,
                        rank: item.rank_name,
                        mobile: item.mobile,
                        photo: item.photo
                    };
            	});
            	

                isEmployeesLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(0); // 데이터 로드 상태 확인
            },
            error: function () {
            	modal.showAlert('사원 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }

    
    /* 부서별 사원 데이터 로드 함수 */
    function loadTeamEmp() {
		
    	// 이미 데이터가 로드된 경우, 다시 호출하지 않도록 차단
        if (isteamEmpLoaded) {
            console.log("부서별 사원 데이터는 이미 로드되었습니다.");
            return;
        }
    	
    	isteamEmpLoaded = false; // 항상 데이터를 다시 로드
        
    	$.ajax({
            method: 'POST',
            url: 'orgChart.ajax',
            dataType: 'JSON',
            data: {
            	depart_idx: departIdx,
            	route_name: routeName
            },
            success: function (list) {
            	console.log("부서별 사원 데이터 로드 성공:", list);
            	
            	// 조직도를 그리기 위한 값 저장. 
            	
            	teamEmp = []; // 이전 데이터 초기화
            	
            	$.each(list, function(index, item) {
            		teamEmp.push({ 
            			id: item.emp_idx,
                        name: item.name,
                        rankId: item.rank_idx,
                        rank: item.rank_name,
                        departmentId: item.depart_idx,
                        department: item.depart_name,
                        route_name: item.route_name
           	    	});
            		
            	});

                isteamEmpLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(1); // 데이터 로드 상태 확인
            },
            error: function () {
            	modal.showAlert('사원 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }


    /* 데이터 로드 상태 확인 함수 */
    // 모든 데이터를 불러왔다면, 폴더와 차트 생성.
    function checkAndGenerate(empType) {
    	
    	var checkEmpType = empType == 0 
    		? isDepartmentsLoaded && isRanksLoaded && isEmployeesLoaded && isRoutesLoaded
 			: isDepartmentsLoaded && isRanksLoaded && isEmployeesLoaded && isteamEmpLoaded && isRoutesLoaded 
    	
		if (!checkEmpType) {
	        console.log("데이터가 아직 로드되지 않았습니다.");
	        return;
	    }
 			
    	if (checkEmpType) {
            if (empType === 0) {
                generateFolders(); // 폴더 생성
                drawChart();       // 조직도 차트 생성
            } else {
                drawTeamChart();   // 부서 또는 팀별 조직도 차트생성
            }
        }

    }

    
    
    /* 폴더 생성 함수 */
function generateFolders() {
    var userbox = $(".userbox");
    userbox.empty(); // 기존 폴더 초기화

    // 부서별 폴더 생성
    $.each(departments, function (deptIndex, dept) {
        var deptFolder = $('<div class="folder">' +
            '<span class="folder-icon">📁</span> ' + dept.name +
            '<div class="subfolders" style="display:none;"></div>' +
            '</div>');

        var deptSubfolders = deptFolder.find(".subfolders");

        if (dept.id === 4) {
            // 기사팀인 경우 버스 팀별로 정리
            $.each(routes, function (routeIndex, route) {
                var teamFolder = $('<div class="folder">' +
                    '<span class="folder-icon">🚍</span> 버스 ' + route.id + '팀' +
                    '<div class="subfolders" style="display:none;"></div>' +
                    '</div>');

                var teamSubfolders = teamFolder.find(".subfolders");

                // 팀에 속한 사원 추가
                $.each(employees, function (empIndex, emp) {
                    if (emp.route_name === route.name && emp.departmentId === 4) {
                        var empDiv = $('<div class="folder" data-id="' + emp.id + '">' +
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
            // 일반 부서의 경우 기존 방식 유지
            $.each(ranks, function (rankIndex, rank) {
                var rankFolder = $('<div class="folder">' +
                    '<span class="folder-icon">📂</span> ' + rank.name +
                    '<div class="subfolders" style="display:none;"></div>' +
                    '</div>');

                // 직급별 사원 추가
                $.each(employees, function (empIndex, emp) {
                    if (emp.rankId === rank.id && emp.departmentId === dept.id) {
                        var empDiv = $('<div class="folder" data-id="' + emp.id + '">' +
                            '<span class="folder-icon">👤</span> ' + emp.name +
                            '</div>');
                        rankFolder.find(".subfolders").append(empDiv);
                    }
                });

                // 직급 폴더에 사원이 있을 경우에만 추가
                if (rankFolder.find(".subfolders").children().length > 0) {
                    deptSubfolders.append(rankFolder);
                }
            });
        }

        // 부서 폴더를 사용자 박스에 추가
        userbox.append(deptFolder);
    });

    console.log("폴더 생성 완료");
    bindFolderEvents(); // 폴더 이벤트 바인딩
}




    
    
    /* 폴더 이벤트 바인딩 함수 */
    function bindFolderEvents() {
        $(".userbox").on("click", ".folder", function (e) {
            e.stopPropagation(); // 이벤트 전파 방지
            $(this).children(".subfolders").slideToggle(); // 하위 폴더 토글
        });
        
        
        // 폴더영역의 사원이름 클릭시 해당노드로 이동.
        $(".userbox").on("click", ".folder", function (e) {
            e.stopPropagation(); // 이벤트 전파 방지

            // 사원 ID 가져오기
            var empId = $(this).data("id");

            if (empId) {
                // ID를 사용하여 사원 검색
                var employee = employees.find(emp => emp.id == empId);

                if (employee) {
                    console.log("찾은 사원:", employee);
                    
                    // 값 초기화
                    departIdx = employee.departmentId;
                    routeName = employee.route_name || '';

                    // 데이터 로드 및 차트 생성
                    isteamEmpLoaded = false; // 초기화
                    loadTeamEmp();
                } else {
                    console.error("사원을 찾을 수 없습니다: ID=", empId);
                }
            }
        });
        
    }
    


    
    
    
    
    /* 조직도 차트 생성 함수 */
/*      function drawChart(){ */
 	 drawChart = function (){
    	
    	$("#backButton").remove(); // 뒤로가기 버튼 제거 (초기 조직도에서는 표시되지 않음)
    	
    	
    	// 초기화: 부서 및 팀 상세 보기 관련 변수들
        departIdx = null; // 부서 idx 초기화
        routeName = '';   // 팀 이름 초기화
        isteamEmpLoaded = false; // 부서별 사원 데이터 로드 상태 초기화
    	
    	
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Node ID'); // 노드 ID
        data.addColumn('string', 'Parent Node ID'); // 부모 노드 ID
        data.addColumn('string', 'ToolTip Info'); // 툴팁 정보
        
        var rows = [];

	    // 1. 맨처음 노드 => 대표정보 세팅
	    var ceo = employees[0];
       	rows.push([
       		{ 
	        	v: '1',
	     		f: '대표<i class="fas fa-id-card"></i><div class="emp">' +ceo.name+ '</div>' 
     		}, 
        	'', 
        	'부서: ' + ceo.department
   	     ]);
	    	
	    	
       	// 2. 부서정보, 부서장 정보 추가 
       	$.each(departments, function (deptIndex, dept) {
       		// 조직도에 노드 생성하기
    	    var deptNodeId = '';
    	    var beforeRankNodeId = '';
    	    var afterRankNodeId = '';
       		
    	    // 부서장을 찾기위한 변수
       		var managerId;           // 부서장 idx를 담을 변수
        	var managerName = '';    // 부서장 이름을 담을 변수
        	var managerRankId;       // 부서장 직급을 담을 변수
        	var managerIndex = 0;       
        	
        	// 부서의 최상급자를 찾기위한 변수
        	var highId = 999;                  
        	var highName = '';
        	var highRankId = 999; 
        	var highIndex = 0; 
        	
       		
       		// 부서정보 추가
       	    deptNodeId = "dept-" + dept.id;    // 부서idx
			
       	    // 팀장정보 찾기 (팀장이 없는경우 해당 부서의 최상급자)
	        $.each(employees, function (empIndex, emp) {
	        	
	        	if (emp.departmentId === dept.id){ // 같은부서인 직원
	        		
	        		// 팀장인 경우 부서장으로 세팅
		        	if(emp.rankId === 3){
		        		managerId = emp.id;
			        	managerName = emp.name;	
			        	managerRankId = emp.rankId;	
			        	managerIndex = deptIndex;
		        	}
	        	
        			// 부서의 최상급자 찾기 
        			if(emp.rankId < highRankId){
	        			highId = emp.id;
	        			highName = emp.name;	
	        			highRankId = emp.rankId;		
	        			highIndex = deptIndex;
        			}
	        	}
	        	
	        });
	            
	        
	        // 팀장이 없는경우 부서의 최상급자 세팅.
	        if (!managerId || managerId == 999) {
	        	managerId = highId;
	        	managerName = highName;	
	        	managerRankId = highRankId;	
	        }
	        
	        
	        // 팀원이 한명도 없는경우
	        if(!managerId || managerId == 999){
	        	managerName = '<span style="color: #E9396B;">인원수 0</span>';
	        }
	        
	        
	        
	        // 기사팀이 아닌 경우만 아이콘 추가
	        var iconHtml = dept.id === 4 ? '' : '<i class="bi bi-box-arrow-in-right"></i>';
	        
	        // 부서 및 부서장 노드생성.
            rows.push([
                {
                	v: deptNodeId,
                	f: dept.name + iconHtml + '<div class="emp">' +managerName+ '</div>' 
                },
                '1',                             // 상위 노드는 '대표'
    	        '부서: ' + dept.name              // 툴팁 정보
            ]);

	        
	        // 기사부서인 경우 버스팀 노드 생성.
	        if(dept.id === 4){
	        	$.each(routes, function(teamIdx, route){
	    			
	        		var teamNodeId = "team-" + route.name;
	        		var team = '버스 ' + route.id + '팀';
	        		
	        		rows.push([
		                { 
		                    v: teamNodeId, 
		                    f: team + '<i class="bi bi-box-arrow-in-right"></i><div class="emp">' + route.name + '</div>'
		                },
		                deptNodeId, // 상위 노드는 해당 부서
		                "팀: " + team  // 툴팁 정보
		            ]);
	        	});
	        } 
	        
       	});

        data.addRows(rows);
        console.log("조직도에 추가된 데이터:", data.toJSON());
        

        // 조직도 그리기
        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        chart.draw(data, { 
        	allowHtml: true,
        });

        
        // 노드 클릭 이벤트 처리
        google.visualization.events.addListener(chart, 'select', function () {
            var selection = chart.getSelection();
            if (selection.length > 0) {
                var selectedNode = selection[0];
                var nodeId = data.getValue(selectedNode.row, 0);

                if (nodeId.startsWith("dept-")) {
                    // 부서 노드 클릭 처리
                    var deptId = parseInt(nodeId.split("-")[1]);
                    if (deptId === 4) {
                        // 기사부서 클릭 시 동작 없음
                    } else {
                        // 일반 부서 클릭 시 departIdx 설정
                        departIdx = deptId;
                        drawTeamChart(); // 부서 조직도 상세보기
                    }
                } else if (nodeId.startsWith("team-")) {
                    // 팀 노드 클릭 처리
                    var teamName = nodeId.split("-")[1];
                    departIdx = 4; // 기사부서의 경우 departIdx 고정
                    routeName = teamName; // routeName 설정
                    drawTeamChart(); // 부서 조직도 상세보기
                } else {
                    // 직원 노드 클릭 시 모달 열기
                    if (nodeInfo[nodeId]) {
                        openModal(nodeInfo[nodeId]);
                    }
                }
            }
            
        });

    }
    
    
    
    
    
// 부서 또는 팀별 조직도 상세보기  
/* function Chart() { */
drawTeamChart = function () {
    loadTeamEmp(); // 부서 또는 팀의 데이터 로드
    
    var data = new google.visualization.DataTable();
    data.addColumn("string", "Node ID");
    data.addColumn("string", "Parent Node ID");
    data.addColumn("string", "ToolTip Info");

    var rows = [];

 	// 조직도 데이터 생성
    if (departIdx !== 4) {
        // 부서 상세보기
        var department = departments.find(dept => dept.id === departIdx);
        if (!department) {
            console.error("해당 부서를 찾을 수 없습니다:", departIdx);
            return;
        }

        // 부서 노드 추가
        var departmentNodeId = "dept-" + department.id;
        rows.push([
            { 
            	v: departmentNodeId, 
            	f: "부서<div class='emp'>" +department.name+ "</div>"
            },
            "",
            "부서: " + department.name
        ]);

        // 직급별로 그룹화 후 추가
        var groupedByRank = {};
        teamEmp.forEach(emp => {
            if (emp.departmentId === departIdx) {
                if (!groupedByRank[emp.rank]) groupedByRank[emp.rank] = [];
                groupedByRank[emp.rank].push(emp);
            }
        });

        addRankAndEmployeeNodes(rows, groupedByRank, departmentNodeId);
    } else if (departIdx === 4 && routeName) {
        // 기사팀 상세보기
        var teamNodeId = "team-" + routeName;

        var route = routes.find(r => r.name === routeName); // routeName과 일치하는 route 객체 검색
        var team = '버스 ' + route.id + '팀'; // route.id와 route.name 사용
        
        // 팀 노드 추가
        rows.push([
            { 
            	v: teamNodeId, 
            	f: team + "<div class='emp'>" +routeName+ "</div>" 
            },
            "",
            "팀: " + routeName
        ]);

        // 직급별로 그룹화 후 추가
        var groupedByRank = {};
        teamEmp.forEach(emp => {
            if (emp.route_name === routeName) {
                if (!groupedByRank[emp.rank]) groupedByRank[emp.rank] = [];
                groupedByRank[emp.rank].push(emp);
            }
        });

        addRankAndEmployeeNodes(rows, groupedByRank, teamNodeId);
    } else {
        console.error("올바른 departIdx 또는 routeName이 설정되지 않았습니다.");
        return;
    }

    data.addRows(rows);
    
    
    var chart = new google.visualization.OrgChart(document.getElementById("chart_div"));
    chart.draw(data, { 
    	allowHtml: true,
    });


 	// 노드 클릭 이벤트 처리
    google.visualization.events.addListener(chart, 'select', function () {
	    var selection = chart.getSelection();
	    if (selection.length > 0) {
	        var selectedNode = selection[0];
	        var nodeId = data.getValue(selectedNode.row, 0);
	
	        // nodeId에서 'emp-' 접두사 제거
	        if (nodeId.startsWith('emp-')) {
	            var employeeId = nodeId.replace('emp-', '');
	
	            // nodeInfo에서 직원 정보 검색
	            if (nodeInfo[employeeId]) {
	                openModal(nodeInfo[employeeId]);
	            } else {
	                console.warn("nodeInfo에 직원 정보가 없습니다:", employeeId);
	            }
	        }
	    }
	});


    addBackButton();
}




function addRankAndEmployeeNodes(rows, groupedByRank, parentId) {
    Object.keys(groupedByRank).forEach(rank => {
        var rankNodeId = parentId + "-rank-" + rank;

        // 직급 노드 추가
        rows.push([
            { 
            	v: rankNodeId, 
            	f: "<div class='rank-node'>" + rank + "</div>" 
            },
            parentId,
            "직급: " + rank
        ]);

        var employees = groupedByRank[rank];
        var currentParentGroup = [rankNodeId];

        // 사원 노드를 10개씩 끊어서 추가
        for (var i = 0; i < employees.length; i += 10) {
            var currentGroup = employees.slice(i, i + 10);
            var nextParentGroup = [];

            currentGroup.forEach(function (employee, index) {
                var employeeId = "emp-" + employee.id;

                rows.push([
                    { 
                    	v: employeeId, 
                    	f: '<div class="emp-node">' + rank + '<i class="bi bi-box-arrow-in-right"></i><div class="emp">' + employee.name + '</div></div>'
                    },
                    currentParentGroup[index % currentParentGroup.length],
                    "사원: " + employee.name
                ]);

                nextParentGroup.push(employeeId);
            });

            currentParentGroup = nextParentGroup;
        }
    });
}

    

    /* 모달 열기 함수 */
    function openModal(employee) {
        $("#modalPhoto").attr("src", "/photo/" + employee.photo || "default_photo.jpg"); // 사진이 없으면 기본 이미지
        $("#modalName").text(employee.name);
        $("#modalRank").text(employee.rank);
        $("#modalDepartment").text(employee.department);
        $("#modalEmail").text(employee.email);
        $("#modalPhone").text(employee.phone);
        $("#modalMobile").text(employee.mobile);

        $("#employeeModal").fadeIn(); // 모달 창 표시
    }

    /* 모달 닫기 이벤트 */
    $(document).on("click", "#employeeModal", function () {
        $("#employeeModal").fadeOut(); // 모달 창 닫기
    });
    
    

// 뒤로가기 버튼		
function addBackButton() {
    const contentBox = $(".contentbox");

    // 버튼 중복 방지
    if ($("#backButton").length > 0) return;

    contentBox.prepend(
    		'<button class="backBtn" id="backButton">'
    		+ '<i class="bi bi-arrow-left-square-fill">'
        	+ '</i>&nbsp;뒤로가기'
    		+ '</button>'
    );

    // 버튼 클릭 이벤트
    $("#backButton").on("click", function () {
    	// 초기 조직도 불러오기
        drawChart();
    });

}


var searchKeyword = '';

//검색 아이콘 클릭 이벤트
$('.search-icon').on('click', function () {
  searchKeyword = $('.search-bar').val().trim();
  $('.search-bar').val(''); // 검색창 입력값 초기화
  executeSearch(); 
});

	// 검색창 Enter 이벤트
$('.search-bar').on('keyup', function (e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
        searchKeyword = $(this).val().trim();
        $(this).val(''); // 검색창 입력값 초기화
        executeSearch();
    }
});

	
function executeSearch(){
	// 사원명을 사용하여 사원 검색
	var employee = employees.find(emp => emp.name == searchKeyword);
	
	if (employee) {
        
        // 값 초기화
        departIdx = employee.departmentId;
        routeName = employee.route_name || '';

        // 데이터 로드 및 차트 생성
        isteamEmpLoaded = false; // 초기화
        loadTeamEmp();
    } else {
        modal.showAlert(searchKeyword + " 사원을 찾을 수 없습니다.")
    }
}
    
});
</script>
</html>
