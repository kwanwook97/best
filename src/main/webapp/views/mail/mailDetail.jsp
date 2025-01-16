<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="resources/css/root.css" />
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link href="resources/css/mail/mailDetail.css" rel="stylesheet"/>
<style>

</style>
</head>
<body class="bg-theme bg-theme1">
  <jsp:include page="../main/header.jsp"></jsp:include>
  <c:set var="empIdx" value="${sessionScope.loginId}" />
  <div class="dashboard-body">
    <div class="maintext">
      <h3 class="mail">메일함</h3>
      <h3>>&nbsp;&nbsp;메일상세</h3>
    </div>
    <div class="mailbox">
      <table class="mailForm">
        <tr>
          <td>
            <div id="mailSubject" class="specialArea" style="display: flex; align-items: center; justify-content: flex-start;"></div>
          </td>
          <td id="subject"></td>
        </tr>
        <tr>
          <td>보낸 날짜</td>
          <td id="sendDate"></td>
        </tr>
        <tr>
          <td>보낸 사람</td>
          <td id="sender"></td>
        </tr>
        <tr>
          <td>받는 사람</td>
          <td id="receiver"></td>
        </tr>
        <tr>
          <td>참조</td>
          <td id="reference"></td>
        </tr>
        <tr>
          <td>파일 첨부</td>
          <td id="attachments"></td>
        </tr>
        <tr class="content-row">
          <td colspan="2" class="content-box">
            <div id="content" class="mail-content"></div>
          </td>
        </tr>
      </table>
      <div class="btnArea">
        <button type="button" onclick="location.href='mail.go'">
          <i class="fas fa-th-list"></i> 목록으로
        </button>
        <button type="button" class="forward-btn" onclick="location.href='mailForward.go?idx=${param.idx}'">
          <i class="fas fa-share"></i> 전달
        </button>
        <button type="button" class="reply-btn" onclick="location.href='mailReWrite.go?idx=${param.idx}'">
          <i class="fas fa-paper-plane"></i> 답장하기
        </button>
      </div>
    </div>
  </div>
</body>
<script>
$(document).ready(function () {
  var mailIdx = '${param.idx}';
  var emp_idx = ${empIdx}; // 작성자 사번

  // AJAX 요청
  $.ajax({
    type: 'POST',
    url: 'mailDetail.ajax',
    data: { idx: mailIdx },
    dataType: 'json',
    success: function (response) {
      var senderDto = response.senderDto;
      var receiverList = response.receiverList;
      var fileList = response.fileList; // 첨부파일 데이터 추가

      // 보낸 사람인지 확인
      if (senderDto.sender_idx === emp_idx) {
    	// 보낸 사람이면 "전달" 및 "답장하기" 버튼 숨김
        $('.reply-btn').hide();  
    	  
        // 보낸 사람의 starIcon 생성
        var starIcon = $('<i>').addClass(senderDto.special_flag === 1 ? 'bi bi-star-fill' : 'bi bi-star')
          .attr('title', senderDto.special_flag === 1 ? '중요' : '일반')
          .css({ cursor: 'pointer', marginLeft: '10px', color: 'var(--accent-color)' })
          .data('mail-idx', senderDto.mail_send_idx)
          .data('mail-idx-type', 'mail_send_idx')
          .data('current-flag', senderDto.special_flag)
          .on('click', function () { toggleSpecialFlag(this); });

        $('#mailSubject').append($('<span>').text('제목')).append(starIcon);
      } else {
        // 받는 사람의 starIcon 생성
        $.each(receiverList, function (index, receiver) {
          if (receiver.receiver_idx === emp_idx) { // 현재 로그인된 사용자가 받는 사람인지 확인
            var starIcon = $('<i>').addClass(receiver.special_flag === 1 ? 'bi bi-star-fill' : 'bi bi-star')
              .attr('title', receiver.special_flag === 1 ? '중요' : '일반')
              .css({ cursor: 'pointer', marginLeft: '10px', color: 'var(--accent-color)' })
              .data('mail-idx', receiver.mail_receive_idx)
              .data('mail-idx-type', 'mail_receive_idx')
              .data('current-flag', receiver.special_flag)
              .on('click', function () { toggleSpecialFlag(this); });

            $('#mailSubject').append($('<span>').text('제목')).append(starIcon);
          }
        });
      }

      // 제목 내용
      $('#subject').text(senderDto.subject);

      // 보낸 날짜
      $('#sendDate').text(senderDto.date);

      // 보낸 사람
      $('#sender').text(senderDto.sender_name + ' <' + senderDto.sender_email + '>');

   		// 받는 사람
      var receiverHtml = '';
      $.each(receiverList, function (index, receiver) {
          var name = receiver.receiver_name || '이름 없음'; // 이름 기본값 제공
          var email = receiver.receiver_email || '이메일 없음'; // 이메일 기본값 제공

          // HTML 엔티티로 변환
          var safeName = $('<div>').text(name).html(); 
          var safeEmail = $('<div>').text(email).html();

          if (receiver.receiver_type === 0) {
              receiverHtml += '<div class="receiver-item">' + safeName + ' &lt;' + safeEmail + '&gt;</div>';
          }
      });
      $('#receiver').html(receiverHtml);


   		// 참조
      var referenceHtml = '';
      $.each(receiverList, function (index, receiver) {
          var name = receiver.receiver_name || '이름 없음'; // 이름 기본값 제공
          var email = receiver.receiver_email || '이메일 없음'; // 이메일 기본값 제공

          // HTML 엔티티로 변환
          var safeName = $('<div>').text(name).html(); 
          var safeEmail = $('<div>').text(email).html();

          if (receiver.receiver_type === 1) {
              referenceHtml += '<div class="receiver-item">' + safeName + ' &lt;' + safeEmail + '&gt;</div>';
          }
      });
      $('#reference').html(referenceHtml);


      // 내용
      $('#content').html(senderDto.content);
      
 	  // 첨부파일
      var attachmentHtml = '';
      if (fileList && fileList.length > 0) {
          $.each(fileList, function (index, file) {
              attachmentHtml += '<div style="display: flex; align-items: center; margin-bottom: 5px;">';
              attachmentHtml += '<a href="mailAttachDown.do?newfile_name=' + encodeURIComponent(file.newfile_name) + '&file_name=' + encodeURIComponent(file.file_name) + '" ' +
                                'title="파일 다운로드: ' + file.file_name + '" ' +
                                'style="color: var(--primary-color); text-decoration: underline; font-weight: bold;">' +
                                file.file_name +
                                '</a>';
              attachmentHtml += '<i class="fas fa-download" style="margin-left: 10px; color: var(--accent-color); cursor: pointer;" title="다운로드"></i>';
              attachmentHtml += '</div>';
          });
      } else {
          attachmentHtml = '첨부파일 없음';
      }
      $('#attachments').html(attachmentHtml);
      
    },
    error: function (error) {
      console.error('메일 상세 정보 로드 중 오류 발생:', error);
      alert('메일 상세 정보를 가져오는 중 문제가 발생했습니다.');
    }
  });
});

function toggleSpecialFlag(iconElement) {
  var mailIdx = $(iconElement).data('mail-idx');
  var mailIdxType = $(iconElement).data('mail-idx-type');
  var currentFlag = $(iconElement).data('current-flag');
  var newFlag = currentFlag === 1 ? 0 : 1;

  $.ajax({
    type: 'POST',
    url: 'updateSpecialStatus.ajax',
    data: {
      mailIdxType: mailIdxType,
      mailIdx: mailIdx,
      special_flag: newFlag
    },
    success: function () {
      if (newFlag === 1) {
        $(iconElement).removeClass('bi-star').addClass('bi-star-fill').attr('title', '중요');
      } else {
        $(iconElement).removeClass('bi-star-fill').addClass('bi-star').attr('title', '일반');
      }
      $(iconElement).data('current-flag', newFlag);
    },
    error: function (error) {
      console.error('중요 상태 업데이트 오류:', error);
      alert('중요 상태를 변경하는 중 문제가 발생했습니다. 다시 시도해주세요.');
    }
  });
}
</script>
</html>
