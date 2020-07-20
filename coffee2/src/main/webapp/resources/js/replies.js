var repliesService = (function(){
	function add(reply, callback, error){
		$.ajax({
			type:"POST",
			url:"/replies/new",
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function add2(reply, callback, error){
		$.ajax({
			type:"POST",
			url:"/replies/new2",
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function getList(param, callback, error){
		var fno = param.fno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+fno+"/"+page+".json", function(data){
			if(callback){
				//callback(data);
				callback(data.cnt, data.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function remove(param, callback, error){
		var rno = param.rno;
		var fno = param.fno;
		$.ajax({
			type:'delete',
			url:'/replies/'+rno+"/"+fno,
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function removeReReply(param, callback, error){
		var srno = param.srno;
		var rno = param.rno;
		var fno = param.fno;
		$.ajax({
			type:'delete',
			url:'/replies/delete/'+rno+"/"+srno,
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function update(reply, callback, error){
		console.log("RNO : " + reply.rno);
		$.ajax({
			type:"put",
			url:"/replies/"+reply.rno,
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function getReRepliesList(rno, callback, error){
		console.log("~~rno : " + rno.rno);
		$.getJSON("/replies/rno/"+rno.rno+".json", function(data){
			if(callback){
				//callback(data);
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	return {
		add : add,
		add2 : add2,
		getList : getList,
		remove : remove,
		removeReReply : removeReReply,
		update : update,
		getReRepliesList : getReRepliesList
	};
})();