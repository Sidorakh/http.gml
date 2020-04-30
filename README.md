# http.gml
An HTTP request library for GameMaker Studio 2.3, allowing the use of callbacks and more!

## Included functions

| Function | Description |
|--|--|
| `form_data_load_file(filename)` | Loads the file located at `filename` into a buffer, ready for insertion into formdata |
| `form_data(...)` | Takes in a struct and returns an array, with valid formdata and a boundary. The structure is described below |
| `http(url,method,body,callback)` | Fires off an HTTP request top the specified URL, and runs the passed in callback on completion. The options map and cb function are described below |


### form-data structure

Each item in the struct is either a `real` or `string` value, or an `array` with the following structure:

| Index | Description |
|--|--|
| 0 | File buffer |
| 1 | File options struct


Structure for the Options map in form_data

| Name | Description |
|--|--|
| filename | Name of the file being sent |
| mimetype | Type of data being sent. Possible values listed [here](https://tools.ietf.org/html/rfc2045) |
| encoding | Encoding of the file (currently ignored, defaults to binary) |
| keep_buffer | Defaults to `false`. If set to `true`, the buffer is *not* deleted, otherwise, it is |

Example usage, this adds two text fields and one file field into a formdata structure:
```gml
var _buff = buffer_load("test.txt");
var _form_data = form_data({
	name:"JOHN",
	can_fly:true,
		file:form_data_load_file("fcsmile.png")
});
```

## Usage

```gml
http("https://xkcd.com/info.0.json","GET",{},
	function(status,http_status,content_length,size_downloaded,result){
		var data = json_decode(result);
		load_xkcd(result[? "num"]);
	}
);

```

---
## Notes

Also includes a very basic wrapper for dialog boxes to make my life easier. This system is far less polished, but still usable. 

Includes two objects, `obj_tester` and `obj_xkcd`. The former is a small set of functions to test it
