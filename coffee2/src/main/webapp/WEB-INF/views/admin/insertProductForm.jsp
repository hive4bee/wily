<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerA.jsp" %>

<div class="col-lg-7 container">
	<h1 class="h3 mb-4 text-gray-800 text-center">*상품등록</h1>
<div class="row justify-content-center">
	<form class="user col-lg-7" name='pkc' encType="multipart/form-data" method="post" action="/admin/insertPro">
		<div class="form-group row">
				<input type="text" class="form-control form-control-user"
					id="pcode" name="pcode" placeholder="상품코드">
		</div>
		<div class="form-group row">
				<input type="text" class="form-control form-control-user"
					id="pname" name="pname" placeholder="상품이름">
		</div>
		<div class="form-group row">
			<input type="text" class="form-control form-control-user"
				id="pprice" name='pprice' placeholder="상품가격">
		</div>
		<div class="form-group row">
			<input type="text" class="form-control form-control-user"
				id="pcategory" name='pcategory' placeholder="카테고리">
		</div>
		<div class="form-group row">
			<textarea class='form-control form-control-user' id='pcomment' name='pcomment' placeholder="상품설명"></textarea>
		</div>
		
		<div class="form-group row">
			<input type="file" name='uploadFile' id="uploadFile"><br>
			<!-- 이미지 파일을 여러 개 업로드 하고 싶다면 아래 multiple을 붙여준다. 
			<input type="file" name='uploadFile' id="uploadFile" multiple><br>
			 -->
		</div>
		<div class="form-group row images">
			<img id="blah" src=""/><br>
		</div>
		
		<a href="/admin/insertProductPro" id="insertBtn" class="btn btn-primary btn-user btn-block">
			상품등록 </a>
		<hr>
		
	</form>
</div>
</div>
<%@ include file="../include/footerA.jsp" %>
<script>
	var images = $(".images");
	var insertBtn = $("#insertBtn");
	var regex = new RegExp("(.*?)\.(jpg|png)$");
	var maxSize = 5242880;//5MB;
	var chk = 1;
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			chk = -1;
			return false;
		}
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			chk = -1;
			return false;
		}
		chk=1;
		return true;
	}
	$(document).ready(function(){
		
		 $("#uploadFile").on('change', function(){
			 checkExtension(this.files[0].name, this.files[0].size);
             readURL(this);
         });
		 
		/* 이미지 여러 개를 업로드하고 싶다면 주석을 풀고 위의 uploadFile과 아래쪽 readURL부분을 주석처리해준다.
		 $("#uploadFile").on('change', function(){
			 console.log("file_length : " + this.files.length);
			 var len=this.files.length;
			 for(var i=0; i<len; i++){
				 console.log("i : " + i);
			 	console.log(this.files[i])
			 	var file = this.files[i]
			 	var reader = new FileReader();
			 	reader.onload=function(e){
			 		var str="<div class='row'><img name='image["+i+"]' width='200' height='200' src='"+e.target.result+"'></div>";
	       			images.append(str);
			 	}
			 	reader.readAsDataURL(file);
			 }
             //readURL(this);
         });
		   */
		 insertBtn.on("click", function(e){
			e.preventDefault();
			console.log("insert button clicked....");
			if(!$("#pcode").val()){
				alert("상품코드를 입력하시오");
				$("#pcode").focus();
				return false;
			}
			if(!$("#pname").val()){
				alert("상품이름을 입력하시오");
				$("#pname").focus();
				return false;
			}
			if(!$("#pprice").val()){
				alert("상품가격을 입력하시오");
				$("#pprice").focus()
				return false;
			}
			if(!$("#pcategory").val()){
				alert("카테고리를 입력하시오");
				$("#pcategory").focus()
				return false;
			}
			if(!$("#pcomment").val()){
				alert("상품설명을 입력하시오");
				$("#pcomment").focus();
				return false;
			}
			if(chk==-1){
				alert("올바른 양식의 파일을 업로드 하시오");
				return false;
			}
			if(!$("#uploadFile").val()){
				alert("이미지 파일을 업로드하시오");
				return false;
			}
			document.pkc.submit();
		 });
	});//--------------end document ready-----------------------
	
	function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
       	 	$('#blah').attr('width',"200px");
       	 	$("#blah").attr('height',"200px");
                $('#blah').attr('src', e.target.result);
            }
          reader.readAsDataURL(input.files[0]);
        }
    }
	
	
</script>