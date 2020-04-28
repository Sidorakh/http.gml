function form_data(data) {
	
	/// 
	// Argument structure
	//  - Struct with the format `field`:`value` for basic text/number fields
	//  - Format of [buffer,{file_options}] for any files
	//
	///
	// File Data structure
	// {
	//     filename: name of file (string)
	//     mimetype: file mimetype (string), see: see: https://tools.ietf.org/html/rfc2045
	//     encoding: encoding type, defaults to "binary" (currently ignored)
	// }
	// 
	///
	// 
	// File Options k/v
	//  - filename: (String) filename (if omitted, defaults to field name)
	//  - mimetype: MIME type of the data, see: https://tools.ietf.org/html/rfc2045
	//  - encoding: Encoding type of data, defaults to binary
	///
	
	var _bound = "----" + sha1_string_utf8(date_datetime_string(date_current_datetime()));
	var _buff = buffer_create(128,buffer_grow,1);
	var _nl = chr(13) + chr(10);
	
	var _keys = variable_struct_get_names(data);
	
	for (var i=0;i<array_length(_keys);i++) {
		var name = _keys[i];
		show_debug_message(name);
		var value = variable_struct_get(data,name);
		if (is_array(value) != true) {
			var _s = string(value);
			while (string_pos(_bound,_s) != 0) {
				_bound += form_get_bound_safe_char();
			}
			continue;
		}
		var buff = value[0];
		var o = "";
		var bc = 1;
		var val = 0;
		for (var p=0;p<buffer_get_size(buff);p++) {
			val = buffer_peek(buff,p,buffer_u8);
			o = ord(string_char_at(_bound,bc));
			if (val == 0) {
				bc++;
				if (bc == string_length(_bound)) {
					_bound += form_get_bound_safe_char();
				}
			} else {
				bc = 1;
				break;
			}
		}
	}
	
	show_debug_message(_bound);
	for (var i=0;i<array_length(_keys);i++) {
		var name = _keys[i];
		var value = variable_struct_get(data,name);
		//var _a = argument[i];
		//show_debug_message(_a);
		buffer_write(_buff,buffer_text,"--"+_bound+_nl);	// `--${BOUND}\r\n`
		if (is_array(value) != true) {
			// Boring-ass regular form field
			buffer_write(_buff,buffer_text,"Content-Disposition: form-data; name=\""+name+"\""+_nl+_nl);
			buffer_write(_buff,buffer_text,string(value)+_nl);
			continue;
		}
		
		// File field!
		
		
		var options = value[1];
		value = value[0];
		if (variable_struct_get(options,"filetype") == undefined) {
			options.filename = name;	
		}
		if (variable_struct_get(options,"mimetype") == undefined) {
			options.mimetype = "text/plain";		// according to rfc2045
		}
		buffer_write(_buff,buffer_text,"Content-Disposition: form-data; name=\""+name+"\"; filename=\"" + options.filename + "\"" + _nl);
		buffer_write(_buff,buffer_text,"Content-Type: " + options.mimetype + _nl + _nl);
		
		buffer_copy(value,0,buffer_get_size(value),_buff,buffer_tell(_buff));
		buffer_seek(_buff,buffer_seek_relative,buffer_get_size(value));
		buffer_write(_buff,buffer_text,_nl);
		if (variable_struct_get(options,"keep_buffer") != true) {
			buffer_delete(value);
		}
	}
	
	buffer_write(_buff,buffer_text,"--" + _bound + "--" + _nl); // end with `--${BOUND}--\n`
	buffer_seek(_buff,buffer_seek_start,0);
	//var _text = buffer_read(_buff,buffer_text);
	//show_message(_text);
	//clipboard_set_text(_text);
	//buffer_seek(_buff,buffer_seek_start,0);
	return [_bound, _buff];
}

function form_get_bound_safe_char() {
	var _index = irandom(array_length(global.bound_char_set)-1);
	return global.bound_char_set[_index];
}

function form_data_load_file(file_path) {
	var buff = buffer_load(file_path);
	var file_ext = filename_ext(file_path);
	var mime = "";
	switch (string_lower(file_ext)) {
		case ".png":
			mime = "image/png";
		break;
		case ".jpg":
		case ".jpe":
		case ".jpeg":
			mime = "image/jpeg";
		break;
		case ".gif":
			mime = "image/gif";
		break;
		case ".txt":
			mime = "text/plain";
		break;
	}
	var options = {
		keep_buffer:false,
		filename: filename_name(file_path)
	}
	if (mime != "") {
		options.mimetype = mime;
	}
	return [buff,options];
}

global.bound_char_set = [
	"-","_",
	"1","2","3","4","5","6","7","8","9","0",
	"a","b","c","d","e","f","g","h","i","j","k","l","m",
	"n","o","p","q","r","s","t","u","v","w","x","y","z",
	"A","B","C","D","E","F","G","H","I","J","K","L","M",
	"N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
];