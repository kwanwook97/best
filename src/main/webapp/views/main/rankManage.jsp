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

    .naviPath {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 20px;
      color: var(--primary-color);
    }

    .content {
      display: flex;
      justify-content: space-between;
      margin-top: 30px;
      height: 80%;
    }

    .panel {
      width: 95%;
      border: 2px solid var(--primary-color);
      border-radius: 10px;
      background-color: var(--light-color);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }

    .panel h2 {
      margin-bottom: 15px;
    }

    .table-container {
      max-height: 80%;
      overflow-y: auto;
      margin-top: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    table th, table td {
      padding: 10px;
      text-align: center;
      border: 1px solid var(--primary-color);
    }

    table th {
      background-color: var(--primary-color);
      color: #fff;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    .form-group input {
      width: 100%;
      padding: 10px;
      border: 1px solid var(--primary-color);
      border-radius: 5px;
      font-size: 16px;
    }

    button {
      background-color: var(--accent-color);
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }

	table button{
		width: 100%;
	}

    button:hover {
      background-color: #FF527D;
    }
    
    <style>
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
	
	
	
  .searchbox {
    display: flex;
    align-items: center;
    justify-content: space-between; /* 검색창과 버튼을 양쪽 끝으로 배치 */
    margin-bottom: 15px;
  }

  .search {
    position: relative;
    flex-grow: 1; /* 검색창이 가능한 넓게 확장 */
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
    width: 100%;
  }

  .search i {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 18px;
    pointer-events: all; 
    color: var(--accent-color);
    cursor: pointer;
  }

  .add-button {
    margin-left: 15px; /* 검색창과 버튼 사이의 간격 */
    background-color: var(--accent-color);
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    height: 42px; /* 검색창과 동일한 높이 */
  }

  .add-button:hover {
    background-color: #FF527D;
  }
	
  label{
  	color: var(--primary-color) !important;
  	text-align: left;
  }    
    
  </style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/adminHeader.jsp"/>
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
                  alert("직급 목록을 가져오는 데 실패했습니다.");
              }
          },
          error: function () {
              alert("서버 요청 중 오류가 발생했습니다.");
          }
      });
  }
  

  // 직급 데이터를 테이블에 렌더링
  function renderRanks(data) {
      var rows = "";
      for (var i = 0; i < data.length; i++) {
          var rank = data[i];
          rows += "<tr>" +
              "<td>" + rank.rank_idx + "</td>" +
              "<td>" + rank.rank_name + "</td>" +
              "<td><button onclick=\"updateRank(" + rank.rank_idx + ", '" + rank.rank_name + "')\">수정</button></td>" +
              "<td><button onclick=\"deleteRank(" + rank.rank_idx + ")\">삭제</button></td>" +
              "</tr>";
      }
      $("#rankTable").html(rows);
  }

//직급 추가
  function addRank() {
      var rankName = $("#newRankName").val();
      if (!rankName) {
          alert("직급 이름을 입력하세요.");
          return;
      }
      $.post("addRank.ajax", { 'rankName': rankName }, function (response) {
          if (response.success) {
              alert("직급이 추가되었습니다.");
              loadAllRanks();
              closeModal('addRankModal');
          } else {
              alert("직급 추가 실패: " + response.message);
          }
      });
  }

  // 직급 수정
  function updateRank(rankIdx, rankName) {
      var newRankName = prompt("새로운 직급 이름을 입력하세요:", rankName);
      if (newRankName) {
          $.post("updateRank.ajax", { rankIdx: rankIdx, rankName: newRankName }, function (response) {
              if (response.success) {
                  alert("직급이 수정되었습니다.");
                  loadAllRanks();
              } else {
                  alert("직급 수정 실패: " + response.message);
              }
          });
      }
  }

  // 직급 삭제
  function deleteRank(rankIdx) {
      if (confirm("정말로 이 직급을 삭제하시겠습니까?")) {
          $.post("deleteRank.ajax", { rankIdx: rankIdx }, function (response) {
              if (response.success) {
                  alert("직급이 삭제되었습니다.");
                  loadAllRanks();
              } else {
                  alert("직급 삭제 실패: " + response.message);
              }
          });
      }
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
    $("#" + modalId).fadeOut();
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
</script>

</body>
</html>
