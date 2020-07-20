<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Website 2019</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="/resources/vendorsA/jquery/jquery.min.js"></script>
  <script src="/resources/vendorsA/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendorsA/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/jsA/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <script src="/resources/vendorsA/chart.js/Chart.min.js"></script>

  <!-- Page level custom scripts -->
  <script src="/resources/jsA/demo/chart-area-demo.js"></script>
  <script src="/resources/jsA/demo/chart-pie-demo.js"></script>
  <script src="/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="/resources/js/order.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
  <script>
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
			if(strs[0] == "100"){
				checkOrderQuantity();
				getOrderList();
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
			if(strs[0] == "100"){
				checkOrderQuantity();
				getOrderList();
			}
		}
		ws.onclose=function(event){
			console.log("Info : connection closed");
			//setTimeout(function(){connect();}, 1000);
		};
		ws.onerror=function(err){console.log("Error:", err);};
	}
	 */
  	$(document).ready(function(){
		connectSockJS();
		setTimeout(function(){
			console.log("HIHIHI");
			socket.send("HIHIHI");
		},1000);
	});
  </script>
  <script>
	var id = '<c:out value="${mid}" />';
	function checkOrderQuantity(){
		console.log("check order quantity....");
		$.ajax({
			type:"get",
				url:"/admin/checkOrderQuantity",
				data:{id:id},
				success:function(check){
					//data:JSON.stringify(reply),	
					if(check){
						console.log("cnt : " + check);
						$(".alertCnt").text(check);
						
					}else {
						console.log("DB 입력 실패");
					}
				}
		});
	}
	function getOrderList(){
		console.log("get order list....");
		ordersService.getOrderList(id, function(list){
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
				str+="<span class='font-weight-bold'>주문이력이 존재하지 않습니다.</span>";
				str+="</div></a>";
				str+="<a class='dropdown-item text-center small text-gray-500 showAllOrders' href='/admin/showAllOrders'>Show All Alerts</a>";
				$(".alertAA").html(str);
				return ;
			}
			console.log("length : " + list.length);
			str+="<h6 class='dropdown-header'>Alerts Center</h6>";
			for(var i=0, len=list.length; i<len; i++){
				console.log(list[i]);
				str+="<a class='dropdown-item d-flex align-items-center' href='#'>";
				str+="<div class='mr-3'>";
				str+="<div class='icon-circle bg-primary'>";
				str+="<i class='fas fa-file-alt text-white'></i>";
				str+="</div></div>";
				str+="<div><div class='small text-gray-500'>"+list[i].odate+"</div>"
				str+="<span class='font-weight-bold'>"+list[i].onum+"</span>";
				str+="</div></a>";
			}
				str+="<a class='dropdown-item text-center small text-gray-500 showAllOrders' href='/admin/showAllOrders'>Show All Alerts</a>";
			$(".alertAA").html(str);
		});
	}
	$(document).ready(function(){
		console.log("id session : " + id);
		if(id=='admin'){
			console.log("admin logined...");
			checkOrderQuantity();
			getOrderList();
		}else{
			console.log("not logined....");
			$(".alertCnt").text("0");
		}
		/* 
		$(".alertAA").on("click", ".showAllOrders", function(e){
			e.preventDefault();
			console.log("show all list button clicked...");
		});
		 */
	});
</script>
</body>

</html>
    