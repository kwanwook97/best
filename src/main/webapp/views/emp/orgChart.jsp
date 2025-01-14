<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="resources/css/emp/orgChart.css" rel="stylesheet"/>
<style>

</style>
</head>
<body class="bg-theme bg-theme1">
	<sec:authorize access="!hasAuthority('ROLE_ADMIN')">
		<c:set var="user_rank_idx" value="${sessionScope.employee.rank_idx}" />
		<jsp:include page="../main/header.jsp"></jsp:include>
	</sec:authorize>
	<sec:authorize access="hasAuthority('ROLE_ADMIN')">
		<jsp:include page="../main/adminHeader.jsp"></jsp:include>
	</sec:authorize>
	
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


<div id="searchResults" style="display: none; position: absolute; z-index: 10; background: white; border: 1px solid #ccc; border-radius: 5px; max-width: 300px;">
    <!-- 검색 결과 리스트가 동적으로 추가됩니다 -->
</div>

		
	
	
	<div class="dashboard-body">
		<div class="textbox">
			<div class="maintext">
				<h3 class="document">조직도</h3>
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


var data; // Google Charts DataTable 객체
var chart; // Google Charts OrgChart 객체

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
	
	 	// Google Charts 로드 완료 후 데이터 로드 시작
	    google.charts.setOnLoadCallback(function () {
	        console.log("Google Charts 로드 완료");

	        // 데이터 로드
	        loadDepartments();
	        loadRanks();
	        loadRoutes();
	        loadEmployees();

	        // 모든 데이터 로드 상태 확인 후 조직도 생성
	        var interval = setInterval(function () {
	            if (isDepartmentsLoaded && isRanksLoaded && isEmployeesLoaded && isRoutesLoaded) {
	                clearInterval(interval); // 상태 확인 멈춤
	                checkAndGenerate(0); // 폴더 및 차트 생성
	            }
	        }, 100); // 100ms마다 데이터 로드 상태 확인
	    });
	});

    /* 부서 데이터 로드 함수 */
    function loadDepartments() {
    	departments = []; // 기존 데이터를 초기화
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
                checkAndGenerate(0); // 데이터 로드 상태 확인
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
    	employees = []; // 기존 데이터를 초기화
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
    function loadTeamEmp(callback) {
		
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
                
                
             	// 콜백 함수 호출 (존재할 경우)
                if (typeof callback === "function") {
                    console.log("loadTeamEmp 완료 후 콜백 호출");
                    callback();
                }
                
            },
            error: function () {
            	modal.showAlert('사원 데이터를 가져오는 중 오류가 발생했습니다.');
            }
        });
    }


    /* 데이터 로드 상태 확인 함수 */
    function checkAndGenerate(empType) {
	    var checkEmpType = empType === 0 
	        ? isDepartmentsLoaded && isRanksLoaded && isEmployeesLoaded && isRoutesLoaded
	        : isDepartmentsLoaded && isRanksLoaded && isEmployeesLoaded && isteamEmpLoaded && isRoutesLoaded;
	
	    if (!checkEmpType) {
	        console.log("데이터가 아직 로드되지 않았습니다.");
	        return;
	    }
	
	    if (checkEmpType) {
	        if (empType === 0) {
	            console.log("데이터 로드 완료, 폴더 및 차트 생성");
	            if (!$(".userbox").children().length) {
	                generateFolders(); // 폴더 생성
	            }
	            drawChart(); // 조직도 차트 생성
	        } else {
	            drawTeamChart(); // 부서 또는 팀별 조직도 차트 생성
	        }
	    }
	}


    
    
    /* 폴더 생성 함수 */
	function generateFolders() {
	    var userbox = $(".userbox");
	    userbox.empty(); // 기존 폴더 초기화
	
	    var addedDepartments = new Set(); // 중복 부서 방지
	    var addedEmployees = new Set();   // 중복 사원 방지
	
	    // 부서별 폴더 생성
	    $.each(departments, function (deptIndex, dept) {
	        if (addedDepartments.has(dept.id)) return; // 이미 추가된 부서는 건너뜀
	        addedDepartments.add(dept.id);
	
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
	                    if (emp.route_name === route.name && emp.departmentId === 4 && !addedEmployees.has(emp.id)) {
	                        var empDiv = $('<div class="folder" data-id="' + emp.id + '">' +
	                            '<span class="folder-icon">👤</span> ' + emp.name +
	                            '</div>');
	                        teamSubfolders.append(empDiv);
	                        addedEmployees.add(emp.id);
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
	                    if (emp.rankId === rank.id && emp.departmentId === dept.id && !addedEmployees.has(emp.id)) {
	                        var empDiv = $('<div class="folder" data-id="' + emp.id + '">' +
	                            '<span class="folder-icon">👤</span> ' + emp.name +
	                            '</div>');
	                        rankFolder.find(".subfolders").append(empDiv);
	                        addedEmployees.add(emp.id);
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
                    
                    loadTeamEmp(function () {
                    	var employeeNodeId = 'emp-' + empId; // 사원의 노드 ID 생성
                        highlightNode(employeeNodeId); // 로드 완료 후 강조
                    });
                    
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
    	
    	
        data = new google.visualization.DataTable();
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
        chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
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
    
    data = new google.visualization.DataTable();
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
    
    
    chart = new google.visualization.OrgChart(document.getElementById("chart_div"));
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
	    $("#modalPhoto").attr("src", "/photo/" + (employee.photo || "default_photo.jpg")); // 사진이 없으면 기본 이미지
	    $("#modalName").text(employee.name);
	    $("#modalRank").text(employee.rank);
	    $("#modalDepartment").text(employee.department);
	    $("#modalEmail").text(employee.email);
	    $("#modalPhone").text(employee.phone);
	    $("#modalMobile").text(employee.mobile);
	
	    $("#employeeModal").fadeIn(); // 모달 창 표시
	}
	
	// 모달 닫기 이벤트
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

	
function executeSearch() {
    // 검색어로 사원 목록 필터링 후 emp_idx 중복 제거
    const uniqueEmployees = Array.from(new Map(
        employees.filter(emp => emp.name.includes(searchKeyword))
                .map(emp => [emp.id, emp]) // emp.id를 기준으로 중복 제거
    ).values());

    // 검색 결과 리스트 컨테이너 선택
    const searchResultsContainer = $('#searchResults');
    searchResultsContainer.empty(); // 이전 검색 결과 초기화

    if (uniqueEmployees.length === 0) {
        modal.showAlert(searchKeyword + " 사원을 찾을 수 없습니다.");
        searchResultsContainer.hide();
        return;
    }

    if (uniqueEmployees.length === 1) {
        // 검색 결과가 한 명일 경우 바로 해당 노드로 이동
        const employee = uniqueEmployees[0];
        departIdx = employee.departmentId;
        routeName = employee.route_name || '';

        // 데이터 로드 및 차트 생성
        isteamEmpLoaded = false; // 초기화
        loadTeamEmp(function () {
            const employeeNodeId = 'emp-' + employee.id; // 사원의 노드 ID 생성
            highlightNode(employeeNodeId); // 로드 완료 후 강조
        });

        searchResultsContainer.hide(); // 결과 리스트 숨김
    } else {
        // 검색 결과가 여러 명인 경우 모달창을 검색창 아래에 표시
        openSearchModal(uniqueEmployees); // 검색 결과 모달 열기
    }
}

// 검색 결과가 여러개일 때 모달창 형태로 검색창 아래에 표시
function openSearchModal(employees) {
    const searchBar = $('.search-bar');
    const searchResultsContainer = $('#searchResults');

    searchResultsContainer.empty(); // 이전 결과 초기화

    employees.forEach(emp => {
        const listItem = $('<div>')
            .text(emp.name)
            .css({ 
                padding: '10px', 
                cursor: 'pointer', 
                borderBottom: '1px solid #ddd' 
            })
            .hover(
                function () { $(this).css('background', '#f1f1f1'); },
                function () { $(this).css('background', 'white'); }
            )
            .on('click', function () {
                // 선택한 사원으로 이동
                searchResultsContainer.hide(); // 결과 리스트 숨김
                departIdx = emp.departmentId;
                routeName = emp.route_name || '';

                // 데이터 로드 및 차트 생성
                isteamEmpLoaded = false; // 초기화
                loadTeamEmp(function () {
                    const employeeNodeId = 'emp-' + emp.id; // 사원의 노드 ID 생성
                    highlightNode(employeeNodeId); // 로드 완료 후 강조
                });
            });

        searchResultsContainer.append(listItem);
    });

    // 모달 스타일 검색창 아래로 설정 및 스크롤바 추가
    searchResultsContainer.css({
        position: 'absolute',
        display: 'block',
        top: searchBar.offset().top + searchBar.outerHeight() + 10 + 'px', // 검색창 아래로 10px
        left: searchBar.offset().left + 'px',
        width: searchBar.outerWidth() + 'px',
        maxHeight: '200px', // 최대 높이 설정
        overflowY: 'auto', // 세로 스크롤바 활성화
        background: 'white',
        border: '1px solid #ccc',
        borderRadius: '5px',
        zIndex: 1000,
        boxShadow: '0 4px 6px rgba(0,0,0,0.1)',
    }).fadeIn();
}




function highlightNode(nodeId) {

    // Google Charts에서 노드 인덱스 검색
    const nodeIndex = data.getFilteredRows([{ column: 0, value: nodeId }])[0];
    if (typeof nodeIndex === "undefined") {
        modal.showAlert("해당 사원을 찾을 수 없습니다.");
        return;
    }

    // 노드 선택 이벤트 트리거
    chart.setSelection([{ row: nodeIndex }]);
    google.visualization.events.trigger(chart, 'select', {});
}


    
});
</script>
</html>
