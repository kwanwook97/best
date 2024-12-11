<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <title>Modal Example</title>
  <style>

  </style>
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
</body>
</html>

<script>
  const alertCont = document.querySelector('.modal_alert');
  const confirmCont = document.querySelector('.modal_confirm');

  const modal = {
    hide: function () {
      alertCont.style.display = 'none';
      confirmCont.style.display = 'none';
    },
    show: function (modalElement, message) {
      const modalBody = modalElement.querySelector('.modal_body');
      if (!modalBody) {
        console.error('modal_body element not found in', modalElement);
        return;
      }
      // 로그 추가
      console.log('Updating modal_body content:', message);

      // 내용 업데이트
      modalBody.innerHTML = `<p>message</p>`;
      modalElement.style.display = 'flex';

      // 버튼 이벤트 추가
      const closeButtons = modalElement.querySelectorAll('.btn_cancel, .btn_confirm');
      closeButtons.forEach(button => {
        button.addEventListener('click', modal.hide, { once: true });
      });
    },
    showAlert: function (msg) {
      this.show(alertCont, msg);
    },
    showConfirm: function (msg, loc) {
      this.show(confirmCont, msg);
      const confirmButton = confirmCont.querySelector('.btn_confirm');
      if (confirmButton) {
        confirmButton.addEventListener(
          'click',
          function () {
            location.href = loc;
          },
          { once: true }
        );
      }
    },
  };

</script>
