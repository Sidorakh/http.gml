# Home

<center>
<p>
    HTTP.gml : a HTTP Request handler for GameMaker
</p>

[Download the latest version here](https://github.com/Sidorakh/http.gml/releases/)
</center>


An HTTP request wrapper for [GameMaker](https://gamemaker.io), based around callbacks rather than the HTTP Async event. 

# Features

- Wraps HTTP requests in an easy to sue callback system
- Includes functionality to create `multipart/form-data` HTTP requests automatically
- Automatically applies correct `Content-Type` header when sending structs and arrays
- Includes automatic JSON parsing of responses by default, and has hooks for more parsers
- A fifth thing!

# Why was http.gml made?

The Async event system isn't the best for managing HTTP requests, and wrapping the HTTP async event in a function that accepts a callback seemed like a great way to make it bearable to use. 

# What license is HTTP.gml released under?

HTTP.gml is under the [MIT License](https://github.com/Sidorakh/http.gml/blob/master/LICENSE)