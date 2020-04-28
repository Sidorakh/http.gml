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
	http("http://localhost:3000","GET",{},function(status,http_status,__cl,__sd,body) {
		dialog(map(
			["type",DIALOG_TYPES.SHOW_MESSAGE],
			["text",body]
		),undefined);
	});
}
if (keyboard_check_pressed(vk_control)) {
	var _buff = buffer_load("fcsmile.png");
	var _form_data = form_data({
		name:"JOHN",
		can_fly:true,
		file:form_data_load_file("fcsmile.png")
	});
	
	http(
		"http://localhost:3000",
		"POST",
		{
			body:_form_data
		},
		function(){
			show_message("Did the thing")
		}
	);
}