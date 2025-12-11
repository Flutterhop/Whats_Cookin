/// @description Insert description here
// You can write your code in this editor
if(global.debug_setting == debug_type.enemy_debug && _debug_listener.display_spawn_menu){
	if(pop_in){
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_set_color(c_white);
		if(active){sprite_index = active_sprite}else{sprite_index = inactive_sprite}
		draw_self();
		draw_sprite_ext(object_get_sprite(preview_object),0,x + sprite_width / 2, y + sprite_height / 2,.5,.5,0,c_white,1);
		draw_text_color(x + sprite_width - x_buffer,y + sprite_height - y_buffer,number_of_enemies,c_white,c_white,c_white,c_white,1);
	}
}else{

}
