enum npc_size{
	small,
	medium,
	large,
	biiiiiiiiig
}

function npc_determine_sprite(action = "",equipment = ""){
	var return_sprite
	var state_to_use
	var sprite_var_name
	var direction_affix = "left"
	var is_moving = struct.state_machine.state.name == "move" or struct.state_machine.state.name == "wander"
	direction_facing = determine_direction(direction);
	sprite_var_name = string_concat(direction_facing,"_sprite");
	var skin_prefix = string_concat("spr_",struct.name);

	if(not_null(equipment)){
		direction_affix = string_concat(equipment,"_",direction_affix);
	}
	if(not_null(action)){
		direction_affix = string_concat(action,"_",direction_affix);
	}
	if(is_moving){
		state_to_use = "idle";
	}else{
		state_to_use = struct.state_machine.state.name
	}
	var asset_name = string_concat(skin_prefix,"_",state_to_use,"_",direction_affix);
	return_sprite = asset_get_index(asset_name);
	if(not_null(return_sprite)){
		sprite_index = return_sprite
	}else{
		sprite_index = spr_item_placeholder
	}
}

function npc_handle_pathfinding(){
	//1. Does the npc have a target?
	//1a. If so then we need to check whether a path to that objective exists
	//1b. If not then we can wander until a target becomes available or until the npc despawns.
	//2.
	try{
		var is_wandering = struct.state_machine.IsInState("wander") ? true : false
		var target_x = 0;
		var target_y = 0;
		//select the closest target to navigate to
		var target = find_priority_target();

		//If no path exists then we should create one.
		if(path_index == -1){
			if(path_position >= .99 || path_position == 0){
				if(is_wandering or is_null(target)){
					// target should be a random location nearby depending on how far 
					// the NPC is allowed to travel during a movement interval.
					target_x = irandom_range(-wander_distance,wander_distance);
					target_y = irandom_range(-wander_distance,wander_distance);
					if(struct.grid.set_path(path,x,y,x + target_x,y + target_y,struct.move_speed)){
						path_start(path,struct.move_speed,path_action_stop,true);
					}
					return;
				}
				//If the path position is not complete aka not one nor zero, then we start a path.
				//target is determined by struct data
				target_x = target.x;
				target_y = target.y;
				if(point_distance(target_x,target_y,x,y) > 30){
					if(struct.grid.set_path(path,x,y,target_x,target_y,struct.move_speed)){
						path_start(path,struct.move_speed,path_action_stop,true);
					}
				}
			}

		}else{
			// Path exists so we need to check if the path needs to be 
			// recalculated based on the distance to the target.
			var target_x = path_get_point_x(path_index,path_get_number(path_index) - 1);
			var target_y = path_get_point_y(path_index,path_get_number(path_index) - 1);
			var target_distance = point_distance(target_x,target_y,target.x,target.y)
			///If too far away then recalculate the path.
			if(target_distance > 150){
				show_debug_message("target too far from end of path. Recalculating...")
				if(struct.grid.set_path(path,x,y,target.x,target.y,struct.move_speed)){
					path_start(path,struct.move_speed,path_action_stop,true);
					//var path_pos = path.path_position;
				}
			}
		}
	}catch(_exception){
		show_debug_message(_exception.message);
		show_debug_message(_exception.longMessage);
		show_debug_message(_exception.script);
		show_debug_message(_exception.stacktrace);
	}
}

function npc_find_priority_target(){
	var target_num = array_length(struct.target_objects);
	var prime_target = ""
	var current_distance = 0;
	var previous_distance = 0;
	if(target_num > 0){
		for(var i = 0; i < target_num;i++){
			// If the number of targets is greater than one then we need to do some
			// prioritizing. For simplicity we will work with distance.
			var current_target = instance_nearest(x,y,target_num[i]);
			current_distance = point_distance(current_target.x,current_target.y,x,y);
			if(current_distance < previous_distance){
				prime_target = current_target;
			}
			previous_distance = current_distance;		
		}
	}
	
	return prime_target;
}

function npc_idle_complete(){
	if(not_null(active_state)){
		struct.state_machine.ChangeState(active_state);
	}
}

function npc_manage_movement(){
	var has_moved = (xprevious != x) or(yprevious != y);
	if(has_moved){
		direction = point_direction(xprevious,yprevious,x,y);
	}
}