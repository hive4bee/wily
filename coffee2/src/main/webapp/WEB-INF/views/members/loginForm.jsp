<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <style>
  	.msg{
  		margin-left:15px;
  		color:red;
  		font-size:12px;
  	}
  </style>
<%@ include file="../include/header.jsp" %>
  
  <!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Login / Register</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Login/Register</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  <!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>New to our website?</h4>
							<p>There are advances being made in science and technology everyday, and a good example of this is the</p>
							<a class="button button-account" href="register.html">Create an Account</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner">
						<h3>Log in to enter</h3>
						<form name="pkc" class="row login_form" method="post" action="/members/loginPro" id="contactForm" >
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="mid" name="mid" placeholder="아이디" onblur="">
							</div>
							<div class="msg"></div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="mpw" name="mpw" placeholder="비밀번호" onblur="">
							</div>
							<div class="msg"></div>
							<!-- 
							<div class="col-md-12 form-group">
								<div class="creat_account">
									<input type="checkbox" id="f-option2" name="selector">
									<label for="f-option2">Keep me logged in</label>
								</div>
							</div>
							 -->
							<div class="col-md-12 form-group">
								<button type="submit" value="submit" class="button button-login w-100">Log In</button>
								<a href="/members/findId">아이디 찾기</a>
								<a href="/members/findPwd">Forgot Password?</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Login Box Area =================-->


<%@ include file="../include/footer.jsp" %>



  <script>
  	var msg = document.getElementsByClassName("msg");
	var formObj = $("form[class='row']");
	var submitBtn = $("button[type='submit']");
  	$(document).ready(function(){
  		submitBtn.on("click", function(e){
  			e.preventDefault();
  			
  			if(!$("#mid").val()){
  				msg[0].innerText="아이디를 입력해주세요";
  				return false;
  			}
  			if(!$("#mpw").val()){
  				msg[1].innerText="비밀번호를 입력해주세요";
  				return false;
  			}
  			if($("#mid").val().length>0 && $("#mpw").val().length>0){
  				$.ajax({
  					type:"POST",
  					url:"/members/confirmLogin",
  					data:{mid:$("#mid").val().trim(), mpw:$("#mpw").val().trim()},
  					//contentType:"application/json",
  					//contentType:"application/json; charset=utf-8",
  					success:function(check){
  						//data:JSON.stringify(reply),	
  						if(check=='n'){
  							console.log("NO");
  							msg[1].innerText="존재하지 않는 유저이거나 비밀번호가 일치하지 않습니다.";
  							chkId=-1;
  						}else if(check='y'){
  							console.log("YES");
  							msg[1].innerText="";
  							chkId=1;
  							console.log(formObj);
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