<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="UTF-8">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Login</title>

  <!-- Custom fonts for this template-->
  <link href="/resources/vendorsA/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="/resources/cssA/sb-admin-2.min.css" rel="stylesheet">
  <style>
  	.msg{
  		margin-left:15px;
  		color:red;
  		font-size:12px;
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
                    <h3 class="h4 text-gray-900 mb-4">were you not a administrator please get back!</h3>
                  </div>
                  <form name='pkc' class="user" method="post">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" id="id" name='id' placeholder="아이디">
                      <div class="msg"></div>
                    </div>
                    
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="pwd" name='pwd' placeholder="비밀번호">
                      <div class="msg"></div>
                    </div>
                    <!-- 
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">Remember Me</label>
                      </div>
                    </div>
                     -->
                     <div class="form-group">
                     	<button type="submit" value="submit" class="btn btn-primary btn-user btn-block">Log In</button>
                     </div>
                     <!-- 
                    <a href="index.html" class="btn btn-primary btn-user btn-block">
                      Login
                    </a> -->
                  </form>
                  <hr>
                  
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendorsA/jquery/jquery.min.js"></script>
  <script src="/resources/vendorsA/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendorsA/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/jsA/sb-admin-2.min.js"></script>
  <script>
  	var msg = document.getElementsByClassName("msg");
  	var submitBtn = $("button[type='submit']");
  	$(document).ready(function(){
  		submitBtn.on("click", function(e){
  			e.preventDefault();
  			//console.log("HIHIHI");
  			if(!$("#id").val().trim()){
  				msg[0].innerText="아이디를 입력해주세요";
  				return false;
  			}
  			if(!$("#pwd").val().trim()){
  				msg[1].innerText="비밀번호를 입력해주세요";
  				return false;
  			}
  			if($("#id").val().trim().length>0 && $("#pwd").val().trim().length>0){
  				$.ajax({
  					type:"POST",
  					url:"/admin/confirmLogin",
  					data:{id:$("#id").val().trim(), pwd:$("#pwd").val().trim()},
  					success:function(check){
  						//data:JSON.stringify(reply),	
  						if(check=='n'){
  							console.log("NO");
  							msg[1].innerText="존재하지 않는 유저이거나 비밀번호가 일치하지 않습니다.";
  						}else if(check='y'){
  							console.log("YES");
  							msg[1].innerText="";
  							document.pkc.action="/admin/loginPro";
  							document.pkc.submit();
  							
  						}
  					}
  				});
  			}
  		});
  	});
  </script>
</body>

</html>
