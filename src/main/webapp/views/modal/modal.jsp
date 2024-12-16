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

    function showConfirm(message, location) {
        var confirmModal = document.querySelector('.modal_confirm');
        showModal(confirmModal, message);

        var confirmButton = confirmModal.querySelector('.btn_confirm');
        if (confirmButton) {
            confirmButton.onclick = function () {
                window.location.href = location;
            };
        }
    }

    window.modal = {
        showAlert: showAlert,
        showConfirm: showConfirm
    };
})();
</script>

</body>
</html>
