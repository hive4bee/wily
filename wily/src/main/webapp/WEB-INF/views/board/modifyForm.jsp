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
	<form action="${ctxpath}/board/modifyPro" method="post" name="modifyForm">
		<h1 class="h3 ml-2 mb-2 text-gray-800">${boardDTO.bno}번 글</h1>
		<input type="hidden" name="bno" value="${boardDTO.bno}">
		<div class="row col-lg-12 align-items-center mb-2">
			<span class="col-lg-1">제목</span>
			<span class="col-lg-7">
				<input type="text" value="${boardDTO.bsubject}" name="bsubject">
			</span>
		</div>
		<div class="row col-lg-12 align-items-center mb-2">
			
			<span class="col-lg-1">내용</span>
			<span class="col-lg-7">
				<textarea rows="15" name="bcontent">${boardDTO.bcontent}</textarea>
			</span>
			
		</div>
		<div class='row ml-2 mt-2'>
			<div class="col-sm-12 ml-2 mt-2 mb-5">
				<a href="#" class="btn btn-primary listBtn">리스트</a>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq boardDTO.mid}">
						<a href="#" class="btn btn-primary modifyBtn">수정하기</a>
					</c:if>
				</sec:authorize>
			</div>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</div>
<form action="${ctxpath}/board/list" name="listForm">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
</form>
<%@ include file="../include/pageFooter.jsp" %>
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
		if(!$("input[name='bsubject']").val().trim()){
			alert("제목을 입력하셔야 합니다.");
			return ;
		}
		if(!$("textarea[name='bcontent']").val().trim()){
			alert("내용을 입력하셔야 합니다.");
			return;
		}
		var modifyFormObj=$("form[name='modifyForm']")
		modifyFormObj.submit();
	});
</script>
<%@ include file="../include/footer.jsp" %>