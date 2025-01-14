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
    <div class="naviPath">직급 관리</div>

    <div class="content">

      <!-- 직급 목록 -->
      <div class="panel">
        <h2>직급 목록</h2>
        <div class="searchbox">
		  <div class="search">
		    <input type="text" id="searchInput" placeholder="직급명을 입력하세요">
		    <i class="fas fa-search" id="searchIcon"></i>
		  </div>
		  <button class="add-button" onclick="showAddRankModal()">직급 추가</button>
		</div>

        <div class="table-container">
          <table>
            <thead>
              <tr>
                <th>직급 ID</th>
                <th>직급 이름</th>
                <th>수정</th>
                <th>삭제</th>
              </tr>
            </thead>
            <tbody id="rankTable">
              <!-- AJAX로 데이터 채워짐 -->
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>


  <!-- 직급 추가 모달 -->
  <div id="addRankModal" class="modal">
    <div class="modal-container">
      <h2>직급 추가</h2>
      <div class="form-group">
        <label for="newRankName">직급 이름</label>
        <input type="text" id="newRankName">
      </div>
      <button onclick="addRank()">저장</button>
      <button onclick="closeModal('addRankModal')">취소</button>
      
    </div>
  </div>

<script>
// 모든 직급 데이터를 저장할 변수
var ranks = [];


  $(document).ready(function () {
    loadAllRanks();
  });

//모든 직급 목록 가져오기
  function loadAllRanks() {
      $.ajax({
          url: "getAllRanks.ajax",
          method: "GET",
          success: function (response) {
              if (response.success) {
                  ranks = response.ranks; // 데이터를 ranks 배열에 저장
                  renderRanks(ranks); // 화면에 직급 표시
              } else {
            	  modal.showAlert("직급 목록을 가져오는 데 실패했습니다.");
              }
          },
          error: function () {
        	  modal.showAlert("서버 요청 중 오류가 발생했습니다.");
          }
      });
  }
  

//직급 데이터를 테이블에 렌더링
  function renderRanks(data) {
      var rows = "";
      for (var i = 0; i < data.length; i++) {
          var rank = data[i];
          rows += "<tr>" +
              "<td>" + rank.rank_idx + "</td>" +
              "<td>" + rank.rank_name + "</td>" +
              "<td><button onclick=\"updateRank(" + rank.rank_idx + ", '" + rank.rank_name + "')\">수정</button></td>" +
              "<td>";
          // rank_idx가 1~8 사이인 경우 삭제 버튼 비활성화
          if (rank.rank_idx >= 1 && rank.rank_idx <= 8) {
              rows += "<button disabled style=\"background-color: #ccc; cursor: not-allowed;\">삭제</button>";
          } else {
              rows += "<button onclick=\"deleteRank(" + rank.rank_idx + ")\">삭제</button>";
          }
          rows += "</td></tr>";
      }
      $("#rankTable").html(rows);
  }


	// 클라이언트에서 중복 체크
	function isDuplicateRankName(rankName) {
		rankName = rankName.trim();
		
	    return ranks.some(function (rank) {
	        return rank.rank_name === rankName;
	    });
	}

  
	//직급 추가
  function addRank() {
	  	var rankName = $("#newRankName").val();
	    if (!rankName) {
	        modal.showAlert("부서 이름을 입력하세요.");
	        return;
	    }
	    
	    // 중복 체크
	    if (isDuplicateRankName(rankName)) {
	        modal.showAlert("이미 존재하는 직급 이름입니다.");
	        closeModal('addRankModal');
	        return;
	    }
	
	    $.ajax({
	        url: "addRank.ajax",
	        method: "POST",
	        data: { 'rankName': rankName },
	        success: function (response) {
	            if (response.success) {
	                modal.showAlert("직급이 추가되었습니다.");
	                loadAllRanks();
	                closeModal('addRankModal');
	            } else {
	                modal.showAlert("부서 추가 실패: " + response.message);
	            }
	        },
	        error: function () {
	            modal.showAlert("부서 추가 요청 중 오류가 발생했습니다.");
	        }
	    });
	}

  	// 직급 수정
	function updateRank(rankIdx, currentName) {
	    modal.showChangeModal(
	        "직급 이름 변경",
	        currentName,
	        "admin",
	        function (newName) {
	            if (!newName || newName.trim() === "") {
	                modal.showAlert("변경할 직급 이름을 입력하세요.");
	                return;
	            }
	            
	            // 중복 체크
	            if (isDuplicateRankName(currentName)) {
	                modal.showAlert("이미 존재하는 직급 이름입니다.");
	                closeModal('addRankModal');
	                return;
	            }
	
	            $.ajax({
	                url: "updateRank.ajax",
	                method: "POST",
	                data: { rankIdx: rankIdx, rankName: newName }, // newName 사용
	                success: function (response) {
	                    if (response.success) {
	                        modal.showAlert("직급이 수정되었습니다.");
	                        loadAllRanks();
	                    } else {
	                        modal.showAlert("직급 수정 실패: " + response.message);
	                    }
	                },
	                error: function () {
	                    modal.showAlert("직급 수정 요청 중 오류가 발생했습니다.");
	                }
	            });
	        }
	    );
	}

  

      
   // 직급 삭제
  	function deleteRank(rankIdx) {
  	    modal.showConfirm(
 	    	"정말로 이 직급을 삭제하시겠습니까?",
  	        function () {
  	            $.ajax({
  	                url: "deleteRank.ajax",
  	                method: "POST",
  	                data: { rankIdx: rankIdx },
  	                success: function (response) {
  	                    if (response.success) {
  	                        modal.showAlert("직급이 삭제되었습니다.");
  	                        loadAllRanks();
  	                    } else {
  	                        modal.showAlert("직급 삭제 실패: " + response.message);
  	                    }
  	                },
  	                error: function () {
  	                    modal.showAlert("직급 삭제 요청 중 오류가 발생했습니다.");
  	                }
  	            });
  	        }
  	    );
  	}    

  
	//검색 실행 함수
  function executeSearch() {
      var query = $("#searchInput").val().trim().toLowerCase(); // 검색어 가져오기
      if (query === "") {
          renderRanks(ranks); // 검색어가 없으면 전체 목록 표시
          return;
      }

      // 검색어를 포함하는 직급 필터링
      var filteredRanks = ranks.filter(function (rank) {
          return rank.rank_name.toLowerCase().includes(query);
      });

      renderRanks(filteredRanks); // 필터링된 데이터 렌더링
  }
  
  // 모달 닫기
  function closeModal(modalId) {
	  const $modal = $("#" + modalId);
	  $("#new").val(""); // id가 "new"인 필드 초기화
	  $modal.fadeOut(); // 모달 닫기 애니메이션
  }

  // 모달 열기
  function showAddRankModal() {
    $("#addRankModal").show();
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
