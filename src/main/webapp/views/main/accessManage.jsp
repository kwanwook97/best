<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    :root {
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
      --light-color: #F9F6F1;
    }


    body {
      font-family: 'Arial', sans-serif;
      background-color: #fff;
      color: var(--primary-color);
      margin: 0;
      padding: 0;
    }

    .body {
      width: 83%;
      margin-top: 110px;
      margin-left: 320px;
    }

	body .body {
	    transform: scale(0.55);
	    transform-origin: top left; /* 화면의 왼쪽 상단을 기준으로 축소 */
	    width: 150%; /* 축소에 따른 여백 보정 */
	    overflow: hidden; /* 스크롤바 제거 */
	    position: absolute;
	    top: 1px;
	    left: -37px;
	    height: 187%;
	  }
    .naviPath {
      font-size: 48px;
      font-weight: bold;
      margin-bottom: 20px;
      color: var(--primary-color);
    }

    .naviPath span {
      color: var(--secondary-color);
    }

    .content {
      height: 40%;
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
    }

    .left-panel, .right-panel {
      width: 48%;
      border: 2px solid var(--primary-color);
      border-radius: 10px;
      background-color: var(--light-color);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      overflow: hidden;
    }

    .tab-section {
      display: flex;
      justify-content: flex-start;
      align-items: center;
      gap: 20px;
      border-bottom: 2px solid var(--primary-color);
      margin-bottom: 20px;
    }

    .tabs {
      display: flex;
      padding: 0;
      margin: 0;
    }

    .tabs li {
      list-style: none;
      font-weight: bold;
      font-size: 18px;
      padding: 10px 20px;
      cursor: pointer;
      color: var(--secondary-color);
      border-bottom: 3px solid transparent;
      transition: all 0.3s;
    }

    .tabs li.active {
      color: var(--primary-color);
      border-bottom: 3px solid var(--accent-color);
    }

    .tab-content {
      margin-top: 20px;
    }
    
    
    .tab-content .tab {
	  display: none;
	}
	
	.tab-content .tab.active {
	  display: block;
	}
	    
    

    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    .form-group input, .form-group select {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid var(--primary-color);
      border-radius: 5px;
      box-sizing: border-box;
    }

	

    button.normalBtn {
      background-color: var(--accent-color);
      color: #fff;
      font-weight: bold;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button.normalBtn:hover {
      background-color: #FF527D; /* accent-color hover */
    }
    

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    table th, table td {
      padding: 15px;
      text-align: left;
      border: 1px solid var(--primary-color);
    }

	table th {
	  background-color: var(--primary-color); 
	  color: #fff;
	}
	
	.table-container {
	  max-height: 75%; /* 테이블 컨테이너의 최대 높이를 설정 */
	  overflow-y: auto; /* 세로 스크롤바를 자동으로 표시 */
	}
	

    .bottom-section {
      height: 40%;
      overflow: hidden;
      margin-top: 30px;
      padding: 20px;
      border: 2px solid var(--primary-color);
      border-radius: 10px;
      background-color: var(--light-color);
    }
    
    label{
    	color: var(--primary-color) !important;
    }
    
    tr a{
    	font-weight: bold;
    	text-decoration: underline;
    }
    
    /* 모달 창 스타일 */
.modal {
  display: none; /* 기본적으로 숨김 */
  justify-content: center; /* 가로 중앙 정렬 */
  align-items: center; /* 세로 중앙 정렬 */
  position: fixed; /* 고정 위치 */
  top: 0;
  left: 0;
  width: 100%; /* 화면 전체 너비 */
  height: 100%; /* 화면 전체 높이 */
  background-color: rgba(0, 0, 0, 0.4); /* 반투명 배경 */
  z-index: 9999; /* 다른 요소 위에 표시 */
}

.modal-container {
  background-color: #FFF5E2; /* 베이지색 */
  border-radius: 10px;
  padding: 20px;
  width: 400px; /* 모달 너비 */
  text-align: center;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  position: relative; /* 내부 요소의 상대 위치 */
  top: 50%; /* 세로 중앙 정렬 */
  left: 50%; /* 가로 중앙 정렬 */
  transform: translate(-50%, -50%); /* 중앙으로 이동 */
}


.modal-header {
  background-color: var(--primary-color);
  color: white;
  font-size: 20px;
  font-weight: bold;
  padding: 10px;
  text-align: center;
  border-radius: 10px 10px 0 0;
}

.modal-body {
  margin: 15px 0;
}

.input-field {
  width: 100%;
  padding: 10px;
  margin-top: 5px;
  font-size: 14px;
  border: 1px solid var(--primary-color);
  border-radius: 5px;
}

.modal-footer {
  display: flex;
  justify-content: space-between;
}

.btn-confirm {
  background-color: var(--primary-color);
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-cancel {
  background-color: var(--accent-color);
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-confirm:hover {
  background-color: #4A0073;
}

.btn-cancel:hover {
  background-color: #FF527D;
}

.input-field::placeholder {
  color: #aaa !important; /* placeholder 텍스트 색상 */
  font-style: italic !important; /* 기울임 효과 */
  opacity: 1 !important; /* 투명도 */
}

table tr.selected-page {
  background-color: var(--secondary-color); 
  opacity: 1; /* 선택 항목 선명도 */
  color: #fff;
}

/* 검색 및 필터 디자인 */
.searchbox {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
}

.search {
  position: relative;
  flex-grow: 1; /* 검색창이 가능한 넓게 확장 */
}

#searchInput{
	width: 100%;
}

.search input {
  border-radius: 10px;
  padding: 0 10px;
  border: 2px solid var(--primary-color);
  height: 42px;
  font-size: 16px;
  font-weight: bold;
  line-height: 42px;
  box-sizing: border-box;
}

.search i {
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 18px;
  pointer-events: all; 
  color: var(--accent-color);
  cursor: pointer; /* 클릭 가능 표시 */
}

select {
  font-size: 16px;
  font-weight: bold;
  padding: 0 10px;
  border: 2px solid var(--primary-color);
  border-radius: 10px;
  background-color: #fff !important; /* 흰색 배경 */
  color: var(--primary-color) !important; /* 텍스트 색상 */
  height: 42px;
  line-height: 42px;
  cursor: pointer;
}

select option {
  background-color: #fff !important; /* 옵션 배경 흰색 */
  color: var(--primary-color) !important; /* 옵션 텍스트 색상 */
}

/* 버튼 */
button.btn-add-page {
  background-color: var(--accent-color);
  color: #fff;
  font-weight: bold;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
  margin-left: auto; /* 우측으로 정렬 */
}

button.btn-add-page:hover {
  background-color: #FF527D;
}
    


.pageName{
	margin: 10px 0;
}    

.selectOption{
	width: auto !important;
}

.smallTxt{
	font-size: 18px;
}

.lPurple{
	color: var(--secondary-color); 
}
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/adminHeader.jsp"/>

  <div class="body">
    <div class="naviPath">권한 관리</div>

    <div class="content">
       <!-- Left Panel -->
      <div class="left-panel">
        <h2>페이지 접근관리</h2> 
		<div class="searchbox">
		  <select id="searchFilter" class="searchFilter">
		    <option value="page_name">페이지 이름</option>
		    <option value="url">URL</option>
		  </select>
		  <div class="search">
		    <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
		    <i class="fas fa-search" id="searchIcon"></i>
		  </div>
		  <button class="btn-add-page" onclick="showAddPageModal()">페이지 등록</button>
		</div>

		<div class="table-container">
	        <table>
	          <thead>
	            <tr>
	              <th>페이지 이름</th>
	              <th>URL</th>
	              <th>삭제</th> 
	            </tr>
	          </thead>
	          <tbody id="pageList">
	            <!-- AJAX로 목록 채움 -->
	          </tbody>
	        </table>
        </div>
      </div>

      <!-- Right Panel -->
      <div class="right-panel">
        <div class="tab-section">
          <ul class="tabs">
            <li class="active" data-tab="tab1">부서권한</li>
            <li data-tab="tab2">직급권한</li>
          </ul>
        </div>

        <div class="tab-content">
			<div id="tab1" class="tab active">
			  <h2 class="pageName">부서목록</h2>
			  <div class="add-section" id="departmentAddSection">
			    <select id="unassignedDepartments" class="add-dropdown">
			      <!-- 권한이 없는 부서 목록 AJAX로 채워짐 -->
			    </select>
			    <button class="normalBtn" onclick="addDepartmentRole()">부서 추가</button>
			  </div>
			  <div class="table-container">
				  <table>
				    <thead>
				      <tr>
				        <th>부서</th>
				        <th>삭제</th> 
				      </tr>
				    </thead>
				    <tbody id="departmentRoles">
				      <!-- AJAX로 채워질 내용 -->
				    </tbody>
				  </table>
			  </div>
			</div>
			
			<div id="tab2" class="tab">
			  <h2 class="pageName">직급목록</h2>
			  <div class="add-section" id="rankAddSection">
			    <select id="unassignedRanks" class="add-dropdown">
			      <!-- 권한이 없는 직급 목록 AJAX로 채워짐 -->
			    </select>
			    <button class="normalBtn" onclick="addRankRole()">직급 추가</button>
			  </div>
			  <div class="table-container">
				  <table>
				    <thead>
				      <tr>
				        <th>직급</th>
				        <th>삭제</th> 
				      </tr>
				    </thead>
				    <tbody id="rankRoles">
				      <!-- AJAX로 채워질 내용 -->
				    </tbody>
				  </table>
			  </div>
			</div>

        </div>
      </div>
    </div>

    <div class="bottom-section">
      <div class="tab-section">
        <ul class="tabs">
          <li class="active" data-tab="allDepartments">부서별 권한조회</li>
          <li data-tab="allRanks">직급별 권한조회</li>
        </ul>
      </div>

      <div class="tab-content">
        <div id="allDepartments" class="tab active">
          <h2>부서별 권한조회</h2>
          <div class="form-group">
		    부서 선택: <select id="departmentSelect" class="selectOption" onchange="filterDepartmentRoles()">
				        <!-- AJAX로 채워질 옵션 -->
				    </select>
		  </div>
		  <div class="table-container">
	          <table>
	            <thead>
	              <tr>
	                <th>페이지 이름</th>
	                <th>URL</th>
	              </tr>
	            </thead>
	            <tbody id="filteredDepartmentRoles">
	              <!-- AJAX로 필터링된 내용 -->
	            </tbody>
	          </table>
          </div>
        </div>

        <div id="allRanks" class="tab">
          <h2>직급별 권한조회</h2>
          <div class="form-group">
			    직급 선택: <select id="rankSelect" class="selectOption" onchange="filterRankRoles()">
					        <!-- AJAX로 채워질 옵션 -->
					    </select>
		  </div>
		  <div class="table-container">
	          <table>
	            <thead>
	              <tr>
	                <th>페이지 이름</th>
	                <th>URL</th>
	              </tr>
	            </thead>
	            <tbody id="filteredRankRoles">
	              <!-- AJAX로 필터링된 내용 -->
	            </tbody>
	          </table>
          </div>
        </div>
      </div>
    </div>
  </div>

<!-- 모달 창 -->
<div id="addPageModal" class="modal">
  <div class="modal-container">
    <div class="modal-header">
      <h2>페이지 등록</h2>
    </div>
    <div class="modal-body">
	  <div class="form-group">
	    페이지 이름: <input type="text" id="newPageName" class="input-field" placeholder="예: 페이지 이름">
	  </div>
	  <div class="form-group">
	    URL: <input type="text" id="newPageUrl" class="input-field" placeholder="예: page.go 또는 page.do (한개씩 등록)">
	  </div>
	</div>

    <div class="modal-footer">
      <button class="btn-confirm" onclick="addPage()">등록</button>
      <button class="btn-cancel" onclick="closeModal('addPageModal')">취소</button>
    </div>
  </div>
</div>


<script>
	/* 전역변수 */
	var searchFilter = "page_name"; // 기본값: 페이지 이름
	var searchKeyword = ""; // 검색어
	
	var currentPageIdx = null; // 전역 변수
	var currentPageUrl = null; // 전역 변수


	
	$(document).ready(function () {
		//페이지 목록 초기 로드	
	    loadPageList();
	    
	    // 모든 부서 목록 로드 후 기본값 설정
	    loadAllDepartments();

	    // 모든 직급 목록 로드 후 기본값 설정
	    loadAllRanks();
	});

	
	
    // 검색 필터 변경
    $("#searchFilter").on("change", function () {
        searchFilter = $(this).val();
    });

 	
 	// 검색 버튼 클릭 이벤트
    $("#searchIcon").on("click", function () {
      executeSearch(); // 검색 실행 함수 호출
    });

    // 검색창 Enter 이벤트
    $("#searchInput").on("keypress", function (e) {
      if (e.key === "Enter") {
        executeSearch();
      }
    });
    
	

	
	
  // 모달 열기
  function showAddPageModal() {
    $("#addPageModal").fadeIn();
  }

  // 모달 닫기
  function closeModal(modalId) {
    $("#" + modalId).fadeOut();
  }

  // 페이지 등록
function addPage() {
    var url = $("#newPageUrl").val().trim();
    var name = $("#newPageName").val().trim();

    if (!url || !name) {
        alert("URL과 페이지 이름을 모두 입력해주세요.");
        return;
    }

    // URL 형식 검증
    if (!url.endsWith('.go') && !url.endsWith('.do')) {
        alert("URL은 '.go' 또는 '.do'로 끝나야 합니다.");
        return;
    }

    // URL에서 앞의 '/' 제거
    if (url.startsWith('/')) {
        url = url.substring(1);
    }

    // AJAX 요청으로 페이지 등록 처리
    $.ajax({
        url: "addPage.ajax",
        method: "POST",
        data: { url: url, name: name },
        success: function (response) {
            if (response.success) {
                loadPageList(); // 목록 갱신
                closeModal("addPageModal");
                alert("페이지가 성공적으로 등록되었습니다.");
            } else {
                alert(response.message || "페이지 등록에 실패했습니다.");
            }
        },
        error: function () {
            alert("서버 요청 중 오류가 발생했습니다.");
        }
    });
}




  // 접근제어 페이지목록 가져오기
function loadPageList() {
  $.ajax({
    url: "getPageList.ajax",
    method: "GET",
    success: function (response) {
      if (response.success) {
        var html = "";
        $.each(response.pages, function (index, page) {
          html += "<tr data-url='" + page.url + "' data-idx='" + page.page_idx + "' " +
                  (index === 0 ? "class='selected-page'" : "") + ">" +
                  "<td>" + page.page_name + "</td>" +
                  "<td>" + page.url + "</td>" +
                  "<td><i class='fas fa-trash delete-icon' onclick='deletePage(" + page.page_idx + ")'></i></td>" 
                  "</tr>";
        });
        $("#pageList").html(html);

        // 첫 번째 페이지 자동 선택 및 데이터 로드
        if (response.pages.length > 0) {
          var firstPage = response.pages[0];
          loadPermissions(firstPage.url);
        }

        // 페이지 선택 이벤트 추가
        $("#pageList tr").on("click", function () {
          $("#pageList tr").removeClass("selected-page"); // 기존 강조 제거
          $(this).addClass("selected-page"); // 현재 강조

          var selectedUrl = $(this).data("url");
          loadPermissions(selectedUrl); // 선택된 페이지의 권한 로드
        });
      } else {
        alert("페이지 목록을 불러오는 데 실패했습니다.");
      }
    },
    error: function () {
      alert("서버 요청 중 오류가 발생했습니다.");
    }
  });
}


// 접근제어 페이지 삭제
function deletePage(pageIdx) {
  if (!confirm("정말 이 페이지를 삭제하시겠습니까?")) {
    return;
  }

  $.ajax({
    url: "deletePage.ajax",
    method: "POST",
    data: { 'pageIdx': pageIdx },
    success: function (response) {
      if (response.success) {
        alert("페이지가 성공적으로 삭제되었습니다.");
        loadPageList(); // 목록 갱신
      } else {
        alert(response.message || "페이지 삭제에 실패했습니다.");
      }
    },
    error: function (e) {
      alert("서버 요청 중 오류가 발생했습니다: ", e);
    }
  });
}


  
  
//검색 실행 함수
function executeSearch() {
  var searchKeyword = $("#searchInput").val().trim();

  if (!searchKeyword) {
    alert("검색어를 입력하세요.");
    return;
  }

  $.ajax({
    url: "searchPages.ajax",
    method: "GET",
    data: { 'searchFilter': searchFilter, 'searchKeyword': searchKeyword },
    success: function (response) {
      if (response.success) {
        var html = "";
        $.each(response.pages, function (index, page) {
          html += "<tr data-url='" + page.url + "' data-idx='" + page.page_idx + "'>" +
                  "<td>" + page.page_name + "</td>" +
                  "<td>" + page.url + "</td>" +
                  "<td><i class='fas fa-trash delete-icon' onclick='deletePage(" + page.page_idx + ")'></i></td>" +
                  "</tr>";
        });

        // 검색 결과를 테이블에 출력
        $("#pageList").html(html);

        // 검색 결과 클릭 이벤트 추가
        $("#pageList tr").on("click", function () {
          $("#pageList tr").removeClass("selected-page"); // 기존 강조 제거
          $(this).addClass("selected-page"); // 현재 강조

          var selectedUrl = $(this).data("url");
          loadPermissions(selectedUrl); // 선택된 페이지의 권한 로드
        });
      } else {
        alert("검색 결과를 가져오는 데 실패했습니다.");
      }
    },
    error: function () {
      alert("서버 요청 중 오류가 발생했습니다.");
    }
  });
}




  // 부서별 권한 가져오기
function filterDepartmentRoles() {
  var departmentId = $("#departmentSelect").val();
  if (!departmentId || departmentId === "0") {
    alert("부서를 선택해주세요.");
    return;
  }
  // AJAX 요청
  $.ajax({
    url: "filterDepartmentRoles.ajax",
    method: "GET",
    data: { 'departmentId': departmentId },
    success: function (response) {
      var html = "";
      if (response.success && response.roles.length > 0) {
        // 데이터를 테이블에 추가
        $.each(response.roles, function (index, role) {
          html += "<tr>" +
                  "<td>" + role.page_name + "</td>" +
                  "<td>" + role.url + "</td>" +
                  "</tr>";
        });
      } else {
        // 데이터가 없을 경우 메시지 표시
        html = "<tr><td colspan='2' style='text-align: center;'>표시할 데이터가 없습니다.</td></tr>";
      }
      $("#filteredDepartmentRoles").html(html);
    },
    error: function () {
      alert("서버 요청 중 오류가 발생했습니다.");
    }
  });
}


  // 직급별 권한 가져오기
function filterRankRoles() {
  var rankId = $("#rankSelect").val();

  // AJAX 요청으로 직급별 권한 가져오기
  $.ajax({
    url: "filterRankRoles.ajax",
    method: "GET",
    data: { 'rankId': rankId },
    success: function (response) {
      var html = "";
      if (response.success && response.roles.length > 0) {
        // 데이터를 테이블에 추가
        response.roles.forEach(function (role) {
          html += "<tr>" +
                  "<td>" + role.page_name + "</td>" +
                  "<td>" + role.url + "</td>" +
                  "</tr>";
        });
      } else {
        // 데이터가 없을 경우 메시지 표시
        html = "<tr><td colspan='2' style='text-align: center;'>표시할 데이터가 없습니다.</td></tr>";
      }
      $("#filteredRankRoles").html(html);
    },
    error: function () {
      alert("서버 요청 중 오류가 발생했습니다.");
    }
  });
}


  
  
  
  // 부서또는 직급권한 삭제
  function deleteRole(roleIdx) {
	    if (!confirm("정말 이 권한을 삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "deleteRole.ajax",
	        method: "POST",
	        data: { 'roleIdx': roleIdx},
	        success: function (response) {
	            if (response.success) {
	                alert("권한이 성공적으로 삭제되었습니다.");
	                loadPermissions(currentPageUrl); // 권한 목록 새로고침
	            } else {
	                alert("권한 삭제에 실패했습니다.");
	            }
	        },
	        error: function () {
	            alert("서버 요청 중 오류가 발생했습니다.");
	        }
	    });
	}


  
  
  
  
  
  
  
//페이지별 권한 가져오기
function loadPermissions(url) {
    currentPageUrl = url;

    // 현재 선택된 페이지의 `page_idx`를 가져오기
    var selectedPageRow = $("#pageList tr[data-url='" + url + "']");
    currentPageIdx = selectedPageRow.data("idx"); // 여기서 page_idx를 가져옴
    var pageName = selectedPageRow.find("td:first").text(); // 페이지 이름 가져오기
    
    // 기존 선택 스타일 제거
    $("#pageList tr").removeClass("selected-page");

    // 현재 URL에 해당하는 tr 강조
    selectedPageRow.addClass("selected-page");

    $.ajax({
        url: "getPermissions.ajax",
        method: "GET",
        data: { 'url': url },
        success: function (response) {
            if (response.success) {
                var departmentHtml = "";
                var rankHtml = "";

            	 // 페이지 이름 및 권한 목록 설정
                updatePageName(pageName, url); // 페이지 이름과 현재 활성 탭에 따른 텍스트 변경
                
                // 부서별 권한 렌더링
                if (response.roles.some(role => role.idx_name === "depart_idx")) {
                    $.each(response.roles, function (index, role) {
                        if (role.idx_name === "depart_idx") {
                            departmentHtml += "<tr>" +
                                              "<td>" + role.related_name + "</td>" +
                                              "<td><i class='fas fa-trash delete-icon' onclick='deleteRole(" + role.role_idx + ")'></i></td>" +
                                              "</tr>";
                        }
                    });
                } else {
                    departmentHtml = "<tr><td colspan='2' style='text-align:center;'>부서 권한이 없습니다.</td></tr>";
                }

                // 직급별 권한 렌더링
                if (response.roles.some(role => role.idx_name === "rank_idx")) {
                    $.each(response.roles, function (index, role) {
                        if (role.idx_name === "rank_idx") {
                            rankHtml += "<tr>" +
                                        "<td>" + role.related_name + "</td>" +
                                        "<td><i class='fas fa-trash delete-icon' onclick='deleteRole(" + role.role_idx + ")'></i></td>" +
                                        "</tr>";
                        }
                    });
                } else {
                    rankHtml = "<tr><td colspan='2' style='text-align:center;'>직급 권한이 없습니다.</td></tr>";
                }

                $("#departmentRoles").html(departmentHtml);
                $("#rankRoles").html(rankHtml);

                // 권한 없는 경우에도 드롭다운 데이터 로드
                if (currentPageIdx) {
                    loadUnassignedDepartments(currentPageIdx);
                    loadUnassignedRanks(currentPageIdx);
                }
            } else {
                alert("권한 정보를 가져오는 데 실패했습니다.");
            }
        },
        error: function () {
            alert("서버 요청 중 오류가 발생했습니다.");
        }
    });
}


function updatePageName(pageName, url) {
    // 현재 활성화된 탭 확인
    var activeTab = $(".right-panel .tabs li.active").data("tab");

    // 부서목록 또는 직급목록에 따라 텍스트 변경
    if (activeTab === "tab1") {
        $('.pageName').html("부서권한 - " + "<span class='lPurple'>" + pageName + "<span class='smallTxt'>(" +url+ ")</span></span>");
    } else if (activeTab === "tab2") {
    	$('.pageName').html("직급권한 - " + "<span class='lPurple'>" + pageName + "<span class='smallTxt'>(" +url+ ")</span></span>");
    }
}


	/* 부서또는 직급추가 드롭다운 데이터 채우기 */
function loadUnassignedDepartments(pageIdx) {
  $.ajax({
    url: "getUnassignedDepartments.ajax",
    method: "GET",
    data: { pageIdx: pageIdx },
    success: function (response) {
      if (response.success) {
        var options = "";
        $.each(response.departments, function (index, department) {
          options += "<option value='" + department.depart_idx + "'>" + department.depart_name + "</option>";
        });
        $("#unassignedDepartments").html(options);
      } else {
        alert("부서 목록을 불러오는 데 실패했습니다.");
      }
    },
    error: function () {
      alert("서버 요청 중 오류가 발생했습니다.");
    }
  });
}

function loadUnassignedRanks(pageIdx) {
  $.ajax({
    url: "getUnassignedRanks.ajax",
    method: "GET",
    data: { pageIdx: pageIdx },
    success: function (response) {
      if (response.success) {
        var options = "";
        $.each(response.ranks, function (index, rank) {
          options += "<option value='" + rank.rank_idx + "'>" + rank.rank_name + "</option>";
        });
        $("#unassignedRanks").html(options);
      } else {
        alert("직급 목록을 불러오는 데 실패했습니다.");
      }
    },
    error: function () {
      alert("서버 요청 중 오류가 발생했습니다.");
    }
  });
}




	// 권한추가 버튼클릭 이벤트
	function addDepartmentRole() {
	    var pageIdx = currentPageIdx; // 현재 선택된 페이지의 page_idx
	    var departIdx = $("#unassignedDepartments").val();
	
	    if (!departIdx) {
	        alert("부서를 선택하세요.");
	        return;
	    }
	
	    $.ajax({
	        url: "assignDepartmentRole.ajax",
	        method: "POST",
	        data: { 'pageIdx': pageIdx, 'departIdx': departIdx },
	        success: function (response) {
	            if (response.success) {
	                alert("부서 권한이 성공적으로 추가되었습니다.");
	                loadPermissions(currentPageUrl); // 페이지 권한 새로고침
	            } else {
	                alert(response.message || "부서 권한 추가에 실패했습니다.");
	            }
	        },
	        error: function () {
	            alert("서버 요청 중 오류가 발생했습니다.");
	        }
	    });
	}


	function addRankRole() {
	    var pageIdx = currentPageIdx; // 현재 선택된 페이지의 page_idx
	    var rankIdx = $("#unassignedRanks").val();

	    // 데이터 검증
	    if (!rankIdx) {
	        alert("직급을 선택하세요.");
	        return;
	    }

	    $.ajax({
	        url: "assignRankRole.ajax",
	        method: "POST",
	        data: { 'pageIdx': pageIdx, 'rankIdx': rankIdx },
	        success: function (response) {
	            if (response.success) {
	                alert("직급 권한이 성공적으로 추가되었습니다.");
	                loadPermissions(currentPageUrl); // 페이지 권한 새로고침
	            } else {
	                alert(response.message || "직급 권한 추가에 실패했습니다.");
	            }
	        },
	        error: function () {
	            alert("서버 요청 중 오류가 발생했습니다.");
	        }
	    });
	}




	
	// 모든 부서목록 가져오기
	function loadAllDepartments() {
	    $.ajax({
	        url: "getAllDepartments.ajax",
	        method: "GET",
	        success: function (response) {
	            if (response.success) {
	                var options = "";
	                $.each(response.departments, function (index, department) {
	                    options += "<option value='" + department.depart_idx + "'>" + department.depart_name + "</option>";
	                });
	                $("#departmentSelect").html(options);

	                // 기본값을 첫 번째 옵션으로 설정
	                if ($("#departmentSelect option").length > 0) {
	                    $("#departmentSelect").val($("#departmentSelect option:first").val());
	                    filterDepartmentRoles(); // 기본값으로 필터링 호출
	                }
	            } else {
	                alert("부서 목록을 가져오는 데 실패했습니다.");
	            }
	        },
	        error: function () {
	            alert("서버 요청 중 오류가 발생했습니다.");
	        }
	    });
	}

	// 모든 직급목록 가져오기
	function loadAllRanks() {
	    $.ajax({
	        url: "getAllRanks.ajax",
	        method: "GET",
	        success: function (response) {
	            if (response.success) {
	                var options = "";
	                $.each(response.ranks, function (index, rank) {
	                    options += "<option value='" + rank.rank_idx + "'>" + rank.rank_name + "</option>";
	                });
	                $("#rankSelect").html(options);

	                // 기본값을 첫 번째 옵션으로 설정
	                if ($("#rankSelect option").length > 0) {
	                    $("#rankSelect").val($("#rankSelect option:first").val());
	                    filterRankRoles(); // 기본값으로 필터링 호출
	                }
	            } else {
	                alert("직급 목록을 가져오는 데 실패했습니다.");
	            }
	        },
	        error: function () {
	            alert("서버 요청 중 오류가 발생했습니다.");
	        }
	    });
	}





//탭 클릭 이벤트
// Right Panel의 탭 클릭 이벤트
$(".right-panel .tabs li").click(function () {
  // 탭 활성화
  $(".right-panel .tabs li").removeClass("active");
  $(this).addClass("active");

  $(".right-panel .tab-content .tab").removeClass("active");
  var tabId = $(this).data("tab");
  $("#" + tabId).addClass("active");

  // 현재 선택된 페이지 정보 가져오기
  var selectedPageRow = $("#pageList tr.selected-page"); // 선택된 tr 찾기
  if (selectedPageRow.length > 0) {
    var pageName = selectedPageRow.find("td:first").text(); // 페이지 이름 가져오기
    var pageUrl = selectedPageRow.data("url"); // URL 가져오기

    // 페이지 이름 및 URL 업데이트
    updatePageName(pageName, pageUrl);
  }

  // 현재 선택된 페이지에 따라 드롭다운 데이터 로드
  var selectedPageIdx = selectedPageRow.data("idx");
  if (tabId === "tab1") {
    loadUnassignedDepartments(selectedPageIdx);
    $("#departmentAddSection").show();
    $("#rankAddSection").hide();
  } else if (tabId === "tab2") {
    loadUnassignedRanks(selectedPageIdx);
    $("#departmentAddSection").hide();
    $("#rankAddSection").show();
  }
});


//Bottom Section의 탭 클릭 이벤트
$(".bottom-section .tabs li").click(function () {
    $(".bottom-section .tabs li").removeClass("active");
    $(this).addClass("active");

    $(".bottom-section .tab-content .tab").removeClass("active");
    var tabId = $(this).data("tab");
    $("#" + tabId).addClass("active");

    // 부서별 권한 탭 선택 시 모든 부서 목록 로드
    if (tabId === "allDepartments") {
        loadAllDepartments();
    }
    // 직급별 권한 탭 선택 시 모든 직급 목록 로드
    if (tabId === "allRanks") {
        loadAllRanks();
    }
});



</script>

</body>
</html>
