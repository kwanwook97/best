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
    		background-image: url('resources/img/bestbus.webp');
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
			  <a href="#" class="resetPW" data-toggle="modal" data-target="#resetPasswordModal">Reset Password</a>
			  <a href="#" class="resetPW" data-toggle="modal" data-target="#changePasswordModal">Change Password</a>
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
        <form id="resetPasswordForm" action="resetPassword.do" method="post">
          <div class="form-group">
            <label for="resetId">ID</label>
            <input type="text" class="form-control" id="resetId" name="id" placeholder="Enter User ID" required>
          </div>
          <div class="form-group">
            <label for="resetEmail">Email Address</label>
            <input type="email" class="form-control" id="resetEmail" name="email" placeholder="Enter Email Address" required>
          </div>
          <button type="submit" class="btn btn-primary btn-block">Reset Password</button>
        </form>
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
        <form id="changePasswordForm" action="chagnePw.do" method="post">
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
            <label for="changPw">Change Password</label>
            <input type="password" class="form-control" id="changPw" name="changPw" placeholder="Enter Change Password" required>
          </div>
          <div class="form-group">
            <label for="resetEmail">Change Password Check</label>
            <input type="password" class="form-control" id="changPwcheck" name="pwCheck" placeholder="Enter Change Password Check" required>
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

  
</body>
<script>
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
        const id = $('#changeId').val(); // 변경된 ID
        const email = $('#changeEmail').val(); // 변경된 Email
        const currentPw = $('#changePassword').val(); // 현재 비밀번호
        const newPassword = $('#changPw').val(); // 새 비밀번호
        const passwordCheck = $('#changPwcheck').val(); // 확인용 비밀번호

        // 비밀번호 확인
        if (newPassword !== passwordCheck) {
            alert('Change Password와 Change Password Check가 일치하지 않습니다.');
            event.preventDefault(); // 폼 제출 막기
            return false;
        }

        // 필수 값 확인
        if (!id || !email || !currentPw) {
            alert('ID, Email 또는 현재 비밀번호를 입력해주세요.');
            event.preventDefault(); // 폼 제출 막기
            return false;
        }

        // 검증 통과 -> 서버로 제출
        return true;
    });
});

$(document).ready(function () {
    // 비밀번호 확인 실시간 처리
    $('#changPwcheck').on('keyup', function () {
        const password = $('#changPw').val(); // 변경할 비밀번호
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
