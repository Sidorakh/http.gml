/// @description Insert description here
// You can write your code in this editor
comic = -1;
title = "";
sprite = -1;
day = -1;
month = -1;
year  = -1;
max_comic = -1;
alt = "";

draw_set_font(fnt_main);

in_menu = false;

randomize();

http("https://xkcd.com/info.0.json","GET","",{},function(status,result) {
	var _data = json_decode(result);
	max_comic = _data[? "num"];
	ds_map_destroy(_data);
});