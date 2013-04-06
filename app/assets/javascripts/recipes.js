$(document).ready(function(){
	$("#search_by_ingredients").click(function(){
		$("#recipe_search_results").html("");
		var ingredients = "";
		for (var i = 0; i < $("#search_ingredients input").length; i++){
			console.log($("#search_ingredients input")[i].value);
			ingredients += $("#search_ingredients input")[i].value + "_"
		}
		console.log(ingredients);
		$.getJSON("/recipes/search/"+ingredients+".json", function(data){
			console.log("JSON data:", data);
			if (data.length === 0){
				$("#recipe_search_results").append("Sorry, no exact matches found.");
			} else {
				for (var i = 0; i < data.length; i++){
					$("#recipe_search_results").append("<li><a href='/recipes/"+data[i].id+
																						 "'>"+data[i].name+"</a></li>");
			  }
			}
		});
	});
});
