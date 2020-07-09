<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	input{
		border:1px solid #eeeeee;
		width:100%;
	}
	textarea{
		width:100%;
	}
</style>
<div class="container-fluid  justify-content-center">
	<h1 class="h3 ml-2 mb-5 text-gray-800 text-center">글작성</h1>
	<form class="user" method="post" name="writeForm" action="${ctxpath}/board/writePro">
		
			<div class="row align-items-center justify-content-center mb-2">
				<span class="col-sm-8 col-md-1">제목</span>
				<span class="col-sm-8 col-md-7">
					<input type="text" id="bsubject" name="bsubject">
				</span>
			</div>
			<div class="row align-items-center justify-content-center mb-2">
				
				<span class="col-sm-8 col-md-1">내용</span>
				<span class="col-sm-8 col-md-7">
					<textarea rows="15" id="bcontent" name="bcontent"></textarea>
				</span>
				
			</div>
			<div class='row align-items-center justify-content-center'>
				<span clsas="col-sm-8 col-md-4">
					<button type="button" class="btn btn-primary submitBtn">제출</button>
					<button type="button" class="btn btn-primary backBtn ml-2">돌아가기</button>
				</span>
			</div>
			<input type="hidden" name="mid" value="">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</div>

<%@ include file="../include/pageFooter.jsp" %>
<script>
	$(".submitBtn").on("click",function(e){
		e.preventDefault();
		console.log("submit button clicked....");
		if(!$("#bsubject").val().trim()){
			alert("제목을 입력하셔야 합니다.");
			$("input[type='text']").focus();
			return ;
		}
		if(!$("#bcontent").val().trim()){
			alert("내용을 입력하셔야 합니다.");
			$("textarea").focus();
			return ;
		}
		if($("#bsubject").val().trim()!="" && $("#bcontent").val().trim()!=""){
			var formObj=$("form[name='writeForm']");
			var userId='<sec:authentication property="principal.username" />';
			$("input[name='mid']").val(userId);
			formObj.submit();
		}
	});
	$(".backBtn").on("click",function(e){
		e.preventDefault();
		console.log("back button clicked....");
	});
	$(document).ready(function(){
		var userId='<sec:authentication property="principal.username" />';
		console.log("userId: " + userId);
	});
</script>

<%@ include file="../include/footer.jsp" %>