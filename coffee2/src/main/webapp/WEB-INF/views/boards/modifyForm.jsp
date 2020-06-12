<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
	<div class="container">
		<form id="pkc" role="form">
		  <div class="form-group">
		  	<label>수정하기</label>
		  	<input type="hidden" id="fno" name="fno" value="${dto.fno}">
		  </div>
          <div class="form-group">
            <label>글 제목</label> <input class="form-control" id="subject" name='subject' value='${dto.subject}'>
          </div>
		  <div class="msg"></div>
          <div class="form-group">
            <label>글 내용</label>
            <textarea class="form-control" rows="20" id="content" name='content'>${dto.content} </textarea>
          </div>
          <div class="msg"></div>
		  <!-- 
          <div class="form-group">
            <label>Writer</label> <input class="form-control" id="mid" name='mid'>
          </div>
           -->
          
          
          <button data-oper="modify" class="button">수정하기</button>
		  <button data-oper='list' class="button">List</button>
          <!--  
          <button type="reset" class="button">Reset</button>
           -->
        </form>
    </div>
    
    <!--================Instagram Area =================-->
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
  <!--================End Instagram Area =================-->
  
<%@ include file="../include/footer.jsp" %>
  <script>
  	var formObj = $("form[role='form']")
  	$(document).ready(function(){
  		$("button[data-oper='modify']").on("click", function(){
			formObj.attr("action", "/boards/modifyPro")
			formObj.submit();
  	  	});
  		$("button[data-oper='list']").on("click", function(){
  	  		formObj.find("#fno").remove();
  	  		formObj.find("#subject").remove();
  	  		formObj.find("#content").remove();
			formObj.attr("action", "/boards/list");
			formObj.submit();
  	  	});
  	});
  </script>
</body>
</html>