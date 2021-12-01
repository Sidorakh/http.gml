global.HTTP_DEFAULT_OPTIONS = {
	headers: undefined,
	keep_header_map: false,
	get_file: false,
	filename: "out",
	formdata: undefined,
	keep_formdata: false,
	buffer: undefined,
	keep_buffer: false,
}
global.HTTP_DEFAULT_VARIABLE_LIST = variable_struct_get_names(global.HTTP_DEFAULT_OPTIONS);


/// @function http
/// @param url {string} request URL
/// @param _method {string} request method (GET/POST/PUT/PATCH/DELETE/etc.)
/// @param body {string|buffer|FormData} Body for the HTTP request
/// @param options {struct} Struct containing one or more 
/// @param cb {function} 

function http(url,_method,body,options={},cb=undefined,cb_error=undefined,cb_progress=undefined){
	for (var i=0;i<array_length(global.HTTP_DEFAULT_VARIABLE_LIST);i++) {
		var key = global.HTTP_DEFAULT_VARIABLE_LIST[i];
		if (options[$ key] == undefined) {
			options[$ key] = global.HTTP_DEFAULT_OPTIONS[$ key];	
		}
	}
	if (!instance_exists(obj_http)) {
		instance_create_depth(0,0,0,obj_http);
	}
	if (options.headers == undefined) {
		options.headers = ds_map_create();
	}
	if (instanceof(body) == "FormData") {
		// Handle FormData uploads/POST/PUT/PATCH requests
		
		// Generates body
		options.formdata = body;
		var out = body.post_body();
		var form = out[0];
		var boundary = out[1];
		
		body = form;
		options.headers[? "Content-Type"] = "multipart/form-data; boundary=" + boundary;
		options.headers[? "Content-Length"] = string(buffer_get_size(body));
		
		
	} else if (is_struct(body) || is_array(body)) {
		body = json_stringify(body);
		options.headers[? "Content-Type"] = "application/json";
	}
	if (options.get_file) {
		var buffer = buffer_create(0,buffer_grow,1);
		var request = http_request(url,_method,options.headers,buffer);
		options.buffer = buffer;
		obj_http.requests[? request] = {
		    callback: cb,
			error: cb_error,
			progress: cb_progress,
			options: options,
			buffer: buffer,
		}
		return request;
	}
	var request = http_request(url,_method,options.headers,body);
	obj_http.requests[? request] = {
		callback: cb,
		error: cb_error,
		progress: cb_progress,
		options: options,
	}
	
	// cleanup if needed
	
	if (options.keep_header_map == false) {
		ds_map_destroy(options.headers);	
	}
	
	if (options.formdata != undefined) {
		buffer_delete(body);
		if (options.keep_formdata == false) {
			options.formdata.cleanup();
		}
	}
	
	
	return request;
	
}