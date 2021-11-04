
if (keyboard_check_pressed(vk_space)) {
	var code = get_string("HTTP Status","200");
	http("https://enn3xyub5vujm.x.pipedream.net/"+code,"GET","",{},function(status,result){
		show_message("\"" + string(status) + "\" - \"" + string(result) + "\"");
	},function(status,result){
		show_message("\"" + string(status) + "\" - \"" + string(result) + "\"");
	});	
}

if (keyboard_check_pressed(vk_enter)) {
	var body = get_string("Body",sha1_string_utf8(date_current_datetime()));
	var form = new FormData();
	form.add_data("testfield",body);
	form.add_file("file","codes.json");
	http("https://enn3xyub5vujm.x.pipedream.net/","POST",form,{},function(status,result){
		show_message_async(result);
	});	
}
// shows automatic stringifying of structs/arrays
if (keyboard_check_pressed(vk_control)) {
	var body = get_string("JSON string","");
	try {
		body = json_parse(body);
		http("https://enn3xyub5vujm.x.pipedream.net/","POST",body,{},function(status,result){
			show_message_async(result);
		});
	} catch(e) {
		show_message(e);
	}
}