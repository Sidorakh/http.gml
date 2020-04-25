// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function http(url, options, callback){
	if (!instance_exists(obj_http)) {
		instance_create_depth(0,0,0,obj_http);	
	}
	var _delete_header_map = false;
	var _file = options[? "file"];
	var _method = options[? "method"];
	if (options[? "body"] == undefined) {
		options[? "body"] = "";	
	}
	if (options[? "headers"] == undefined) {
		_delete_header_map = true;
		options[? "headers"] = map();
	}
	if (typeof(options[? "body"]) == "array") {
		var _fd = options[? "body"];
		options[? "body"] = _fd[1];
		var _h = options[? "headers"];
		_h[? "Content-Type"] = "multipart/form-data; boundary="+_fd[0];
		_h[? "Content-Length"] = string(buffer_get_size(_fd[1]));
	}
	with (obj_http) {
		var _request_id;
		if (_file != undefined) {
			_request_id = http_get_file(url,_file);
		} else {
			_request_id = http_request(url, _method, options[? "headers"], options[? "body"]);
		}
		var _req = map(
			["url",url],
			["options",options],
			["callback",callback]
		);
		requests[? _request_id] = _req;
	}
	if (_delete_header_map) {
		ds_map_destroy(options[? "headers"]);
		options[? "headers"] = undefined;
	}
}