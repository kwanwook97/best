<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		:root {
			--primary-color: #30005A;
			--secondary-color: #8B6AA7;
			--accent-color: #E9396B;
		}

		.dashboard-body {
			margin-left: 16vw;
			width: 85vw;
			margin-top: 7vh;
			padding: 2vh;
			height: 100%;
			display: flex;
			flex-direction: column;
			align-items: flex-start;
		}
		
		.maintext {
			display: flex;
			margin-left: 10px;
		}

		.mailbox {
			border: 2px solid var(--primary-color);
			width: 95%;
			height: 85%;
			border-radius: 10px;
			padding: 10px;
			display: flex;
			flex-direction: column;
		}

		.mailForm {
			width: 100%;
			height: 100%;
			border-collapse: collapse;
			display: table;
		}

		.mailForm tr {
			display: table-row;
		}

		.mailForm td {
			padding: 5px 10px;
			vertical-align: middle;
		    line-height: 1.6;
			border: none;
		}

		.mailForm td:first-child {
			width: 15%;
			font-weight: bold;
			background-color: #FFFBF2;
		}

		.mailForm tr.content-row {
			height: 100%; /* 마지막 행이 남은 공간 차지 */
		}

		.mailForm td.content-box {
			height: 100%;
		}

		.mail-content {
			width: 100%;
			height: 100%;
			overflow-y: auto;
			border: 1px solid #ccc;
			border-radius: 5px;
			padding: 10px;
			box-sizing: border-box;
			background-color: #fff;
		}

		.receiver-item {
			display: inline-block;
			background-color: #d1badb; /* 바이올렛 배경 */
			padding: 5px 10px; /* 내부 여백 */
			border-radius: 15px; /* 둥근 모서리 */
			margin: 5px; /* 항목 간 여백 */
			color: #30005A; /* 글자 색상 */
			font-weight: bold; /* 글자 굵기 */
		}



		.btnArea {
			text-align: right;
			margin-top: 20px;
		}

		.btnArea button {
			height: 40px;
			min-width: 120px;
			padding: 5px 10px;
			font-size: 16px;
			font-weight: bold;
			background-color: #8B6AA7;
			border: none;
			border-radius: 5px;
			color: white;
		}

		.btnArea button:hover {
			background-color: var(--primary-color);
		}
		
		table, tr, td{
			border: 1px solid #ddd !important;
		}
	</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="mail">메일함</h3>
			<h3>>&nbsp;&nbsp;메일상세</h3>
		</div>
		<div class="mailbox">
			<table class="mailForm">
				<tr>
					<td>
				        <div class="specialArea" style="display: flex; align-items: center; justify-content: flex-start;">
						    <span>제목</span>
						    <c:choose>
						        <c:when test="${senderDto.sender_idx == 1}">
						            <i class="${senderDto.special_flag == 1 ? 'bi bi-star-fill' : 'bi bi-star'}"
						               title="${senderDto.special_flag == 1 ? '중요' : '일반'}"
						               style="cursor: pointer; margin-left: 10px; color: var(--accent-color);"
						               data-mail-idx="${senderDto.mail_send_idx}"
						               data-mail-idx-type="mail_send_idx"
						               data-current-flag="${senderDto.special_flag}"
						               onclick="toggleSpecialFlag(this)">
						            </i>
						        </c:when>
						        <c:otherwise>
						            <c:forEach var="receiver" items="${receiverList}">
						                <c:if test="${receiver.receiver_idx == 1}">
						                    <i class="${receiver.special_flag == 1 ? 'bi bi-star-fill' : 'bi bi-star'}"
						                       title="${receiver.special_flag == 1 ? '중요' : '일반'}"
						                       style="cursor: pointer; margin-left: 10px; color: var(--accent-color);"
						                       data-mail-idx="${receiver.mail_receive_idx}"
						                       data-mail-idx-type="mail_receive_idx"
						                       data-current-flag="${receiver.special_flag}"
						                       onclick="toggleSpecialFlag(this)">
						                    </i>
						                </c:if>
						            </c:forEach>
						        </c:otherwise>
						    </c:choose>
						</div>	

				    </td>
					<td>${senderDto.subject}</td>
				</tr>
				<tr>
					<td>보낸 날짜</td>
					<td><fmt:formatDate value="${senderDto.date}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
				<tr>
					<td>보낸 사람</td>
					<td>${senderDto.sender_name} &lt;${senderDto.sender_email}&gt;</td>
				</tr>
				<tr>
					<td>받는 사람</td>
					<td>
						<c:forEach var="receiver" items="${receiverList}">
							<c:if test="${receiver.receiver_type == 0}">
								<div class="receiver-item">
									${receiver.receiver_name} &lt;${receiver.receiver_email}&gt;
								</div>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>참조</td>
					<td>
						<c:forEach var="refer" items="${receiverList}">
							<c:if test="${refer.receiver_type == 1}">
								<div class="receiver-item">
									${refer.receiver_name} &lt;${refer.receiver_email}&gt;
								</div>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>파일 첨부</td>
					<td>
					
					</td>
				</tr>
				
				<tr class="content-row">
					<td colspan="2" class="content-box">
						<div class="mail-content">
							<c:out value="${senderDto.content}" escapeXml="false" />
						</div>
					</td>
				</tr>
			</table>
			<div class="btnArea">
			    <button type="button" onclick="location.href='mail.go'">
			        <i class="fas fa-th-list"></i> 목록으로
			    </button>
			    <button type="button" class="forward-btn" onclick="forwardMail(${senderDto.mail_send_idx})">
			        <i class="fas fa-share"></i> 전달
			    </button>
			    <!-- 답장하기 버튼 -->
			    <button type="button" class="reply-btn" onclick="replyMail(${senderDto.mail_send_idx})">
			        <i class="fas fa-paper-plane"></i> 답장하기
			    </button>
			</div>
		</div>
	</div>
</body>
<script>
/* 전역변수 */
var empIdx = 1;

function toggleSpecialFlag(iconElement) {
    // 클릭된 아이콘에서 data- 속성 값 가져오기
    const mailIdx = $(iconElement).data('mail-idx');
    const mailIdxType = $(iconElement).data('mail-idx-type');
    const currentFlag = $(iconElement).data('current-flag');
    const newFlag = currentFlag === 1 ? 0 : 1; // 반대 상태 설정

    // 메일 읽음처리

    // AJAX 요청으로 중요 상태 업데이트
    $.ajax({
        type: 'POST',
        url: 'updateSpecialStatus.ajax', // 적절한 서버 URL로 변경
        data: {
            mailIdxType: mailIdxType,
            mailIdx: mailIdx,
            special_flag: newFlag // 새 상태 전달
        },
        success: function () {
            // 성공 시 아이콘 상태 업데이트
            if (newFlag === 1) {
                $(iconElement)
                    .removeClass('bi-star')
                    .addClass('bi-star-fill')
                    .attr('title', '중요');
            } else {
                $(iconElement)
                    .removeClass('bi-star-fill')
                    .addClass('bi-star')
                    .attr('title', '일반');
            }

            // HTML 데이터 속성 업데이트
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

