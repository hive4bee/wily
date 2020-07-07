<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctxpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Register</title>

<!-- Custom fonts for this template-->
<link href="/wily/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

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
								<h1 class="h4 text-gray-900 mb-4">인증번호 확인</h1>
							</div>

							<div>
								인증번호 입력 : <input type="text" name="auth">
								<button type="submit" class="btn btn-primary">제출</button>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Bootstrap core JavaScript-->
	<!-- <script src="/wily/resources/vendor/jquery/jquery.min.js"></script> -->
	<script src="/wily/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script
		src="/wily/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/wily/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/wily/resources/js/sb-admin-2.min.js"></script>
	<script>
		var authKey='<c:out value="${authKey}"/>';
		var email='<c:out value="${email}"/>';
		var csrfHeaderName="${_csrf.headerName}";
		var csrfTokenValue="${_csrf.token}";
		console.log("authKey: "+ authKey);
		console.log("email: " + email);
		$(document).ready(function(){
			$(".btn-primary").on("click", function(e){
				e.preventDefault();
				userAuthKey=$("input[name='auth']").val().trim();
				if(!userAuthKey){
					alert("인증번호를 입력해주세요");
				}else{
					if(authKey==userAuthKey){
						$.ajax({
							type:"POST",
							url:"/wily/member/confirmAuthKey",
							beforeSend:function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							data:JSON.stringify(
								{
									email:email
								}
							),
							contentType:"application/json; charset=utf-8",
							success:function(result, status, xhr){
								if(result=='success'){
									self.location="/wily/";
								}
							}
							
						});
					}else{
						alert("인증번호가 일치하지 않습니다.");
						return;
					}
				}
			});
		})
		
  </script>
</body>

</html>
