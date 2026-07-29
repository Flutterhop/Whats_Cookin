enum npc_size{
	small,
	medium,
	large,
	biiiiiiiiig
}

function npc_determine_sprite(action = ""){
	
}

function npc_handle_pathfinding(){
	//1. Does the npc have a target?
	//1a. If so then we need to check whether a path to that objective exists\
	//1b. If not then we can wander until a target becomes available or until the npc despawns.
	//2.
	try{
		//select the closest target to navigate to
		var target = find_priority_target();
		//If no path exists then we should create one.
		if(path_index == -1){
			if(path_position >= .99 || path_position == 0){
				//If the path position is not complete aka not one nor zero, then we start a path.
				//target is determined by struct data
				var target_x = target.x;
				var target_y = target.y;
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
			var target = point_distance(target_x,target_y,target.x,target.y)
			///If too far away then recalculate the path.
			if(target > 150){
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

function find_priority_target(){
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