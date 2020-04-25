/// @description Insert description here
// You can write your code in this editor
var _req_id = async_load[? "id"];
var _req = requests[? _req_id];

if (_req == undefined) {	// not one of ours
	return;
}

var _cb = _req[? "callback"];
var _status = async_load[? "status"];

_cb(_req,
	_status,
	async_load[? "http_status"],
	async_load[? "contentLength"],
	async_load[? "sizeDownloaded"],
	async_load[? "result"]
);
if (_status < 1) { // if we're done with it
	if (_req[?"options"][?"headers"] != undefined) {
		if (ds_exists(ds_type_map,_req[?"options"][?"headers"])) {
			ds_map_destroy(_req[?"options"][?"headers"]);
		}
	}
	ds_map_destroy(_req[? "options"]);
	ds_map_destroy(_req);
}