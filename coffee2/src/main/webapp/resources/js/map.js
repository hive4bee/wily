var mapService = (function(){
	
	
	function getMapList(key, callback, error){
		console.log("~~rno : " + key.key);
		$.getJSON("/shops/key/"+key.key+".json", function(data){
			if(callback){
				console.log(data);
				//callback(data);
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function getAddr(snum, callback, error){
		console.log("~~snum : " + snum.snum);
		$.ajax({
				type:"get",
				url:"/shops/getAddr",
				data:{snum:snum.snum},
				contentType:"application/json; charset=utf-8",
				success:function(result){
					if(callback){
						callback(result);
						//location.reload();
					}else {
						
					}
				}
			});
	}
	
	return {
		getMapList : getMapList,
		getAddr : getAddr
	};
})();