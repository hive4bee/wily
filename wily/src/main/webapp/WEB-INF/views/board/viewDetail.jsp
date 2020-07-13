<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	input{
		border:1px solid #eeeeee;
		width:100%;
	}
	textarea{
		width:100%;
	}
	li{
		list-style-type:none;
		border-bottom:1px solid #cccccc;
		margin-bottom:20px;
	}
	ul{
		padding-left:0px;
	}
</style>
<div class="container-fluid justify-content-center">
	<h1 class="h3 ml-2 mb-2 text-gray-800">${boardDTO.bno}번 글</h1>
	
	
		<div class='row ml-2 mt-2'>
			
			<div class="col-sm-12 ml-2 mt-2 mb-5">
				<a href="#" class="btn btn-primary listBtn">리스트</a>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo"/>
					<c:if test="${pinfo.username eq boardDTO.mid}">
						<a href="#" class="btn btn-primary modifyBtn">수정하기</a>
						<a href="#" class="btn btn-primary deleteBtn">삭제하기</a>
					</c:if>
				</sec:authorize>
			</div>
		</div>
		
			
		<div class="row col-lg-12 align-items-center mb-2">
			<span class="col-lg-1">제목</span>
			<span class="col-lg-7">
				<input type="text" value="${boardDTO.bsubject}" readonly>
			</span>
		</div>
		<div class="row col-lg-12 align-items-center mb-4">
			
			<span class="col-lg-1">내용</span>
			<span class="col-lg-7">
				<textarea rows="15" readonly>${boardDTO.bcontent}</textarea>
			</span>
			
		</div>
		
</div>
<div class="container-fluid">
	 <i class="fa fa-comments fa-fw"></i>Reply
		<div class="row mb-4">
			
			<div class="col-lg-8">
	    		<textarea class="form-control" id="reply"></textarea>
	    	</div>
	    	<div class="col-lg-2">
				<button id="addReplyBtn" class="btn btn-primary">New Reply</button>
			</div>
			<hr>
		</div>
		
		<div class="panel-body">
			<ul class="chat">
				<!-- start reply -->
				<li class="col-lg-8">
					<div class="row">
						<div class="col-lg-2">
							<strong class="primary-font">user00</strong>
						</div>
						<div class="col-lg-3">
							<small>2020-05-08 15:22</small>
						</div>
					</div>
					<p>댓글이 없는 게시글일 경우 내가 보여요....</p>
					<div class="row">
						<div class="col-lg-5">
							<a class="rereply">답글<strong>[0]</strong></a>&nbsp;
						
						
							<a href="#">수정하기</a>&nbsp;
						
						
							<a href="#">삭제하기</a>
						</div>
					</div>
					<hr>
					
				</li>
			</ul>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="dataTables_paginate paging_simple_numbers" id=dataTable_paginate">
					<ul class="pagination">
						
					</ul>
				</div>
			</div>
		</div>
</div>


<%@ include file="../include/pageFooter.jsp" %>
<form action="${ctxpath}/board/list" name="listForm">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
</form>
<form action="${ctxpath}/board/deletePro" method="post" name="deleteForm">
	<input type="hidden" name="bno" value="">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>
<form action="${ctxpath}/board/modifyForm" name="modifyForm">
	<input type="hidden" name="bno" value="">
	<input type="hidden" name="page" value="">
	<input type="hidden" name="amount" value="">
	<input type="hidden" name="keyword" value="">
</form>
<form action="${ctxpath}/board/loginCheck" name="loginCheck">
</form>
<script src="${ctxpath}/resources/js/replies.js"></script>
<script>
	////////////////////////////////////
	//pageNum: 열람한 게시글의 현재 댓글 페이지 번호이다.// 
	var pageNum=1;
	var bno='<c:out value="${boardDTO.bno}"/>';
	////////////////////////////////////
	//listBtn: 게시글의 리스트 버튼을 클릭하면 목록으로 이동한다.//
	$(".listBtn").on("click", function(e){
		e.preventDefault();
		console.log("list button clicked....");
		var page='<c:out value="${startDTO.page}"/>';
		//console.log("page: "+page);
		var amount='<c:out value="${startDTO.amount}"/>';
		//console.log("amount: "+amount);
		var keyword='<c:out value="${startDTO.keyword}"/>';
		//console.log("keyword: "+keyword);
		$("input[name='page']").val(page);
		$("input[name='amount']").val(amount);
		$("input[name='keyword']").val(keyword);
		var listFormObj=$("form[name='listForm']");
		listFormObj.submit();
	});

	////////////////////////////////////
	//modifyBtn: 게시글의 수정버튼을 클릭하면 수정화면으로 이동한다.
	$(".modifyBtn").on("click", function(e){
		e.preventDefault();
		console.log("modify button clicked....");
		var bno='<c:out value="${boardDTO.bno}"/>';
		var page='<c:out value="${startDTO.page}"/>';
		var amount='<c:out value="${startDTO.amount}"/>';
		var keyword='<c:out value="${startDTO.keyword}"/>';

		$("input[name='bno']").val(bno);
		$("input[name='page']").val(page);
		$("input[name='amount']").val(amount);
		$("input[name='keyword']").val(keyword);

		var modifyFormObj=$("form[name='modifyForm']")
		modifyFormObj.submit();
	});

	///////////////////////////////////////
	//deleteBtn: 게시글의 삭제버튼을 클릭하면 알림창을 띄워 확인한다.//
	$(".deleteBtn").on("click", function(e){
		e.preventDefault()
		console.log("delete button clicked....");
		var chk=confirm("정말로 지우시겠습니까?");
		if(chk){
			var bno='<c:out value="${boardDTO.bno}"/>';
			var page='<c:out value="${startDTO.page}"/>';
			var amount='<c:out value="${startDTO.amount}"/>';
			var keyword='<c:out value="${startDTO.keyword}"/>';
			$("input[name='bno']").val(bno);
			$("input[name='page']").val(page);
			$("input[name='amount']").val(amount);
			$("input[name='keyword']").val(keyword);
			var deleteFormObj=$("form[name='deleteForm']");
			deleteFormObj.submit();
		}else{
			return;
		}
	});
	
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	
	$("#reply").on("focus", function(){
		var replyer="";
		<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';   
		</sec:authorize>
		if(!replyer){
			var loginCheckFormObj=$("form[name='loginCheck']");
			loginCheckFormObj.submit();
		}
	});

	///////////////////////////////////////////////
	//newReply(): 게시글에 대해 댓글을 작성한다.//
	$("#addReplyBtn").on("click", function(e){
		e.preventDefault();
		console.log("reply button clicked....");
		var replyer;
	    <sec:authorize access="isAuthenticated()">
    		replyer = '<sec:authentication property="principal.username"/>';   
    	</sec:authorize>
    	var rcontent=$("#reply").val().trim();
		if(!rcontent){
			alert("댓글을 입력하셔야 합니다.");
			return;
		}
		
		if(!replyer){
			console.log("..........");
			var loginCheckFormObj=$("form[name='loginCheck']");
			loginCheckFormObj.submit();
			return ;
		}else{
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			//repliesService.addReply({bno:bno, mid:replyer, rcontent:rcontent,csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue},function(result){
			repliesService.addReply({bno:bno, mid:replyer, rcontent:rcontent, csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue},function(result){
				$("#reply").val("");
				showList(pageNum, bno);
			});
		}
	});

	////////////////////////////////////////////
	//pagelink: 댓글부분의 페이지 숫자를 누르면 해당 페이지로 이동한다.
	$(".pagination").on("click", ".page-link", function(e){
		e.preventDefault();
		console.log("pagination button clicked....");
		pageNum=$(this).attr("href");
		showList(pageNum, bno);
	});

	////////////////////////////////////////////
	//reredel: 댓글을 삭제한다. 댓글 작성자와 일치한 유저만 가능하다.//
	$(".chat").on("click", ".reredel", function(e){
		e.preventDefault();
		console.log("delete button clicked....");
		var bno=$(this).closest("li").data("bno");
		var rno=$(this).attr("href");
		console.log("bno: "+bno+" / rno: "+rno);
		
		var chk=confirm("정말로 지우시겠습니까?");
		if(chk){
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			repliesService.deleteReply({rno:rno, bno:bno,csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue}, function(){
				showList(pageNum, bno);
			});
		}
		
	});

	////////////////////////////////////////////
	//reremod: 댓글을 수정한다. 댓글 작성자와 일치한 유저만 가능하다.//
	$(".chat").on("click", ".reremod", function(e){
		e.preventDefault();
		var rno = $(this).attr("href");
		console.log("modify button clicked....");
		var li = $(this).closest("li");
		//console.log("li: "+li.html());
		var rcontent=$(this).closest("li").find("p").data("rcon");
		console.log("rcontent: "+rcontent);
		var str="";
		str+="<div class='row'>";
		str+="<div class='col-lg-8'><textarea class='form-control modifyReply'>"+rcontent+"</textarea></div>";
		str+="<div class='col-lg-2'><button data-rno='"+rno+"' class='btn btn-primary modifyReplyBtn'>수정하기</button></div>";
		str+="<div class='col-lg-2'><button data-bak='"+li.html()+"' class='btn btn-primary cancelBtn'>취소하기</button></div><hr>";
		str+="</div>";
		li.empty().html(str);
	});

	//////////////////////////////////
	//cancelBtn: 댓글을 수정하던 중 취소할 수 있다.//
	$(".chat").on("click", ".cancelBtn", function(e){
		e.preventDefault();
		var bak=$(this).data("bak");
		console.log("bak: "+bak);
		$(this).closest("li").empty().html(bak);
		//showList(pageNum, bno);
	});

	/////////////////////////////////////
	//modifyReply: 수정폼에서 수정할 경우 수정처리하여 유저에게 결과를 보여준다.
	$(".chat").on("click", ".modifyReplyBtn", function(e){
		e.preventDefault();
		console.log("modify btn clicked....");
		var rno = $(this).data("rno");
		var rcontent=$(this).closest("li").find("textarea").val();
		console.log("rcontent: "+rcontent);
		if(!rcontent){
			alert("내용을 입력하셔야 합니다.");
		}else{
			//console.log("....");
			var chk=confirm("정말로 수정하시겠습니까?");
			if(chk){
				var csrfHeaderName = "${_csrf.headerName}";
				var csrfTokenValue = "${_csrf.token}";
				repliesService.modifyReply({rno:rno, rcontent:rcontent,csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue}, function(){
					showList(pageNum, bno);
				});
			}
		}
		
	});
		
	//////////////////////////////////////////////
	//showList(pageNum, bno): 게시글의 댓글 리스트를 보여준다.//
	function showList(pageNum, bno){
		console.log("show list....");
		repliesService.getList({bno:bno, page:pageNum||1}, function(replyCnt,list){
			console.log("start list....");
			var replyer;
		    <sec:authorize access="isAuthenticated()">
	    		replyer = '<sec:authentication property="principal.username"/>';   
	    	</sec:authorize>
	    	
			var str="";

			if(list==null || list.length==0){
				
				str+="<li class='col-lg-8'>";
				str+="<div class='row'>";
				str+="<div class='col-lg-8'>";
				str+="<strong class='primary-font'>첫 번째 댓글을 달아주세요!!!</strong>";
				str+="</div></div></li>";
				$(".chat").html(str);
				
				return;
			}

			for(var i=0,len=list.length||0; i<len; i++){
				var dateObj=new Date(list[i].rregdate);
				var yy=dateObj.getFullYear();
				var mm=dateObj.getMonth()+1;
				var dd=dateObj.getDate();
				var hh=dateObj.getHours();
				var mi=dateObj.getMinutes();
				var ss=dateObj.getSeconds();
				mm=mm<10 ? "0"+mm : mm;
				dd=dd<10 ? "0"+dd : dd;
				hh=hh<10 ? "0"+hh : hh;
				mi=mi<10 ? "0"+mi : mi;
				ss=ss<10 ? "0"+ss : ss;
				str+="<li class='col-lg-8' data-bno='"+list[i].bno+"'>";
				str+="<div class='row'>";
				str+="<div class='col-lg-2'>";
				str+="<strong class='primary-font'>"+list[i].mid+"</strong>";
				str+="</div>";
				str+="<div class='col-lg-3'>";
				str+="<small>"+yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss+"</small>";
				str+="</div></div>";
				str+="<p data-rcon='"+list[i].rcontent+"'>"+list[i].rcontent+"</p>";
				str+="<div class='row'>";
				str+="<div class='col-lg-8'>";
				str+="<a href='"+list[i].rno+"' class='rereply'>답글<strong>["+list[i].rcnt+"]</strong></a>&nbsp;";
				if(replyer){
					if(replyer==list[i].mid){
						str+="<a href='"+list[i].rno+"' class='reremod'>수정하기</a>&nbsp;&nbsp;";
						str+="<a href='"+list[i].rno+"' class='reredel'>삭제하기</a>&nbsp;&nbsp;";
					}
				}
				str+="</div>";
				str+="</li>";
			}
			$(".chat").html(str);
			showReplyCnt(replyCnt);
		});
	}

	////////////////////////////////////////////////////////////////////
	//showReplyCnt(replyCnt): 열람한 게시글의 댓글을 페이지 처리한다.(페이지당 10개씩 고정으로 처리)//
	function showReplyCnt(replyCnt){
		var endNum=Math.ceil(pageNum/10.0)*10;
		var startNum=endNum-9;

		var prev=startNum!=1;
		var next=false;
		if(endNum * 10>=replyCnt){
			endNum=Math.ceil(replyCnt/10.0);
		}

		if(endNum*10 <= replyCnt){
			next=true;
		}
		
		var str="";
		
		if(prev){
			str+="<li class='paginate_button page-item previous' id='dataTable_previous'>";
		}else{
			str+="<li class='paginate_button page-item previous disabled' id='dataTable_previous'>";
		}
		str+="<a href='"+(startNum-1)+"' class='page-link'>Previous</a>";

		for(var i=startNum; i<=endNum; i++){
			var active=pageNum==i? "active":"";
			str +="<li class='paginate_button page-item "+active+"'><a href='"+i+"' class='page-link'>"+i+"</a></li>";
		}

		if(next){
			str+="<li class='paginate_button page-item next' id='dataTable_next'>";
		}else{
			str+="<li class='paginate_button page-item next disabled' id='dataTable_next'>";
		}
		str+="<a href='"+(endNum+1)+"' class='page-link'>Next</a>";
		$(".pagination").html(str);
	}

	//////////////////////////////////////////////////
	//document ready: 페이지가 로드됐을 경우 실행된다. 주로 댓글 관련/////
	$(document).ready(function(){
		showList(pageNum, bno);
	});
</script>

<%@ include file="../include/footer.jsp" %>