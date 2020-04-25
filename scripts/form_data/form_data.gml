// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function form_data(){
	
	// 
	// Argument structure
	//  - Arrays
	//     - 0: Field Name
	//     - 1: Data
	//     - 2: (Optional) File Options (if present, assumes that data is a buffer)
	//
	
	///
	// 
	// File Options k/v
	//  - filename: (String) filename (if omitted, defaults to field name)
	//  - mimetype: MIME type of the data, see: https://tools.ietf.org/html/rfc2045
	//  - encoding: ?
	///
	
	var _bound = "----" + "WebKitFormBoundaryADrpNr7cKhNyE0nz";//sha1_string_utf8(date_datetime_string(date_current_datetime()));
	var _buff = buffer_create(128,buffer_grow,1);
	var _nl = chr(13) + chr(10);
	
	
	for (var i=0;i<argument_count;i++) {
		var _a = argument[i];
		show_debug_message(_a);
		buffer_write(_buff,buffer_text,"--"+_bound+_nl);	// `--${BOUND}\r\n`
		if (array_length(_a) == 2) {
			// Boring-ass regular form field
			buffer_write(_buff,buffer_text,"Content-Disposition: form-data; name=\""+_a[0]+"\""+_nl+_nl);
			buffer_write(_buff,buffer_text,string(_a[1])+_nl);
			continue;
		}
		
		// File field!
		var _opt = _a[2];
		if (_opt[? "filename"] == undefined) {
			_opt[? "filename"] = _a[0];	
		}
		if (_opt[? "mimetype"] == undefined) {
			_opt[? "mimetype"] = "text/plain";		// according to rfc2045
		}
		buffer_write(_buff,buffer_text,"Content-Disposition: form-data; name=\""+_a[0]+"\"; filename=\"" + _opt[? "filename"] + "\"" + _nl);
		buffer_write(_buff,buffer_text,"Content-Type: " + _opt[? "mimetype"] + _nl + _nl);
		
		//buffer_copy(_a[1],0,buffer_get_size(_a[1]),_buff,buffer_tell(_buff));
		//buffer_seek(_buff,buffer_seek_relative,buffer_get_size(_a[1]));
		buffer_write(_buff,buffer_text,"we flew a kite in a public place...")
		buffer_write(_buff,buffer_text,_nl);
		ds_map_destroy(_a[2]);
	}
	
	buffer_write(_buff,buffer_text,"--" + _bound + "--" + _nl); // end with `--${BOUND}--\n`
	buffer_seek(_buff,buffer_seek_start,0);
	var _text = buffer_read(_buff,buffer_text);
	show_message(_text);
	clipboard_set_text(_text);
	buffer_seek(_buff,buffer_seek_start,0);
	return [_bound, _buff];
}