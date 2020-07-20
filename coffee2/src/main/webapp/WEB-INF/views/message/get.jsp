<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<div class="container">
		<form id="pkc" role="form">
		  <div class="form-group">
		  	<label class="txtT">${dto.u_no}번 메시지</label>
		  	<input type="hidden" id="u_no" name="u_no" value="${dto.u_no}">
		  </div>
		  <div class="form-group">
		  	<label>보낸날짜</label>
		  	<input type="text" class="form-control" value="${dto.u_reg }" readonly>
		  </div>
		  <div class="form-group">
		  	<label>보낸사람</label>
		  	<input type="text" class="form-control" value="${dto.u_from }" readonly/>
		  </div>
          <div class="form-group">
            <label>메시지 제목</label> <input class="form-control" id="u_sub" name='u_sub' value='${dto.u_sub}' readonly>
          </div>
		  <div class="msg"></div>
          <div class="form-group">
            <label>메시지 내용</label>
            <textarea class="form-control" rows="20" id="u_msg" name='u_msg' readonly>${dto.u_msg} </textarea>
          </div>
          <div class="msg"></div>
		  <!-- 
          <div class="form-group">
            <label>Writer</label> <input class="form-control" id="mid" name='mid'>
          </div>
           -->
          
          <c:if test="${mid == dto.mid}">
          	  <button data-oper="delete" class="button" >삭제하기</button>
          </c:if>
		  <button data-oper='list' class="button">List</button>
          <!--  
          <button type="reset" class="button">Reset</button>
           -->
        </form>
    </div>

    <!--=================reply area=====================-->
   
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
		var mid = '<c:out value="${mid}"/>';
		var u_no = '<c:out value="${dto.u_no}"/>';
		function checkReadStatus(mid, u_no){
			$.ajax({
				type:"get",
				url:"/message/checkReadStatus",
				data:{mid:mid, u_no:u_no},
				success:function(check){
					if(check == "changed"){
						checkMessageQ(mid);
						getMessageL(mid);
					}
				}
			});
		}
		$(document).ready(function(){
			checkReadStatus(mid, u_no);
			$("button[data-oper='delete']").on("click", function(e){
				e.preventDefault();
				console.log("delete button clicked....");
				var chk = confirm("정말로 지우시겠습니까?");
				if(chk){
					document.location.href="/message/delete?u_no="+u_no+"&mid="+mid;
				}
			});
			$("button[data-oper='list']").on("click", function(e){
				e.preventDefault();
				console.log("list button clicked....");
				document.location.href="/message/showAllMessage?mid="+mid;
			});
		});
	</script>