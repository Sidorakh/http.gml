/// @description 
var req = async_load[? "id"]
if (requests[? req] == undefined) return;

var status = async_load[? "status"];
var options = requests[? req].options;
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
		error(async_load[? "http_status"],result,requests[? req].options);	
		if (requests[? req].options.keep_buffer == false) {
			if (buffer_exists(requests[? req].options.buffer)) {
				buffer_delete(requests[? req].options.buffer);
			}
		}
		requests[? req] = undefined;
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
		}
		callback(async_load[? "http_status"],result,requests[? req].options);	
		if (requests[? req].options.keep_buffer == false) {
			if (buffer_exists(requests[? req].options.buffer)) {
				buffer_delete(requests[? req].options.buffer);
			}
		}
		requests[? req] = undefined;
	}
}
if (status == 1) {
	// Progress
	var progress = requests[? req].progress;
	if (progress != undefined) {
		progress(async_load[? "contentLength"],async_load[? "sizeDownloaded"],requests[? req].options);
	}
}