<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<
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
					<h1>Register</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Register</li>
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
							<h4>Already have an account?</h4>
							<p>There are advances being made in science and technology everyday, and a good example of this is the</p>
							<a class="button button-account" href="login.html">Login Now</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner register_form_inner">
						<h3>Create an account</h3>
						<form name='pkc' class="row login_form" method="post" action="/members/register" id="register_form" >
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="mid" name="mid" placeholder="아이디" onblur="checkId(this)" onchange="resetValue()">
							</div>
							<div class="msg"></div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="mpw"
									name="mpw" placeholder="비밀번호"
									onblur="checkBlank(this, 1)">
							</div>
							<div class="msg"></div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="mpw2"
									name="mpw2" placeholder="비밀번호 확인"
									onblur="checkPwd(this)">
							</div>
							<div class="msg"></div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="mname" name="mname" placeholder="이름" onblur="checkBlank(this, 3)">
							</div>
							<div class="msg"></div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="mpn" name="mpn" placeholder="전화번호" onblur="checkBlank(this, 4)">
							</div>
							<div class="msg"></div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="memail" name="memail" placeholder="이메일" onblur="checkBlank(this, 5)">
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
								<button type="submit" value="submit" class="button button-register w-100">가입하기</button>
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
	var txt = ["아이디를 입력하세요", "비밀번호를 입력하세요", "비밀번호가 일치하지 않습니다.", "이름을 입력해주세요", "전화번호를 입력해주세요", "이메일을 입력해주세요"]
 	var msg = document.getElementsByClassName("msg");
 	var chkId;
 	function checkId(my){
 	 	console.log("checkId......");
		if(!my.value.trim()){
			msg[0].innerText=txt[0];
		}else{
			$.ajax({
				type:"POST",
				url:"/members/confirmId",
				data:{mid:my.value.trim()},
				success:function(check){
					if(check=='n'){
						console.log("NO");
						msg[0].innerText="사용 불가능한 아이디입니다.";
						chkId=-1;
					}else if(check='y'){
						console.log("YES");
						msg[0].innerText="";
						chkId=1;
					}
				}
			});
		}
 	}
  	function checkBlank(my, n){
		if(!my.value.trim()){
			msg[n].innerText=txt[n];
		}else{
			msg[n].innerText="";
		}
  	}//end checkBlank() function;
  	
  	function checkPwd(my){
  		var mpw = document.getElementById("mpw").value;
  		var mpw2 = my.value;
  		//alert("mpw : " + mpw + " mpw2 : " + mpw2);
  		if(mpw != mpw2 || mpw.length == 0){
  			msg[2].innerText=txt[2];
  		}else{
  			msg[2].innerText="";
  		}
  	}
  	$(document).ready(function(){
  	  	var formObj = $("form[class='row']");
  		var submitBtn = $("button[type='submit']");
  		submitBtn.on("click", function(e){
  			e.preventDefault();
  			//alert("HIHI");
  			if(!$("#mid").val()){
				msg[0].innerText="아이디를 입력해주세요";
				$("#mid").focus();
				return false;
  	  		}
  	  		if(!$("#mpw").val()){
				msg[1].innerText="비밀번호를 입력해주세요";
				$("#mpw").focus();
				return false;
  	  	  	}
  	  	  	if(!$("#mpw2").val()){
				msg[2].innerText="비밀번호를 확인해주세요";
				$("#mpw2").focus();
				return false;
  	  	  	}
  	  	  	if($("#mpw").val() != $("#mpw2").val() || $("#mpw").val().length==0){
				msg[2].innerText="비밀번호가 일치하지 않습니다.";
				$("#mpw").focus();
				return false;
  	  	  	}
  	  	  	if(!$("#mname").val()){
				msg[3].innerText="이름을 입력해주세요";
				$("#mname").focus();
				return false;
  	  	  	}
  	  	  	if(!$("#mpn").val()){
				msg[4].innerText="전화번호를 입력해주세요";
				$("#mpn").focus();
				return false;
  	  	  	}
  	  	  	if(!$("#memail").val()){
				msg[5].innerText="이메일을 입력해주세요";
				$("#memail").focus();
				return false;
  	  	  	}
  	  	  	if(chkId==-1){
  	  	  		msg[0].innerText="사용 불가능한 아이디입니다!";
  	  	  		return false;
  	  	  	}
  	  	  	formObj.method="post";
  	  	  	//formObj.submit();
  	  	  	document.pkc.submit();
  		});
  	});
  	function resetValue(){
  		chkId=-1;
  	}
  </script>
</body>
</html>