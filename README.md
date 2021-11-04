
# http.gml v2.0
A complete rewrite of http.gml. It's much nicer now. 

## http(url, method, body, options, callback, [error], [progress])
A wrapper for `http_request` (and `http_get_file`), returns the HTTP request ID. The callbacks passed in are called at appropriate times. 
| Parameter | Type | Description |
|--|--|--|
| url | String | A valid URL |
| method | String | A valid HTTP Request Method |
| body | String/FormData | An HTTP request body, either a string or FormData |
| options | Struct\<HTTPOptions\> | A struct setting various options in the request (further docs below) |
| callback | function | A function to be called if the HTTP request succeeds |
| error | function | (Optional) A function to be called if the HTTP request fails |
| progress | function | (Optional) A function to be called when the HTTP request is still in progress |

### options \<HTTPOptions\>
| Property | Type | Description |
|--|--|--|
| headers | Real (ds_map) | A ds_map index of headers to be sent with the HTTP reequest. If not provided, a map is created |
| keep_header_map | Boolean | Whether or not to keep the header map (useful if the headers are reused and don't need to change often) |
| get_file | Boolean | Whether or not to use `http_get_file` instead of `http_request` (not recommended) |
| filename | String | The file to output to when using `http_get_file` |
| keep_form_data | Boolean | Whether or not to clean up/destroy the FormData object included in a HTTP request. Ignored if no FormData object is passed in as body |

### callback(http_status, result)
A function to be called when the HTTP request is successful
| Parameter | Type | Description |
|--|--|--|
| http_status | Real | HTTP status code |
| result | String | HTTP response body |

### error(http_status, result)
A function to be called when the HTTP request is unsuccessful
| Parameter | Type | Description |
|--|--|--|
| http_status | Real | HTTP status code |
| result | String | HTTP response body |

### progress(content_length, size_downloaded)
A function that is called when an HTTP request is still in progress (and has not completed or failed)
| Parameter | Type | Description |
|--|--|--|
| content_length | Real | Total response size |
| size_dwnloaded | String | Data downloaded |

## FormData
A struct that implements FormData as best I can to the spec set out in [rfc2045](https://datatracker.ietf.org/doc/html/rfc2045). 

### add_file(name, file, options)
Adds a file field to the FormData object
| Parameter| Type | Description |
|--|--|--|
| name | String | Field name |
| file | String | Path to file to load into FormData |
| options | Struct\<FormDataOptions\> | Options related to file |

### add_data(name, data)
Adds a data field to the FormData object
| Parameter | Type | Description |
|--|--|--|
| name | String | Field name |
| data | String | Field Data |

### form_body
Returns the `multipart/form-data` encoded body and the boundary, ready for use in the `HTTP` function
Returns: [Buffer, String]

### cleanup
Cleans up any buffers created and stored in the FormData object that were not flagged with `keep_buffer`, except the results of the `form_body` function

### options\<FormDataOptions\>
| Property | Type | Description |
|--|--|--|
| file_is_buffer | Boolean | Whether or not the File passed in to `add_file` is a Buffer instead of a file/path |
| keep_buffer | Boolean | When using `file_is_buffer`, this controls whether or not the buffer is kept after the FormData object runs its `cleanup()` function |
| filename | String | Filename to use for the uploaded file (in the form field). If blank, will use the filename in the `file` argument, or the string `"unknown"` if a buffer was specified |
| mimetype | String | The mimetype to mark the file as. This is sniffed from the filename if there's a [filetype registered with the IANA](https://www.iana.org/assignments/media-types/media-types.xhtml) in the `get_mime_from_extension()` function |


## Example Usage
### Basic GET request
```js
// Using the amazing yes/no API - https://yesno.wtf
http("https://yesno.wtf/api","GET","",{},function(status,result){
	result = json_parse(result);
	show_message(result.answer);
})
```
### Uploading a file (multipart/form-data)

```js
var form = new FormData();
form.add_file("file","codes.json");
form.add_data("foo","bar");
var headers = ds_map_create();
headers[? "X-App-Id"] = "ABC123"
http("https://enn3xyub5vujm.x.pipedream.net/", "POST", form, {headers:headers}, function(http_status,result){
	show_message(result);
},function(http_status,result){
	show_message("Error - " + result);
});
```