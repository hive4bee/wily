<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="UTF-8">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Home</title>
	<link rel="icon" href="/resources/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="/resources/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="/resources/vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
  <link rel="stylesheet" href="/resources/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="/resources/vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="/resources/vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="/resources/vendors/nouislider/nouislider.min.css">
  
  <link rel="stylesheet" href="/resources/css/style.css">
    <script src="/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
</head>
<body onload="checkCartQuantity('${mid}')">
	<!-- <div id="socketAlert" class="alert alert-success" role="alert"></div> -->
  <!--================ Start Header Menu Area =================-->
	<header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
          <a class="navbar-brand logo_h" href="/"><img src="/resources/img/logo.png" alt=""></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
              <li class="nav-item active"><a class="nav-link" href="/">홈으로</a></li>
              <li class="nav-item submenu dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">카테고리</a>
                <ul class="dropdown-menu">
                  <li class="nav-item"><a class="nav-link" href="/products/coffeeList2">커피</a></li>
                  <!-- 
                  <li class="nav-item"><a class="nav-link" href="single-product.html">Product Details</a></li>
                  <li class="nav-item"><a class="nav-link" href="checkout.html">Product Checkout</a></li>
                  <li class="nav-item"><a class="nav-link" href="confirmation.html">Confirmation</a></li>
                  <li class="nav-item"><a class="nav-link" href="cart.html">Shopping Cart</a></li>
                   -->
                </ul>
							</li>
              <li class="nav-item submenu dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">게시판</a>
                <ul class="dropdown-menu">
                  <li class="nav-item"><a class="nav-link" href="/boards/list">자유게시판</a></li>
                  <!-- 
                  <li class="nav-item"><a class="nav-link" href="single-blog.html">Blog Details</a></li>
                   -->
                </ul>
							</li>
							<li class="nav-item submenu dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                  aria-expanded="false">내정보</a>
                <ul class="dropdown-menu">
                  <c:if test="${!empty sessionScope.mid }">
                  	
                  	<li class="nav-item"><a class="nav-link" href="/members/logOut">로그아웃</a></li>
                  	<li class="nav-item"><a class="nav-link" href="/members/viewMyRecord?mid=${mid}">주문조회</a></li>
	                <li class="nav-item"><a class="nav-link" href="/products/viewMyLikes?mid=${mid}">찜 목록</a></li>
                  </c:if>
                  <c:if test="${empty sessionScope.mid}">
                  	<li class="nav-item"><a class="nav-link" href="/members/loginForm">로그인</a>
	                <li class="nav-item"><a class="nav-link" href="/members/register">회원가입</a></li>
                  </c:if>
                </ul>
              </li>
              <li class="nav-item"><a class="nav-link" href="/contact">주문하기</a></li>
            </ul>

            <ul class="nav-shop">
            <!--  -->
              <li class="nav-item dropdown mx-3">
              	<button class="nav-link dropdown-toggle" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              		<i class="ti-comment"></i><span class="nav-shop__circle messageCnt">0</span>
              		<div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in messageAA" aria-labelledby="alertsDropdown">
	                <h6 class="dropdown-header">
	                  Alerts Center
	                </h6>
	                <a class="dropdown-item d-flex align-items-center" href="#">
	                  <div class="mr-3">
	                    <div class="icon-circle bg-warning">
	                      <i class="fas fa-exclamation-triangle text-whit"></i>
	                    </div>
	                  </div>
	                  <div>
	                    <div class="small text-gray-500">probably you may want to log in</div>
	                    <span class="font-weight-bold">로그인이 필요한 서비스입니다.</span>
	                  </div>
	                </a>
	                <!-- 
	                <a class="dropdown-item d-flex align-items-center" href="#">
	                  <div class="mr-3">
	                    <div class="icon-circle bg-primary">
	                      <i class="fas fa-file-alt text-white"></i>
	                    </div>
	                  </div>
	                  <div>
	                    <div class="small text-gray-500">December 12, 2019</div>
	                    <span class="font-weight-bold">A new monthly report is ready to download!</span>
	                  </div>
	                </a>
	                
	                <a class="dropdown-item d-flex align-items-center" href="#">
	                  <div class="mr-3">
	                    <div class="icon-circle bg-success">
	                      <i class="fas fa-donate text-white"></i>
	                    </div>
	                  </div>
	                  <div>
	                    <div class="small text-gray-500">December 7, 2019</div>
	                    $290.29 has been deposited into your account!
	                  </div>
	                </a>
	                
	                <a class="dropdown-item d-flex align-items-center" href="#">
	                  <div class="mr-3">
	                    <div class="icon-circle bg-warning">
	                      <i class="fas fa-exclamation-triangle text-white"></i>
	                    </div>
	                  </div>
	                  <div>
	                    <div class="small text-gray-500">December 2, 2019</div>
	                    Spending Alert: We've noticed unusually high spending for your account.
	                  </div>
	                </a>
	                 -->
	                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
	              </div>
              	</button>
              </li>
              <li class="nav-item"><button onclick="cartBtn('${mid}')"><i class="ti-shopping-cart"></i><span class="nav-shop__circle" id="cartN"></span></button> </li>
              <li class="nav-item"><a class="button button-header" href="#">Buy Now</a></li>
            </ul>
          </div>
        </div>
      </nav>
    </div>
  </header>
	<!--================ End Header Menu Area =================-->
	<script>
		function checkCartQuantity(mid){
			if(!mid){
				$("#cartN").text("0");
			}else{
				$.ajax({
					type:"get",
  					url:"/products/checkCartQuantity",
  					data:{mid:mid},
  					//contentType:"application/json",
  					//contentType:"application/json; charset=utf-8",
  					success:function(check){
  						//data:JSON.stringify(reply),	
  						if(check){
  							$("#cartN").text(check);
  							console.log("cnt : " + check);
  						}else {
  							console.log("DB 입력 실패");
  						}
  					}
				});
			}
		}
		
		function cartBtn(mid){
			
			console.log("cartBtn clicked.....");
			
			if(!mid){
				document.location="/members/loginForm";
			}else{
				document.location="/products/viewCart?mid="+mid;
			}
		}
	</script>