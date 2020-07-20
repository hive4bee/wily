<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Shopping Cart</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Shopping Cart</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  

  <!--================Cart Area =================-->
  <section class="cart_area">
      <div class="container">
      	<div class="row mb-5 ml-3">
      	<div class="shipping_box">
             <c:if test="${empty addr}">
             	픽업매장을 선택하세요
             	<button class="btn-outline-primary">지도</button>
             </c:if>
             <c:if test="${!empty addr }">
             	<strong>*픽업 매장</strong> : <span id="pickup">${addr}</span>&nbsp;&nbsp;&nbsp;
             	<!-- <strong>바꾸기</strong> -->
             	<button class="btn-outline-primary">바꾸기</button>
             </c:if>
         </div>
         
      	</div>
          <div class="cart_inner">
              <div class="table-responsive">
                  <table class="table">
                  	
                      <thead>
                          <tr>
                              <th scope="col"><input type="checkbox" class="checkT" checked onclick="checkAll()">&nbsp;Product</th>
                              <th scope="col">가격</th>
                              <th scope="col">수량</th>
                              <th scope="col">소계</th>
                              <th scope="col">비고</th>
                          </tr>
                      </thead>
                      <tbody>
                      	<tr id="trtr">
                      	  <c:if test="${empty list }">
                      	  	<tr>
                      	  		<td colspan="4">
                      	  			장바구니에 담긴 상품이 없습니다.
                      	  		</td>
                      	  	</tr>
                      	  </c:if>
                      	  <c:if test="${!empty list}">
                      	  <c:set var="sum" value="0"/>
                      	  <c:set var="ii" value="0"/>
                      	  <form name='pkc' action='/products/orderForm'>
                      	  <input type="hidden" name="mid" value="${mid}">
                      	  <input type="hidden" name="addr" value="">
                      	  <c:forEach var="dto" items="${list}">
                      	  <c:set var="sum" value="${sum+dto.cqty*dto.pprice}" />
                      	  
                      	  	<tr>
                      	  		<td>
                      	  			<div class="media">
                      	  				<div class="d-flex">
                      	  					<input type="checkbox" class="checkS" checked onclick="checkcheck()">
                      	  					<img src="/imgs/${dto.uploadpath}/s_${dto.uuid}_${dto.filename}" width="100" height="100">
                      	  				</div>
                      	  				<div class="media-body">
                      	  					<p>${dto.pname}</p>
                      	  				</div>
                      	  			</div>
                      	  		</td>
                      	  		<td>
                      	  			<h5><fmt:formatNumber value="${dto.pprice}" type="currency"/></h5>
                      	  		</td>
                      	  		<td>
                      	  			<div class="product_count">
                      	  				<input type="hidden" name="cnum" class="hiddenCnum" value="${dto.cnum}">
                      	  				<input type="hidden" class="hiddenP" value="${dto.pprice}">
                      	  				<input type="text" name="cqty" value="${dto.cqty}" title="Quantity:"
                      	  					class="input-text qty" readonly>
                      	  				<button onclick="plus(this, ${dto.cnum}); pplus('${ii}')"
                                          class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                                      	<button onclick="minus(this, ${dto.cnum}); mminus('${ii}')"
                                          class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                      	  			</div>
                      	  		</td>
                      	  		<td>
                      	  			<h5><span class="priceArea">
                      	  				<fmt:formatNumber value="${dto.cqty * dto.pprice}" type="currency"/>원
                      	  			</span></h5>
                      	  		</td>
                      	  		<td>
                      	  		<button onclick="deleteP('${dto.cnum}')">X</button>
                      	  		<!-- <img src="/resources/img/closeIcon.png" width="15" height="15" style="cursor:pointer"> -->
                      	  		</td>
                      	  	</tr>
                      	  	<c:set var="ii" value="${ii+1}"/>
                      	  </c:forEach>
                      	  </form>
                      	  </c:if>
                      	  	</tr>
                      	  <!-- 
                          <tr>
                              <td>
                                  <div class="media">
                                      <div class="d-flex">
                                          <img src="img/cart/cart1.png" alt="">
                                      </div>
                                      <div class="media-body">
                                          <p>Minimalistic shop for multipurpose use</p>
                                      </div>
                                  </div>
                              </td>
                              <td>
                                  <h5>$360.00</h5>
                              </td>
                              <td>
                                  <div class="product_count">
                                      <input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:"
                                          class="input-text qty">
                                      <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                                          class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                                      <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
                                          class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                                  </div>
                              </td>
                              <td>
                                  <h5>$720.00</h5>
                              </td>
                          </tr>
                           -->
                          
                          <!-- 
                          <tr class="bottom_button">
                              <td>
                                  <a class="button" href="#">Update Cart</a>
                              </td>
                              <td>

                              </td>
                              <td>

                              </td>
                              <td>
                                  <div class="cupon_text d-flex align-items-center">
                                      <input type="text" placeholder="Coupon Code">
                                      <a class="primary-btn" href="#">Apply</a>
                                      <a class="button" href="#">Have a Coupon?</a>
                                  </div>
                              </td>
                          </tr>
                           -->
                          
                          
                           <%-- 
                          <tr class="shipping_area">
                              <td colspan="3"></td>
                              <td colspan="2">
                                  <div class="shipping_box">
                                      <c:if test="${empty addr}">
                                      	<small>픽업매장을 선택하세요</small>
                                      	<button class="btn-outline-primary">지도</button>
                                      </c:if>
                                      <c:if test="${!empty addr }">
                                      	<small>픽업 매장 : ${addr}</small>&nbsp;&nbsp;&nbsp;
                                      	<small>바꾸기</small>
                                      	<button class="btn-outline-primary">지도</button>
                                      </c:if>
                                  </div>
                              </td>
                          </tr>
                           --%>
                          <tr id="subT">
                              <td colspan="2">
									
                              </td>
                              <td></td>
                              <td>
                                  <!-- <h5>Total</h5> -->
                                  <h5>Total&nbsp;&nbsp;<span id="subTT"><fmt:formatNumber value="${sum}" type="currency"/></span></h5>
                              </td>
                              <td>
                              </td>
                          </tr>
                          <tr class="out_button_area">
                              <td class="d-none-l">

                              </td>
                              <td class="">

                              </td>
                              <td>

                              </td>
                              <td>
                                  <div class="checkout_btn_inner d-flex align-items-center">
                                      <a class="gray_btn" href="/products/coffeeList2">쇼핑 계속하기</a>
                                      <button class="primary-btn ml-2" id="orderB">결제하기</button>
                                  </div>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>
  </section>
  
  <!-- Modal  추가 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">픽업 매장 선택</h4>
				</div>
				<div class="modal-body">
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
					<div class="container">
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
						</div>
					</div>
					<div class="container" id="shopshop" style="height:200px; overflow:auto;">
	        
        			</div>
					<div class="container">
						<div id="map" style="width:100%;height:350px;"></div>
					</div>
				
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default"
						data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=212448827467eac6ba3ba9165d851f8a&libraries=services"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 10 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	</script>
  <!--================End Cart Area =================-->

<%@ include file="../include/footer.jsp" %>
<script src="/resources/js/cart.js"></script>
<script src="/resources/js/map.js"></script>
<script>
	var mid = '<c:out value="${mid}"/>';
	$(document).ready(function(){
		$(".btn-outline-primary").on("click", function(){
			console.log("지도 버튼 클릭....");
			$(".modal").modal("show");
			setTimeout(function(){ map.relayout(); }, 1000);
		});
		$(".shipping_box").on("click", ".btnC", function(e){
			e.preventDefault();
			$(".modal").modal("show");
			setTimeout(function(){map.relayout();}, 1000);
		});

		$("#orderB").on("click", function(e){
			e.preventDefault();
			console.log("orderB clicked.....");
			var pickup = $("#pickup").text();
			if(pickup){
				console.log("pickup : " + pickup);
				$("input[name='addr']").val(pickup);
			}else{
				console.log("choose pickup location");
				alert("픽업매장을 선택해주세요");
				return false;
			}

			var len = document.getElementsByClassName("checkS").length;
			var chk=0;//check가 되지 않은 갯수
			for(var i=0; i<len; i++){
				if(!document.getElementsByClassName("checkS")[i].checked){
					chk++;
					document.getElementsByClassName("hiddenCnum")[i].disabled=true;
				}
			}
			
			if(chk==len){
				console.log("하나도 선택된 물품이 없습니다. 하나 이상을 선택하세요!");
				for(var i=0; i<len; i++){
					document.getElementsByClassName("hiddenCnum")[i].disabled=false;
				}
				alert("하나 이상의 상품을 선택하셔야 합니다.");
				return false;
			}else{
				console.log("하나 이상을 선택하셨습니다");
			}

			if(!mid){
				document.location='members/loginForm';
			}else{
				
				document.pkc.submit();
			}
			
		});
	});
	function numberFormat(inputNumber) {
	   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function checkAll(){
		/* 
		var len = document.getElementsByClassName("checkS").length;
		if(document.getElementsByClassName("checkT")[0].checked){
			for(var i=0; i<len; i++){
				document.getElementsByClassName("checkS")[i].checked=true;
			}
		}else{
			for(var i=0; i<len; i++){
				document.getElementsByClassName("checkS")[i].checked=false;
			}
		}
		 */
		var len=document.getElementsByClassName("checkS").length;
		var sumR=0;
		if(document.getElementsByClassName("checkT")[0].checked){
			for(i=0;i<len;i++){
				document.getElementsByClassName("checkS")[i].checked=true;
				var qq=document.getElementsByClassName("input-text")[i].value;
				var pp=document.getElementsByClassName("hiddenP")[i].value;
				sumR=sumR+(qq*pp);
			}
			sumR=sumR+"";
			document.getElementById("subTT").innerText=numberFormat(sumR)+"원";
		}else{
			for(i=0;i<len;i++){
				document.getElementsByClassName("checkS")[i].checked=false;
			}
			document.getElementById("subTT").innerText=0;
		}
	}
	function checkcheck(){
		var len = document.getElementsByClassName("checkS").length;
		var sumR=0;
		var chk=0;
		for(var i=0; i<len; i++){
			if(document.getElementsByClassName("checkS")[i].checked){
				chk++;
				var qq=document.getElementsByClassName("input-text")[i].value;
				var pp=document.getElementsByClassName("hiddenP")[i].value;
				sumR=sumR+(qq*pp);
			}
		}
		if(len == chk){
			document.getElementsByClassName("checkT")[0].checked=true;
		}else{
			document.getElementsByClassName("checkT")[0].checked=false;
		}
		document.getElementById("subTT").innerText=numberFormat(sumR)+"원";
		
	}
	function plus(th, cnum){
		var mid = '<c:out value="${mid}"/>';
		var val = $(th).closest("div").find("input[type='text']").val();
		console.log("val : " + val);
		if(val <100){
			val++;
			$(th).closest("div").find("input[type='text']").val(val);
			$.ajax({
				type:"GET",
				url:"/products/updateProductFromCart",
					data:{cnum:cnum, cqty:val},
					success:function(check){
						//data:JSON.stringify(reply),	
						if(check=='success'){
							console.log("DB ++ 입력 성공");
							//showCartList(mid)
						}else {
							console.log("DB ++ 입력 실패");
						}
					}
			});
		}
	}
	
	function minus(th, cnum){
		var mid = '<c:out value="${mid}"/>';
		var val = $(th).closest("div").find("input[type='text']").val();
		console.log("val : " + val);
		if(val > 1){
			val--;
			$(th).closest("div").find("input[type='text']").val(val);
			$.ajax({
				type:"GET",
				url:"/products/updateProductFromCart",
					data:{cnum:cnum, cqty:val},
					success:function(check){
						//data:JSON.stringify(reply),	
						if(check=='success'){
							console.log("DB -- 입력 성공");
							//showCartList(mid)
						}else {
							console.log("DB -- 입력 실패");
						}
					}
			});
		}
	}
	function pplus(n){
		var len=document.getElementsByClassName("checkS").length;
		var price=document.getElementsByClassName("hiddenP")[n].value;
		var quantity=document.getElementsByClassName("input-text")[n].value;
		var sumR = price*quantity;
		document.getElementsByClassName("priceArea")[n].innerText=numberFormat(sumR)+"원";
		var sumRR=0;
		for(var i=0; i<len; i++){
			if(document.getElementsByClassName("checkS")[i].checked){
				var pp = document.getElementsByClassName("hiddenP")[i].value;
				var qq = document.getElementsByClassName("input-text")[i].value;
				sumRR+=(pp*qq);
			}
		}
		document.getElementById("subTT").innerText=numberFormat(sumRR)+"원";
	}
	function mminus(n){
		var len=document.getElementsByClassName("checkS").length;
		var price=document.getElementsByClassName("hiddenP")[n].value;
		var quantity=document.getElementsByClassName("input-text")[n].value;
		var sumR = price*quantity;
		document.getElementsByClassName("priceArea")[n].innerText=numberFormat(sumR)+"원";
		var sumRR=0;
		for(var i=0; i<len; i++){
			if(document.getElementsByClassName("checkS")[i].checked){
				var pp = document.getElementsByClassName("hiddenP")[i].value;
				var qq = document.getElementsByClassName("input-text")[i].value;
				sumRR+=(pp*qq);
			}
		}
		document.getElementById("subTT").innerText=numberFormat(sumRR)+"원";
	}
	function deleteP(cnum){
		$.ajax({
			type:"get",
			url:"/products/deleteProductFromCart",
			data:{cnum:cnum},
			success:function(result){
				if(result='success'){
					console.log("삭제 성공");
					location.reload();
				}
			}
		});
		
	}
	/* 
	function showCartList(mid){
		var mid = {mid:mid}
		cartService.getCartList(mid, function(list){
			console.log("// length : " + list.length);
			var str="";
			var sum=0;
			$("#trtr").empty("");
			for(var i=0, len=list.length; i<len; i++){
				sum+=(list[i].cqty*list[i].pprice);
				str+="<tr><td><div class='media'><div class='d-flex'>";
				str+="<input type='checkbox' class='checkS' checked onclick='checkcheck()'>";
				str+="<img src='/imgs/"+list[i].uploadpath+"/"+list[i].uuid+"_"+list[i].filename+"'></div>";
				str+="<div class='media-body'><p>"+list[i].pname+"</p></div></div></td>";
				str+="<td><h5>&#8361;"+numberFormat(list[i].pprice)+"</h5></td>";
				str+="<td><div class='product_count'>";
				str+="<input type='text' maxlength='12' value='"+list[i].cqty+"' title='Quantity:' class='input-text qty' readonly>";
				//str+="<button onclick='plus(this,"+list[i].cnum+")' class='increase items-count' type='button'><i class='lnr lnr-chevron-up'></i></button>";
				//str+="<button onclick='minus(this,"+list[i].cnum+")' class='reduced items-count' type='button'><i class='lnr lnr-chevron-down'></i></button>";
				str+="<button class='increase items-count' type='button'><i class='lnr lnr-chevron-up'></i></button>";
				str+="<button class='reduced items-count' type='button'><i class='lnr lnr-chevron-down'></i></button>";
				str+="</div></td>";
				str+="<td><h5><span>&#8361;"+numberFormat(list[i].cqty*list[i].pprice)+"원</span></h5></td></tr>";
			}
			console.log("////////////////////////////"+str);
			$("#trtr").html(str);
			var str2="";
			str2+="<td></td><td></td><td><h5>Subtotal</h5></td><td><h5>&#8361;"+numberFormat(sum)+"</h5></td>";
			$("#subT").html(str2);
		});
	}
	 */
</script>
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
  				str+="</table></div>";
  				$("#shopshop").css("display", "block").html(str);
  				
  			});
  		});
  		
  		$("#shopshop").on("click", ".btn-outline-primary", function(e){
  			e.preventDefault();
  			console.log("선택 버튼 .....");
  			var snum = $(this).closest("tr").find("input").val().trim();
  			var addr = $(this).closest("tr").find("span").text();
  			console.log("snum : " + snum);
  			$(".modal").modal("hide");
  			$(".shipping_box").html("픽업 매장 : <span id='pickup'>" + addr +"</span>&nbsp;&nbsp;&nbsp;<button class='btn-outline-primary btnC'>바꾸기</button>");
  			/* 
  			mapService.getAddr({snum:snum}, function(data){
  				$(".shipping_box").text("픽업 매장 : " + addr);
  			});
  			 */
  			/* 
  			if(snum){
	  			$.ajax({
	  				type:"get",
	  				url:"/shops/getAddr",
					data:{snum:snum},
					success:function(check){
  						if(check=='success'){
  							console.log("cookie.........");
  							//location.reload();
  						}else {
  							console.log("fail cookie...");
  						}
  					}
	  			});
  			}
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