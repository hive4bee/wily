<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerA.jsp" %>
        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-4 text-gray-800">COFFEE</h1>
		  <div class='row'>
              <a href="/admin/insertProductForm" class='btn btn-primary m-4'>제품등록</a>
          </div>
          <div class="row">

            <div class="col-lg-12">

              <!-- Circle Buttons -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">커피</h6>
                </div>
                
                <div class="card-body table-responsive">
                  <table class="table">
                  	<tr>
                  		<td>상품번호</td>
                  		<td>상품코드</td>
                  		<td>상품이름</td>
                  		<td>상품가격</td>
                  		<td>카테고리</td>
                  		<td>등록일자</td>
                  		<td>노출/숨김</td>
                  	</tr>
                  	<c:if test="${empty list }">
                  		<tr>
                  			<td colspan="7">
                  				등록된 상품이 없습니다.
                  			</td>
                  		</tr>
                  	</c:if>
                  	<c:if test="${!empty list}">
                  		<c:forEach var="dto" items="${list}">
                  			<tr>
                  				<td><span>${dto.pnum}</span></td>
                  				<td>${dto.pcode}</td>
                  				<td><a href="/admin/viewProduct?pnum=${dto.pnum}">${dto.pname}</a></td>
                  				<td><fmt:formatNumber value="${dto.pprice}" pattern="#,###"/> 원</td>
                  				<td>${dto.pcategory}</td>
                  				<td><fmt:formatDate value="${dto.pregdate}" pattern="yyyy-MM-dd"/></td>
                  				<td>
                  					<select class="changeH">
                  						<c:if test="${dto.phide eq 'n'}">
                  							<option value="n" selected>숨김</option>
                  							<option value="y">노출</option>
                  						</c:if>
                  						<c:if test="${dto.phide eq 'y'}">
                  							<option value="n">숨김</option>
                  							<option value="y" selected>노출</option>
                  						</c:if>
                  					</select>
                  				</td>
                  			</tr>
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
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->
		<form id="pageF" action='/admin/coffeeList' method='get'>
    	<input type="hidden" name="page" >
    </form>
      </div>
      <!-- End of Main Content -->
      <%@ include file="../include/footerA.jsp" %>
      <script>
	$(document).ready(function(){
		var pageF = $("#pageF");
		$(".pageN").on("click",
				function(e) {
					e.preventDefault();
					/* actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit(); */
					//temp = $(this).attr("href")-1
					pageF.find("input[name='page']").val($(this).attr("href"));
					/* 
					if(temp == 0){
						pageF.find("input[name='page']").val(1);
					}else{
						pageF.find("input[name='page']").val(temp+"1");
					}
					 */
					pageF.submit();
				});
		$(".changeH").on("change", function(){
			console.log("change status....");
			var phide = $(this).val();
			console.log("status value : " + phide);
			var pnum = $(this).closest("tr").find("span").text();
			console.log("pnum : " + pnum);
				/* data:JSON.stringify({pnum:pnum, phide:phide}), */
				$.ajax({
					type:"GET",
					url:"/admin/changeH",
					data:{pnum:pnum, phide:phide},
						//data:JSON.stringify({pnum:pnum, phide:phide}),
						//contentType:"application/json",
						success:function(check){
							//data:JSON.stringify(reply),	
							if(check=='success'){
								console.log("DB -- 입력 성공");
								//showCartList(mid)
							}else {
								console.log("DB -- 입력 실패");
							}
						}
				});
			
		});
	});
  </script>