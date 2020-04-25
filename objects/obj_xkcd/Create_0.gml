/// @description Insert description here
// You can write your code in this editor
comic = -1;
title = "";
sprite = -1;
day = -1;
month = -1;
year  = -1;
max_comic = -1;

draw_set_font(fnt_main);

in_menu = false;


http("https://xkcd.com/info.0.json",map(["method","GET"]),function(req,status,http_status,__cl,__sd,body){
	var _data = json_decode(body);
	max_comic = _data[? "num"];
	ds_map_destroy(_data);
});