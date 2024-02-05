# HttpBodyParser

`HttpBodyParser` handles automatic parsing of HTTP responses based on the Content-Type header of a HTTP Response. By default, an automatic JSON parser is included, and it's easy to add more. All functions and variables for the HttpBodyParser class are static, meaning you should not call the constructor directly, and instead use the static methods provided



## HttpBodyParser.add(content_type,parser)
Registers a parser to run on requests with the given `content_type`

| Name | Type | Required | Description |
| - | - | - | - |
| content_type | String | Yes | The content-type for this parser to operate on |
| parser | [Function\<ParserFunction>](http-body-parser.md?id=functionltparserfunctiongt) | Yes | The parser function to be called |



## Function\<ParserFunction>

A parser function that is called by the HttpBodyParser struct to process HTTP response bodies, with the following signature


| Name | Type | Description |
| - | - | - |
| headers | Id.DsMap | The HTTP Response headers associated with the given request |
| http_body | string OR Id.Buffer | The HTTP response, in either String or Buffer format |
| options | [Struct.HttpOptions](http.md?id=structhttpoptions) | The HTTP Options struct associated with the given request |

Returns: Any


