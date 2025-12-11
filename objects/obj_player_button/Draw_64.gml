

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_Retro_small);
if(active && !is_ready && !is_active){
	blink_timer--;
		if(blink_timer > 0){
			draw_set_color(#ced9d0);
			draw_set_font(fnt_Retro_small);
			draw_set_halign(fa_center);
			draw_text_ext_transformed(x,y + sprite_height,"Press Any Button",20,50,.7,.7,0);
		}
		if(blink_timer == -30){
			blink_timer = 60;
		}
				
}
if(global.debug && global.debug_setting == debug_type.player_debug){
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_Retro_small);
	draw_text_ext_transformed(x + 20,y + sprite_height,"active:",20,200,.7,.7,0);
	draw_text_ext_transformed(x + 20,y + sprite_height * 1.5,active? "true" : "false",20,200,.7,.7,0);
	draw_text_ext_transformed(x + 20,y + sprite_height * 2.0,"is active:",20,200,.7,.7,0);
	draw_text_ext_transformed(x + 20,y + sprite_height * 2.5,is_active? "true" : "false",20,200,.7,.7,0);
	draw_text_ext_transformed(x + 20,y + sprite_height * 3.0,"is ready:",20,200,.7,.7,0);
	draw_text_ext_transformed(x + 20,y + sprite_height * 3.5,is_ready? "true" : "false",20,200,.7,.7,0);
	draw_text_ext_transformed(x + 20, y + sprite_height * 4.0,"palette_index " + string(player.palette_index),20,200,.7,.7,0);
}
if(is_active && player != 0 && player_sprite != ""){
	pal_swap_set(player.character.palette,player.palette_index,false);
	draw_sprite(player_sprite,0,anchor_point_x,anchor_point_y);
	pal_swap_reset();
}else{
	
}
if(is_active && !is_ready && active){
	draw_set_color(#30a455);
	draw_set_halign(fa_center);
	draw_set_font(fnt_Retro_small);
	draw_text(x,y + sprite_height,"Select");
	draw_sprite(arrow_left_sprite,0,anchor_point_x - sprite_width, anchor_point_y - 5);
	draw_sprite(arrow_right_sprite,0,anchor_point_x + 10, anchor_point_y - 5);
}else{

}
if(is_active && is_ready){
	draw_set_color(#30a455);
	draw_set_halign(fa_center);
	draw_set_font(fnt_Retro_small);
	draw_text(x,y + sprite_height,"READY!");
}else{
	
}