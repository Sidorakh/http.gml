# Advanced Use

## Downloading a photo
Lets say you want to download a large file off the internet. This could take some time, so it'll be nice to have the progress shown. It's easy to acheive using http.gml, like so

```gml
/// Create event
data_url = "https://i.imgur.com/R42xZ1p.jpg"
downloading = false;
content_length = 1;
size_downloaded = 0;

/// To start the download

downloading = true;
http(data_url,"GET","",{get_file: true, keep_buffer: false}, function(status, result, options){
    // Success callback
    downloading = false;
    buffer_save(result, "out.jpg");
	show_message($"Find your brand new file at /{game_save_id}out.jpg");
}, function(options){
    // Error callback
    downloading = false;
},function(_content_length,_size_downloaded) {
    // Progress indicator
    content_length = _content_length;
    size_downloaded = _size_downloaded;
});

/// Draw event
if (downloading) {
    draw_text(4,4,$"Downloading: {100*size_downloaded/content_length}%");
}
```


## Adding a parser

To register a custom parser, you need to know what Content-Type it will operate on. For example, the built-in JSON parser is registered like so
```gml
function http_json_parse(headers, http_body, options) {
    try {
        var result = json_parse(http_body);
        return result;
    } catch(e) {
        throw (e);
    }
}

HttpBodyParser.add("application/json",http_json_parse);

```


