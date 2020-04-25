/// @description Insert description here
// You can write your code in this editor
var _req_id = async_load[? "id"];
var _dialog = dialogs[? _req_id];
if (_dialog == undefined) {		// not one of ours
	return;
}
var _cb = _dialog[? "callback"];
switch (_dialog[? "type"]) {
	case DIALOG_TYPES.SHOW_MESSAGE:
		_cb(async_load[? "status"]);
	break;
	case DIALOG_TYPES.SHOW_QUESTION:
		_cb(async_load[? "status"]);
	break;
	case DIALOG_TYPES.GET_LOGIN:
		_cb(async_load[? "status"],
			map(
				["username",async_load[? "username"]],
				["password",async_load[? "password"]]
			)
		);
	break;
	case DIALOG_TYPES.GET_STRING:
		_cb(async_load[? "status"],async_load[? "result"]);
	break;
	case DIALOG_TYPES.GET_INTEGER:
		_cb(async_load[? "status"],async_load[? "value"]);
	break;
}
ds_map_destroy(_dialog);