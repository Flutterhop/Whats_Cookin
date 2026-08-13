enum npc_size{
	small,
	medium,
	large,
	biiiiiiiiig
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
		var _move_speed = struct.get_stat("move_speed")
		//select the closest target to navigate to
		
		target = find_priority_target();

		//If no path exists then we should create one.
		if(path_index == -1){
			if((path_position >= .99 || path_position < 1)){
				if(is_wandering or is_null(target)){
					// target should be a random location nearby depending on how far 
					// the NPC is allowed to travel during a movement interval.
					target_x = irandom_range(-wander_distance,wander_distance);
					target_y = irandom_range(-wander_distance,wander_distance);
					if(struct.grid.set_path(path,x,y,x + target_x,y + target_y,_move_speed)){
						path_start(path,_move_speed,path_action_stop,true);
					}
					return;
				}
				//If the path position is not complete aka not one nor zero, then we start a path.
				//target is determined by struct data
				target_x = target.x;
				target_y = target.y;
				if(point_distance(target_x,target_y,x,y) > 30){
					if(struct.grid.set_path(path,x,y,target_x,target_y,_move_speed)){
						path_start(path,_move_speed,path_action_stop,true);
					}
				}
			}

		}else{
			if(not_null(target)){
				// Path exists so we need to check if the path needs to be 
				// recalculated based on the distance to the target.
				var target_x = path_get_point_x(path_index,path_get_number(path_index) - 1);
				var target_y = path_get_point_y(path_index,path_get_number(path_index) - 1);
				var target_distance = point_distance(target_x,target_y,target.x,target.y)
				///If too far away then recalculate the path.
				if(target_distance > 150){
					show_debug_message("target too far from end of path. Recalculating...")
					if(struct.grid.set_path(path,x,y,target.x,target.y,_move_speed)){
						path_start(path,_move_speed,path_action_stop,true);
						//var path_pos = path.path_position;
					}
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
			var current_target = instance_nearest(x,y,struct.target_objects[i]);
			if(current_target.struct.state_machine.IsInState("dead")){break;}
			current_distance = point_distance(current_target.x,current_target.y,x,y);
			if(current_distance < previous_distance){
				prime_target = current_target;
			}
			if(is_null(prime_target)){
				prime_target = current_target;
			}
			previous_distance = current_distance;
		}
	}
	
	return prime_target;
}

function npc_manage_movement(){
	//var has_moved = (xprevious != x) or(yprevious != y);
	var x_pos = 0
	var y_pos = 0
	if(not_null(target)){
		x_pos = target.x;
		y_pos = target.y;
		direction = point_direction(x_pos,y_pos,x,y);
	}
	
	//if(has_moved){
		//direction = point_direction(xprevious,yprevious,x,y);
	//}
}
	
function npc_read_attack_collision(){
	var rect_coords = get_interact_shape(direction_facing);
	var collisions = ds_list_create();
	var targets = struct.target_objects;
	collision_rectangle_list(x+rect_coords[0],
							y+rect_coords[1],
							x+rect_coords[2],
							y+rect_coords[3],
							targets,
							true,
							true,
							collisions,
							true
							)
	var total_collisions = ds_list_size(collisions)
	if(total_collisions > 0){
		var target = ds_list_find_value(collisions,0);
		return target;
	}
}

function npc_is_near_target(){
	if(not_null(target)){
		var target_distance = point_distance(target.x,target.y,x,y);
		if(target_distance < target_range){
			//Within range so we return true
			return true
		}else{
			return false
		}
	}else{
		//No target so return false
		return false
	}
}

function npc_apply_knockback(){
	var x_change = lengthdir_x(struct.knockback_amount,struct.knockback_direction);
	var y_change = lengthdir_y(struct.knockback_amount,struct.knockback_direction);
    if(not_null(struct.knockback_amount)){
		move_and_collide(x_change,y_change,collision_targets);		
	}
	if(struct.knockback_amount > 1){
		struct.knockback_amount *= friction_amount
		show_debug_message(struct.knockback_amount)
	}else{
		struct.knockback_amount = 0;
	}
}
	
/////////////////////////////////////////////TIMER METHODS////////////////////////////////////////////////
		
function npc_get_active_timers(){
	var num_of_active_timers = 0;
	if(time_source_get_state(idle_timer) == time_source_state_active){
		num_of_active_timers++;
	}
	if(time_source_get_state(attack_windup_timer) == time_source_state_active){
		num_of_active_timers++;
	}
	if(time_source_get_state(attack_timer) == time_source_state_active){
		num_of_active_timers++;
	}
	return num_of_active_timers;
}		

function npc_idle_complete(){
	struct.state_machine.EnsureState(active_state);
}

function npc_attack_windup_complete(){
	struct.state_machine.EnsureState("attack");
}

function npc_attack_complete(){
	struct.state_machine.EnsureState(default_state);
}
	
function npc_knockback_complete(){
	struct.state_machine.EnsureState(default_state);
}

function npc_stun_complete(){
	struct.state_machine.EnsureState(default_state);
}