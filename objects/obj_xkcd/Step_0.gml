/// @description Insert description here
// You can write your code in this editor

if (in_menu == false) {
	if (keyboard_check_pressed(ord("1"))) {
		load_xkcd();
	}
	if (keyboard_check_pressed(ord("2"))) {
		var map = ds_map_create();
		/// feather disable GM2016
		map[? "type"] = DIALOG_TYPES.GET_INTEGER;
		map[? "text"] = "Comic number";
		dialog(map, function(status,result) {
			load_xkcd(result);
		});
		/// feather enable GM2016
	}
	if (keyboard_check_pressed(ord("3"))) {
		load_xkcd(irandom_range(1,max_comic));
	}
}