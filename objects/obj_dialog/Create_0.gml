/// @description Insert description here
// You can write your code in this editor

if (instance_number(object_index) > 1) {
	instance_destroy();	 // THERE CAN ONLY BE ONE
}

dialogs = ds_map_create();

enum DIALOG_TYPES {
	SHOW_MESSAGE,
	SHOW_QUESTION,
	GET_LOGIN,
	GET_STRING,
	GET_INTEGER,
	LENGTH
}