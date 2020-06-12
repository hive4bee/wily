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
	<div class="row mb-3 mt-5">
        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
          <div class="media contact-info">
            <span class="contact-info__icon"><i class="ti-home"></i></span>
            <div class="media-body">
              <h3>비밀번호 찾기</h3>
            </div>
          </div>
        </div>
     </div>
     
		<form name="pkc" method="post" action="/members/findPwdPro">
		<div class="form-group row">
			<label for="mname">이름</label>
			<input id="mname" name="mname" class="form-control form-control-user" onblur="checkcheck(this,0)" type="text" placeholder="이름을 입력해주세요">
		</div>
		<div class="message"></div>
		<div class="form-group row">
			<label for="mid">아이디</label>
			<input id="mid" name="mid" class="form-control form-control-user" onblur="checkcheck(this,1)" type="text" placeholder="아이디를 입력해주세요">
		</div>
		<div class="message"></div>
		<div class="form-group row">
			<label for="memail">이메일</label>
			<input id="memail" name="memail" class="form-control form-control-user" onblur="checkcheck(this,2)" type="text" placeholder="이메일을 입력해주세요">
		</div>
		<div class="message"></div>
		<div class="idR3">
			<input id="confirmR" type="button" value="찾기" onclick="checkIt();">
		</div>
		</form>
	</div>

<%@ include file="../include/footer.jsp" %>
	<script>
		var mess=["이름을 입력해주세요", "아이디를 입력해주세요", "이메일을 입력해주세요"];
		function checkcheck(my,n){
			if(!my.value.trim()){
				document.getElementsByClassName("message")[n].innerText = mess[n];				
			}else{
				document.getElementsByClassName("message")[n].innerText="";
			}
		}
		function checkIt(){
			if(!document.pkc.mname.value){
				document.getElementsByClassName("message")[0].innerText="이름을 입력해주세요";
				document.pkc.mname.focus();
				return false;
			}
			if(!document.pkc.mid.value){
				document.getElementsByClassName("message")[1].innerText="아이디를 입력해주세요";
				document.pkc.mid.focus();
				return false;
			}
			if(!document.pkc.memail.value){
				document.getElementsByClassName("message")[2].innerText="이메일을 입력해주세요";
				document.pkc.memail.focus();
				return false;
			}
			if(document.pkc.mname.value!="" && document.pkc.mid.value!="" && document.pkc.memail.value!=""){
				/* 
				$.ajax({
					type:"POST",
					url:"/members/confirmUser2",
					data:{mname:$("#mname").val(),mid:$("#mid").val(),memail:$("#memail").val()},
					success:function(data){
						if(data=='exist'){//유효한 아이디와 패스워드
							document.pkc.submit();
						}else{//불허받음
							alert("존재하지 않는 유저입니다.");	
						}//end else
					}//end success
				});//end ajax
				 */
				
				$.ajax({
					type:"POST",
					url:"/members/confirmUser2",
					data:JSON.stringify({mname:$("#mname").val(),mid:$("#mid").val(),memail:$("#memail").val()}),
					contentType:"application/json; charset=utf-8",
					//success:function(result, status, xhr){
					success:function(result, status, xhr){
						if(result=='exist'){//유효한 아이디와 패스워드
							document.pkc.submit();
						}else{//불허받음
							alert("존재하지 않는 유저입니다.");	
						}//end else
					}
				});//end ajax
				
			}
		}
	</script>