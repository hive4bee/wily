var ordersService = (function(){

	function getOrderList(id, callback, error){
		console.log("zzzzzzzzzzz");
		$.getJSON("/admin/getOrderList/"+id+".json", function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
		/*
		$.ajax({
			type:"POST",
			url:"/admin/getOrderList",
			data:{id:id},
			success:function(result, status, xhr){
				console.log(result);
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
		*/
	}
	/*
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
	*/

	
	return {
		//getList : getList,
		getOrderList : getOrderList
	};
})();