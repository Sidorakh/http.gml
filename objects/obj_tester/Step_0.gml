
if (keyboard_check_pressed(ord("1"))) {
	url_open(requestbin_url);	
}

if (keyboard_check_pressed(ord("2"))) {
	var code = get_string("HTTP Status","200");
	http("https://enn3xyub5vujm.x.pipedream.net/"+code,"GET","",{},function(status,result){
		show_message("\"" + string(status) + "\" - \"" + string(result) + "\"");
	},function(status,result){
		show_message("\"" + string(status) + "\" - \"" + string(result) + "\"");
	});	
}

if (keyboard_check_pressed(ord("3"))) {
	var body = get_string("Body",sha1_string_utf8(date_current_datetime()));
	var form = new FormData();
	form.add_data("testfield",body);
	form.add_file("file","codes.json");
	http("https://enn3xyub5vujm.x.pipedream.net/","POST",form,{},function(status,result){
		show_message_async(result);
	});	
}
// shows automatic stringifying of structs/arrays
if (keyboard_check_pressed(ord("4"))) {
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

if (keyboard_check_pressed(ord("5"))) {
	var options = {
		get_file: true,
		keep_buffer: false,
	}
	in_progress = true;
	http("https://i.imgur.com/R42xZ1p.jpg","GET","",options,function(status,result,options){
		in_progress = false;
		buffer_save(options.buffer,"out.jpg");
		show_message("Find this file @ %localappdata%/out.jpg");
		show_message(string(result) + " | " + string(options.buffer));
	},function(status,result,options) {
		in_progress = false;
	},function(cl,sd){
		prog_str = string(sd) + " / " + string(cl);
	});
}


if (keyboard_check_pressed(ord("6"))) {
	var url = get_string("Custom URL","https://fake.redshirt.dev");
	http(url,"GET","",{},function(status,result,options){
		show_message("\"" + string(opions.status) + "\" - \"" + string(result) + "\"");
	},function(status,result,options){
		show_message("\"" + string(options.status) + "\" - \"" + string(result) + "\"");
	});	
}