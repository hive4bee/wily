<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<!-- ================ start banner area ================= -->
	<style>
		#likelike{
			border:none;
		}
	</style>
	<section class="blog-banner-area" id="blog">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Shop Single</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Shop Single</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->


  <!--================Single Product Area =================-->
	<div class="product_image_area">
		<div class="container">
			<div class="row s_product_inner">
				<div class="col-lg-6">
					<div class="owl-carousel owl-theme s_Product_carousel">
						<div class="single-prd-item">
							<img class="img-fluid" src='/imgs/${dto.uploadpath}/${dto.uuid}_${dto.filename}'>
						</div>
						<!-- <div class="single-prd-item">
							<img class="img-fluid" src="img/category/s-p1.jpg" alt="">
						</div>
						<div class="single-prd-item">
							<img class="img-fluid" src="img/category/s-p1.jpg" alt="">
						</div> -->
					</div>
				</div>
				<div class="col-lg-5 offset-lg-1">
					<div class="s_product_text">
						<h3>${dto.pname}</h3>
						<h2><fmt:formatNumber value="${dto.pprice}" type="currency"/></h2>
						<ul class="list">
							<li><a class="active" href="#"><span>카테고리</span> : ${dto.pcategory}</a></li>
							<li>제조사 : 빠크</li>
						</ul>
						<p>${dto.pcomment}</p>
						<div class="product_count">
              				<label for="qty">Quantity:</label>
							<input type="text" name="qty" id="sst" size="2" maxlength="12" value="1" title="Quantity:" class="input-text qty" readonly>
              				<button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                             class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                         	<button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
                             class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
						</div><br>
							<button class="button primary-btn addToCart">Add to Cart</button>
							<div class="">
							
							</div>               
						<div class="card_area d-flex align-items-center">
							<!-- <a class="icon_btn" href="#"><i class="lnr lnr lnr-diamond"></i></a> -->
							<!-- <a class="icon_btn" href="#"><i class="lnr lnr lnr-heart"></i></a> -->
							<button class="icon_btn" id="likelike" style="display:flex; align-items:center; justify-content:center;"><img src='/resources/img/heart2.png' width='15' height='15'></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form name="pkc" action="/products/cart">
		<input type="hidden" name="pnum" value="${dto.pnum}">
		<c:if test="${!empty sessionScope.mid }">
			<input type="hidden" name="mid" value="${mid}">
		</c:if>
		<input type="hidden" name="quantity" value="">
	</form>
	<!--================End Single Product Area =================-->
<%@ include file="../include/footer.jsp" %>
<script>
	var formObj = $("form[name='pkc']");
	var id = '<c:out value="${mid}"/>';
	var pnum='<c:out value="${dto.pnum}"/>';
	$(document).ready(function(){
		if(id){
			checkLike(id, pnum);
		}
		//var cartN = $("#cartN").text();
		//alert("cartN : " + cartN);
		$(".addToCart").on("click", function(e){
			e.preventDefault();
			console.log("addToCart Button clicked .......");
			if(!id){
				document.location='/members/loginForm';
			}
			var quantity = $("#sst").val();
			if(quantity == 0){
				alert("하나 이상의 갯수를 고르시오");
				return false;
			}
			$("input[name='quantity']").val(quantity);
			
			if(id.length>0 && quantity > 0){
				//alert("HIHI");
				
				$.ajax({
					type:"get",
  					url:"/products/addToCart",
  					data:{mid:id, pnum:pnum, cqty:quantity},
  					//contentType:"application/json",
  					//contentType:"application/json; charset=utf-8",
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
				
			}
			
			//formObj.submit();
		});//-------end addToCart---------------
		
		$("#likelike").on("click", function(e){
			e.preventDefault();
			if(!mid){
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			console.log("likelike button clicked....");
			var heart = $(this).find("img").attr("src");
			console.log("heart : " + heart);
			var regex = new RegExp("(.*)(heart)(2).");
			console.log("test : " + regex.test(heart));//2 : empty heart, 1 : filled heart
			if(regex.test(heart)){//if empty heart
				$.ajax({
					type:"get",
					url:"/products/insertLike",
					data:{mid:id, pnum:pnum},
					success:function(check){
						if(check=='success'){
							console.log("change heart status : empty -> filled");
							$("#likelike").html("<img src='/resources/img/heart1.png' width='15' height='15'>");
						}
					}
				});
			}else{
				$.ajax({
					type:"get",
					url:"/products/deleteLike",
					data:{mid:id, pnum:pnum},
					success:function(check){
						if(check=='success'){
							console.log("change heart status : filled -> empty")
							$("#likelike").html("<img src='/resources/img/heart2.png' width='15' height='15'>");
						}
					}
				});
			}
			/* 
			$.ajax({
				type:"get",
				url:"/products/clickLike",
				data:{mid:id, pnum:pnum},
				success:function(check){
					
				}
			});
			 */
		});//---------end click like button-------
		
	});//-----------end document----------------
	function checkLike(mid, pnum){
		console.log("mid : " + mid + " pnum : " + pnum);

		$.ajax({
			type:"get",
			url:"/products/likes",
			data:{mid:mid, pnum:pnum},
			success:function(check){
				console.log("check : " + check);
				
				if(check=="exist"){
					console.log("heart exist");
					$("#likelike").html("<img src='/resources/img/heart1.png' width='15' height='15'>")
				}else{
					console.log("not exist");
					$("#likelike").html("<img src='/resources/img/heart2.png' width='15' height='15'>");
				}
				
			}
		});
	}
	
</script>