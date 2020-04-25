// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dialog(options,callback){
	if (!instance_exists(obj_dialog)) {
		instance_create_depth(0,0,0,obj_dialog);	
	}
	if (options[? "text"] == undefined) {
		options[? "text"] = "";	
	}
	if (options[? "default"] == undefined) {
		options[? "default"] = "";	
	}
	if (options[? "username"] == undefined) {
		options[? "username"] = "";	
	}
	if (options[? "password"] == undefined) {
		options[? "password"] = "";	
	}
	var _cb = callback != undefined ? callback : function(){};
	var _request_id;
	switch (options[? "type"]) {
		case DIALOG_TYPES.SHOW_MESSAGE:
			_request_id = show_message_async(options[? "text"]);
		break;
		case DIALOG_TYPES.SHOW_QUESTION:
			_request_id = show_question_async(options[? "text"]);
		break;
		case DIALOG_TYPES.GET_LOGIN:
			_request_id = get_login_async(options[? "username"],options[? "password"]);
		break;
		case DIALOG_TYPES.GET_STRING:
			_request_id = get_string_async(options[? "text"], options[? "default"]);
		break;
		case DIALOG_TYPES.GET_INTEGER:
			_request_id = get_integer_async(options[? "text"], options[? "default"]);
		break;
	}
	with (obj_dialog) {
		options[? "callback"] = _cb;
		options[? "id"] = _request_id;
		dialogs[? _request_id] = options;
	}
	
}