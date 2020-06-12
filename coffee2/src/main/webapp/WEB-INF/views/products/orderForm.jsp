<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<style>
		input{
			border:1px solid #cccccc;
		}
		.nono{
			border:none;
		}
	</style>
	<div class='container'>
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*구매자 정보</h3>
	            </div>
	          </div>
	        </div>
        </div>
		<div class='row table-responsive'>
			<table class="table">
				<tr>
					<td>이름</td><td><input type="text" id="oname" value="${mdto.mname}" readonly></td>
					<td colspan="5"></td>
				</tr>
				<tr>
					<td>전화번호</td><td><input type="text" id="opn" value="${mdto.mpn}" readonly></td>
					<td colspan="5"></td>
				</tr>
				<tr>
					<td>이메일</td><td><input type="text" id="oemail" value="${mdto.memail}" readonly></td>
					<td colspan="5"></td>
				</tr>
			</table>
		</div>
		
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*방문자 정보&nbsp;<button class="btn-outline-info">동일</button></h3>
	            </div>
	          </div>
	        </div>
        </div>
        <form name="pkc" action="/products/viewOrderResult">
        <input type="hidden" name="mid" value="${mid}">
		<div class='row table-responsive'>
			<table class="table">
				<tr>
					<td>이름</td><td><input type="text" name="oname"></td>
					<td colspan="5"></td>
				</tr>
				<tr>
					<td>전화번호</td><td><input type="text" name="opn"></td>
					<td colspan="5"></td>
				</tr>
				<tr>
					<td>이메일</td><td><input type="text" name="oemail"></td>
					<td colspan="5"></td>
				</tr>
				<tr>
					<td>방문할 시간</td>
					<td><input type="date" name="odate"><input type="time" name='otime'></td>
				</tr>
				<tr>
					<td>요청사항</td>
					<td><input type="text" name="ocomment"></td>
				</tr>
			</table>
		</div>
		
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-6 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*방문매장</h3>
	            </div>
	          </div>
	        </div>
        </div>
        <div class='row table-responsive'>
			<table class="table">
				<tr>
					<td>장소 </td><td><input type="text" name="oaddr" value="${addr}" size="50" readonly></td>
					<td colspan="5"></td>
				</tr>
			</table>
		</div>
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-6 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*구매 정보</h3>
	            </div>
	          </div>
	        </div>
        </div>
        
        <div class='row table-responsive'>
			<table class="table">
				<c:set var="sum" value="0"/>
				<c:if test="${!empty list }">
				<c:forEach var="dto" items="${list}">
				<c:set var="sum" value="${sum+dto.pprice*dto.cqty}"/>
				<tr>
					<td><input type="hidden" name="cnum" value="${dto.cnum}"></td>
					<td>${dto.pname}<input type="hidden" name="pnum" value="${dto.pnum}"></td>
					<td><input type="hidden" name="oqty" value="${dto.cqty}"><input type="text" class="nono" value="${dto.cqty}개"></td>
					<td><fmt:formatNumber value="${dto.pprice*dto.cqty}" pattern="#,###"/>원</td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
		</div>
		
		<div class="row mb-3 mt-5">
	        <div class="col-md-4 col-lg-6 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>*결제 정보</h3>
	            </div>
	          </div>
	        </div>
        </div>
        <div class="row table-responsive">
        	<table class="table">
        		<tr>
        			<td>총 결제금액</td><td><fmt:formatNumber value="${sum}" pattern="#,###"/>원</td>
        		</tr>
        		<tr>
        			<td>결제방법</td>
        			<td>
        				<input name="opay" type="radio" value="계좌이체">계좌이체
        				<input name="opay" type="radio" value="페이머니">페이머니
        				<input name="opay" type="radio" value="신용/체크카드">신용/체크카드
        				<input name="opay" type="radio" value="법인카드">법인카드
        				<input name="opay" type="radio" value="휴대폰">휴대폰
        			</td>
        		</tr>
        		
        	</table>
        </div>
        <div class="mt-3"><input id="checkService" type="checkbox">(필수) 구매대행 서비스 이용약관 동의</div>
        
        <div class="checkout_btn_inner d-flex align-items-center">
            <button class="button button-primary" id="submitB">결제하기</button>
        </div>

		</form>
		
	</div>
	
		
<%@ include file="../include/footer.jsp" %>

<script>
	$(document).ready(function(){
		$("input[type='date']").on("change", function(){
			var date = $(this).val();
			console.log("date : " + date);
		});
		$("input[type='time']").on("change", function(){
			var time = $(this).val();
			console.log("time : " + time);
		});
	
		
		$("button[class='btn-outline-info']").on("click", function(e){
			e.preventDefault();
			$("input[name='oname']").val($("#oname").val());
			$("input[name='opn']").val($("#opn").val());
			$("input[name='oemail']").val($("#oemail").val());
		});
		$("#submitB").on("click", function(e){
			e.preventDefault();
			var len = document.pkc.opay.length;
			var chk=0;
			for(i=0; i<len; i++){
				if(document.pkc.opay[i].checked){
					chk=1;
					break;
				}
			}
			if(!$("input[name='oname']").val()){
				alert("수령자 이름을 입력하세요");
				return false;
			}
			if(!$("input[name='opn']").val()){
				alert("수령자 연락처를 입력하세요");
				return false;
			}
			if(!$("input[name='oemail']").val()){
				alert("수령자 이메일을 입력하세요");
				return false;
			}
			if(!$("input[type='date']").val()){
				alert("방문하실 날짜를 입력하세요");
				return false;
			}
			if(!$("input[type='time']").val()){
				alert("방문하실 시간을 입력하세요");
				return false;
			}
			if(chk == 0){
				alert("결제방법을 체크해주세요");
				return false;
			}
			if(!document.getElementById("checkService").checked){
				alert("이용약관에 동의해 주세요");
				return false;
			}
			document.pkc.submit();
		});
	});
</script>