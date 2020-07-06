<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctxpath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Register</title>

  <!-- Custom fonts for this template-->
  <link href="/wily/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/wily/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">계정 생성</h1>
              </div>
              <form id="pkc" class="user" action="${ctxpath}/member/signUp">
              	<div class="form-group">
              		<input type="text" class="form-control form-control-user" name="mid" id="mid" placeholder="아이디">
              	</div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" name="mfname" id="mfname" placeholder="성">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" name="mlname" id="mlname" placeholder="이름">
                  </div>
                </div>
                <div class="form-group">
                  <input type="email" class="form-control form-control-user" name="memail" id="memail" placeholder="이메일">
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" class="form-control form-control-user" name="mpw" id="mpw" placeholder="비밀번호">
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" id="mpw2" placeholder="비밀번호 확인">
                  </div>
                </div>
                <a href="" class="btn btn-primary btn-user btn-block" >
                	제출
                </a>
                <hr>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              </form>
              <hr>
              <div class="text-center">
                <a class="small" href="forgot-password.html">Forgot Password?</a>
              </div>
              <div class="text-center">
                <a class="small" href="login.html">Already have an account? Login!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/wily/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/wily/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/wily/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/wily/resources/js/sb-admin-2.min.js"></script>
  <script>
	$(document).ready(function(){
		$(".btn-user").on("click", function(e){
			e.preventDefault();
			console.log("submit btn clicked....");
			var formObj = $("#pkc");
			formObj.attr("method","post")
			formObj.submit();
		});
	});
  </script>
</body>

</html>
