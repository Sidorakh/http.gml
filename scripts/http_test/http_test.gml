// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function http_test(url, options, callback){
	var _buff = buffer_create(128,buffer_grow,1);
	buffer_write(_buff,buffer_text,
@'--AaB03x
content-disposition: form-data; name="field1"

field1
--AaB03x
content-disposition: form-data; name="field2"

field2
--AaB03x');

}