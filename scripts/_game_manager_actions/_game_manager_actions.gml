function game_manager_input_action_1_pressed(player){
	if (room == rm_Arena && global.game_state == active_game){
		if(not_null(active_spawn_manager)){
			if((instance_exists(active_spawn_manager)) && global.game_state != game_over){
				if (active_spawn_manager.ready_to_shop == true ) {
					end_match();
					active_spawn_manager.round_state = "inactive";
					active_spawn_manager.ready_to_shop = false;
				}
			}else if(global.game_state == game_over){
				quit_game();
			}
		}
	}else if(global.game_state == game_over){
		quit_game();
	}
}
