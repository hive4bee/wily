<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<div class="container col-sm-7 col-lg-5 mb-3 mt-5">
	<div class="row mb-5 mt-5">
        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
          <div class="media contact-info">
            <span class="contact-info__icon"><i class="ti-home"></i></span>
            <div class="media-body">
              <h3>아이디 찾기 결과</h3>
            </div>
          </div>
        </div>
     </div>
     
		<div class="row mb-3 mt-5 align-items-center justify-content-center">
			ID : ${mid}
		</div>
	</div>
	<div class="row mb-5 align-items-center justify-content-center">
		<a href="/members/loginForm" class="button">로그인 하기</a>
	</div>
<%@ include file="../include/footer.jsp" %>