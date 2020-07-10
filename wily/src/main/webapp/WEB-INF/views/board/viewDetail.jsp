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
<sec:authentication property="principal" var="pinfo"/>
<div class="container-fluid justify-content-center">
	<h1 class="h3 ml-2 mb-2 text-gray-800">${boardDTO.bno}번 글</h1>
	
	
		<div class='row ml-2 mt-2'>
			
			<div class="col-sm-12 ml-2 mt-2 mb-5">
				<a href="#" class="btn btn-primary listBtn">리스트</a>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq boardDTO.mid}">
						<a href="#" class="btn btn-primary modifyBtn">수정하기</a>
						<a href="#" class="btn btn-primary deleteBtn">삭제하기</a>
					</c:if>
				</sec:authorize>
			</div>
		</div>
		
			
		<div class="row col-lg-12 align-items-center mb-2">
			<span class="col-lg-1">제목</span>
			<span class="col-lg-7">
				<input type="text" value="${boardDTO.bsubject}" readonly>
			</span>
		</div>
		<div class="row col-lg-12 align-items-center mb-2">
			
			<span class="col-lg-1">내용</span>
			<span class="col-lg-7">
				<textarea rows="15" readonly>${boardDTO.bcontent}</textarea>
			</span>
			
		</div>
</div>

<%@ include file="../include/pageFooter.jsp" %>
<form action="${ctxpath}/board/list" name="listForm">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
</form>
<form action="${ctxpath}/board/deletePro" method="post" name="deleteForm">
	<input type="hidden" name="bno" value="">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>
<form action="${ctxpath}/board/modifyForm" name="modifyForm">
	<input type="hidden" name="bno" value="">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
</form>
<script>
	$(".listBtn").on("click", function(e){
		e.preventDefault();
		console.log("list button clicked....");
		var page='<c:out value="${startDTO.page}"/>';
		//console.log("page: "+page);
		var amount='<c:out value="${startDTO.amount}"/>';
		//console.log("amount: "+amount);
		var keyword='<c:out value="${startDTO.keyword}"/>';
		//console.log("keyword: "+keyword);
		$("input[name='page']").val(page);
		$("input[name='amount']").val(amount);
		$("input[name='keyword']").val(keyword);
		var listFormObj=$("form[name='listForm']");
		listFormObj.submit();
	});
	$(".modifyBtn").on("click", function(e){
		e.preventDefault();
		console.log("modify button clicked....");
		var bno='<c:out value="${boardDTO.bno}"/>';
		var page='<c:out value="${startDTO.page}"/>';
		var amount='<c:out value="${startDTO.amount}"/>';
		var keyword='<c:out value="${startDTO.keyword}"/>';

		$("input[name='bno']").val(bno);
		$("input[name='page']").val(page);
		$("input[name='amount']").val(amount);
		$("input[name='keyword']").val(keyword);

		var modifyFormObj=$("form[name='modifyForm']")
		modifyFormObj.submit();
	});
	$(".deleteBtn").on("click", function(e){
		e.preventDefault()
		console.log("delete button clicked....");
		confirm("정말로 지우시겠습니까?");
		if(confirm){
			var bno='<c:out value="${boardDTO.bno}"/>';
			var page='<c:out value="${startDTO.page}"/>';
			var amount='<c:out value="${startDTO.amount}"/>';
			var keyword='<c:out value="${startDTO.keyword}"/>';
			$("input[name='bno']").val(bno);
			$("input[name='page']").val(page);
			$("input[name='amount']").val(amount);
			$("input[name='keyword']").val(keyword);
			var deleteFormObj=$("form[name='deleteForm']");
			deleteFormObj.submit();
		}else{
			return;
		}
	});
</script>

<%@ include file="../include/footer.jsp" %>