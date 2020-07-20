<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
	<div class="container">
		<form role="form" action="/boards/writePro" method="post">
		  <div class="form-group">
		  	<label>글작성</label>
		  </div>
          <div class="form-group">
            <label>글 제목</label> <input class="form-control" id="subject" name='subject'>
          </div>
		  <div class="msg"></div>
          <div class="form-group">
            <label>글 내용</label>
            <textarea class="form-control" rows="20" id="content" name='content'></textarea>
          </div>
          <div class="msg"></div>
		  <!-- 
          <div class="form-group">
            <label>Writer</label> <input class="form-control" id="mid" name='mid'>
          </div>
           -->
           <input type="hidden" name="mid" value="${mid}">
          <button type="submit" class="button">Submit</button>
          <button type="reset" class="button">Reset</button>
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
  	var submitBtn = $("button[type='submit']");
  	var formObj = $("form[role='form']")
  	var msg = document.getElementsByClassName("msg");
  	$(document).ready(function(){
  		submitBtn.on("click", function(e){
  			e.preventDefault();
  			if(!$("#subject").val()){
  				msg[0].innerText="글 제목을 입력해주세요";
  			}else{
  				msg[0].innerText="";
  			}

  			if(!$("#content").val()){
  				msg[1].innerText="글 내용을 입력해주세요";
  			}else{
  				msg[1].innerText="";
  			}
  			formObj.submit();
  		});
  	});
  </script>
</body>
</html>