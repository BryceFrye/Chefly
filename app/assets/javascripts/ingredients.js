function add_fields(link, association, content){
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g");
	console.log("made it htis far")
	// $(link).up().insert({
	// 		before: content.replace(regexp, new_id)
	// 	});
	$(link).parent().before(content.replace(regexp, new_id));
}