<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerA.jsp" %>

<div class="col-lg-7 container">
	<h3 class="h3 mb-4 text-gray-800 text-center">상품 번호 : ${dto.pnum}</h3>
		<div class="form-group row">
			<label for="pcode">상품코드</label>
			<div class="form-control form-control-user" id="pcode">${dto.pcode }</div>
			<%-- <input type="text" class="form-control form-control-user" id="pcode" value="${dto.pcode}" readonly> --%>
		</div>
		<div class="form-group row">
			<label for="pname">상품이름</label>
			<div class="form-control form-control-user" id="pname">${dto.pname}</div>
				<%-- <input type="text" class="form-control form-control-user" id="pname" name="pname" value="${dto.pname}" readonly> --%>
		</div>
		<div class="form-group row">
			<label for="pprice">상품가격</label>
			<div class="form-control form-control-user"><fmt:formatNumber value="${dto.pprice}" pattern="#,###"/></div>
			<%-- <input type="text" class="form-control form-control-user" id="pprice" name='pprice' placeholder="상품가격" value="${dto.pprice}"> --%>
		</div>
		<div class="form-group row">
			<label for="pcategory">카테고리</label>
			<input type="text" class="form-control form-control-user"
				id="pcategory" name='pcategory' placeholder="카테고리">
		</div>
		<div class="form-group row">
			<label for="pcomment">상품설명</label>
			<textarea class='form-control form-control-user' id='pcomment' name='pcomment' readonly>${dto.pcomment}</textarea>
		</div>
		<div class="form-group row">
			<label for="phide">상품노출여부</label>
			<div class="form-control form-control-user" id="phide">${dto.phide}</div>
		</div>
		
		<div class="form-group row images">
			<img id="blah" src='/imgs/${dto.uploadpath}/${dto.uuid}_${dto.filename}'/><br>
		</div>
		
		<div class="row">
			<a href="/admin/coffeeList" class="btn btn-primary col-lg-4">리스트</a>
			<a href="/admin/insertProductPro" id="insertBtn" class="btn btn-primary col-lg-4 modifyBtn">
				상품수정</a>
			<a href="" class="btn btn-primary col-lg-4 deleteBtn">상품삭제</a>
		</div>
</div>

<%@ include file="../include/footerA.jsp" %>
<script>
	var pnum = '<c:out value="${dto.pnum}"/>';
	var uploadpath = '<c:out value="${dto.uploadpath}"/>';
	var uuid = '<c:out value="${dto.uuid}"/>';
	var filename2 = '<c:out value="${dto.filename}"/>';
	var fileName=encodeURIComponent(uploadpath+"/s_"+uuid+"_"+filename2);
	$(document).ready(function(){
		$(".deleteBtn").on("click", function(e){
			e.preventDefault();			
			console.log("delete btn clicked....");
			console.log("fileName : " + fileName);
			console.log("pnum : " + pnum);
			
			var checkTrue = confirm("삭제하시겠습니까?");
			if(checkTrue){
				self.location="/admin/deleteProduct?pnum="+pnum+"&fileName="+fileName;
			}else{
				console.log("취소됨");
				return;
			}
			
		});
		$(".modifyBtn").on("click", function(e){
			e.preventDefault();
			console.log("modify btn clicked....");
			self.location="/admin/modifyProductForm?pnum="+pnum;
		});
	});
</script>