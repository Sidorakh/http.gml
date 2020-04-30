# http.gml
An HTTP request library for GameMaker Studio 2.3, allowing the use of callbacks and more!

## Included functions

| Function | Description |
|--|--|
| `form_data_load_file(filename)` | Loads the file located at `filename` into a buffer, ready for insertion into formdata |
| `form_data(...)` | Takes in a struct and returns an array, with valid formdata and a boundary. The structure is described below |
| `http(url,method,options,callback)` | Fires off an HTTP request top the specified URL, and runs the passed in callback on completion. The options map and cb function are described below |


### http options structure

Entries in the Options struct are as follows:

| Name | Description |
|--|--|
| headers | A ds map containing any http request headers necessary |
| body | Body of the HTTP request, either a String, FormData, or Buffer |
| keep_header_map | Set to `true` if you don't want the header map passed in to be destroyed. If no header map is present, this option ahs no effect |


### form-data structure

Each item in the struct is either a `real` or `string` value, or an `array` with the following structure:

| Index | Description |
|--|--|
| 0 | File buffer |
| 1 | File options struct


Entries in the form-data Options struct are as follows:

| Name | Description |
|--|--|
| filename | Name of the file being sent, if not provided, defaults to the field name |
| mimetype | Type of data being sent. Possible values listed [here](https://tools.ietf.org/html/rfc2045) |
| encoding | Encoding of the file (currently ignored, defaults to binary) |
| keep_buffer | Defaults to `false`. If set to `true`, the buffer is *not* deleted, otherwise, it is |



Example usage, this adds two text fields and one file field into a formdata structure:
```gml
var _form_data = form_data({
	name:"JOHN",
	can_fly:true,
	file:form_data_load_file("fcsmile.png")
});
```

## Usage

```gml
// a GET request
http("https://xkcd.com/info.0.json","GET",{},
	function(status,http_status,content_length,size_downloaded,result){
		var data = json_decode(result);
		load_xkcd(result[? "num"]);
	}
);
```

```gml
// a POST request
var _form_data = form_data({
	name:"JOHN",
	can_fly:true,
	file:form_data_load_file("fcsmile.png")
});
http("https://form-data-target.com/upload","POST",{
		body:_form_data
	},function(status,http_status,content_length,size_downloaded,result){
		if (status == 0) {
			show_message("Uploaded data successfully");
		}
	}
});```


---
## Notes

Also includes a very basic wrapper for dialog boxes to make my life easier. This system is far less polished, but still usable. 

Includes two objects, `obj_tester` and `obj_xkcd`. The former is a small set of functions to test it
