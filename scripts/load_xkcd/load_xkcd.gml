// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function load_xkcd(num){
	var url="https://xkcd.com/"
	if (num==undefined) {
		url += "info.0.json";
	} else {
		url += string(num) + "/info.0.json";
	}
	http(
		url,
		map(["method","GET"]),
		function(req,status,http_status,__cl,__sd,body){
			var _data = json_decode(body);
			title = _data[? "title"];
			comic = _data[? "num"];
			if (sprite!=-1) {
				sprite_delete(sprite);
			}
			sprite = sprite_add(_data[? "img"],1,0,0,0,0);
			ds_map_destroy(_data);
		}
	);
}