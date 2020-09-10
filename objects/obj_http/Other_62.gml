/// @description Insert description here
// You can write your code in this editor
var _req_id = async_load[? "id"];
var _req = requests[? _req_id];

if (_req == undefined) {	// not one of ours
	return;
}

var _cb = _req[? "callback"];
var _error = _req[? "error"];
var _progress = _req[? "progress"];

var _status = async_load[? "status"];
if (_status < 0) {
	show_debug_message("HTTP Error on request: " + json_encode(_req));
	_cb(_status,
		async_load[? "http_status"]
	);
} else if (_status == 0) {
	show_debug_message("HTTP Success on request: " + json_encode(_req));
	_cb(_status,
		async_load[? "http_status"],
		async_load[? "contentLength"],
		async_load[? "sizeDownloaded"],
		async_load[? "result"]
	);
} else if (_status == 1) {
	show_debug_message("HTTP Progress on request: " + json_encode(_req));
	_progress(_status,
			async_load[? "http_status"],
			async_load[? "contentLength"],
			async_load[? "sizeDownloaded"]
	);
}

if (_status < 1) { // if we're done with it
	ds_map_destroy(_req);
}