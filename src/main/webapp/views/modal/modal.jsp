<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <!-- modal CSS -->
  <link rel="stylesheet" href="resources/css/common.css">
</head>
<body>

  <!-- Confirm Modal -->
  <div class="modal modal_confirm">
    <div class="modal_container">
      <div class="modal_body"></div>
      <div class="modal_footer">
        <button class="btn_confirm">확인</button>
        <button class="btn_cancel">취소</button>
      </div>
    </div>
  </div>

  <!-- Alert Modal -->
  <div class="modal modal_alert">
    <div class="modal_container">
      <div class="modal_body"></div>
      <div class="modal_footer">
        <button class="btn_confirm" style="width: 100%;">확인</button>
      </div>
    </div>
  </div>
  
  
  <!-- Change Modal -->
  <div class="change_modal modal_change">
	  <div class="change_modal_container">
	    <!-- 제목을 동적으로 설정할 부분 -->
	    <h2 id="modalTitle" class="change_modal_title">변경</h2>
	    <table class="modal_table">
	      <tr>
	        <th>기존 값</th>
	        <td><input type="text" id="current" class="input_field" readonly></td>
	      </tr>
	      <tr>
	        <th>변경 값</th>
	        <td id="newVal"><input type="text" id="new" class="input_field"></td>
	      </tr>
	      <tr>
	        <th>담당자</th>
	        <td><input type="text" id="manager" class="input_field" value="홍길동" readonly></td>
	      </tr>
	    </table>
	    <div class="change_modal_footer">
	      <button class="full_btn_change">변경 하기</button>
	      <button class="full_btn_cancel">취소</button>
	    </div>	
	  </div>
  </div>
  	


<script>
	(function () {
	    function hideModal() {
	        var alertModal = document.querySelector('.modal_alert');
	        var confirmModal = document.querySelector('.modal_confirm');
	        if (alertModal) alertModal.style.display = 'none';
	        if (confirmModal) confirmModal.style.display = 'none';
	    }
	
	    function showModal(modalElement, message) {
	        var modalBody = modalElement.querySelector('.modal_body');
	        if (!modalBody) {
	            console.error('modal_body element not found in', modalElement);
	            return;
	        }
	
	        modalBody.innerHTML = '<p>' + message + '</p>';
	        modalElement.style.display = 'flex';
	
	        var closeButtons = modalElement.querySelectorAll('.btn_cancel, .btn_confirm');
	        for (var i = 0; i < closeButtons.length; i++) {
	            closeButtons[i].onclick = hideModal;
	        }
	    }
	
	    function showAlert(message) {
	        var alertModal = document.querySelector('.modal_alert');
	        showModal(alertModal, message);
	    }

	    
	 	function showConfirm(message, action) {
		    var confirmModal = document.querySelector('.modal_confirm');
		    var modalBody = confirmModal.querySelector('.modal_body');
		    modalBody.innerHTML = '<p>' + message + '</p>';
		    confirmModal.style.display = 'flex';

		    var confirmButton = confirmModal.querySelector('.btn_confirm');
		    confirmButton.onclick = function () {
		        if (typeof action === 'function') {
		            action(); // 콜백 함수 실행
		        } else if (typeof action === 'string') {
		            window.location.href = action; // URL로 이동
		        }
		        confirmModal.style.display = 'none'; // 모달 닫기
		    };

		    var cancelButton = confirmModal.querySelector('.btn_cancel');
		    cancelButton.onclick = function () {
		        confirmModal.style.display = 'none'; // 모달 닫기
		    };
		}
	 
	    window.modal = {
	        showAlert: showAlert,
	        showConfirm: showConfirm
	    };
	})();


	/* 변경 모달 */
	// 모달을 열고 값 삽입하는 함수
	function showChangeModal(modalTitle, currentValue, manager) {
	  // 모달 제목 설정
	  document.getElementById('modalTitle').innerText = modalTitle;
	
	  // 기존 값 설정
	  document.getElementById('current').value = currentValue;
	  
	  // 변경자 세팅
	  document.getElementById('manager').value = manager;
	  
	  // 모달 표시
	  document.querySelector('.change_modal.modal_change').style.display = 'flex';
	}
	
	
	// 모달 닫기
	function hideChangeModal() {
	  document.querySelector('.change_modal.modal_change').style.display = 'none';
	}
	
</script>

</body>
</html>
