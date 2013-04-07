$(document).ready(function(){
	$("#add_search_ingredient").click(function(){
		addIngredient();
	});
	
	$("#search_by_ingredients").click(function(){
		searchRecipes();
	});
	
	$("#search_ingredients input").keypress(function(e){
		if (e.charCode === 13){
			addIngredient();
		}
	});
});

function addIngredient(){
	var ingredient = $("#search_ingredients input").val();
	$("#ingredients_list").append("<li><span class='ingredient'>"+ingredient+
																"</span> <a class='remove_link' href='#'>remove</a></li>");
	$(".remove_link").click(function(e){
		e.target.parentElement.remove();
	});
	$("#search_ingredients input").val("").focus();
}

function searchRecipes(){
	$("#recipe_search_results").html("");
	var ingredients = "";
	for (var i = 0; i < $("#ingredients_list li").length; i++){
		ingredients += $("#ingredients_list .ingredient")[i].innerHTML + "_";
	}
	if (ingredients === ""){
		$("#recipe_search_results").append("Please enter some ingredients and try again.");
		$("#search_ingredients input").val("").focus();
	} else {
		$.getJSON("/recipes/search/"+ingredients+".json", function(data){
			if (data.length === 0){
				$("#recipe_search_results").append("Sorry, no recipes found.");
			} else {
				for (var i = 0; i < data.length; i++){
					$("#recipe_search_results").append("<li><a href='/recipes/"+data[i].id+
																						 "'>"+data[i].name+"</a></li>");
			  }
			}
		});
	}
}