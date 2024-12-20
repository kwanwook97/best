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

.userbox {
	border: 2px solid var(--primary-color);
	width: 16%;
	height: 90%;
	border-radius: 0.625rem;
    padding: 1% !important;
}

.contentbox {
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

.search {
	position: absolute;
	display: inline-block; right : 2%;
	top: 64%;
	right: 2%;
}

.search input {
	border-radius: 0.625rem;
	padding-left: 0.625rem;
	border: 1px solid var(--primary-color);
}

.search i {
	position: absolute;
	right: 0.625rem;
	top: 50%;
	transform: translateY(-50%);
	font-size: 1.125rem;
	pointer-events: none;
	color: var(--accent-color);
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
	width: 11%;
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
	height: 1%;
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
			<div class="search">
				<input type="text" name=""> <i class="fas fa-search"></i>
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
$(document).ready(function () {
    /* 전역변수 */
    var isDepartmentsLoaded = false; // 부서 데이터 로드 상태 플래그
    var isRanksLoaded = false;      // 직급 데이터 로드 상태 플래그
    var isEmployeesLoaded = false; // 사원 데이터 로드 상태 플래그

    var departments = []; // 부서 데이터를 저장할 배열
    var ranks = [];       // 직급 데이터를 저장할 배열
    var employees = [];   // 사원 데이터를 저장할 배열
    var nodeInfo = {};    // 조직도 노드 정보를 저장할 객체
    var routeNames = [];   // 기사부서 팀정보
    var groupedRoutes = []; // 기사부서 팀별 직원그룹
    
    /* Google Charts 초기화 */
    google.charts.load('current', { packages: ["orgchart"] });
    google.charts.setOnLoadCallback(function () {
        // Google Charts가 로드된 후 데이터를 불러오기 시작
        loadDepartments();
        loadRanks();
        loadEmployees();
    });

    /* 부서 데이터 로드 함수 */
    function loadDepartments() {
        $.ajax({
            method: 'POST',
            url: 'orgStruct.ajax',
            dataType: 'JSON',
            data: { table: 'department' },
            success: function (list) {
                departments = list.map(function (item) {
                    return { id: item.depart_idx, name: item.depart_name };
                });
                console.log("부서 데이터 로드 완료:", departments);

                isDepartmentsLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(); // 데이터 로드 상태 확인
            },
            error: function () {
                alert('부서 데이터를 가져오는 중 오류가 발생했습니다.');
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
                ranks = list.map(function (item) {
                    return { id: item.rank_idx, name: item.rank_name };
                });
                console.log("직급 데이터 로드 완료:", ranks);

                isRanksLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(); // 데이터 로드 상태 확인
            },
            error: function () {
                alert('직급 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }

    /* 사원 데이터 로드 함수 */
    function loadEmployees() {
        $.ajax({
            method: 'POST',
            url: 'orgChart.ajax',
            dataType: 'JSON',
            success: function (list) {
                employees = list.map(function (item) {
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
                    return {
                        id: item.emp_idx,
                        name: item.name,
                        rankId: item.rank_idx,
                        rank: item.rank_name,
                        departmentId: item.depart_idx,
                        department: item.depart_name,
                        route_name: item.route_name
                    };
                });
                console.log("사원 데이터 로드 완료:", employees);

                isEmployeesLoaded = true; // 데이터 로드 상태 플래그 업데이트
                checkAndGenerate(); // 데이터 로드 상태 확인
            },
            error: function () {
                alert('사원 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }
    
    
 	// 기사팀의 team_name 종류 추출 (stream과 유사한 필터링기능 사용 => 반복문보다 속도우세)
    function extractRouteNames(employees) {
	    return employees
	        .filter(emp => emp.departmentId === 4 && emp.route_name && emp.route_name.trim() !== "") // team_name 확인
	        .reduce((result, emp) => {
	            if (!result.includes(emp.route_name)) { // 중복 제거
	                result.push(emp.route_name);
	            }
	            return result;
	        }, []);
	}
 	

	// 기사팀 별 직원 배열 생성
	function createRouteGroups(employees) {
	    // route_name별로 직원들을 그룹화
	    var groupedByRoute = employees.reduce((result, emp) => {
	        // route_name이 유효하고 departmentId가 4인 경우만 처리
	        if (emp.departmentId === 4 && emp.route_name && emp.route_name.trim() !== "") {
	            // 해당 route_name의 배열이 없으면 초기화
	            if (!result[emp.route_name]) {
	                result[emp.route_name] = [];
	            }
	            // 직원 추가
	            result[emp.route_name].push({
	                id: emp.id,
	                name: emp.name,
	                route_name: emp.route_name,
	                rank: emp.rank,
	            });
	        }
	        return result;
	    }, {});
	
	    // 그룹을 배열 형태로 변환
	    return Object.values(groupedByRoute);
	}

 	
 	


    /* 데이터 로드 상태 확인 함수 */
    function checkAndGenerate() {
        if (isDepartmentsLoaded && isRanksLoaded && isEmployeesLoaded) {
            console.log("모든 데이터 로드 완료. 폴더 및 차트를 생성합니다.");
            
         	// routeNames 초기화
            routeNames = extractRouteNames(employees);
         	// routeNames별 직원그룹 
         	groupedRoutes = createRouteGroups(employees);
         	
            generateFolders(); // 폴더 생성
            drawChart();       // 조직도 차트 생성
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

            // 직급별 폴더 생성
            $.each(ranks, function (rankIndex, rank) {
                var rankFolder = $('<div class="folder">' +
                    '<span class="folder-icon">📂</span> ' + rank.name +
                    '<div class="subfolders" style="display:none;"></div>' +
                    '</div>');

                // 직급별 사원 추가
                $.each(employees, function (empIndex, emp) {
                    if (emp.rankId === rank.id && emp.departmentId === dept.id) {
                        var empDiv = $('<div class="folder">' +
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
    }

    /* 조직도 차트 생성 함수 */
    function drawChart() {
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
	     		f: '대표<div class="emp">' +ceo.name+ '</div>' 
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
       		
       		var managerId;           // 부서장 idx를 담을 변수
        	var managerName = '';    // 부서장 이름을 담을 변수
        	var managerRankId;       // 부서장 직급을 담을 변수
        	var managerIndex = 0;       
        	
        	var highId = 999;                  
        	var highName = '';
        	var highRankId = 999; 
        	var highIndex = 0; 
        	
        	// 부서 소속인원들을 담기위한 배열
    	    var deptEmp = [];
        	var deptIndex = 0;   // 해당 부서의 몇번째 사람인지 체크하기 위함
        	
       		
       		// 부서정보 추가
       	    deptNodeId = "dept-" + dept.id;    // 부서idx
			
       	    // 팀장정보 찾기 (팀장이 없는경우 해당 부서의 최상급자)
	        $.each(employees, function (empIndex, emp) {
	        	
	        	if (emp.departmentId === dept.id){ // 같은부서인 직원
	        		
	        		// 부서원 정보담기
		        	deptEmp.push(emp);
	        		
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
        			
        			deptIndex++;
	        	}
	        	
	        });
	            
	        
	        // 팀장이 없는경우 부서의 최상급자 세팅.
	        if (!managerId || managerId <= 0) {
	        	managerId = highId;
	        	managerName = highName;	
	        	managerRankId = highRankId;	
	        	// 부서원 정보에서 삭제
	        	deptEmp.splice(highIndex, 1);
	        }else{ // 팀장이 있는 경우
	        	// 부서원 정보에서 삭제
	        	deptEmp.splice(managerIndex, 1);
	        }
	        
	        // 부서 및 부서장 노드생성.
            rows.push([
                {
                	v: deptNodeId,
                	f: dept.name + '<div class="emp">' +managerName+ '</div>' 
                },
                '1',                             // 상위 노드는 '대표'
    	        '부서: ' + dept.name              // 툴팁 정보
            ]);

	        
	        // 기사부서인 경우 버스팀 노드 생성.
	        if(dept.id === 4){
	        	$.each(routeNames, function(teamIdx, busTeam){
	    			
	        		var team = '버스 ' + (teamIdx+1) + '팀';
	        		
	        		rows.push([
		                { 
		                    v: busTeam, 
		                    f: team + '<div class="emp">' + busTeam + '</div>'
		                },
		                deptNodeId, // 상위 노드는 해당 부서
		                "팀: " + team  // 툴팁 정보
		            ]);
	    		
	        		// 팀별 직원 묶음
	        		var routeGroup = groupedRoutes[teamIdx];
	        		
	        		// 팀별 직원 개별 노드 생성
	                $.each(routeGroup, function (index, employee) {
	                	
	                	afterRankNodeId = "rank-" + employee.departmentId + "-" + employee.rankId + "-" + employee.id;
	                	if(index === 0){
	                		rows.push([
		                        {
		                            v: afterRankNodeId,
		                            f: employee.rank + '<div class="emp">' + employee.name + '</div>' // 사원 이름
		                        },
		                        busTeam, // 상위 노드는 팀
		                        "사원: " + employee.name // 툴팁 정보
		                    ]);
	                	}else{
	                		rows.push([
		                        {
		                            v: afterRankNodeId,
		                            f: employee.rank + '<div class="emp">' + employee.name + '</div>' // 사원 이름
		                        },
		                        beforeRankNodeId, // 상위 노드는 직원
		                        "사원: " + employee.name // 툴팁 정보
		                    ]);
	                	}
	                	beforeRankNodeId = "rank-" + employee.departmentId + "-" + employee.rankId + "-" + employee.id;
	                    
	                });

        		
	        	});
	        	
	        	
	        } 
            
	        
         	// 부서장을 제외한 부서원 노드생성.
	        $.each(deptEmp, function (empIndex, emp) {
	        	afterRankNodeId = "rank-" + emp.departmentId + "-" + emp.rankId + "-" + emp.id;
	        	
	        	// 기사팀이 아닌경우
	        	if(emp.departmentId !== 4){
	        		// 맨 첫번째 노드
		        	if(empIndex === 0){
			            rows.push([
			                { 
			                    v: afterRankNodeId, 
			                    f: emp.rank + '<div class="emp">' +emp.name+ '</div>' // 직급 노드 표시
			                },
			                deptNodeId, // 상위 노드는 해당 부서
			                "직급: " + emp.rank // 툴팁 정보
			            ]);
		        	}else{   // 두번째 노드부터 
		        		rows.push([
			                { 
			                    v: afterRankNodeId, 
			                    f: emp.rank + '<div class="emp">' +emp.name+ '</div>' // 직급 노드 표시
			                },
			                beforeRankNodeId, // 상위 노드는 직원
			                "직급: " + emp.rank // 툴팁 정보
			            ]);
		        	}
		        	beforeRankNodeId = "rank-" + emp.departmentId + "-" + emp.rankId + "-" + emp.id;
	        		
	        	}else{ // 기사팀인경우     team_name
	        		
	        	}
	        	
	        });
	        
       	});

        data.addRows(rows);

        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        chart.draw(data, { allowHtml: true });

        // 노드 클릭 이벤트 처리
        google.visualization.events.addListener(chart, 'select', function () {
            var selection = chart.getSelection();
            if (selection.length > 0) {
                var selectedNode = selection[0];
                var nodeId = data.getValue(selectedNode.row, 0);
                if (nodeInfo[nodeId]) {
                    openModal(nodeInfo[nodeId]);
                }
            }
            
            
            
         	// 선택된 노드가 버스팀일 경우 조직도를 재구성
            if (routeNames.includes(nodeId)) {
                drawTeamChart(nodeId); // 팀 별 조직도 재구성 함수 호출
            } else if (nodeInfo[nodeId]) {
                openModal(nodeInfo[nodeId]); // 직원 정보 모달 열기
            }
            
        });

        console.log("조직도 차트 생성 완료");
    }
    
    
    
    
    
    
    
    
    
    
    function drawTeamChart(teamId) {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Node ID'); // 노드 ID
        data.addColumn('string', 'Parent Node ID'); // 부모 노드 ID
        data.addColumn('string', 'ToolTip Info'); // 툴팁 정보

        var rows = [];

        // 최상위 노드: 선택된 팀
        rows.push([
            {
                v: teamId,
                f: teamId // 팀 이름
            },
            '', // 부모 노드 없음 (최상위 노드)
            '팀: ' + teamId // 툴팁 정보
        ]);

        // 팀에 속한 직원 노드 추가
        var selectedTeam = groupedRoutes.find(group => group[0].route_name === teamId);
        if (selectedTeam) {
            $.each(selectedTeam, function (index, employee) {
                rows.push([
                    {
                        v: String(employee.id), // 직원 ID
                        f: '<div class="emp">' + employee.name + '</div>' // 직원 이름
                    },
                    teamId, // 상위 노드는 팀
                    '사원: ' + employee.name // 툴팁 정보
                ]);
            });
        }

        data.addRows(rows);

        // 조직도 다시 그리기
        var chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
        chart.draw(data, { allowHtml: true });

        // 다시 그린 조직도에 클릭 이벤트 바인딩
        google.visualization.events.addListener(chart, 'select', function () {
            var selection = chart.getSelection();
            if (selection.length > 0) {
                var selectedNode = selection[0];
                var nodeId = data.getValue(selectedNode.row, 0);
                if (nodeInfo[nodeId]) {
                    openModal(nodeInfo[nodeId]); // 직원 정보 모달 열기
                }
            }
        });

        console.log(teamId + " 조직도 재구성 완료");
    }

    
    
    
    
    
    
    
    

    /* 모달 열기 함수 */
    function openModal(employee) {
        $("#modalPhoto").attr("src", employee.photo || "default_photo.jpg"); // 사진이 없으면 기본 이미지
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
});

	
		
		
		
/* 		
		
		// 새 노드 추가
		$('#submitBtn').on('click',function() {
			const position = $('#position').val();
			const name = $('#name').val();
			const phone = $('#phone').val();
			const email = $('#email').val();
			const parentNode = $('#parentNodeSelect').val();
			const siblingNode = $('#siblingNodeSelect').val();
			const department = $('#department').val();

			if (!position || !name || !phone || !email	|| !parentNode) {
				alert('모든 필드를 입력해주세요.');
				return;
			}
			const newNodeId = String(Object.keys(nodeInfo).length + 1);
			nodeInfo[newNodeId] = {
				name : name,
				phone : phone,
				email : email
			};

			let insertionIndex = data.getNumberOfRows();
			if (siblingNode) {
				const siblingIndex = data.getFilteredRows([ 
					{column : 0,
						value : siblingNode} 
				])[0];
				insertionIndex = siblingIndex + 1; // 형제 노드의 바로 다음에 추가
			}

			// 새 노드를 추가
			data.insertRows(insertionIndex,[ 
				[{v : newNodeId, f : position+ '<div class="emp">'+ name+ '</div>'},
					parentNode,
					'부서 : '+ department+ '<br>연락처 : '+ phone+ '<br>이메일 : '+ email] 
			]);

			chart.draw(data, {allowHtml : true});

			// 새 노드가 부모로 선택될 수 있도록 부모 노드 선택 옵션 갱신
			$('#parentNodeSelect').append('<option value="' + newNodeId + '">'+ position+ '</option>');
			$('#parentNodeSelect').val(newNodeId); // 새로 추가된 노드를 부모로 설정

			// 입력 폼 초기화
			$('#addForm').hide();
			$('#addForm input').val('');
			$('#siblingNodeSelect').val('');
			$('#siblingNodeSelect').val('');

			// 부모 노드 선택 폼 업데이트
			$('#parentNodeSelect').trigger('change'); // 부모 노드를 변경하여 형제 목록 갱신
		});

		// "추가하기" 버튼 클릭 시 폼 표시 토글
		$('#showAddFormBtn').on('click', function() {
			$('#addForm').toggle(); // 버튼을 클릭하면 폼이 보이거나 숨겨집니다.
		});
		
		 */
		 
		 
		 /* 받아온 값 */
			// item.emp_idx 
         // item.name 
         // item.email 
         // item.phone 
         // item.mobile 
         // item.photo 
         // item.enable 
         // item.state 
         // item.depart_idx 
         // item.depart_name 
         // item.rank_idx
         // item.rank_name
		
	
</script>
</html>
