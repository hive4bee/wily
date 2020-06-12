var cartService = (function(){
	
	
	function getCartList(mid, callback, error){
		console.log("~~rno : " + mid.mid);
		$.getJSON("/products/mid/"+mid.mid+".json", function(data){
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
	
	return {
		getCartList : getCartList
	};
})();