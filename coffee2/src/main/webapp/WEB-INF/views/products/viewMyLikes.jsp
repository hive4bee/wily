<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
				<c:set var='prefix' value='C:\upload'/>
	
	<section class="section-margin calc-60px">
      <div class="container">
        <div class="section-intro pb-60px">
          <p>Popular Item in the market</p>
          <h2>Trending <span class="section-intro__style">Product</span></h2>
        </div>
        <div class="row">
				<c:if test="${empty list }">
					<div>등록된 상품이 없습니다.</div>
				</c:if>
				<c:if test="${!empty list }">
				<c:forEach var="dto" items="${list}">
					<div class="col-md-6 col-lg-4 col-xl-3 cursorP">
			            <div class="card text-center card-product">
			              <div class="card-product__img">
			                <img class="card-img" src='/imgs/${dto.uploadpath}/${dto.uuid}_${dto.filename}'>
			                <ul class="card-product__imgOverlay">
			                  <li><button onclick="document.location.href='/products/viewDetail?pnum=${dto.pnum}'"><i class="ti-search"></i></button></li>
			                  <li data-pnum="${dto.pnum}"><button class="btnbtnb"><i class="ti-shopping-cart"></i></button></li>
			                  <!-- <li><button><i class="ti-heart"></i></button></li> -->
			                </ul>
			              </div>
			              <div class="card-body">
			                <p>${dto.pcategory }</p>
			                <h4 class="card-product__title"><a href="single-product.html">${dto.pname }</a></h4>
			                <p class="card-product__price"><fmt:formatNumber value="${dto.pprice }" type="currency"/></p>
			              </div>
			            </div>
			          </div>
					
						<%-- <img src='${"c:\\upload\\"+dto.uploadpath+"\\"+dto.uuid+"\\"+dto.filename}'> --%>
						<%-- <img src='/imgs/${dto.uploadpath}/s_${dto.uuid}_${dto.filename}' width='200' height='200'> --%>
						<%-- <img src='${"c:/upload/"+dto.uploadpath+"/"+"s_"+dto.uuid+"_"+dto.filename}'> --%>
					
				</c:forEach>
				</c:if>
		</div>
	  </div>
	</section>
					<%-- 
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
                  				<td>${dto.pnum}</td>
                  				<td>${dto.pcode}</td>
                  				<td>${dto.pname}</td>
                  				<td><fmt:formatNumber value="${dto.pprice}" pattern="#,###"/> 원</td>
                  				<td>${dto.pcategory}</td>
                  				<td><fmt:formatDate value="${dto.pregdate}" pattern="yyyy-MM-dd"/></td>
                  				<td>IMSI</td>
                  			</tr>
                  		</c:forEach>
                  	</c:if>
                  </table>
                   --%>
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
<form id="pageF" action='/products/coffeeList2' method='get'>
    	<input type="hidden" name="page" >
    </form>
<%@ include file="../include/footer.jsp" %>
<script>
	var id = '<c:out value="${mid}"/>';
	$(document).ready(function(){
		
		var pageF = $("#pageF");
		
		$(".pageN").on("click",	function(e) {
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
		});//-------------end pagination-------------
		
		$(".btnbtnb").on("click", function(e){
			e.preventDefault();
			console.log("btnbtnb Button clicked .......");
			if(!id){
				document.location='/members/loginForm';
			}
			var pnum = $(this).closest("li").data("pnum");
			console.log("mid : " + id + " pnum : " + pnum);
			$.ajax({
				type:"get",
					url:"/products/addToCart",
					data:{mid:id, pnum:pnum, cqty:1},
					success:function(check){
						//data:JSON.stringify(reply),	
						if(check=='success'){
							checkCartQuantity(id);
							console.log("DB 입력 성공");
						}else {
							console.log("DB 입력 실패");
						}
					}
			});
		});//---------------end addProductToCart------------
		
		
		
	});//-------------end document ready--------------
  </script>