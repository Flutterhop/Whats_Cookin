/// @description Insert description here
// You can write your code in this editor
if(live_call()){return live_result}
draw_flush();
draw_self();
draw_set_font(fnt_arcade);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
text_w = string_width(button_text);
text_h = string_height(button_text);
text_w = text_w * text_size_mod;
text_h = text_h * text_size_mod;

if(always_display){
	bind_button_draw();
}else{
	if(is_gamepad && manager.pause_menu_state == pause_state.controller_menu && InputPlayerGetDevice(player.player_number) == 0){
		bind_button_draw();
	}else if(!is_gamepad && manager.pause_menu_state == pause_state.keyboard_menu && InputPlayerGetDevice(player.player_number) == -1){
		bind_button_draw();
	}
}





