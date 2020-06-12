<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<div class="container">
		<form id="pkc" role="form">
		  <div class="form-group">
		  	<label class="txtT">${dto.fno}번 글</label>
		  	<input type="hidden" id="fno" name="fno" value="${dto.fno}">
		  </div>
          <div class="form-group">
            <label>글 제목</label> <input class="form-control" id="subject" name='subject' value='${dto.subject}' readonly>
          </div>
		  <div class="msg"></div>
          <div class="form-group">
            <label>글 내용</label>
            <textarea class="form-control" rows="20" id="content" name='content' readonly>${dto.content} </textarea>
          </div>
          <div class="msg"></div>
		  <!-- 
          <div class="form-group">
            <label>Writer</label> <input class="form-control" id="mid" name='mid'>
          </div>
           -->
          
          <c:if test="${mid == dto.mid}">
          	  <button data-oper="delete" class="button">삭제하기</button>
	          <button data-oper="modify" class="button">수정하기</button>
          </c:if>
		  <button data-oper='list' class="button">List</button>
          <!--  
          <button type="reset" class="button">Reset</button>
           -->
        </form>
    </div>
    <div class="container">
    <hr>
    	<label class="txtT">댓글</label>
    </div>
    <!--=================reply area=====================-->
    <div class="container">
	    <i class="fa fa-comments fa-fw"></i>Reply
		<div class="row">
			
			<div class="col-lg-10">
	    		<textarea class="form-control" id="reply" name="reply" onfocus="checkLogin(${mid})"></textarea>
	    	</div>
	    	<div class="col-lg-2">
				<button id="addReplyBtn" class="btn btn-primary">New Reply</button>
			</div>
			<hr>
		</div>
		
		<div class="panel-body">
			<ul class="chat">
				<!-- start reply -->
				<li class="left clearfix" data-rno="12">
					<div class="row">
						<div class="col-lg-1">
							<strong class="primary-font">user00</strong>
						</div>
						<div class="col-lg-2">
							<small>2020-05-08 15:22</small>
						</div>
					</div>
					<p>댓글이 없는 게시글일 경우 내가 보여요....</p>
					<hr>
					<!-- 
					<div>
						<div class="header">
							<strong class="primary-font">user00</strong>
							<small class="pull-right text-muted">2020-05-08 15:22</small>
						</div>
						<p>Good job!</p>
					</div>
					 -->
				</li>
				<!-- end reply -->
			</ul>
		</div>
		
		<nav class="blog-pagination justify-content-center d-flext">
			
		</nav>
	</div>
    <!-- 
    <div class="container">
    	<div class="form-group row">
    		<div class="col-lg-10">
    			<input class="form-control" type="text" id="reply" name="reply">
    		</div>
    		<div class="col-lg-2">
    			<button class="replyB">입력</button>
    		</div>
    	</div>
    </div>
     -->
    <!--================Instagram Area =================-->
  <section class="instagram_area">
    <div class="container box_1620">
      <div class="insta_btn">
        <a class="btn theme_btn" href="#">Follow us on instagram</a>
      </div>
      <div class="instagram_image row m0">
        <a href="#"><img src="/resources/img/instagram/ins-1.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-2.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-3.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-4.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-5.jpg" alt=""></a>
        <a href="#"><img src="/resources/img/instagram/ins-6.jpg" alt=""></a>
      </div>
    </div>
  </section>
  <!--================End Instagram Area =================-->
  

 
	<%@ include file="../include/footer.jsp" %>
  <script src="/resources/js/replies.js"></script>
  
  <script>
  	var formObj = $("form[role='form']")
  	var addReplyBtn = $("#addReplyBtn");
  	var fo = '<c:out value="${dto.fno}"/>';
	var id = '<c:out value="${mid}"/>';
	console.log("id : " + id);
	var pageNum = 1;
	var rpf = $(".blog-pagination");
	function checkLogin(mid){
  		if(!mid){
  			document.location.href="/members/loginForm";
  		}
  	}
  	$(document).ready(function(){//----------------------------------------
  		showList(1);
  		$("button[data-oper='modify']").on("click", function(){
			formObj.attr("action", "/boards/modifyForm");
			formObj.submit();
  	  	});
  		$("button[data-oper='list']").on("click", function(){
  	  		formObj.find("#fno").remove();
  	  		formObj.find("#subject").remove();
  	  		formObj.find("#content").remove();
			formObj.attr("action", "/boards/list");
			formObj.submit();
  	  	});
  	  	$("button[data-oper='delete']").on("click", function(){
			formObj.attr("action", "/boards/delete");
  	  	});
  	  	addReplyBtn.on("click", function(){
  	  		//var t = new Date();
  	  		var  rep = $("#reply").val();
  	  		
  	  		if(!rep){
  	  			alert("댓글 내용을 입력하세요");
  	  			return false;
  	  		}
  	  		console.log("reply : " + rep + " mid : " + id + " fno : " + fo);
  	  		
  	  		var reply = {reply:rep, mid:id, fno:fo};
  	  		repliesService.add(reply, function(result){
  	  			//alert(result);
  	  			$("#reply").val("");
  	  			showList(1);
  	  		});
  	  		
  	  		
  	  		/*
  	  		var str="";
  	  		str+="<li class='left clearfix'>";
  	  		str+="<div class='row'>";
  	  		str+="<div class='col-lg-1'>";
  	  		str+="<strong class='primary-font'>"+${mid}+"</strong>";
  	  		str+="</div>";
  	  		str+="<div class='col-lg-2'>";
  	  		str+="<small>"+t+"</small>";
  	  		str+="</div></div><p>"+$("#reply").val()+"</p><hr>";
  	  		$(".chat").append(str);
  	  		 */
  	  	});
  	  	
  	  	
  	  	$(".chat").on("click", ".dd a", function(e){
  	  		//alert("HIHI");
  	  		e.preventDefault();
  	  		var num = $(this).attr("href");
  	  		console.log("num1_d : " + num);
  	  		repliesService.remove({rno:num, fno:fo}, function(){
  	  	  		
	  	  		showList(1);
  	  		});
  	  	});
  		$(".chat").on("click", ".dd2 a", function(e){
	  		//alert("HIHI");
	  		e.preventDefault();
	  		var num = $(this).attr("href");
	  		super_rno = $(this).closest("span").data("super");
	  		console.log("num1_d : " + num);
	  		repliesService.removeReReply({srno:super_rno, rno:num, fno:fo}, function(){
	  	  		
	  	  		showList(1);
	  		});
	  	});
		
  	  	
  	  	$(".chat").on("click", ".uu a", function(e){
  	  		e.preventDefault();
  	  		var num = $(this).attr("href");
  	  		console.log("num2_u : " + num);
  	  		var str="";
  	  		str+="<div class='row'>";
  	  		str+="<div class='col-lg-10'><textarea class='form-control' name='reply'></textarea></div>";
  	  		str+="<input type='hidden' value='"+num+"'>";
  	  		str+="<div class='col-lg-2'><button class='btn btn-primary modifyReplyBtn'>New Reply</button></div><hr>";
  	  		str+="</div>";
  	  		$(this).closest("li").empty().html(str);
  	  	});
  	  	
  	  	$(".chat").on("click", ".modifyReplyBtn", function(e){
  	  		e.preventDefault();
  	  		var rno = $(this).closest("li").find("input").val();
  	  		var rep = $(this).closest("li").find("textarea").val();
  	  		var reply={rno:rno, reply:rep}
  	  		if(!rep){
  	  			alert("댓글을 입력해주세요");
  	  			return false;
  	  		}
  	  		console.log("HIHIHIHIHIH");
  	  		
  	  		
  	  		repliesService.update(reply, function(e){
  	  			showList(1);
  	  		});
  	  		
  	  	});

  	  	rpf.on("click", "li a", function(e){
	  	  	e.preventDefault();
			var temp = $(this).attr("href");
			pageNum = temp;
			showList(pageNum);
  	  	});

  	  	$(".chat").on("click", ".rereply", function(e){
			e.preventDefault();
			console.log("HIHIHIHIHIHI");
			lili = $(this).closest("li");
			var cnt = $(this).closest("div").data("cnt");

			var rno = $(this).attr("href");
			var str="";
  	  		var str2="";
  	  		//str2+="<ul><li>";
  	  		str2+="<div class='row'>";
  	  		str2+="<div class='col-lg-1'></div>";
  	  		str2+="<div class='col-lg-9'><textarea class='form-control rereplyT' name='reply'></textarea></div>";
  	  		str2+="<input type='hidden' value='"+rno+"'>";
  	  		str2+="<div class='col-lg-2'><button class='btn btn-primary addReReplyBtn'>New Reply</button><br></div>";
  	  		str2+="</div><hr>";
  	  		//str2+="</li></ul>";
			console.log(str2);
			repliesService.getReRepliesList({rno:rno}, function(list){
				if(cnt == '0'){
					
				console.log("list.length : " + list.length);
				if(list==null || list.length==0){
					//$(this).closest("li").append(str2);
					lili.append(str2);
					console.log("//////////////////////////////////////////!");
					return ;
				}
				console.log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
				for(var i=0, len=list.length||0; i<len; i++){
					console.log("listlist : " + list[i]);
		  			var dateObj = new Date(list[i].replyDate);
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
					//console.log("???????????? : "+i+list[i].mid === id);
					console.log("rno : " + list[i].rno + " / mid : " + list[i].mid + " / reply : " + list[i].reply);
					str+="<li class='left clearfix zzz' data-rno='"+list[i].rno+"'>";
		  			str+="<div class='row'>";
		  			str+="<div class='col-lg-1'></div>";
		  			str+="<div class='col-lg-1'>";
		  			str+="<strong class='primary-font'>"+list[i].mid+"</strong>";
		  			str+="</div>";
		  			str+="<div class='col-lg-2'>";
		  			str+="<small>"+yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss+"</small>";
		  			str+="</div></div>";
		  			str+="<div class='row'>"
		  			str+="<div class='col-lg-1'></div><div class='col-lg-10'><p>"+list[i].reply+"</p></div>";
		  			str+="</div>";
		  			str+="<div class='row'>";
		  			//str+="<div class='col-lg-1'><c:if test='${!empty mid}'><a class='rereply' href='"+list[i].rno+"'>답글쓰기</a></c:if></div>";
		  			//str+="<div class='col-lg-1'><a class='rereply' href='"+list[i].rno+"'>답글</a></div>";
		  			if(id == list[i].mid){
		  				str+="<div class='col-lg-1'></div><div class='col-lg-1 dd2'><span data-super='"+rno+"'><a href='"+list[i].rno+"'>삭제하기</a></span></button></div><div class='col-lg-1 uu'><a href='"+list[i].rno+"'>수정하기</a></div>";
		  			}
		  			//str+="<div class='col-lg-1'><c:if test='${list[i].mid eq id}'>삭제하기</c:if></div>"
		  			//console.log(list[i].mid);
		  			//str+="<div class='col-lg-1'><c:if test='${list[i].mid eq id}'>수정하기</c:if></div>"
		  			str+="</div></li>"
		  			str+="<hr>";
		  		}
		  		console.log("HIHIHIHIHIHIHIHIHIHIHIHIHIHIHIH");
		  		str+=str2;
		  		//console.log(str);
		  		lili.append(str);
				}
			});
			$(this).closest("div").data("cnt", "1");
	  	  	//$(this).closest("li").append(str);
			//lili.append(str);
  	  	});
		$(".chat").on("focus", ".rereplyT", function(e){
			if(!id){
				document.location.href="/members/loginForm";
			}
			
		})
  	  	$(".chat").on("click", ".addReReplyBtn", function(e){
			e.preventDefault();
			console.log("!!!!!!!!!!!!!!!!!!");
			var lili = $(this).closest("li");
			var rno = $(this).closest("li").find("input").val();
  	  		var rep = $(this).closest("li").find("textarea").val();
  	  		console.log(" mid : " + id + " fno : " + fo);
  	  		console.log("!!! rno : " + rno + " / rep : " + rep);
  	  		if(!rep){
				alert("대댓글을 입력하세요");
				return false;
  	  	  	}
			var str=""
		
  	  		var reply = {rno:rno, reply:rep, mid:id, fno:fo, rgroup:rno};
  	  		//lili=$(this).closest("li");
  	  		//lili.empty();
  	  		lili=$(this).parent("li");
			repliesService.add2(reply, function(result){
				showList(1);
				/* 
	  			repliesService.getReRepliesList({rno:rno}, function(list){
		  			
					for(var i=0, len=list.length||0; i<len; i++){
			  			var dateObj = new Date(list[i].replyDate);
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
						console.log("zzzzzz : " + list[i].rno + " z " + list[i].reply);
						str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
			  			str+="<div class='row'>";
			  			str+="<div class='col-lg-1'></div>";
			  			str+="<div class='col-lg-1'>";
			  			str+="<strong class='primary-font'>"+list[i].mid+"</strong>";
			  			str+="</div>";
			  			str+="<div class='col-lg-2'>";
			  			str+="<small>"+yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss+"</small>";
			  			str+="</div></div>";
			  			str+="<div class='row'>"
			  			str+="<div class='col-lg-1'></div><div class='col-lg-10'><p>"+list[i].reply+"</p></div>";
			  			str+="</div>";
			  			str+="<div class='row'>";
			  			//str+="<div class='col-lg-1'><c:if test='${!empty mid}'><a class='rereply' href='"+list[i].rno+"'>답글쓰기</a></c:if></div>";
			  			//str+="<div class='col-lg-1'><a class='rereply' href='"+list[i].rno+"'>답글</a></div>";
			  			if(id == list[i].mid){
			  				str+="<div class='col-lg-1'></div><div class='col-lg-1 dd'><a href='"+list[i].rno+"'>삭제하기</a></button></div><div class='col-lg-1 uu'><a href='"+list[i].rno+"'>수정하기</a></div>";
			  			}
			  			//str+="<div class='col-lg-1'><c:if test='${list[i].mid eq id}'>삭제하기</c:if></div>"
			  			//console.log(list[i].mid);
			  			//str+="<div class='col-lg-1'><c:if test='${list[i].mid eq id}'>수정하기</c:if></div>"
			  			str+="</div></li>"
			  			str+="<hr>";
			  			//lili.append(str);
			  		}
					var str2="";
		  	  		//str2+="<ul><li>";
		  	  		str2+="<div class='row'>";
		  	  		str2+="<div class='col-lg-1'></div>";
		  	  		str2+="<div class='col-lg-9'><textarea class='form-control rereplyT' name='reply'></textarea></div>";
		  	  		str2+="<input type='hidden' value='"+rno+"'>";
		  	  		str2+="<div class='col-lg-2'><button class='btn btn-primary addReReplyBtn'>New Reply</button><br></div>";
		  	  		str2+="</div><hr>";
		  	  		str+=str2;
		  			lili.append(str);
		  			
				}); 
				*/
	  		});
  	  	});
  	  	
  	});//----------------------end document ready---------------------------
  	function showList(page){
  		console.log("fno : " + fo + " page : " + page);
	  	repliesService.getList({fno:fo, page:page||1}, function(replyCnt, list){
	  		console.log("///replyCnt : " + replyCnt);
	  		var str="";
	  		
	  		if(list==null || list.length==0){
	  			str="<li class='left clearfix'>";
	  			str+="<div class='row'>";
	  			str+="<div class='col-lg-12'>";
	  			str+="<strong class='primary-font'>"+"첫 번째 댓글을 달아주세요!!!";
	  			str+="</div></div></li>";
	  			$(".chat").html(str);
	  			return;
	  		}
	  		for(var i=0, len=list.length||0; i<len; i++){
	  			var dateObj = new Date(list[i].replyDate);
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
				//console.log("???????????? : "+i+list[i].mid === id);
				str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
	  			str+="<div class='row'>";
	  			str+="<div class='col-lg-1'>";
	  			str+="<strong class='primary-font'>"+list[i].mid+"</strong>";
	  			str+="</div>";
	  			str+="<div class='col-lg-2'>";
	  			str+="<small>"+yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss+"</small>";
	  			str+="</div></div><p>"+list[i].reply+"</p>";
	  			str+="<div class='row'>";
	  			//str+="<div class='col-lg-1'><c:if test='${!empty mid}'><a class='rereply' href='"+list[i].rno+"'>답글쓰기</a></c:if></div>";
	  			str+="<div class='col-lg-1' data-cnt='0'><a class='rereply' href='"+list[i].rno+"'>답글 <strong>["+list[i].rtotal+"]</strong></a></div>";
	  			if(id == list[i].mid){
	  				str+="<div class='col-lg-1 dd'><a href='"+list[i].rno+"'>삭제하기</a></button></div><div class='col-lg-1 uu'><a href='"+list[i].rno+"'>수정하기</a></div>";
	  			}
	  			//str+="<div class='col-lg-1'><c:if test='${list[i].mid eq id}'>삭제하기</c:if></div>"
	  			//console.log(list[i].mid);
	  			//str+="<div class='col-lg-1'><c:if test='${list[i].mid eq id}'>수정하기</c:if></div>"
	  			str+="</div>"
	  			str+="<hr></li>";
	  		}
	  		$(".chat").html(str);
	  		showReplyPage(replyCnt);
	  	});
	}//end showList() function;
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum/10.0) * 10;
		var startNum = endNum - 9;

		var prev = startNum!=1;
		var next = false;

		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		if(endNum * 10 < replyCnt){
			next = true;
		}

		var str = "<ul class='pagination'>";

		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"' aria-label='Previous'>";
			str += "<span aria-hidden='true'><span class='lnr lnr-chevron-left'></span></span></a></li>"
		}

		for(var i=startNum; i<=endNum; i++){
			var active = pageNum==i ? "active" : "";
			str += "<li class='page-item "+ active + " '><a class='page-link pageN' href='"+i+"'>"+i+"</a></li>";
		}

		if(next){
			str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"' aria-label='Next'>";
			str += "<span aria-hidden='true'><span class='lnr lnr-chevron-right'></span></span></a></li>"
		}
		str+="</ul>";
		//console.log(str);

		rpf.html(str);
	}

	
	
  	
  </script>
</body>
</html>