<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>QMS LOGIN</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Mar 17 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <main>
    <div class="container">
      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="index.html" class="logo d-flex align-items-center w-auto">
                  <img src="assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">QMS</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">계정 로그인</h5>
                    <p class="text-center small">로그인을 위해 아이디와 비밀번호를 입력하세요!</p>
                  </div>

                  <form class="row g-3 needs-validation" id='loginform' novalidate>

                    <div class="col-12">
                      <label for="yourUserID" class="form-label">사용자 ID</label>
                      <div class="input-group has-validation">
                        <input type="text" name="userId" class="form-control" id="yourUserID" required>
                      </div>
                    </div>

                	 <div class="col-12">
					  <label for="yourUserPassword" class="form-label">Password</label>
					  <div class="input-group">
					    <input type="password" name="userPwd" class="form-control password-field" id="yourUserPassword" required>
					    <div class="input-group-append">
					      <button type="button" class="btn btn-outline-secondary toggle-password" data-target="yourUserPassword">
					        <i class="bi bi-eye" id="password-icon"></i>
					      </button>
					    </div>
					  </div>
					</div>


                    <div class="col-12">
                      <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="remember" value="true" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">ID 기억하기</label>
                      </div>
                    </div>
                    <div class="col-12">
                      <button type ='button' class="btn btn-primary w-100" onclick="login();">Login</button>
                    </div>
                    <div class="col-12">
  					<button type ='button' class="btn btn-sm btn-primary" onclick="searchPwd();">비밀번호를 잊으셨나요?</button>
                    </div>
                  </form>

                </div>
              </div>

              <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                Designed by <a href="https://bootstrapmade.com/">이젠아카데미</a>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->	
	<div class="modal fade" id="resetPasswordModal" tabindex="-1">
  <div class="modal-dialog modal-sm modal-dialog-centered">
  <form id='Pwdfindform'>
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">비밀번호 재설정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        비밀번호를 재설정하려면 <br> 
        사용자 ID를 입력하세요.
        <input type="text" class="form-control mt-3" id="userId" name="userId" placeholder="아이디">
        새로운 비밀번호를 입력하세요.
        <div class="input-group mt-3">
          <input type="password" class="form-control password-field" id="newUserPwd" name="userPwd" placeholder="새로운 비밀번호">
          <div class="input-group-append">
            <button type="button" class="btn btn-outline-secondary toggle-password" data-target="newUserPwd">
              <i class="bi bi-eye new-password-icon"></i>
            </button>
          </div>
        </div>
        <div class="input-group mt-3">
          <input type="password" class="form-control password-field" id="checkUserPwd" placeholder="비밀번호 확인">
          <div class="input-group-append">
            <button type="button" class="btn btn-outline-secondary toggle-password" data-target="checkUserPwd">
              <i class="bi bi-eye check-password-icon"></i>
            </button>
          </div>
        </div>  
        <div id="passwordMatchMessage"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="updateManagePwd();">비밀번호 재설정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
      </form>
  </div>
</div>


  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>
  <script src="/assets/js/jquery-3.7.1.js"></script>
  <script src="/assets/js/common.js"></script>
  <script src="/assets/js/jquery.cookie.js"></script>

</body>

</html>

<script>
	// <------  쿠키가 존재하는 경우에만 아이디 필드에 설정 시작 ----->
	$(document).ready(function() {
		  
	    var yourUserID = $.cookie("yourUserID");
	  
	    if (yourUserID) {
	        $('#yourUserID').val(yourUserID);
	        $('#rememberMe').prop('checked', true);
	    }
	    
	});
	// <------  쿠키가 존재하는 경우에만 아이디 필드에 설정 끝 ----->
	
	// <------ 로그인 시작 ----->
	function login(){
		if($('#yourUserID').val()==''){
			alert("아이디를 입력하세요!");
			return;
		}
		if($('#yourUserPassword').val()==''){
			alert("패스워드를 입력하세요!");
			return;
		}
		call_server(loginform, "/loginProcess", confirmLogin);
	}
	
	function confirmLogin(vo){
		if(vo.result){
			 var rememberMe = $('#rememberMe').is(':checked');
			 if (rememberMe) {
				 $.cookie("yourUserID", $('#yourUserID').val(), { expires: 7 });
			 } else {
	           $.removeCookie("yourUserID");
			 }
			location.href="/approve/list";
		}else{
			alert(vo.msg);
			
		}
	}
	// <------ 로그인 끝  ----->
	
	// <------ 비밀번호 재설정 시작  ----->
	function searchPwd() {
		$('#userId').val(''); 
		$('#newUserPwd').val(''); 
	    $('#checkUserPwd').val(''); 
	    $('#passwordMatchMessage').text(''); 
	    //새로 비밀번호 재설정 모달을 열었을때 내용을 비움 
	    
	    $('#resetPasswordModal').modal('show');
	}
	
	function updateManagePwd() {
	    if (!validation()) {
	        return;
	    }
	    if (confirm("비밀번호를 재설정하시겠습니까?")) {
	        call_server(Pwdfindform, '/login/findPwd', updateManagePwdcallback);
	    }
	}
	
	function updateManagePwdcallback(cnt) {
	    if (cnt > 0) {
	        alert("비밀번호 재설정성공");
	        $('#resetPasswordModal').modal('hide');
	    } else {
	        alert("실패");
	    }
	}
	
	$(document).ready(function() {
		  // 비밀번호 토글 기능 설정
		  $('.toggle-password').click(function() {
		    const targetId = $(this).data('target');
		    const passwordField = $('#' + targetId);
		    const passwordIcon = $(this).find('i');
		    if (passwordField.attr('type') === 'password') {
		      passwordField.attr('type', 'text');
		      passwordIcon.removeClass('bi-eye').addClass('bi-eye-slash');
		    } else {
		      passwordField.attr('type', 'password');
		      passwordIcon.removeClass('bi-eye-slash').addClass('bi-eye');
		    }
		  });

		  // 비밀번호 일치 확인
		  $('#newUserPwd, #checkUserPwd').on('input', function() {
		    comparePasswords();
		  });
		});
	
	function comparePasswords() {
		  var password = $('#newUserPwd').val();
		  var confirmPassword = $('#checkUserPwd').val();
		  if (password === confirmPassword) {
		    $('#passwordMatchMessage').text('비밀번호가 일치합니다').css('color', 'green');
		  } else {
		    $('#passwordMatchMessage').text('비밀번호가 일치하지 않습니다').css('color', 'red');
		  }
		}
	
	function validation() {
	    var specialCharRegex = /[^a-zA-Z0-9]/;

	    if ($('#userId').val() == '') {
	        alert("사용자 ID를 입력해주세요!");
	        return false;
	    }
	    if ($('#newUserPwd').val() == '') {
	        alert("비밀번호를 입력해주세요!");
	        return false;
	    }
	    if($('#newUserPwd').val().length > 20){
	        alert("비밀번호는 20자리 이내로 지정해주세요!");
	        return false;
	    }
	    if (specialCharRegex.test($('#newUserPwd').val())) {
	        alert("비밀번호는 알파벳 대소문자와 숫자만 사용 가능합니다!");
	        return false;
	    }
	    if ($('#newUserPwd').val() !== $('#checkUserPwd').val()) {
	        alert("새 비밀번호와 비밀번호 재확인이 일치하지 않습니다!");
	        return false;
	    }

	    return true;
	}

	// <------ 비밀번호 재설정 끝  ----->
	 

</script>	