/// @description When game state is Game Over show text.
try{
	if(live_call())return live_result;
	if(room == rm_Arena){
		if(global.game_state == game_over){
			scribble("Game Over!").starting_format("fnt_Retro",c_white).align(fa_center,fa_middle).draw(get_screen_center_x(),get_screen_center_y() - 60);
			scribble("Press [input_icon,4,0] to continue.").align(fa_center,fa_middle).starting_format("fnt_Retro",c_white).draw(get_screen_center_x(),get_screen_center_y() - 30);	

		}else{
			if(not_null(active_spawn_manager)){

				with(active_spawn_manager){
					if(round_state == "round_won"){
						if(y_offset > 0){
							var shake = irandom_range(-1, 1);
							
							scribble(string(current_value)).starting_format("main_sm",c_white).align(fa_center,fa_middle).blend(merge_color(c_white, make_color_rgb(135, 83, 204), color_blend),alpha).outline(c_white,1).draw(get_screen_center_x() + shake,room_height - 160 - y_offset);
						}else{
							// Flash effect when the number reaches the target
						    var flash_alpha = (abs(sin(current_time * .002)) * 255);
							
						    scribble(string(current_value)).starting_format("main",c_white).blend(make_color_rgb(180, 0, 255),flash_alpha / 255).align(fa_center,fa_middle).scale(1.5).outline(c_white,1).draw(get_screen_center_x(),room_height - 160);
							
						}
					    scribble("Round Cleared!").starting_format("main",c_white).align(fa_center,fa_middle).outline(c_black,1).draw(get_screen_center_x(),get_screen_center_y() - 50);
						if(ready_to_shop){
							scribble("Press [input_icon,4,0] to continue.").align(fa_center,fa_middle).starting_format("main",c_white).draw(get_screen_center_x(),get_screen_center_y());	
						}
					}
				}
				scribble("Prize: " + string(bet_value)).starting_format("main_sm",c_white).align(fa_left,fa_top).draw(2,2);
				scribble("Round: " + string(game_round)).starting_format("main",c_white).align(fa_left,fa_bottom).draw(1, room_height + 1);
			}
		}
	}
}catch(_exception){
	show_debug_message(_exception.message);
	show_debug_message(_exception.longMessage);
	show_debug_message(_exception.script);
	show_debug_message(_exception.stacktrace);
}

