questionsService=(function(){
	function getQuestion(param, callback, error){
		var page=param.page;
		var amount=param.amount;
		$.getJSON("/wily/questions/pages/"+page+"/"+amount, function(data){
			if(callback){
				callback(data.cnt, data.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(err);
			}
		});
	}
	
	function addQuestion(param, callback, error){
		var qsubject=param.qsubject;
		var qcontent=param.qcontent;
		var mid=param.mid;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		$.ajax({
			type:"post",
			url:"/wily/questions/addQuestion",
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				qsubject:qsubject,qcontent:qcontent,mid:mid
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	function showDetailQuestion(param, callback, error){
		var qno=param.qno;
		$.ajax({
			type:"get",
			url:"/wily/questions/showDetailQuestion/"+qno,
			dataType:"json",
			success:function(result){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	function deleteQuestion(param, callback, error){
		var qno=param.qno;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		$.ajax({
			type:"delete",
			url:"/wily/questions/delete/"+qno,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			contentType:"application/json; charset=utf-8",
			success:function(result){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	function modifyQuestion(param, callback, error){
		var qno=param.qno;
		var qsubject=param.qsubject;
		var qcontent=param.qcontent;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		
		$.ajax({
			type:"put",
			url:"/wily/questions/modify/"+qno,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				qno:qno,qsubject:qsubject,qcontent:qcontent
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	return {
		getQuestion:getQuestion,
		addQuestion:addQuestion,
		showDetailQuestion:showDetailQuestion,
		deleteQuestion:deleteQuestion,
		modifyQuestion:modifyQuestion
	}
})();