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
  <style>
  	.bg-th111{
   		background-image: url('img/loginBus5.jpg');
   		background-size: cover; /* 이미지가 화면 전체를 덮도록 설정 */
  	 		background-repeat: no-repeat; /* 이미지가 반복되지 않도록 설정 */
   		background-position: center; 
   	}
    .modal-content{
    	background-color: #30005A;
    	left: 126px;
    	top: 244px;
    	color: #FFFBF2;
    	border-radius: 10px;
    }
    #resetPasswordForm button{
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
		  <div class="card-title text-uppercase text-center py-3">Admin Login</div>
		  
		  
		  
		  
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
		  
		  
		  
		  
		  
		  
		    <form action="adminLogin.do" method="post">
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
                <input type="checkbox" id="user-checkbox" checked="" />
                <label for="user-checkbox">Remember me</label>
                <a class="loginType" href="login.go">User Login</a>
			  </div>
			 </div>
			 <div class="form-group col-6 text-right">
			  <a href="#" data-toggle="modal" data-target="#resetPasswordModal">Reset Password</a>
			 </div>
			</div>
			 <button type="submit" class="btn btn-light btn-block">Sign In</button>

			 
			 </form>
		   </div>
		  </div>
	     </div>
    <div class="modal fade" id="resetPasswordModal" tabindex="-1" role="dialog" aria-labelledby="resetPasswordModalLabel" aria-hidden="true" data-backdrop="false">
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
     <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

	</div><!--wrapper-->
	
  <!-- Bootstrap core JavaScript-->
<!--   <script src="recources/js/jquery.min.js"></script>
  <script src="recources/js/popper.min.js"></script> -->
  <script src="resources/js/bootstrap.min.js"></script>
	
  <!-- sidebar-menu js -->
<!--   <script src="recources/js/sidebar-menu.js"></script>
   -->
  <!-- Custom scripts -->
<!--   <script src="recources/js/app-script.js"></script> -->
  
</body>
</html>
