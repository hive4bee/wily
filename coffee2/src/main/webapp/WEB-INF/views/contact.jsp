<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>


	<!-- ================ start banner area ================= -->
	<section class="blog-banner-area" id="contact">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>지점확인</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item">어디서 살껀지 골라야쥐~??</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->

	<!-- ================ contact section start ================= -->
  <section class="section-margin--small">
    <div class="container">
      <div class="d-none d-sm-block mb-5 pb-4">
      <!-- style="width:500px;height:400px;" -->
        <p style="margin-top:-12px"></p>
        <div class="row">
	        <div class="col-md-4 col-lg-3 mb-4 mb-md-0">
	          <div class="media contact-info">
	            <span class="contact-info__icon"><i class="ti-home"></i></span>
	            <div class="media-body">
	              <h3>방문매장 검색</h3>
	              <!-- <p>확인 잘해라잉</p> -->
	              <p></p>
	            </div>
	          </div>
	        </div>
        </div>
            <div class="row">
              
        	<select id="selectF">
        		<option value="0">지역을 선택해주세요</option>
        		<option value="강원도">강원도</option>
        		<option value="경기">경기도</option>
        		<option value="경상남도">경상남도</option>
        		<option value="경상북도">경상북도</option>
        		<option value="광주광역시">광주광역시</option>
        		<option value="대구광역시">대구광역시</option>
        		<option value="대전">대전광역시</option>
        		<option value="부산">부산광역시</option>
        		<option value="서울">서울특별시</option>
        		<option value="세종">세종특별자치시</option>
        		<option value="울산광역시">울산광역시</option>
        		<option value="인천광역시">인천광역시</option>
        		<option value="전라남도">전라남도</option>
        		<option value="전라북도">전라북도</option>
        		<option value="제주">제주특별자치</option>
        		<option value="충청남도">충청남도</option>
        		<option value="충청북도">충청북도</option>
        	</select>
        	<button class="searchBtn">검색</button>
                <!-- 
                  <select class="shipping_select">
                     <option value="1">군산 빠끄커피</option>
                  </select>
                   -->
            </div>
            
        </div>
      </div>
      <!-- 
        <h3><strong>방문 매장검색</strong> 검색하여 매장을 선택하세요</h3>
        <div class="row">
        	<select>
        		<option value="">지역을 선택해주세요</option>
        		<option value="">강원도</option>
        		<option value="">경기도</option>
        		<option value="">경상남도</option>
        		<option value="">경상북도</option>
        		<option value="">광주광역시</option>
        		<option value="">대구광역시</option>
        		<option value="">대전광역시</option>
        		<option value="">부산광역시</option>
        		<option value="">서울특별시</option>
        		<option value="">세종특별자치시</option>
        		<option value="">울산광역시</option>
        		<option value="">인천광역시</option>
        		<option value="">전라남도</option>
        		<option value="">전라북도</option>
        		<option value="">제주특별자치</option>
        		<option value="">충청남도</option>
        		<option value="">충청북도</option>
        	</select>
        	<button>검색</button>
        </div>
         -->
         <div class="container" id="shopshop" style="height:200px; overflow:auto;">
	        
        </div>
        <p style="margin-top:12px"></p>
        <div class="container">
			<div id="map" style="width:100%;height:350px;"></div>
			<!-- 
			<div class="form-group text-center text-md-right mt-3">
              <button type="submit" class="button button--active button-contactForm">결제하러 갈까?</button>
            </div>
             -->
		</div>
		<form name="pkc" action="/products/cooookie">
			<input type="hidden" name="snum" value="">
		</form>
		
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=212448827467eac6ba3ba9165d851f8a&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
//var arr = ["서울시 노원구 월계동 469-3 101호", "서울시 동대문구 이문로 83", "서울시 강서구 양천로 132"];
/* 
for(var i=0; i<arr.length; i++){
	//console.log(i + "   " + arr[i]);
geocoder.addressSearch(arr[i], function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        //var infowindow = new kakao.maps.InfoWindow({
        //    content: '<div style="width:150px;text-align:center;padding:6px 0;">BBAKK</div>'
        //});
        //infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});
}
 */
</script>
       


      
  </section>
	<!-- ================ contact section end ================= -->
  
<%@ include file="./include/footer.jsp" %>
<script src="/resources/js/map.js"></script>
  <script>
  	$(document).ready(function(){
  		$("#shopshop").css("display", "none");
  		$(".searchBtn").on("click", function(e){
  			e.preventDefault();
  			console.log("searchBtn clicked......");
  			var str="";
  			var sel = document.getElementById("selectF");
  			var kk = sel.options[sel.selectedIndex].value;
  			if(kk=='0'){
  				console.log("다른 것을 선택해야함");
  				return false;
  			}
  			var key={key:kk};
  			mapService.getMapList(key, function(list){
  				str+="<div class='table-responsive'><table class='table'>"
  				for(var i=0,len=list.length; i<len; i++){
  					//console.log(list[i]);
  					str+="<tr><td><input type='hidden' value='"+list[i].snum+"'></td>";
  					str+="<td>"+list[i].loc+"<br>";
  					str+=list[i].tel+"</td><td></td>";
  					str+="<td><span>"+list[i].addr+"</span></td>";
  					str+="<td></td><td><button class='btn-outline-primary'>선택</button>&nbsp;<button class='btn-outline-info'>지도</button></td>";
  					str+="</tr>";
  					geocoder.addressSearch(list[i].addr, function(result, status) {

  					    // 정상적으로 검색이 완료됐으면 
  					     if (status === kakao.maps.services.Status.OK) {

  					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

  					        // 결과값으로 받은 위치를 마커로 표시합니다
  					        var marker = new kakao.maps.Marker({
  					            map: map,
  					            position: coords
  					        });

  					        map.setCenter(coords);
  					    } 
  					});
  				}
  				str+="</table></div>";
  				$("#shopshop").css("display", "block").html(str);
  				
  			});
  		});
  		
  		$("#shopshop").on("click", ".btn-outline-primary", function(e){
  			e.preventDefault();
  			console.log("선택 버튼 .....");
  			var snum = $(this).closest("tr").find("input").val();
  			var formObj = $("form[name='pkc']");
  			$("input[name='snum']").val(snum);
  			formObj.submit();
  			/* 
  			console.log(" : " + ad);
  			geocoder.addressSearch(ad, function(result, status){
  				if(status === kakao.maps.services.Status.OK){
  					var coo = new kakao.maps.LatLng(result[0].y, result[0].x);
  					map.setCenter(coo);
  				}
  			});
  			 */
  		});
  		$("#shopshop").on("click", ".btn-outline-info", function(e){
  			e.preventDefault();
  			console.log("지도 버튼....");
  			var ad = $(this).closest("tr").find("span").text();
  			console.log("주소 출력해보자 : " + ad);
  			geocoder.addressSearch(ad, function(result, status){
  				if(status === kakao.maps.services.Status.OK){
  					var coo = new kakao.maps.LatLng(result[0].y, result[0].x);
  					map.setCenter(coo);
  				}
  			});
  		});
  	});
  </script>