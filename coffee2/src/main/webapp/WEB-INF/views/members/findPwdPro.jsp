<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<style>
		.message{
			font-size:12px;
			color:red;
		}
	</style>

	<div class="container col-sm-7 col-lg-5 mb-3 mt-5">
	<div class="row mb-5 mt-5">
        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
          <div class="media contact-info">
            <span class="contact-info__icon"><i class="ti-home"></i></span>
            <div class="media-body">
              <h3>비밀번호 찾기 결과</h3>
            </div>
          </div>
        </div>
     </div>
     
		<div class="row mb-3 mt-5 align-items-center col-lg-10">
			<span class="col-lg-4">인증번호 : </span><input type="password" id="authkey" onblur="checkcheck(this,0)">
		</div>
		<div class="message"></div>
		<div class="row mb-3 mt-5 align-items-center col-lg-10">
			<span class="col-lg-4">새로운 비밀번호 : </span><input type="password" id="pwd" onblur="checkcheck(this,1)">
		</div>
		<div class="message"></div>
		<div class="row mb-3 mt-5 align-items-center col-lg-10">
			<span class="col-lg-4">비밀번호 확인 : </span><input type="password" id="pwdC" onblur="checkcheck2(this,2)">
		</div>
		<div class="message"></div>
	</div>
	<div class="row mb-5 align-items-center justify-content-center">
		<a href="" class="button">제출</a>
	</div>

<%@ include file="../include/footer.jsp" %>
<script>
	var mid='<c:out value="${mid}"/>';
	var mess=["인증번호를 입력해주세요", "아이디를 입력해주세요", "이메일을 입력해주세요"];
	var auth = '<c:out value="${AuthenticationKey}"/>';
	function checkcheck(my,n){
		if(!my.value.trim()){
			document.getElementsByClassName("message")[n].innerText = mess[n];				
		}else{
			document.getElementsByClassName("message")[n].innerText="";
		}
	}
	function checkcheck2(my,n){
		var pwd = $("#pwd").val().trim();
		var pwdC = $("#pwdC").val().trim();
		if(pwd != pwdC || pwd.length==0){
			document.getElementsByClassName("message")[n].innerText="비밀번호가 일치하지 않습니다.";
		}else{
			document.getElementsByClassName("message")[n].innerText="";
		}
	}
	$(document).ready(function(){
		$("a[class='button']").on("click", function(e){
			console.log("button clicked....");
			if(!$("#authkey").val().trim()){
				document.getElementsByClassName("message")[0].innerText="인증번호를 입력하세요";
				$("#authkey").focus();
				return false;
			}
			if($("#authkey").val().trim() != auth){
				document.getElementsByClassName("message")[0].innerText="인증번호가 일치하지 않습니다.";
				$("#authkey").text("");
				$("#authkey").focus();
				return false;
			}
			if(!$("#pwd").val().trim()){
				document.getElementsByClassName("message")[1].innerText="비밀번호를 입력하세요";
				$("#pwd").focus();
				return false;
			}
			if(!$("#pwdC").val().trim()){
				document.getElementsByClassName("message")[2].innerText="비밀번호를 확인해주세요";
				$("#pwdC").focus();
				return false;
			}
			if($("#pwd").val().trim() != $("#pwdC").val().trim() || $("#pwd").val().trim().length==0){
				document.getElementsByClassName("message")[2].innerText="비밀번호가 일치하지 않습니다.";
				$("#pwd").focus();
				return false;
			}
			changePwd();
			
		});
	});
	function changePwd(){
		$.ajax({
			type:"post",
			url:"/members/changePwd",
			data:JSON.stringify({mid:mid, mpw:$("#pwd").val()}),
			contentType:"application/json; charset=UTF-8",
			success:function(result){
				if(result=='success'){
					alert("비밀번호 변경이 완료되었습니다.");
					self.location="/members/loginForm";
				}else{
					alert("변경실패...");
				}
			}
		});
	}
</script>