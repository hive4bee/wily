<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>


  <!-- ================ start banner area ================= -->	
  <section class="blog-banner-area" id="blog">
    <div class="container h-100">
      <div class="blog-banner">
        <div class="text-center">
          <h3>자유 게시판</h3>
          <!-- 
          <nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Blog</li>
            </ol>
          </nav>
           -->
        </div>
      </div>
    </div>
  </section>
  <!-- ================ end banner area ================= -->


  <!--================Blog Categorie Area =================-->
  
  <!--================Blog Categorie Area =================-->

  <!--================Blog Area =================-->
      <div class="container">
	  	<div class="row no-gutters align-items-center pt-30px">
	  		<a class="button" href="/boards/write">글작성</a>
	  	</div>
          <!-- <div class="row">
              <div class="col-lg-8"> -->
                  <div class="table-responsive">
                  	
                      <table class="table">
                      	<tr>
                      		<td>글번호</td>
                      		<td>글제목</td>
                      		<td>작성자</td>
                      		<!-- <td>조회수</td> -->
                      		<td>작성일</td>
                      	</tr>
                      	<c:if test="${empty list}">
                      		<tr>
                      			<td colspan="4">
                      				등록된 글이 없습니다.
                      			</td>
                      		</tr>
                      	</c:if>
                      	<c:if test="${!empty list}">
	                      	<c:forEach var="dto" items="${list}">
	                      		<tr>
	                      			<td>${dto.fno }</td>
	                      			<td><a href="/boards/get?fno=${dto.fno}">${dto.subject}&nbsp;<strong>[${dto.replycnt}]</strong></a></td>
	                      			<td>${dto.mid}</td>
	                      			<%-- <td>${dto.hit }</td> --%>
	                      			<td>
	                      				<fmt:formatDate value="${dto.f_indate}" pattern="yyyy-MM-dd"/>
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
                          <!-- 
                              <li class="page-item">
                                  <a href="#" class="page-link" aria-label="Previous">
                                      <span aria-hidden="true">
                                          <span class="lnr lnr-chevron-left"></span>
                                      </span>
                                  </a>
                              </li>
                               -->
                              <c:forEach var="num" begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}">
								
								<li class='page-item  ${pageMaker.st.page == num ? "active":""} '>
									<a href="${num}" class="page-link pageN">${num}</a>
								</li>
								
							</c:forEach>
                              <!-- 
                              <li class="page-item">
                                  <a href="#" class="page-link">01</a>
                              </li>
                              <li class="page-item active">
                                  <a href="#" class="page-link">02</a>
                              </li>
                              <li class="page-item">
                                  <a href="#" class="page-link">03</a>
                              </li>
                              <li class="page-item">
                                  <a href="#" class="page-link">04</a>
                              </li>
                              <li class="page-item">
                                  <a href="#" class="page-link">09</a>
                              </li>
                               -->
                               <c:if test="${pageMaker.next}">
									<li class="page-item">
	                                  <a href="${pageMaker.endPage +1 }" class="page-link" aria-label="Next">
	                                      <span aria-hidden="true">
	                                          <span class="lnr lnr-chevron-right"></span>
	                                      </span>
	                                  </a>
	                              </li>
								</c:if>
								<!-- 
                              <li class="page-item">
                                  <a href="#" class="page-link" aria-label="Next">
                                      <span aria-hidden="true">
                                          <span class="lnr lnr-chevron-right"></span>
                                      </span>
                                  </a>
                              </li>
                               -->
                          </ul>
                      </nav>
                      
                  </div>
              <!-- </div>
  		</div> -->
  	</div>
    <form id="pageF" action='/boards/list' method='get'>
    	<input type="hidden" name="page" >
    </form>
  <!--================Blog Area =================-->

  <!--================Instagram Area =================-->
  <!-- 
  <section class="instagram_area">
    <div class="container box_1620">
      <div class="insta_btn">
        <a class="btn theme_btn" href="#">Follow us on instagram</a>
      </div>
      <div class="instagram_image row m0">
        <a href="#"><img src="/resources/img/instagram/ins-1.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-2.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-3.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-4.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-5.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-6.jpg" alt=""></a>
      </div>
    </div>
  </section>
   -->
  <!--================End Instagram Area =================-->
  
<%@ include file="../include/footer.jsp" %>



  
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
	});
  </script>
</body>
</html>