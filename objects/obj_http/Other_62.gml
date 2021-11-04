/// @description 
var req = async_load[? "id"]
if (requests[? req] == undefined) return;

var status = async_load[? "status"];
if (status < 0) {
	// Error
	
	var error = requests[? req].error;
	if (error != undefined) {
		error(async_load[? "http_status"],async_load[? "result"]);	
		requests[? req] = undefined;
	}
}
if (status == 0) {
	// Complete	
	var callback = requests[? req].callback;
	if (callback != undefined) {
		callback(async_load[? "http_status"],async_load[? "result"]);	
		requests[? req] = undefined;
	}
}
if (status == 1) {
	// Progress
	var progress = requests[? req].progress;
	if (progress == undefined) {
		progress(async_load[? "contentLength"],async_load[? "sizeDownloaded"]);
	}
}