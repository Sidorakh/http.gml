# Getting Started

## What even is an HTTP request
---
An HTTP request is a standard way of passing information to and from web services, especially API's. Each HTTP request contains a version and HTTP verb (such as "GET" and "POST"), then a series of ehaders, and then (optionally) a body.  

HTTP headers indicate certain things about HTTP requests and responses, including the request/response body language, and also may include API keys or tokens that can be used to authenticate with a server.

## Installing
---
1. Download the latest .yymp from [releases](https://github.com/Sidorakh/http.gml/releases/)
2. Open your existing GameMaker project and drag the .yymp file into the IDE (or go to the Tools menua nd select Import Local Package)
3. Ensure you import the `http.gml` folder in "Extensions" (optionally, you can import everything which includes some examples)
4. You're done!

## Using HTTP.gml
---
Instead of using `http_request` or a similar `http_` function, use the `http` function and pass in a callback 

For example, to fetch the users public IP address with http.gml

```gml
// With http.gml
var headers = ds_map_create();
headers[? "User-Agent"] = "GameMaker Client";
http("https://icanhazip.com","GET","",{ headers, keep_header_map: false }, function(status, result) {
    show_message("Your IP address is " + result);
});
```
Maybe you want your player to sign into your own backend with a username and password:
```gml
var headers = ds_map_create();
headers[? "User-Agent"] = "GameMaker Client";
http("https://yourbackend.com/users/login","POST",{username: "admin", password: "password123"},{ headers, keep_header_map: false}, function(status, result) {
    show_message("Server response: " + string(status) + " - " + json_stringify(result));
})
```
These are only some basic examples of what this library can do

## Updating HTTP.gml
---
1. If you modified HTTP_DEFAULT_OPTIONS, back this up
2. Delete the `http.gml` folder in the IDE
3. Follow the steps in [Installing](#installing) with the new version

