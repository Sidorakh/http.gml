# FormData()

## FormData()

The FormData constructor. 

Returns: Struct.FormData

## FormData.add_file(name,file,[options])

Adds a file to the FormData struct

Returns: Nothing

| Name | Type | Required | Description |
| - | - | - | - | 
| name | String | Yes | Field name in the FormData struct |
| file | String | Yes | Path to a file (either relative or absolute) |
| options | Struct.AddFileOptions | No | Various options and flags to be used when adding the file |
## FormData.add_buffer(name,buffer,[fname],[options])

Adds a buffer to the FormData struct

Returns: Nothing

| Name | Type | Required | Description | 
| - | - | - | - |
| name | String | Yes | Field name in the FormData struct |
| buffer | Id.Buffer | Yes | Buffer containing data to be loaded into the FormData struct |
| fname | Atring | No | Filename for the binary data. Defaults to the field name if not supplied |
| options | Struct.AddFileOptions | No | Various options and flags to be used when adding the file |

## FormData.add_data(name,value)

Adds a text field to the FormData struct

Returns: Nothing

| Name | Type | Required | Description | 
| - | - | - | - |
| name | String | Yes | Field name in the FormData struct |
| value | String | Yes | Field value in the FormData struct |

## FormData.cleanup()

Deletes all buffers stored within the FormData struct

Returns: Nothing


## FormData.post_body()

Encodes the FormData struct into a `multipart/form-data` compatible format and calculates a suitable boundary header. 

Note: You normally wouldn't need to use this function directly, [`http`](http.md?id=httpurl-method-body-options-callback-error-progress) automatically calls it if it has a `FormData` struct passed into it as the body. 

Returns: Array, [Struct.FormData, string]

## Struct.AddFileOptions

A struct that contains options for adding files and buffers into a FormData struct

| Name | Type | Required | Description |
| - | - | - |
| keep_buffer | Boolean | No | Whether or not to keep the buffer when loading it into an HTTP request (default: `false`) |
| filename | String | No | Name of the file (default: `""`) |
| mimetype | String | No | Mimetype of the file (default: `""`) | 