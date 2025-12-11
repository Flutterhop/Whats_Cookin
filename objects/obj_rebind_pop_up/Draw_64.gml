if(live_call())return live_result;
depth = -100;
if(not_null(message_struct.window)){
	draw_sprite_ext(message_struct.window,0,x,y,1,1,0,c_white,1);
	scribble(string_concat("[fnt_Retro]",message_struct.alert_message)).draw(x - string_width(message_struct.alert_message) / 2
																			,y - string_height(message_struct.alert_message) )
}
if(not_null(message_struct.input_options)){
	if(array_length(message_struct.input_options) > 0){
		for(var i = 0;i < array_length(message_struct.input_options);i++){
			var x_pos = x - (sprite_get_width(message_struct.window) / 6) + (i * 50);
			var y_pos = y + sprite_get_height(message_struct.window) / 6;
			draw_sprite_ext(message_struct.button_sprite,0,x_pos,y_pos,1,1,0,c_white,1);
			if(not_null(message_struct.button_sprite)){
				var button_x = x_pos - 12;
				var button_y = y_pos - 5;
				scribble(string_concat( "[fnt_Retro_small]",message_struct.input_options[i])).wrap(sprite_get_width(message_struct.window),sprite_get_height(message_struct.window),false).draw(button_x,button_y);
				if(selection = i){
					draw_set_color(c_white);
					draw_set_alpha(.3);
					draw_rectangle(x_pos - sprite_get_width(message_struct.button_sprite) / 3.1,
									y_pos - sprite_get_height(message_struct.button_sprite) / 6.7,
									x_pos + sprite_get_width(message_struct.button_sprite) / 3.3,
									y_pos + sprite_get_height(message_struct.button_sprite) / 7.2,
									false);
					draw_set_alpha(1);
				}
			}
		}
	}else{
		///
	}
}