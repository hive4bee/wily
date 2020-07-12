<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!-- Custom styles for this page -->
<link href="${ctxpath}/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<div class="container-fluid">
	<h1 class="h3 ml-2 mb-2 text-gray-800">자유게시판</h1>
	
	<div class="card shadow mb-4">
		<div class='row ml-2 mt-2'>
			
			<div class="col-sm-12 col-md-3 ml-2 mt-2">
				<a href="${ctxpath}/board/writeForm" class="btn btn-primary writeBtn">글작성</a>
			</div>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTable_wrapper dt-bootstrap4">
					
					<div class="row">
						<div class="col-sm-12 col-md-2">
							<div class="dataTables_length" id="dataTable_length">
								<label>
									SHOW
									<select name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
										<option value="10">10</option>
										<option value="25">25</option>
										<option value="50">50</option>
										<option value="100">100</option>
									</select>
								</label>
							</div>
						</div>
						<div class="col-sm-12 col-md-2">
							<div id="dataTable_filter" class="dataTables_filter">
								<label>
									Search:
									<input type="search" class="form-control form-control-sm" placeholder aria-controls="dataTable">
								</label>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered" id='dataTable' width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
									<c:when test="${empty list}">
									<tr>
										<td colspan="5">작성된 게시글이 없습니다.</td>
									</tr>
									</c:when>
									<c:when test="${!empty list}">
									<c:forEach items="${list}" var="dto">
									<tr>
										<td>${dto.bno}</td>
										<td><a class="viewDetail" href="${dto.bno}">${dto.bsubject}</a></td>
										<td>${dto.mid}</td>
										<td>${dto.bhit}</td>
										<td><fmt:formatDate value="${dto.bregdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									</tr>
									</c:forEach>
									</c:when>
									</c:choose>
									
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12">
							<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item previous ${pageMaker.prev=='true' ? '':'disabled'}" id="dataTable_previous">
										<a href="${pageMaker.startPage-1}" class="page-link">Previous</a>
									</li>
									<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
										<li class="paginate_button page-item ${pageMaker.st.page==num ? 'active':''}">
											<a href="${num}" class="page-link">${num}</a>
										</li>
									</c:forEach>
									<li class="paginate_button page-item next ${pageMaker.next=='true' ? '':'disabled' }" id="dataTable_next">
										<a href="${pageMaker.endPage+1}" class="page-link">Next</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
<form action="${ctxpath}/board/viewDetail" name="viewDetailForm">
	<input type="hidden" name="bno" value="">
	<input type="hidden" name="page" value="${pageMaker.st.page}">
	<input type="hidden" name="amount" value="${pageMaker.st.amount}">
	<input type="hidden" name="keyword" value="${pageMaker.st.keyword}">
</form>
<form action="${ctxpath}/board/list" name="listForm">
	<input type="hidden" name="amount" value="${pageMaker.st.amount}">
	
</form>
<!-- 
<script src="/wily/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/wily/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>


<script src="/wily/resources/js/demo/datatables-demo.js"></script>
 -->
<%@ include file="../include/pageFooter.jsp" %>
<script>
		$(".viewDetail").on("click", function(e){
			e.preventDefault();
			var bno=$(this).attr("href");
			$("input[name='bno']").val(bno);
			var formObj=$("form[name='viewDetailForm']");
			
			formObj.submit();
		});
		$(".page-link").on("click", function(e){
			e.preventDefault();
			var page=$(this).attr("href");
			var listFormObj=$("form[name='listForm']");
			listFormObj.append("<input type='hidden' name='page' value='"+page+"'>");
			listFormObj.submit();
		});
</script>
<%@ include file="../include/footer.jsp" %>