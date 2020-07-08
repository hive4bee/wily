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

</head>

<body class="bg-gradient-primary">

  <div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Logout Page</h3>
				</div>
				<div class="panel-body">
					<form role="form" method="post" action="/logout/">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<fieldset>
							<!-- <a href="" class="btn btn-lg btn-success btn-block">Logout</a> -->
							<button type="submit" class='btn btn-lg btn-success btn-block'>Logout</button>
						</fieldset>
					</form>
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
  /* 
	$(".btn-success").on("click", function(e){
		var ctxpath = '<c:out value="${ctxpath}"/>';
		e.preventDefault();
		console.log("btn clicked....");
		//console.log("ctxpath: " + ctxpath);
		$("form").submit();
	});
	 */
  </script>
  
</body>

</html>
