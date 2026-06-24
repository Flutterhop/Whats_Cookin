if(room != _display_init){
	event_inherited();

	if((instance_number(obj_bug_player_entity) == 0) && (room == rm_Arena || room == rm_Arena_02) && check_player_status() && global.game_state == active_game){
		spawn_players();
		track_players();
	}
	if((is_null(active_spawn_manager) || !instance_exists(active_spawn_manager)) && room == rm_Arena && global.game_state != game_over){
		active_spawn_manager = create_if_none(obj_spawn_manager,"System",0,0);
	}
	if(time_to_spawn_medkit > 0 && activate_medkit){
		if(medkit_timer < time_to_spawn_medkit){
			medkit_timer += delta_time / 1_000_000;
		}else if(medkit_timer >= time_to_spawn_medkit){
			generate_medkit();
			medkit_timer = 0;
		}
	}
}