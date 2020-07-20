<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctxpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Login</title>

  <!-- Custom fonts for this template-->
  <link href="/wily/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/wily/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <style>
  	.msgmsg{
  		color:red;
  		font-size:12px;
  		margin-left:15px;
  		margin-bottom:10px;
  	}
  </style>
</head>

<body class="bg-gradient-primary">

  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                  </div>
                  <form id="pkc" class="user" method="post" action="">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name="mid" id="mid" placeholder="ID를 입력하세요">
                    </div>
                    <div class="msgmsg"></div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="mpw" id="mpw" placeholder="비밀번호를 입력하세요">
                    </div>
                    <div class="msgmsg"></div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">Remember Me</label>
                      </div>
                    </div>
                    <a href="" class="btn btn-primary btn-user btn-block">
                      Login
                    </a>
                    <hr>
                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="forgot-password.html">Forgot Password?</a>
                  </div>
                  <div class="text-center">
                    <a class="small" href="register.html">Create an Account!</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/wily/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
  <script src="/wily/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/wily/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/wily/resources/js/sb-admin-2.min.js"></script>
  <script>
	$(document).ready(function(){
		var prevPage='<c:out value="${prevPage}"/>';
		if(prevPage){
			
		}
		$("#mid").on("blur",function(){
			var mid=$(this).val().trim();
			if(!mid){
				document.getElementsByClassName("msgmsg")[0].innerText="아이디를 입력해주세요";
				return;
			}else{
				document.getElementsByClassName("msgmsg")[0].innerText="";
			}
		});
		$("#mpw").on("blur", function(){
			var mpw=$(this).val().trim();
			if(!mpw){
				document.getElementsByClassName("msgmsg")[1].innerText="비밀번호를 입력해주세요";
				return;
			}else{
				document.getElementsByClassName("msgmsg")[1].innerText="";
			}
		});
		$(".btn-primary").on("click", function(e){
			e.preventDefault();
			console.log("login btn clicked....");
			var mid=$("#mid").val().trim();
			var mpw=$("#mpw").val().trim();
			var csrfHeaderName="${_csrf.headerName}";
			var csrfTokenValue="${_csrf.token}";
			var msgmsg=document.getElementsByClassName("msgmsg");
			if(!mid){
				msgmsg[0].innerText="아이디를 입력해주세요";
				return;
			}else{
				msgmsg[0].innerText="";
			}
			if(!mpw){
				msgmsg[1].innerText="비밀번호를 입력해주세요";
				return;
			}else{
				msgmsg[1].innerText="";
			}
			if(mid!="" && mpw!=""){
				/* 
				var formObj=$("#pkc");
				formObj.submit();
				 */
				
				$.ajax({
					type:"POST",
					url:"/wily/login",
					beforeSend:function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					//data:JSON.stringify({mid:mid,mpw:mpw}),
					//contentType:"application/json; charset=utf-8",
					data:{mid:mid,mpw:mpw},
					dataType:"json",
					success:function(rdto,status,xhr){
						if(rdto.status=='OK'){
							self.location=rdto.url;
						}else{
							document.getElementsByClassName("msgmsg")[1].innerText="존재하지 않는 유저이거나 비밀번호가 틀렸습니다.";
						}
					}
				});
				
			}
		});
	});
  </script>
</body>

</html>
