<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<section class="blog-banner-area" id="blog">
    <div class="container h-100">
      <div class="blog-banner">
        <div class="text-center">
          <h3>메시지함</h3>
        </div>
      </div>
    </div>
  </section>
  
  <div class="container">
                  <div class="table-responsive">
                  	
                      <table class="table">
                      	<tr>
                      		<td>글번호</td>
                      		<td>메시지 제목</td>
                      		<td>보낸사람</td>
                      		<td>상태</td>
                      		<td>작성일</td>
                      	</tr>
                      	<c:if test="${empty list}">
                      		<tr>
                      			<td colspan="5">
                      				등록된 글이 없습니다.
                      			</td>
                      		</tr>
                      	</c:if>
                      	<c:if test="${!empty list}">
	                      	<c:forEach var="dto" items="${list}">
	                      		<tr>
	                      			<td>${dto.u_no }</td>
	                      			<td><a href="/message/get?u_no=${dto.u_no}">${dto.u_sub}</a></td>
	                      			<td>${dto.u_from}</td>
	                      			<c:if test="${dto.u_status eq 'n'}">
	                      			<td>미확인</td>
	                      			</c:if>
	                      			<c:if test="${dto.u_status eq 'y'}">
	                      			<td>읽음</td>
	                      			</c:if>
	                      			<td>
	                      				<fmt:formatDate value="${dto.u_reg}" pattern="yyyy-MM-dd"/>
	                      			</td>
	                      		<tr>
	                      	</c:forEach>
                      	</c:if>
                      </table>
                      
                      <nav class="blog-pagination justify-content-center d-flex">
                          <ul class="pagination">
                          		<c:if test="${pageMaker.prev}">
                          			<li class="page-item">
                                  <a href="${pageMaker.startPage -1}" class="page-link" aria-label="Previous">
                                      <span aria-hidden="true">
                                          <span class="lnr lnr-chevron-left"></span>
                                      </span>
                                  </a>
                              </li>
                          		</c:if>

                              <c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								
								<li class='page-item  ${pageMaker.st.page == num ? "active":""} '>
									<a href="${num}" class="page-link pageN">${num}</a>
								</li>
								
							</c:forEach>

                               <c:if test="${pageMaker.next}">
									<li class="page-item">
	                                  <a href="${pageMaker.endPage +1 }" class="page-link" aria-label="Next">
	                                      <span aria-hidden="true">
	                                          <span class="lnr lnr-chevron-right"></span>
	                                      </span>
	                                  </a>
	                              </li>
								</c:if>
								
                          </ul>
                      </nav>
                      
                  </div>

  	</div>
  	    <form id="pageF" action='/message/showAllMessage' method='get'>
  	    <input type="hidden" name="page" value="">
    	<input type="hidden" name="mid" value="${mid}">
    </form>
<%@ include file="../include/footer.jsp" %>
  <script>
	$(document).ready(function(){
		var pageF = $("#pageF");
		$(".pageN").on("click",
				function(e) {
					e.preventDefault();
					pageF.find("input[name='page']").val($(this).attr("href"));
					pageF.submit();
				});
	});
  </script>