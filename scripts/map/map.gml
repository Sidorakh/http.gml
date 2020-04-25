// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function map() {
	var _map = ds_map_create();
	for (var i=0;i<argument_count;i++) {
		var _a = argument[i];
		_map[? _a[0]] = _a[1];
	}
	return _map;
}