<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="resources/css/main/departAndRankManage.css" rel="stylesheet"/>
  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/adminHeader.jsp"/>
  <jsp:include page="../modal/modal.jsp"></jsp:include>
  <div class="body">
    <div class="naviPath">부서 관리</div>

    <div class="content">
      <!-- 부서 목록 -->
      <div class="panel">
        <h2>부서 목록</h2>
        <div class="searchbox">
		  <div class="search">
		    <input type="text" id="searchInput" placeholder="부서명을 입력하세요">
		    <i class="fas fa-search" id="searchIcon"></i>
		  </div>
		  <button class="add-button" onclick="showAddDepartmentModal()">부서 추가</button>
		</div>
        <div class="table-container">
          <table>
            <thead>
              <tr>
                <th>부서 ID</th>
                <th>부서 이름</th>
                <th>수정</th>
                <th>삭제</th>
              </tr>
            </thead>
            <tbody id="departmentTable">
              <!-- AJAX로 데이터 채워짐 -->
            </tbody>
          </table>
        </div>
      </div>

    </div>
  </div>

  <!-- 부서 추가 모달 -->
  <div id="addDepartmentModal" class="modal">
    <div class="modal-container">
      <h2>부서 추가</h2>
      <div class="form-group">
        <label for="newDepartmentName">부서 이름</label>
        <input type="text" id="newDepartmentName">
      </div>
      <button onclick="addDepartment()">저장</button>
      <button onclick="closeModal('addDepartmentModal')">취소</button>
    </div>
  </div>


  <script>
  var departments = []; // 모든 부서 데이터를 저장할 배열
  
  $(document).ready(function () {
	    loadAllDepartments();
	  });

	// 모든 부서 목록 가져오기
	function loadAllDepartments() {
	    $.ajax({
	        url: "getAllDepartments.ajax",
	        method: "GET",
	        success: function (response) {
	            if (response.success) {
	                departments = response.departments; // 데이터를 로컬 변수에 저장
	                renderDepartments(departments); // 화면에 부서 표시
	            } else {
	            	modal.showAlert("부서 목록을 가져오는 데 실패했습니다.");
	            }
	        },
	        error: function () {
	        	modal.showAlert("서버 요청 중 오류가 발생했습니다.");
	        }
	    });
	}

	  
	// 부서 데이터를 테이블에 렌더링
	function renderDepartments(data) {
	    var rows = "";
	    for (var i = 0; i < data.length; i++) {
	        var dept = data[i];
	        rows += "<tr>" +
	            "<td>" + dept.depart_idx + "</td>" +
	            "<td>" + dept.depart_name + "</td>" +
	            "<td><button onclick=\"editDepartment(" + dept.depart_idx + ", '" + dept.depart_name + "')\">수정</button></td>" +
	            "<td>";
	        // depart_idx가 1~5 사이인 경우 삭제 버튼 비활성화
	        if (dept.depart_idx >= 1 && dept.depart_idx <= 5) {
	            rows += "<button disabled style=\"background-color: #ccc; cursor: not-allowed;\">삭제</button>";
	        } else {
	            rows += "<button onclick=\"deleteDepartment(" + dept.depart_idx + ")\">삭제</button>";
	        }
	        rows += "</td></tr>";
	    }
	    $("#departmentTable").html(rows);
	}

	  
	// 클라이언트에서 중복 체크
	function isDuplicateDepartmentName(departName) {
		
		departName = departName.trim();
		
	    return departments.some(function (dept) {
	        return dept.depart_name === departName;
	    });
	}
	
	// 부서 추가
	function addDepartment() {
	    var name = $("#newDepartmentName").val();
	    if (!name) {
	        modal.showAlert("부서 이름을 입력하세요.");
	        return;
	    }
	    
	    // 클라이언트에서 중복 확인
	    if (isDuplicateDepartmentName(name)) {
	    	closeModal('addDepartmentModal');
	        modal.showAlert("이미 존재하는 부서 이름입니다.");
	        return;
	    }
	
	    $.ajax({
	        url: "addDepartment.ajax",
	        method: "POST",
	        data: { departName: name },
	        success: function (response) {
	            if (response.success) {
	                modal.showAlert("부서가 추가되었습니다.");
	                loadAllDepartments();
	                closeModal('addDepartmentModal');
	            } else {
	                modal.showAlert("부서 추가 실패: " + response.message);
	            }
	        },
	        error: function () {
	            modal.showAlert("부서 추가 요청 중 오류가 발생했습니다.");
	        }
	    });
	}

	// 부서 수정
	function editDepartment(departIdx, currentName) {
	    modal.showChangeModal(
	        "부서 이름 변경", // 모달 제목
	        currentName, // 기존 값
	        "admin", // 담당자
	        function (newName) {
	            if (!newName || newName.trim() === "") {
	                modal.showAlert("변경할 부서 이름을 입력하세요.");
	                return;
	            }
	
	         	// 클라이언트에서 중복 확인
	            if (isDuplicateDepartmentName(newName)) {
	                modal.showAlert("이미 존재하는 부서 이름입니다.");
	                return;
	            }
	            
	            $.ajax({
	                url: "updateDepartment.ajax",
	                method: "POST",
	                data: { departIdx: departIdx, departName: newName },
	                success: function (response) {
	                    if (response.success) {
	                        modal.showAlert("부서가 수정되었습니다.");
	                        loadAllDepartments();
	                    } else {
	                        modal.showAlert("부서 수정 실패: " + response.message);
	                    }
	                },
	                error: function () {
	                    modal.showAlert("부서 수정 요청 중 오류가 발생했습니다.");
	                }
	            });
	        }
	    );	
	}



	  // 부서 삭제
	function deleteDepartment(departIdx) {
	    modal.showConfirm(
	        "정말로 이 부서를 삭제하시겠습니까?",
	        function () {
	            $.ajax({
	                url: "deleteDepartment.ajax",
	                method: "POST",
	                data: { departIdx: departIdx },
	                success: function (response) {
	                    if (response.success) {
	                        modal.showAlert("부서가 삭제되었습니다.");
	                        loadAllDepartments();
	                    } else {
	                        modal.showAlert("부서 삭제 실패: " + response.message);
	                    }
	                },
	                error: function () {
	                    modal.showAlert("부서 삭제 요청 중 오류가 발생했습니다.");
	                }
	            });
	        }
	    );
	}
	  
	  // 모달 닫기
	  function closeModal(modalId) {
		  const $modal = $("#" + modalId);
		  $("#new").val(""); // id가 "new"인 필드 초기화
		  $modal.fadeOut(); // 모달 닫기 애니메이션
	  }

	  // 모달 열기
	  function showAddDepartmentModal() {
	    $("#addDepartmentModal").show();
	  }
	  
	  
		// 검색 실행 함수
	  function executeSearch() {
	      var query = $("#searchInput").val().trim().toLowerCase(); // 검색어 가져오기 (소문자 변환)
	      if (query === "") {
	          renderDepartments(departments); // 검색어가 없으면 전체 목록 표시
	          return;
	      }

	      // 검색어를 포함하는 부서 필터링
	      var filteredDepartments = departments.filter(function (dept) {
	          return dept.depart_name.toLowerCase().includes(query);
	      });

	      renderDepartments(filteredDepartments); // 필터링된 데이터 렌더링
	  }

	  
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
	  

    function showChangeModal(title, currentValue, manager, callback) {
        console.log('showChangeModal called'); // 디버깅 로그
        var $modal = $('.change_modal');
        if ($modal.length === 0) {
            console.error('Change modal not found.');
            return;
        }

        $('#modalTitle').text(title);
        $('#current').val(currentValue);
        $('#manager').val(manager);

        $modal.css('display', 'flex'); // 모달 표시

        $modal.find('.full_btn_change').off('click').on('click', function () {
            console.log('Change button clicked'); // 디버깅 로그
            var newValue = $('#new').val();
            if (typeof callback === 'function') {
                callback(newValue);
            }
            hideChangeModal();
        });

        $modal.find('.full_btn_cancel').off('click').on('click', function () {
            console.log('Cancel button clicked'); // 디버깅 로그
            hideChangeModal();
        });
    }


    
 // 모달창 변경
    window.modal = {
    	    showChangeModal: showChangeModal,
    	    showAlert: function (message) {
    	        var $alertModal = $('.modal_alert'); // 커스텀 alert 모달 선택
    	        if ($alertModal.length === 0) {
    	            console.error('Alert modal not found.');
    	            return;
    	        }

    	        // 메시지 설정
    	        $alertModal.find('.modal_body').html('<p>' + message + '</p>');

    	        // 모달 표시
    	        $alertModal.css('display', 'flex');

    	        // 확인 버튼 클릭 시 모달 닫기
    	        $alertModal.find('.btn_confirm').off('click').on('click', function () {
    	            $alertModal.css('display', 'none'); // 모달 숨김
    	        });
    	    },
    	    showConfirm: function (message, callback) {
    	        var $confirmModal = $('.modal_confirm');
    	        if ($confirmModal.length === 0) {
    	            console.error('Confirm modal not found.');
    	            return;
    	        }

    	        // 메시지 설정
    	        $confirmModal.find('.modal_body').html('<p>' + message + '</p>');

    	        // 모달 표시
    	        $confirmModal.css('display', 'flex');

    	        // 확인 버튼 클릭
    	        $confirmModal.find('.btn_confirm').off('click').on('click', function () {
    	            if (typeof callback === 'function') {
    	                callback(); // 콜백 실행
    	            }
    	            $confirmModal.css('display', 'none'); // 모달 닫기
    	        });

    	        // 취소 버튼 클릭
    	        $confirmModal.find('.btn_cancel').off('click').on('click', function () {
    	            $confirmModal.css('display', 'none'); // 모달 닫기
    	        });
    	    },
    	};





  </script>
</body>
</html>
