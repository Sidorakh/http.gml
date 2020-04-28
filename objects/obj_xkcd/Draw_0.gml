/// @description Insert description here
// You can write your code in this editor

draw_text(4,4,string_hash_to_newline("Select an option:#1. Latest comic#2. Select a Comic#3. Random Comic"));
draw_text(4,120,"Title: " + title + "\nNumber: " + string(comic));
draw_text_ext(4,room_height-100,alt,-1,room_width-8);
if (sprite > -1) {
	draw_sprite(sprite,0,200,200);
}