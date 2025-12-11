/// @description Insert description here

//TODO make bullet trail effect.
draw_set_alpha(.3);
//draw_circle_color(x + sprite_width / 2,y + sprite_height / 2,3,c_purple,c_purple,false);
draw_set_alpha(1);
draw_self();
draw_sprite_ext(sprite_index,0,x + trail_x ,y + trail_y,1,1,0,c_white,.5);
draw_sprite_ext(sprite_index,0,x + trail_x_2 ,y + trail_y_2 ,1,1,0,c_white,.2);
draw_set_alpha(1);