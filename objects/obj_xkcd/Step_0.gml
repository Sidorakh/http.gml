/// @description Insert description here
// You can write your code in this editor

if (in_menu == false) {
	if (keyboard_check_pressed(ord("1"))) {
		load_xkcd();
	}
	if (keyboard_check_pressed(ord("2"))) {
			dialog(map(
			["type",DIALOG_TYPES.GET_INTEGER],
			["text","Comic number"]
		), function(status,result) {
				load_xkcd(result);
			}
		);
	}
	if (keyboard_check_pressed(ord("3"))) {
		load_xkcd(irandom_range(1,max_comic));
	}
}