/// @description Stubs for testing specific async events

if (keyboard_check_pressed(vk_space)) {
	dialog(map(
		["type",DIALOG_TYPES.GET_STRING],
		["text","Enter some text"]
	), function(status,result) {
		dialog(map(
			["type",DIALOG_TYPES.SHOW_MESSAGE],
			["text",result]
		),undefined);
	});
}
if (keyboard_check_pressed(vk_enter)) {
	http("http://localhost:3000",map(
		["method","GET"]
	),function(req,status,http_status,__cl,__sd,body) {
		dialog(map(
			["type",DIALOG_TYPES.SHOW_MESSAGE],
			["text",body]
		),undefined);
	});
}
if (keyboard_check_pressed(vk_control)) {
	var _buff = buffer_create(128,buffer_fixed,1);
	buffer_write(_buff,buffer_text,"we flew a kite in a public place...");
	http(
		//"https://postb.in/b/1584797069959-0726414755918",
		"http://localhost:3000",
		//"https://entzkl95cxecd.x.pipedream.net",
		//"https://webhook.site/2273c4b0-abcf-49cb-8f78-80a969aaf112",
		map(
			["method","POST"],
			["body",form_data(
				["name","JOHN"],
				["can-fly","true"],
				["file",_buff,map(
					["filename","test.txt"],
					["mimetype","text/plain"]
				)]
			)]
		),
		function(){
			show_message("Did the thing")
		}
	);
	buffer_delete(_buff);
}
//if (keyboard_check_pressed(vk_control)) {
//	http(
//		"http://localhost:3000",
//		map(
//			["method","POST"],
//			["body",http_test()],
//			["headers",map(["content-type","multipart/form-data, boundary=AaB03x"])]
//		),
//		function(){
//			show_message("Did the thing")
//		}
//	);
//}

if (keyboard_check_pressed(vk_alt)) {
	http(
		//"https://postb.in/1584794855141-1986487612593",
		"http://localhost:3000",
		map(
			["method","POST"],
			["body","This was a triumph"]
		),
		function(){
			show_message("Did the thing")
		}
	);
}

