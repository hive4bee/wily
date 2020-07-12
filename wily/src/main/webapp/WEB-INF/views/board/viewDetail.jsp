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
	}
	ul{
		padding-left:0px;
	}
</style>
<sec:authentication property="principal" var="pinfo"/>
<div class="container-fluid justify-content-center">
	<h1 class="h3 ml-2 mb-2 text-gray-800">${boardDTO.bno}번 글</h1>
	
	
		<div class='row ml-2 mt-2'>
			
			<div class="col-sm-12 ml-2 mt-2 mb-5">
				<a href="#" class="btn btn-primary listBtn">리스트</a>
				<sec:authorize access="isAuthenticated()">
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
<script src="${ctxpath}/resources/js/replies.js"></script>
<script>
	var pageNum=1;
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
	$(".deleteBtn").on("click", function(e){
		e.preventDefault()
		console.log("delete button clicked....");
		confirm("정말로 지우시겠습니까?");
		if(confirm){
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
	
	function showList(pageNum, bno){
		console.log("show list....");
		repliesService.getList({bno:bno, page:pageNum||1}, function(list){
			console.log("start list....");
			var str="";

			if(list==null || list.length==0){
				str+="<li class='col-lg-8'>";
				str+="<div class='row'>";
				str+="<div class='col-lg-2'>";
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
				str+="<li class='col-lg-8'>";
				str+="<div class='row'>";
				str+="<div class='col-lg-2'>";
				str+="<strong class='primary-font'>"+list[i].mid+"</strong>";
				str+="</div>";
				str+="<div class='col-lg-3'>";
				str+="<small>"+yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss+"</small>";
				str+="</div></div>";
				str+="<p>"+list[i].rcontent+"</p>";
				str+="<hr></li>";
			}
			$(".chat").html(str);
			//showReplyCnt(replyCnt);
		});
	}

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
		$(".pagication").html(str);
	}
	$(document).ready(function(){
		var bno='<c:out value="${boardDTO.bno}"/>';
		showList(pageNum, bno);
	});
</script>

<%@ include file="../include/footer.jsp" %>