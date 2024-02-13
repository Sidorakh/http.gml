# http()
---

## `http(url, method, body, options, callback, [error], [progress])`

Creates and sends an HTTP request to the specified URL with the specified options, and calls any relevant callback functions passed.
NOTE: When a [Struct.FormData](form-data.md?id=formdata-1) struct is passed in as the `body` parameter, any `Content-Type` headers present are ignored and overwritten with the boudnary calculated in the `FormData` struct.


| Name | Type | Required | Description |
| - | - | - | - |
| url | String | Yes | The URL to make a request to |
| method | String | Yes | HTTP Method to use (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`) |
| body | String OR Struct OR Array OR [Struct.FormData](form-data.md?id=formdata-1) | Yes | HTTP Body to send with the HTTP request. GET requests cannot have a body so this argument is ignored when sending a GET request |
| options | [Struct.HttpOptions](http.md?id=structhttpoptions) | Yes | A struct that sets various options for this HTTP request |
| callback | [Function\<SuccessCallback>](http.md?id=functionltsuccesscallbackgt) | Yes | A function to be run on completion of the HTTP request |
| error | [Function\<ErrorCallback>](http.md?id=functionlterrorcallbackgt) | No | A function to be run if the HTTP request fails
| progress | [Function\<ProgressCallback>](http.md?id=functionltprogresscallbackgt) | No | A function to be run when the HTTP request has not completed but when progress changes | 

Returns: Async Request ID (Real)



## Struct.HttpOptions

A struct passed to the `http()` function and passed into each callback that contains various options for that HTTP request

| Name | Type | Description |
| - | - | - |
| headers | Id.DSMap | DS Map containing headers for this request. Can be left unset if no custom headers are required (default: `undefined`) |
| response_headers | Id.DSMap | A DS Map containing headers for the HTTP response if received. (default: `undefined`) |
| keep_header_map | Boolean | Whether or not to keep the header map passed into the HTTP request (default: `false`) |
| formdata | Struct.FormData | An internal variable, used to keep track of the `formdata` struct and buffers (default: `undefined`) |
| keep_formdata | Boolean | Whether or not the `cleanup` function of the FormData struct should be run, deleting any buffers added to the FormData struct (default: `false`) |
| get_file | Boolean | Whether or not to pipe the HTTP Response into a buffer, and return that instead (default: `false`) |
| buffer | Id.Buffer | An internal variable, used to keep track of a buffer used to download a file (default: `undefined`) |
| keep_buffer | Boolean | Whether or not to delete the `buffer` after the HTTP request resolves (either successfully or in an error) (default: `false`) |
| status | Real | Set on the HttpOptions struct when sent into an HTTP async event, is the status field from `async_load` |
| raw_body | String OR Id.Buffer | The raw body of the HTTP request, before any automatic parsing (default: `""`) |


## Function\<SuccessCallback>

A user-defined function called on success of an HTTP request that takes the following parameters

Note: HTTP statuses are not verified, so a request that returns a 404 or 500 error will still count as successful. Check the status code 

| Name | Type | Description | 
| - | - | - | 
| status | String | HTTP Status returned by the request |
| result | String OR Id.Buffer | Response returned by the server |
| options | [Struct.HttpOptions](http.md?id=structhttpoptions) | The options struct associated with this request, including response headers if they were received |

Returns: Nothing



## Function\<ErrorCallback>

A user-defined function called on failure of an HTTP request that takes the following parameters

Note: HTTP statuses are not verified, so a request that returns a 404 or 500 error will still count as successful

| Name | Type | Description |
| - | - | - |
| options | [Struct.HttpOptions](http.md?id=structhttpoptions) | The options struct associated with this request |

Returns: Nothing


## Function\<ProgressCallback> 

A user-defined function called while an HTTP request is in progress, that takes the following parameters


| Name | Type | Description |
| - | - | - |
| content_length | Real | Size of the content, in bytes |
| size_downloaded | Real | Size of content downloaded, in bytes |
| options | [Struct.HttpOptions](http.md?id=structhttpoptions) |  The options struct associated with this request, including response headers if they were received |

Returns: Nothing
