(
	document.onload =
	function(){
		var script = 
			document.createElement('script'); 
			script.setAttribute("type", "text/javascript"); 
			script.setAttribute("src", "https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"); 
			document.getElementsByTagName("head")[0].appendChild(script);
	}
)();