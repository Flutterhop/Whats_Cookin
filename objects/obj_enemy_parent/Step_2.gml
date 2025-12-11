try{
	if(core_find_bombs()){
		if(not_null(target_player) && instance_exists(target_player)){
			var type = target_player.object_index;
			if(type != obj_player_entity){
				return;
			}
			var temp_target = find_lure_bombs(x,y);
			if(not_null(temp_target) && instance_exists(temp_target)){
				target_player = temp_target;
			}
		}
	}
}catch(_exception){
	show_debug_message(_exception.message);
	show_debug_message(_exception.longMessage);
	show_debug_message(_exception.script);
	show_debug_message(_exception.stacktrace);
}