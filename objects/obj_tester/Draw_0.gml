/// @description Insert description here
// You can write your code in this editor


var _str = "";
_str += "1. Open RequestBin url ("+requestbin_url+")\n";
_str += "2. Send GET request\n";
_str += "3. Send POST/form-data request\n";
_str += "4. Send POST request (JSON string)\n";
_str += "5. Download photo of a cat (get_file: true)\n";
_str += "6. Data parsing functions\n";
_str += "7. GET Request to custom URL\n";

draw_text(4,4,_str);

if (in_progress == true) {
	draw_text(4,256,prog_str);	
}