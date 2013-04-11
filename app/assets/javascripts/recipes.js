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
	
	$("#select_all").click(function(){
		$(".checkbox").prop('checked', true);
	});
	
	$("#deselect_all").click(function(){
		$(".checkbox").prop('checked', false);
	});
	
	$("#add_checked_ingredients").click(function(){
		addCheckedIngredients();
	});
});

function addIngredient(){
	var ingredient = $("#added_ingredient").val();
	if (ingredient !== ""){
		$("#ingredients_list").append("<li><span class='ingredient'>"+ingredient+
																	"</span> <a class='remove_link' href='#'>remove</a></li>");
		$(".remove_link").click(function(e){
			e.target.parentElement.remove();
		});
	}
	$("#search_ingredients input").val("").focus();
}

function searchRecipes(){
	$("#recipe_search_results").html("");
	var ingredients = "";
	for (var i = 0; i < $("#ingredients_list li").length; i++){
		ingredients += $("#ingredients_list .ingredient")[i].innerHTML.toLowerCase() + "_";
	}
	if (ingredients === ""){
		$("#recipe_search_results").append("<h2>Please enter some ingredients and try again.</h2>");
		$("#search_ingredients input").val("").focus();
	} else {
		$.getJSON("/recipes/update_ingredient_cookies/"+ingredients+".json");
		$.getJSON("/recipes/search/"+ingredients+".json", function(data){
			if (data.length === 0){
				$("#recipe_search_results").append("<h2>Sorry, no recipes found.</h2>");
			} else {
				$("#recipe_search_results").append("<p>Matching Recipes:</p>");
				for (var i = 0; i < data.length; i++){
					$("#recipe_search_results").append("<li><a href='/recipes/"+data[i].id+
																						 "'>"+data[i].name+"</a></li>");
			  }
			}
		});
	}
}

function addCheckedIngredients(){
	var ingredients = [];
	for (var i = 0; i < $(".suggested_ingredient").length; i++){
		if ($(".suggested_ingredient .checkbox")[i].checked){
			ingredients.push($(".suggested_ingredient_name")[i].innerHTML);
		}
	}
	for (var i = 0; i < ingredients.length; i++){
		$("#ingredients_list").append("<li><span class='ingredient'>"+ingredients[i]+
																	"</span> <a class='remove_link' href='#'>remove</a></li>");
		$(".remove_link").click(function(e){
			e.target.parentElement.remove();
		});
	}
}

function addIngredientFromCookie(ingredient){
	$("#ingredients_list").append("<li><span class='ingredient'>"+ingredient+
																"</span> <a class='remove_link' href='#'>remove</a></li>");
	$(".remove_link").click(function(e){
		e.target.parentElement.remove();
	});
}