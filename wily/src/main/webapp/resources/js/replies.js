repliesService=(function(){
	function getList(param, callback, error){
		var bno=param.bno;
		var page=param.page||1;
		$.getJSON("/wily/replies/pages/"+bno+"/"+page+".json",function(data){
			if(callback){
				callback(data.cnt, data.list);
				//callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function getReList(param, callback, error){
		var rno=param.rno;
		var page=param.page||1;
		$.getJSON("/wily/replies/re/"+rno+".json",function(data){
			if(callback){
				callback(data);
				//callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function addReply(param, callback, error){
		
		var bno=param.bno;
		var mid=param.mid;
		var rcontent=param.rcontent;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		//var csrfHeaderName = "${_csrf.headerName}";
		//var csrfTokenValue = "${_csrf.token}";
		console.log("bno: "+bno + " / mid: "+mid+" / rcontent: "+rcontent);
		$.ajax({
			type:"POST",
			url:"/wily/replies/addReply",
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				bno:bno,mid:mid,rcontent:rcontent
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				
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
	
	function deleteReply(param, callback, error){
		var rno=param.rno;
		var bno=param.bno;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		$.ajax({
			type:"delete",
			url:"/wily/replies/deleteReply/"+bno+"/"+rno,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				rno:rno,bno:bno
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
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
	
	function modifyReply(param, callback, error){
		var rno=param.rno;
		var rcontent=param.rcontent;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		$.ajax({
			type:"put",
			url:"/wily/replies/modifyReply/"+rno,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				rno:rno,rcontent:rcontent
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
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
	
	function addRereply(param, callback, error){
		var rno=param.rno;
		var bno=param.bno;
		var mid=param.mid;
		var rcontent=param.rcontent;
		var rsup=param.rsup;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		$.ajax({
			type:"post",
			url:'/wily/replies/addRereply',
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				rno:rno,bno:bno,mid:mid,rsup:rsup,rcontent:rcontent
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				
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
	
	function deleteRereply(param, callback, error){
		var rno=param.rno;
		var rgroup=param.rgroup;
		var csrfHeaderName=param.csrfHeaderName;
		var csrfTokenValue=param.csrfTokenValue;
		$.ajax({
			type:"delete",
			url:"/wily/replies/deleteRereply/"+rgroup+"/"+rno,
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data:JSON.stringify({
				rno:rno,bno:bno
			}),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
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
		getList:getList,
		addReply:addReply,
		deleteReply:deleteReply,
		modifyReply:modifyReply,
		addRereply:addRereply,
		getReList:getReList,
		deleteRereply:deleteRereply
	}
})();