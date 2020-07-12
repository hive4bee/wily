repliesService=(function(){
	function getList(param, callback, error){
		var bno=param.bno;
		var page=param.page||1;
		$.getJSON("/wily/pages/"+bno+"/"+page+".json",function(data){
			if(callback){
				//callback(data.cnt, data.list);
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	return {
		getList:getList
	}
})();