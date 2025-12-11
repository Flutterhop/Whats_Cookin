/// @description Insert description here
// You can write your code in this editor
draw_flush();

draw_self();

if(active){
	draw_set_alpha(.2);
	draw_rectangle_color(x - sprite_width / 2.1,y - sprite_height / 2,x + sprite_width / 2.1,y + sprite_height / 2.5,c_white,c_white,c_white,c_white,false);			
	draw_set_alpha(1);
	
}