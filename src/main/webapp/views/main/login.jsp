<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>BEST</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <!-- Bootstrap core CSS-->
  <link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- Custom Style-->
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <script src="resources/js/bootstrap.min.js"></script>
  <style>
  .bg-th111{
    		background-image: url('resources/img/busbusbus.webp');
    		 background-size: cover; /* 이미지가 화면 전체를 덮도록 설정 */
   	 		/*background-repeat: no-repeat; /* 이미지가 반복되지 않도록 설정 */ */
    		background-position: center; 
    	}
    .modal-content{
    	background-color: #30005A;
    	left: 126px;
    	top: 244px;
    	color: #FFFBF2;
    	border-radius: 10px;
    	position: relative;
    display: flex;
    flex-direction: column;
    width: 100%;
    pointer-events: auto;
    background-clip: padding-box;
    border: 1px solid rgba(0, 0, 0, .2);
    outline: 0;
    }
    .modal-header{
    	padding: 1rem;
    }
    #resetPasswordForm button, #changePasswordForm button{
    	background-color: #E9396B;
    	border-color: #30005A;
    }
    .close{
    	color: #E9396B;
    }
    .loginType{
    	color: #E9396B;
    }
    .loginType:hover{
    	color: #E9396B;
    }
    .resetPW{
		color: #FFFBF2 !important;
	}
	
	.form-group{
	    display: flex;
    	flex-direction: column;
	}
  </style>
</head>

<body class="bg-th111">

<!-- start loader -->
   <div id="pageloader-overlay" class="visible incoming"><div class="loader-wrapper-outer"><div class="loader-wrapper-inner" ><div class="loader"></div></div></div></div>
   <!-- end loader -->

<!-- Start wrapper-->
 <div id="wrapper">

 <div class="loader-wrapper"><div class="lds-ring"><div></div><div></div><div></div><div></div></div></div>
	<div class="card card-authentication1 mx-auto my-5">
		<div class="card-body">
		 <div class="card-content p-2">
		 	<div class="text-center">
		 		<h2 style="color:#E9396B; font-weight:700;">BEST</h2>
		 	</div>
		  <div class="card-title text-uppercase text-center py-3">User Login</div>
		  
		  
		  
		  
		  <!-- 여기에 조건부 메시지 표시 -->
			<c:if test="${param.logout == 'success'}">
			    <div class="alert alert-success text-center" role="alert">
			        성공적으로 로그아웃되었습니다.
			    </div>
			</c:if>
			<c:if test="${param.error == 'invalid'}">
			    <div class="alert alert-danger text-center" role="alert">
			        아이디 또는 비밀번호가 잘못되었습니다.
			    </div>
			</c:if>
		  
		  
		  
		  
		  
		  
		    <form action="login.do" method="post">
			  <div class="form-group">
			  <label for="exampleInputUsername" class="sr-only">Username</label>
			   <div class="position-relative has-icon-right">
				  <input type="text" id="exampleInputUsername" name="id" class="form-control input-shadow" placeholder="Enter User ID">
				  <div class="form-control-position">
					  <i class="icon-user"></i>
				  </div>
			   </div>
			  </div>
			  <div class="form-group">
			  <label for="exampleInputPassword" class="sr-only">Password</label>
			   <div class="position-relative has-icon-right">
				  <input type="password" id="exampleInputPassword" name="pw" class="form-control input-shadow" placeholder="Enter Password">
				  <div class="form-control-position">
					  <i class="icon-lock"></i>
				  </div>
			   </div>
			  </div>
			<div class="form-row">
			 <div class="form-group col-6">
			   <div class="icheck-material-white">
                <a class="loginType" href="adminLogin.go">Admin Login</a>
			  </div>
			 </div>
			 <div class="form-group col-6 text-right">
			  <a href="#" class="resetPW" data-toggle="modal" data-target="#resetPasswordModal">비밀번호 찾기</a>
			  <a href="#" class="resetPW" data-toggle="modal" data-target="#changePasswordModal">비밀번호 변경</a>
			 </div>
			</div>
			 <button type="submit" class="btn btn-light btn-block">Sign In</button>

			 
			 </form>
		   </div>
		  </div>
	     </div>
<div class="modal fade" id="resetPasswordModal" tabindex="0" role="dialog" aria-labelledby="resetPasswordModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resetPasswordModalLabel">Reset Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="resetPasswordForm">
          <div class="form-group">
            <label for="resetId">ID</label>
            <input type="text" class="form-control" id="resetId" name="id" placeholder="Enter User ID" required>
          </div>
          <div class="form-group">
            <label for="resetEmail">Email Address</label>
            <input type="email" class="form-control" id="resetEmail" name="email" placeholder="Enter Email Address" required>
          </div>
          <button type="button" class="btn btn-primary btn-block" id="resetPasswordBtn">Reset Password</button>
        </form>
        <div id="resetPasswordMessage" class="mt-3 text-center"></div> <!-- 메시지 표시 영역 -->
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="changePasswordModal" tabindex="0" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="changePasswordForm">
          <div class="form-group">
            <label for="resetId">ID</label>
            <input type="text" class="form-control" id="changeId" name="id" placeholder="Enter User ID" required>
          </div>
          <div class="form-group">
            <label for="resetEmail">Email Address</label>
            <input type="email" class="form-control" id="changeEmail" name="email" placeholder="Enter Email Address" required>
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="changePassword" name="pw" placeholder="Enter Password" required>
          </div>
          <div class="form-group">
            <label for="changePw">Change Password</label>
            <input type="password" class="form-control" id="changePw" name="changePw" placeholder="Enter Change Password" required>
          </div>
          <div class="form-group">
            <label for="resetEmail">Change Password Check</label>
            <input type="password" class="form-control" id="changePwcheck" name="pwCheck" placeholder="Enter Change Password Check" required>
          	<div id="pwCheckMessage" class="text-center mt-2"></div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">Change Password</button>
        </form>
      </div>
    </div>
  </div>
</div>
     <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

	</div><!--wrapper-->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="messageModalLabel">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="messageModalBody">
        <!-- 메시지 내용이 여기에 표시됩니다 -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
  
</body>
<script>
$(document).ready(function () {
    $('#resetPasswordBtn').on('click', function () {
        const id = $('#resetId').val(); // ID 입력값
        const email = $('#resetEmail').val(); // 이메일 입력값
        const $button = $(this); // 버튼 요소 참조

        // 필수 값 확인
        if (!id || !email) {
            $('#messageModalBody').text('ID와 Email을 모두 입력해주세요.');
            $('#messageModal').modal('show'); // 모달 표시
            return;
        }

        // 버튼 비활성화 및 상태 변경
        $button.prop('disabled', true).text('임시 비밀번호 전송 중...');

        // AJAX 요청
        $.ajax({
            url: 'resetPassword.ajax',
            type: 'POST',
            data: { id: id, email: email },
            success: function (response) {
                $('#messageModalBody').text(response.message); // 서버 응답 메시지 설정
                $('#messageModal').modal('show'); // 모달 표시

                // 요청 완료 후 버튼 초기화
                $button.prop('disabled', false).text('Reset Password');
            },
            error: function () {
                $('#messageModalBody').text('서버와의 통신에 실패했습니다. 다시 시도해주세요.');
                $('#messageModal').modal('show'); // 모달 표시

                // 요청 실패 후 버튼 초기화
                $button.prop('disabled', false).text('Reset Password');
            }
        });
    });
});


//문서 전체에서 클릭 이벤트 감지
$(document).on('click', function (event) {
    // 클릭한 요소가 모달 내부(.modal-content) 또는 모달 자체가 아닌 경우만 닫기
    if (!$(event.target).closest('.modal-content').length && !$(event.target).is('#resetPasswordModal')) {
        if ($('#resetPasswordModal').is(':visible')) {
            $('#resetPasswordModal').modal('hide'); // 모달 닫기
        }
    }
});
$(document).ready(function () {
    $('#changePasswordForm').on('submit', function (event) {
        event.preventDefault(); // 기본 폼 제출 방지

        const id = $('#changeId').val(); // ID 입력값
        const email = $('#changeEmail').val(); // 이메일 입력값
        const currentPw = $('#changePassword').val(); // 현재 비밀번호
        const newPassword = $('#changePw').val(); // 새 비밀번호
        const passwordCheck = $('#changePwcheck').val(); // 새 비밀번호 확인

        // 비밀번호 확인
        if (newPassword !== passwordCheck) {
            $('#messageModalBody').text('Change Password와 Change Password Check가 일치하지 않습니다.');
            $('#messageModal').modal('show'); // 모달 표시
            return false;
        }

        // AJAX 요청
        $.ajax({
            url: 'changePw.ajax',
            type: 'POST',
            data: {
                id: id,
                email: email,
                pw: currentPw,
                changePw: newPassword
            },
            success: function (response) {
                $('#messageModalBody').text(response.message); // 서버 응답 메시지 설정
                $('#messageModal').modal('show'); // 모달 표시

                // 비밀번호 변경 성공 시 폼 초기화
                if (response.status === 'success') {
                    $('#changePasswordForm')[0].reset();
                }
            },
            error: function () {
                $('#messageModalBody').text('서버와의 통신에 실패했습니다. 다시 시도해주세요.');
                $('#messageModal').modal('show'); // 모달 표시
            }
        });
    });
});

$(document).ready(function () {
    // 비밀번호 확인 실시간 처리
    $('#changePwcheck').on('keyup', function () {
        const password = $('#changePw').val(); // 변경할 비밀번호
        const passwordCheck = $(this).val(); // 확인용 비밀번호

        const messageDiv = $('#pwCheckMessage'); // 메시지 표시 영역

        if (password === passwordCheck) {
            messageDiv.text('비밀번호가 일치합니다.').css('color', '#FFFBF2');
        } else {
            messageDiv.text('비밀번호가 일치하지 않습니다.').css('color', '#E9396B');
        }
    });
}); 
</script>
</html>
