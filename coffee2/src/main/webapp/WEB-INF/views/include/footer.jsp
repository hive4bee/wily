<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!--================ Start footer Area  =================-->	
	<footer class="footer">
		<div class="footer-area">
			<div class="container">
				<div class="row section_gap">
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single-footer-widget tp_widgets">
							<h4 class="footer_title large_title">Our Mission</h4>
							<p>
								So seed seed green that winged cattle in. Gathering thing made fly you're no 
								divided deep moved us lan Gathering thing us land years living.
							</p>
							<p>
								So seed seed green that winged cattle in. Gathering thing made fly you're no divided deep moved 
							</p>
						</div>
					</div>
					<div class="offset-lg-1 col-lg-2 col-md-6 col-sm-6">
						<div class="single-footer-widget tp_widgets">
							<h4 class="footer_title">Quick Links</h4>
							<ul class="list">
								<li><a href="#">Home</a></li>
								<li><a href="#">Shop</a></li>
								<li><a href="#">Blog</a></li>
								<li><a href="#">Product</a></li>
								<li><a href="#">Brand</a></li>
								<li><a href="#">Contact</a></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-2 col-md-6 col-sm-6">
						<div class="single-footer-widget instafeed">
							<h4 class="footer_title">Gallery</h4>
							<ul class="list instafeed d-flex flex-wrap">
								<li><img src="/resources/img/gallery/r1.jpg" alt=""></li>
								<li><img src="/resources/img/gallery/r2.jpg" alt=""></li>
								<li><img src="/resources/img/gallery/r3.jpg" alt=""></li>
								<li><img src="/resources/img/gallery/r5.jpg" alt=""></li>
								<li><img src="/resources/img/gallery/r7.jpg" alt=""></li>
								<li><img src="/resources/img/gallery/r8.jpg" alt=""></li>
							</ul>
						</div>
					</div>
					<div class="offset-lg-1 col-lg-3 col-md-6 col-sm-6">
						<div class="single-footer-widget tp_widgets">
							<h4 class="footer_title">Contact Us</h4>
							<div class="ml-40">
								<p class="sm-head">
									<span class="fa fa-location-arrow"></span>
									Head Office
								</p>
								<p>123, Main Street, Your City</p>
	
								<p class="sm-head">
									<span class="fa fa-phone"></span>
									Phone Number
								</p>
								<p>
									+123 456 7890 <br>
									+123 456 7890
								</p>
	
								<p class="sm-head">
									<span class="fa fa-envelope"></span>
									Email
								</p>
								<p>
									free@infoexample.com <br>
									www.infoexample.com
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="footer-bottom">
			<div class="container">
				<div class="row d-flex">
					<p class="col-lg-12 footer-text text-center">
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
				</div>
			</div>
		</div>
	</footer>
	<!--================ End footer Area  =================-->



  <script src="/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="/resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendors/skrollr.min.js"></script>
  <script src="/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="/resources/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="/resources/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="/resources/vendors/mail-script.js"></script>
  <script src="/resources/js/main.js"></script>
  <script src="/resources/js/message.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
  <script>
  	var mid = '<c:out value="${mid}" />';
  	var socket = null;
  	function connectSockJS(){
		var ws = new SockJS("http://192.168.56.73:9000/replyEcho");
		//var ws = new WebSocket("ws://192.168.56.73:9000/replyEcho");
		socket = ws;
		ws.onopen=function(){
			console.log("Info : connection opened");
			
		}
		ws.onmessage=function(event){
			console.log("ReceiveMessage : ",event.data+"\n");
			var strs = event.data.split("|");
			if(strs[0] == "300"){
				console.log("관리자로부터 받은 메시지");
				checkMessageQ(mid);
				getMessageL(mid);
			}
		}
		ws.onclose=function(event){
			console.log("Info : connection closed");
			//setTimeout(function(){connect();}, 1000);
		};
		ws.onerror=function(err){console.log("Error:", err);};
	}
  	/* 
  	function connect(){
		var ws = new WebSocket("ws://192.168.134.128:9000/replyEcho");
		//var ws = new WebSocket("ws://192.168.56.73:9000/replyEcho");
		socket = ws;
		ws.onopen=function(){
			console.log("Info : connection opened");
			
		}
		ws.onmessage=function(event){
			console.log("ReceiveMessage : ",event.data+"\n");
			var strs = event.data.split("|");
			if(strs[0] == "300"){
				console.log("관리자로부터 받은 메시지");
				checkMessageQ(mid);
				getMessageL(mid);
			}
		}
		ws.onclose=function(event){
			console.log("Info : connection closed");
			//setTimeout(function(){connect();}, 1000);
		};
		ws.onerror=function(err){console.log("Error:", err);};
	}
	 */
  	function checkMessageQ(mid){
  		console.log("check message....");
  		$.ajax({
			type:"get",
			url:"/message/checkMessageQ",
			data:{mid:mid},
			success:function(check){
				//data:JSON.stringify(reply),	
				if(check){
					console.log("cnt : " + check);
					$(".messageCnt").text(check);
					
				}else {
					console.log("DB 입력 실패");
				}
			}
		});
  	}
  	function getMessageL(mid){
  		console.log("get order list....");
		messageService.getMessageL(mid, function(list){
			console.log("hahaha");
			var str="";
			if(list == null || list.length == 0){
				console.log("?????");
				str+="<h6 class='dropdown-header'>Alerts Center</h6>";
				str+="<a class='dropdown-item d-flex align-items-center' href='#'>";
				str+="<div class='mr-3'>";
				str+="<div class='icon-circle bg-warning'>";
				str+="<i class='fas fa-exclamation-triangle text-white'></i>";
				str+="</div></div>";
				str+="<div><div class='small text-gray-500'></div>";
				str+="<span class='font-weight-bold'>미확인 메시지가 존재하지 않습니다.</span>";
				str+="</div></a>";
				/* str+="<a class='dropdown-item text-center small text-gray-500 showAllMessage' href='/message/showAllMessage?mid="+mid+"'>Show All Alerts</a>"; */
				str+="<a class='dropdown-item text-center small text-gray-500 showAllMessage' href='/message/showAllMessage'>Show All Alerts</a>";
				$(".messageAA").html(str);
				return ;
			}
			console.log("length : " + list.length);
			str+="<h6 class='dropdown-header'>Alerts Center</h6>";
			for(var i=0, len=list.length; i<len; i++){
				var dateObj = new Date(list[i].u_reg);
	  			var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth() + 1;
				var dd = dateObj.getDate();
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
				mm = mm < 10 ? "0"+mm : mm;
				dd = dd < 10 ? "0"+dd : dd;
				hh = hh < 10 ? "0"+hh : hh;
				mi = mi < 10 ? "0"+mi : mi;
				ss = ss < 10 ? "0"+ss : ss;
				console.log(list[i]);
				str+="<a class='dropdown-item d-flex align-items-center' href='#'>";
				str+="<div class='mr-3'>";
				str+="<div class='icon-circle bg-primary'>";
				str+="<i class='fas fa-file-alt text-white'></i>";
				str+="</div></div>";
				str+="<div><div class='small text-gray-500'>"+yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss+"</div>"
				str+="<span class='font-weight-bold'>"+list[i].u_sub+"</span>";
				str+="</div></a>";
			}
				str+="<a class='dropdown-item text-center small text-gray-500 showAllMessage' href='/message/showAllMessage'>Show All Alerts</a>";
			$(".messageAA").html(str);
		});
  	}
	$(document).ready(function(){
		connectSockJS();
		setTimeout(function(){
			console.log("HIHIHI");
			socket.send("HIHIHI");
		},1000);
		
		if(!mid){
			$(".messageCnt").text("0");
		}else{
			checkMessageQ(mid);
			getMessageL(mid);
		}
		
		$(".messageAA").on("click", ".showAllMessage", function(e){
			e.preventDefault();
			console.log("show All Message button clicked.....");
			location.href='/message/showAllMessage?mid='+mid;
		});
	});
  </script>
</body>
</html>