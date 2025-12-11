/// @description Insert description here
// You can write your code in this editor
draw_set_alpha(.5);
draw_set_color(c_black);
draw_rectangle(x - sprite_width - 5,y - sprite_height - 5,x + sprite_width - 5,y + sprite_height - 5,false);
draw_self();
draw_set_alpha(1);