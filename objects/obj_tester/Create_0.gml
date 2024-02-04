/// @description Insert description here
// You can write your code in this editor

requestbin_url = "https://requestbin.com/r/enn3xyub5vujm";

in_progress = false;
prog_str = "";


HttpBodyParser.add("text/csv",function(headers,body){
	var str = string_split(body,"\n");
	var grid = array_create_ext(array_length(str),function(){return []});
	for (var i=0;i<array_length(str);i++) {
		grid[i] = string_split(str[i],",");
	}
	return grid;
});

