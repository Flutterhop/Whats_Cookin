event_user(EV_INIT);
event_user(EV_METHOD_BINDING);


function pause_button_action(){
	set_input_player(global._users[setting].player_data);
}


function bind_button_draw(){
	if(active){
		draw_set_alpha(alpha_value);
		draw_rectangle_color(x - 105,y - text_h /1.8,x + 100,(y + 5) + text_h / 1.8,c_white,c_white,c_white,c_white,false);	
		draw_set_alpha(alpha_max);
		draw_sprite_ext(spr_arrow_small_left,0,(x + 53),y - text_h /2,1,1,0,c_white,1);
		draw_sprite_ext(spr_arrow_small_right,0,(x + 80),y - text_h /2,1,1,0,c_white,1);

	}
	
	scribble(string_concat("[fnt_arcade]",button_text)).scale(text_size_mod).draw(x - 100,y)
	scribble(string_concat("[fnt_arcade]",setting)).scale(text_size_mod).draw(x + 70,y)

}