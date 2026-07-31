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
		//select the closest target to navigate to
		
		var _target = find_priority_target();

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
			if(not_null(target)){
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
	
function npc_read_attack_collision(){
	var rect_coords = get_interact_shape(direction);
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

function npc_get_interact_shape(query_direction){
	var top_left_x = 0
	var top_left_y = 0
	var bottom_right_x = 0
	var bottom_right_y = 0
	var x_increment = struct.attack_range
	var y_increment = struct.attack_range
	switch(query_direction){
		case "right"://0
			top_left_x += x_increment;
			top_left_y -= y_increment;
			bottom_right_x += x_increment * 2;
			bottom_right_y += y_increment;
		break;

		case "up":
			top_left_x -= x_increment;
			top_left_y -= y_increment * 2;
			bottom_right_x += x_increment;
			bottom_right_y -= y_increment;
		break;
		case "left":
			top_left_x -= x_increment * 2;
			top_left_y -= y_increment;
			bottom_right_x -= x_increment;
			bottom_right_y += y_increment;
		break;
		case "down"://6
			top_left_x -= x_increment;
			top_left_y += y_increment;
			bottom_right_x += x_increment;
			bottom_right_y += y_increment * 2;
		break;
	}
	var return_coords = [top_left_x,top_left_y,bottom_right_x,bottom_right_y];
	return return_coords
}