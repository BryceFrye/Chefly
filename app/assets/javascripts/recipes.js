$(document).ready(function(){
	$("#search_by_ingredients").click(function(){
		$("#recipe_search_results").html("");
		$.getJSON("/recipes/search/"+$("#search_ingredient_input").val()+".json", function(data){
			if (data.length === 0){
				$("#recipe_search_results").append("Sorry, no recipes found.");
			} else {
				for (var i = 0; i < data.length; i++){
					$("#recipe_search_results").append("<li><a href='/recipes/"+data[i].id+"'>"+
																					 	 data[i].name+"</a></li>");
			  }
			}
		});
	});
});
