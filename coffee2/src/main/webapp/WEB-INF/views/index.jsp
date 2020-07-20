<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
  <main class="site-main">
    
    <!--================ Hero banner start =================-->
    <section class="hero-banner">
      <div class="container">
        <div class="row no-gutters align-items-center pt-60px">
          <div class="col-5 d-none d-sm-block">
            <div class="hero-banner__img">
              <img class="img-fluid" src="resources/img/maincoffee.jpg" alt="">
            </div>
          </div>
          <div class="col-sm-7 col-lg-6 offset-lg-1 pl-4 pl-md-5 pl-lg-0">
            <div class="hero-banner__content">
              <h4>Shop is fun</h4>
              <h1>Browse Our Premium Product</h1>
              <p>Us which over of signs divide dominion deep fill bring they're meat beho upon own earth without morning over third. Their male dry. They are great appear whose land fly grass.</p>
              <a class="button button-hero" href="#">Browse Now</a>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!--================ Hero banner start =================-->

    <!--================ Hero Carousel start =================-->
    <section class="section-margin mt-0">
      <div class="owl-carousel owl-theme hero-carousel">
        <div class="hero-carousel__slide">
          <img src="resources/img/coffeeBean.jpg" alt="" class="img-fluid">
          <a href="/products/coffeeList2" class="hero-carousel__slideOverlay">
            <h3>커피</h3>
            <p>제품보기</p>
          </a>
        </div>
        <div class="hero-carousel__slide">
          <img src="resources/img/branch.png" alt="" class="img-fluid">
          <a href="#" class="hero-carousel__slideOverlay">
            <h3>지점</h3>
            <p>지점 찾기</p>
          </a>
        </div>
        <div class="hero-carousel__slide">
          <img src="resources/img/cartcart.png" alt="" class="img-fluid">
          <a href="/products/viewCart?mid=${mid}" class="hero-carousel__slideOverlay">
            <h3>장바구니</h3>
            <p>바로가기</p>
          </a>
        </div>
      </div>
    </section>
    <!--================ Hero Carousel end =================-->

    

  </main>
	<%@ include file="./include/footer.jsp" %>
