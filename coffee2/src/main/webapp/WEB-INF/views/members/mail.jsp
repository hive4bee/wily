<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<div class="container mt-5 mb-5 justify-content-center align-items-center">
	<form method="post" name="pkc" action="/members/inputKey">
	
		<input name="mid" type="hidden" value="${dto.mid}">
		<input name="mpw" type="hidden" value="${dto.mpw}">
		<input name="mname" type="hidden" value="${dto.mname}">
		<input name="mpn" type="hidden" value="${dto.mpn}">
		<input name="memail" type="hidden" value="${dto.memail}">
		<input name="authenticationKey" type="hidden" value="${AuthenticationKey}">
		<div id="informText">발송된 인증번호를 입력해주세요</div>
		<div id="key">인증번호 :&nbsp;<input name="key" type="text"></div>
		<div id="submitF"><input id="submitB" type="button" value="제출" onclick="checkIt();"></div>
	</form>
	</div>
<%@ include file="../include/footer.jsp" %>
	<script>
		function checkIt(){
			if(document.pkc.authenticationKey.value!=document.pkc.key.value){
				alert("인증번호가 일치하지 않습니다.");
				return false;
			}
			alert("축하합니다 가입이 완료되었습니다.");
			document.pkc.submit();
		}
	</script>