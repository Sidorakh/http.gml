/// @description 
var req = async_load[? "id"]
if (requests[? req] == undefined) return;

var status = async_load[? "status"];
var options = requests[? req].options;
options.status = status;
if (status < 0) {
	// Error
	var error = requests[? req].error;
	if (error != undefined) {
		var result = async_load[? "result"];
		if (options.get_file) {
			result = options.buffer;
		}
		if (async_load[? "response_headers"]) {
			options.response_headers = async_load[? "response_headers"];
		}
		error(status,requests[? req].options);	
		if (requests[? req].options.keep_buffer == false) {
			if (buffer_exists(requests[? req].options.buffer)) {
				buffer_delete(requests[? req].options.buffer);
			}
		}
		ds_map_delete(requests,req);
	}
}
if (status == 0) {
	// Complete	
	var callback = requests[? req].callback;
	if (callback != undefined) {
		var result = async_load[? "result"];
		if (options.get_file) {
			result = options.buffer;
		}
		if (async_load[? "response_headers"]) {
			options.response_headers = async_load[? "response_headers"];
            var keys = ds_map_keys_to_array(options.response_headers);
            for (var i=0;i<array_length(keys);i++) {
                var key = keys[i];
                options.response_headers[? string_lower(key)] = options.response_headers[? key];
            }
            options.raw_body = result;
            if (options.get_file != true) {
                result = HttpBodyParser.parse(options.response_headers,result,options);
            }
		}
		callback(async_load[? "http_status"],result,requests[? req].options);
		if (requests[? req].options.keep_buffer == false) {
			if (buffer_exists(requests[? req].options.buffer)) {
				buffer_delete(requests[? req].options.buffer);
			}
		}
		ds_map_delete(requests,req);
	}
}
if (status == 1) {
	// Progress
	var progress = requests[? req].progress;
	if (async_load[? "response_headers"]) {
		options.response_headers = async_load[? "response_headers"];
	}
	if (progress != undefined) {
		progress(async_load[? "contentLength"],async_load[? "sizeDownloaded"],requests[? req].options);
	}
}

if (ds_map_size(requests) == 0) {
	active = false;	
}