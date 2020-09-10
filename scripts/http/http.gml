// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function http(url, _method, options, callback){
	if (!instance_exists(obj_http)) {
		instance_create_depth(0,0,0,obj_http);	
	}
	var _is_form_data = false;
	var _file = variable_struct_get(options,"file");
	if (variable_struct_get(options,"body") == undefined) {
		options.body = "";	
	}
	if (variable_struct_get(options,"headers") == undefined) {
		options.keep_header_map = false;
		options.headers = map();
	}
	if (is_array(options.body)) {
		_is_form_data = true;
		var _fd = options.body;
		options.body = _fd[1];
		var _h = options.headers;
		_h[? "Content-Type"] = "multipart/form-data; boundary="+_fd[0];
		_h[? "Content-Length"] = string(buffer_get_size(_fd[1]));
	}
	with (obj_http) {
		var _request_id;
		if (_file != undefined) {
			_request_id = http_get_file(url,_file);
		} else {
			_request_id = http_request(url, _method, options.headers, options.body);
		}
		var _error = function(){};
		var _progress = function(){};
		if (typeof(callback)=="struct") {
			var _m;
			_m = variable_struct_get(callback,"error");
			if (_m != undefined) {
				_error = _m
			}
			_m = variable_struct_get(callback,"progress");
			if (_m != undefined) {
				_progress = _m;
			}
			callback = callback.complete;
		}
		var _req = map(
			["url",url],
			["callback",callback],
			["error",_error],
			["progress",_progress]
		);
		requests[? _request_id] = _req;
	}
	if (variable_struct_get(options,"keep_header_map") == true) {
		ds_map_destroy(options.headers);
	}
	if (_is_form_data) {
		buffer_delete(options.body);
	}
}


function map() {
	var _map = ds_map_create();
	for (var i=0;i<argument_count;i++) {
		var _a = argument[i];
		_map[? _a[0]] = _a[1];
	}
	return _map;
}
