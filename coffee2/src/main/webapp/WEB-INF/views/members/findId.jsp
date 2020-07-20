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
              <h3>아이디 찾기</h3>
            </div>
          </div>
        </div>
     </div>
     
		<form name="pkc" method="post" action="/members/findIdPro">
		<div class="form-group row">
			<label for="mname">이름</label>
			<input id="mname" name="mname" class="form-control form-control-user" onblur="checkcheck(this,0)" type="text" placeholder="이름을 입력해주세요">
		</div>
		<div class="message"></div>
		<div class="form-group row">
			<label for="mpn">전화번호</label>
			<input id="mpn" name="mpn" class="form-control form-control-user" onblur="checkcheck(this,1)" type="text" placeholder="전화번호를 입력해주세요">
		</div>
		<div class="message"></div>
		<div class="idR3">
			<input id="confirmR" type="button" value="찾기" onclick="checkIt();">
		</div>
		</form>
	</div>

<%@ include file="../include/footer.jsp" %>
	<script>
		var mess=["이름을 입력해주세요", "전화번호를 입력해주세요"];
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
			if(!document.pkc.mpn.value){
				document.getElementsByClassName("message")[1].innerText="전화번호를 입력해주세요";
				document.pkc.mpn.focus();
				return false;
			}
			if(document.pkc.mname.value!="" && document.pkc.mpn.value!=""){
				$.ajax({
					type:"POST",
					url:"/members/confirmUser",
					data:{mname:$("#mname").val(),mpn:$("#mpn").val()},
					success:function(data){
						if(data=='exist'){//유효한 아이디와 패스워드
							document.pkc.submit();
						}else{//불허받음
							alert("존재하지 않는 유저입니다.");	
						}//end else
					}//end success
				});//end ajax
			}
		}
	</script>