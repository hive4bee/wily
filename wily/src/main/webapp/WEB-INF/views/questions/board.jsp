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
</style>
<div class="container-fluid">
	
</div>
<form action="${ctxpath}/questions/loginCheck" name='loginCheckForm'></form>
<%@ include file="../include/pageFooter.jsp" %>
<script src="${ctxpath}/resources/js/questions.js"></script>
<script>
	////////////////////////////////////////////////////////////////
	//page: 현 페이지, amount: 페이지당 레코드 수
	var page=1;
	var amount=10;
	function getDate(date){
		var dateObj=new Date(date);
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
		return yy+"-"+mm+"-"+dd+" "+hh+":"+mi+":"+ss;
	}

	///////////////////////////////////////////////////////////////////////
	//showQuestionList(page, amount): 질문 리스트를 보여준다.
	function showQuestionList(page,amount){
		questionsService.getQuestion({page:page, amount:amount}, function(cnt, list){
	    	var str="";
			str+="<h1 class='h3 ml-2 mb-2 text-gray-800'>질문게시판</h1>";
			str+="<div class='card shadow mb-4'>";
			str+="<div class='row ml-2 mt-2'>";
			str+="<div class='col-sm col-md-3 ml-2 mt-2'>";
			str+="<a href='#' class='btn btn-primary writeQuestion'>글작성</a>";
			str+="</div></div>";
			str+="<div class='card-body'>";
			str+="<div class='table-responsive'>";
			str+="<div id='dataTable-wrapper' class='dataTable_wrapper dt-bootstrap4'>";
			str+="<div class='row'>";
			str+="<div class='col-sm-12 col-md-2'>";
			str+="<div class='dataTables_length' id='dataTable_length'>";
			str+="<label>SHOW";
			str+="<select name='dataTable_length' aria-controls=dataTable' class='custom-select custom-select-sm form-control form-control-sm'>";
			str+="<option value='10'>10</option>";
			str+="<option value='25'>25</option>";
			str+="<option value='50'>50</option>";
			str+="<option value='100'>100</option></select></label></div></div>";
			str+="<div class='col-sm-12 col-md-2'>";
			str+="<div id='dataTable_filter' class='dataTables_filter'>";
			str+="<label>Search:<input type='search' class='form-control form-control-sm' aria-controls='dataTables'></label></div></div></div>";
			str+="<div class='row'>";
			str+="<div class='col-sm-12'>";
			str+="<table class='table table-bordered' id='dataTable' width='100%' cellspacing='0'>";
			str+="<thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th></tr></thead>";
			str+="<tbody>";
			if(list==null || list.length==0){
				str+="<tr><td colspan='5'>작성된 게시글이 없습니다.</td></tr>";
			}else{
				for(var i=0,len=list.length||0; i<len; i++){
					str+="<tr>";
					str+="<td>"+list[i].qno+"</td>";
					str+="<td><a href='"+list[i].qno+"' class='viewQuestionDetail'>"+list[i].qsubject+"<strong>["+list[i].qcnt+"]</strong></a></td>";
					str+="<td>"+list[i].mid+"</td>";
					str+="<td>"+list[i].qhit+"</td>";
					str+="<td>"+getDate(list[i].qregdate)+"</td>";
				}
			}
			str+="</tbody></table></div></div>";
			str+="<div class='row'>";
			str+="<div class='col-sm-12'>";
			str+="<div class='dataTables_paginate paging_simple_numbers' id='dataTables-paginate'>";
			str+="<ul class='pagination'>";
			str+=showReplyCnt(cnt);
			str+="</ul></div></div></div>";
			str+="</div></div></div></div></div>";
			$(".container-fluid").html(str);
		});
	}

	//////////////////////////////////////////////////////////////////////////////////////
	//showReplyCnt: 페이징 처리
	function showReplyCnt(replyCnt){
		var endNum=Math.ceil(page/10.0)*10;
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
			var active=page==i? "active":"";
			str +="<li class='paginate_button page-item "+active+"'><a href='"+i+"' class='page-link'>"+i+"</a></li>";
		}

		if(next){
			str+="<li class='paginate_button page-item next' id='dataTable_next'>";
		}else{
			str+="<li class='paginate_button page-item next disabled' id='dataTable_next'>";
		}
		str+="<a href='"+(endNum+1)+"' class='page-link'>Next</a>";
		return str;
	}
	
	////////////////////////////////////////////////////////////////////////
	//writeQuestion: 게시판에서 글작성 버튼을 클릭했을 때
	$(".container-fluid").on("click",".writeQuestion", function(e){
		e.preventDefault();
		console.log("write question button clicked....");
		var userId;
	    <sec:authorize access="isAuthenticated()">
    		userId = '<sec:authentication property="principal.username"/>';   
    	</sec:authorize>
    	if(!userId){
			var loginCheckFormObj=$("form[name='loginCheckForm']");
			loginCheckFormObj.submit();
        };

        var str="";
        str+="<h1 class='h3 ml-2 mb-5 text-gray-800 text-center'>글작성</h1>";
        str+="<div class='row align-items-center justify-content-center mb-2'>";
        str+="<span class='col-sm-8 col-md-1'>제목</span>";
        str+="<span class='col-sm-8 col-md-7'>";
        str+="<input type='text' class='qsubjectFromWriteForm'>";
        str+="</span></div>";
        str+="<div class='row align-items-center justify-content-center mb-2'>";
        str+="<span class='col-sm-8 col-md-1'>내용</span>";
        str+="<span class='col-sm-8 col-md-7'>";
        str+="<textarea rows='15' class='qcontentFromWriteForm'></textarea>";
        str+="</span></div>";
        str+="<div class='row align-items-center justify-content-center'>";
        str+="<span class='col-sm-8 col-md-4'>";
        str+="<button type='button' class='btn btn-primary submitBtnFromWriteForm'>제출</button>";
        str+="<button type='button' class='btn btn-primary backBtnFromWriteForm ml-2'>돌아가기</button>";
        str+="</span></div>";
        str+="<input type='hidden' name='mid' value=''>";
        $(".container-fluid").html(str);
	});

	//////////////////////////////////////////////////////////////////////////////
	//backBtnFromWriteForm: 글작성 중 돌아가기 버튼 클릭
	$(".container-fluid").on("click", ".backBtnFromWriteForm", function(e){
		console.log("back Button from writeForm clicked....");
		showQuestionList(page,amount);
	});

	//////////////////////////////////////////////////////////////////////////////
	//submitBtnFromWriteForm: 글작성 중 제출버튼 클릭
	$(".container-fluid").on("click", ".submitBtnFromWriteForm", function(){
		var qsubject=$(".qsubjectFromWriteForm").val().trim();
		var qcontent=$(".qcontentFromWriteForm").val().trim();
		if(!qsubject){
			alert("제목을 입력하셔야 합니다.");
			return;
		}
		if(!qcontent){
			alert("내용을 입력하셔야 합니다.");
			return;
		}

		if(qsubject && qcontent){
			var userId;
		    <sec:authorize access="isAuthenticated()">
	    		userId = '<sec:authentication property="principal.username"/>';   
	    	</sec:authorize>
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			questionsService.addQuestion({qsubject:qsubject,qcontent:qcontent,mid:userId,csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue},
					function(result){
				if(result=='success'){
					showQuestionList(page, amount);
				}
			});
		}
	});

	//////////////////////////////////////////////////////////////////////////////////////
	//viewQuestionDetail: 글제목을 클릭하고 상세하게 열람한다.
	$(".container-fluid").on("click", ".viewQuestionDetail", function(e){
		e.preventDefault();
		console.log("view Question Detail button clicked....");
		var userId;
	    <sec:authorize access="isAuthenticated()">
    		userId = '<sec:authentication property="principal.username"/>';   
    	</sec:authorize>
		var qno=$(this).attr("href");
		questionsService.showDetailQuestion({qno:qno}, function(result){
			if(result){
				var str="";
				str+="<h1 class='h3 ml-2 mb-2 text-gray-800'>"+result.qno+"번 글</h1>";
				str+="<div class='row ml-2 mt-2'>";
				str+="<div class='col-sm-12 ml-2 mt-2 mb-5'>";
				str+="<a href='#' class='btn btn-primary listBtnFromDetail'>리스트</a>";
				if(userId){
					if(userId==result.mid){
						str+="<a href='"+result.qno+"' class='btn btn-primary modifyBtnFromDetail'>수정하기</a>";
						str+="<a href='"+result.qno+"' class='btn btn-primary deleteBtnFromDetail'>삭제하기</a>";
					}
				}
				str+="</div></div>";
				str+="<div class='row col-lg-12 align-items-center mb-2'>";
				str+="<span class='col-lg-1'>제목</span>";
				str+="<span class='col-lg-7'>";
				str+="<input type='text' value='"+result.qsubject+"' readonly>";
				str+="</span></div>";
				str+="<div class='row col-lg-12 align-items-center mb-4'>";
				str+="<span class='col-lg-1'>내용</span>";
				str+="<span class='col-lg-7'>";
				str+="<textarea rows='15' readonly>"+result.qcontent+"</textarea>";
				str+="</span></div>";

				$(".container-fluid").html(str);
			}
		});
	});

	/////////////////////////////////////////////////////////////////////////////////////////
	//listBtnFromDetail: 다시 리스트로 이동한다.
	$(".container-fluid").on("click", ".listBtnFromDetail", function(e){
		e.preventDefault();
		showQuestionList(page, amount);
	});

	////////////////////////////////////////////////////////////////////////////////////////
	//deleteBtnFromDetail: 게시글을 삭제하는 버튼 클릭
	$(".container-fluid").on("click", ".deleteBtnFromDetail", function(e){
		e.preventDefault();
		var qno=$(this).attr("href");
		var chk=confirm("정말로 지우시겠습니까?");
		if(chk){
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			questionsService.deleteQuestion({qno:qno,csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue}, function(result){
				if(result=='success'){
					showQuestionList(page, amount);
				}
			});
		}
	});

	////////////////////////////////////////////////////////////////////////////////////////////
	//modifyBtnFromDetail: 게시글을 수정하는 버튼 클릭
	$(".container-fluid").on("click", ".modifyBtnFromDetail", function(e){
		e.preventDefault();
		var qno=$(this).attr("href");
		var chk=confirm("정말로 수정하시겠습니까?");
		var userId;
	    <sec:authorize access="isAuthenticated()">
    		userId = '<sec:authentication property="principal.username"/>';   
    	</sec:authorize>
    	
		questionsService.showDetailQuestion({qno:qno}, function(result){
			if(result){
				var str="";
				str+="<h1 class='h3 ml-2 mb-2 text-gray-800'>"+result.qno+"번 글</h1>";
				str+="<input type='hidden' name='hiddenQnoFromModify' value='"+result.qno+"'>";
				str+="<div class='row ml-2 mt-2'>";
				str+="<div class='col-sm-12 ml-2 mt-2 mb-5'>";
				str+="<a href='#' class='btn btn-primary listBtnFromDetail'>리스트</a>";
				str+="<a href='#' class='btn btn-primary completeBtnFromModify'>수정하기</a>";
				str+="</div></div>";
				str+="<div class='row col-lg-12 align-items-center mb-2'>";
				str+="<span class='col-lg-1'>제목</span>";
				str+="<span class='col-lg-7'>";
				str+="<input type='text' class='qsubjectFromModify' value='"+result.qsubject+"'>";
				str+="</span></div>";
				str+="<div class='row col-lg-12 align-items-center mb-4'>";
				str+="<span class='col-lg-1'>내용</span>";
				str+="<span class='col-lg-7'>";
				str+="<textarea class='qcontentFromModify' rows='15'>"+result.qcontent+"</textarea>";
				str+="</span></div>";

				$(".container-fluid").html(str);
			}
		});
	});

	////////////////////////////////////////////////////////////////////////////////////////
	//completeBtnFromModify: 수정하기 완료버튼 클릭
	$(".container-fluid").on("click", ".completeBtnFromModify", function(e){
		var qno=$("input[name='hiddenQnoFromModify']").val();
		var qsubject=$(".qsubjectFromModify").val().trim();
		var qcontent=$(".qcontentFromModify").val().trim();
		console.log("qno: "+qno+" / qsubject: "+qsubject+" / qcontent: "+qcontent);
		if(!qsubject){
			alert("제목을 입력하셔야 합니다.");
			return;
		}
		if(!qcontent){
			alert("내용을 입력하셔야 합니다.");
			return;
		}
		
		if(qsubject && qcontent){
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			questionsService.modifyQuestion({qno:qno,qsubject:qsubject,qcontent:qcontent,csrfHeaderName:csrfHeaderName,csrfTokenValue:csrfTokenValue}, function(result){
				if(result=='success'){
					alert("성공적으로 수정 완료했습니다.");
					showQuestionList(page, amount);
				}
			});
		}
		
	});
	
	////////////////////////////////////////////////////////////////////////////////////////
	//document ready
	$(document).ready(function(){
		showQuestionList(page,amount);
	});
</script>
<%@ include file="../include/footer.jsp" %>