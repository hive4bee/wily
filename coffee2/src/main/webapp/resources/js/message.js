var messageService = (function(){
	
	
	function getMessageL(mid, callback, error){
		$.getJSON("/message/mid/"+mid+".json", function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	return {
		getMessageL : getMessageL
	};
})();