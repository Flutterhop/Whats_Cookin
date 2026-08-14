///METHODS WITHOUT PLAYER PREFIX ARE USED BY THE PLAYER ENTITY STRUCT

function player_change_state(next_state){
	var state = struct.state_machine.GetStateName(next_state);
	if(not_null(state)){
		struct.state_machine.ChangeState(next_state);
	}else{
		EchoDebug(string_concat("State: ",next_state," not found, returning to idle."));
	}
	
}

function player_queue_state(next_state){
	var state = struct.state_machine.GetStateName(next_state);
	if(not_null(state)){
		struct.state_machine.QueueState(next_state);
	}else{
		EchoDebug(string_concat("State: ",next_state," not found, returning to idle."));
	}
	
}

function get_direction(face_num){
	var direction_text = ""
	if(face_num == 0 or face_num == 1 or face_num == 7){
		direction_text = "right";}
	else if(face_num == 3 or face_num == 4 or face_num == 5){
		direction_text = "left";}
	else if(face_num == 2){
		direction_text = "up";}
	else if(face_num == 6){
		direction_text = "down";}
	return direction_text
}

function player_update_sprites(state){
	var skin_prefix = string_concat("spr_","char");
	if(not_null(state)){
		left_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_left"));
		up_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_up"));
		down_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_down"));
	}
}

function player_return_collision(rect_coords,targets = "",x_pos = 0,y_pos = 0){
	var collisions = ds_list_create();
	if(is_null(targets)){
		targets = struct.target_objects;
	}
	if(x_pos == 0){
		x_pos = x
	}
	if(y_pos == 0){
		y_pos = y
	}
	collision_rectangle_list(x_pos+rect_coords[0],
							y_pos+rect_coords[1],
							x_pos+rect_coords[2],
							y_pos+rect_coords[3],
							targets,
							true,
							true,
							collisions,
							true
							)
	var total_collisions = ds_list_size(collisions);
	if(total_collisions > 0){
		var target = ds_list_find_value(collisions,0);
		return target;
	}
	
}

function player_return_multiple_collisions(rect_coords,targets = "",x_pos = 0,y_pos = 0){
	var collisions = ds_list_create();
	if(is_null(targets)){
		targets = struct.target_objects;
	}
	if(x_pos == 0){
		x_pos = x
	}
	if(y_pos == 0){
		y_pos = y
	}
	collision_rectangle_list(x_pos+rect_coords[0],
							y_pos+rect_coords[1],
							x_pos+rect_coords[2],
							y_pos+rect_coords[3],
							targets,
							true,
							true,
							collisions,
							true
							)
	var total_collisions = ds_list_size(collisions);
	if(total_collisions > 0){
		var collision_array = []
		for(var i = 0;i < total_collisions;i++){
			var list_item = ds_list_find_value(collisions,i);
			if(not_null(list_item)){
				array_push(collision_array,list_item);
			}
		}
		return collision_array;
	}else{
		EchoDebug("no collisions found. returning blank string.");
		return "";
	}
	
}

function get_interact_shape(query_direction,range = 0){
	var range_mod
	if(is_null(range)){
		range_mod = struct.get_stat("interaction_range")
	}else{
		range_mod = range;
	}
	var top_left_x = 0
	var top_left_y = 0
	var bottom_right_x = 0
	var bottom_right_y = 0
	var x_increment = range_mod
	var y_increment = range_mod
	switch(query_direction){
		case dir_face.east://0
			top_left_x += x_increment;
			top_left_y -= y_increment;
			bottom_right_x += x_increment * 2;
			bottom_right_y += y_increment;
		break;
		case dir_face.north_east://1
			top_left_x += x_increment;
			top_left_y -= y_increment * 2;
			bottom_right_x += x_increment * 2;
			bottom_right_y -= y_increment;
		break;
		case dir_face.north://2
			top_left_x -= x_increment;
			top_left_y -= y_increment * 2;
			bottom_right_x += x_increment;
			bottom_right_y -= y_increment;
		break;
		case dir_face.north_west://3
			top_left_x -= x_increment * 2;
			top_left_y -= y_increment * 2;
			bottom_right_x -= x_increment;
			bottom_right_y -= y_increment;
		break;
		case dir_face.west://4
			top_left_x -= x_increment * 2;
			top_left_y -= y_increment;
			bottom_right_x -= x_increment;
			bottom_right_y += y_increment;
		break;
		case dir_face.south_west://5
			top_left_x -= x_increment * 2;
			top_left_y += y_increment;
			bottom_right_x -= x_increment;
			bottom_right_y += y_increment * 2;
		break;
		case dir_face.south://6
			top_left_x -= x_increment;
			top_left_y += y_increment;
			bottom_right_x += x_increment;
			bottom_right_y += y_increment * 2;
		break;
		case dir_face.south_east://7
			top_left_x += x_increment;
			top_left_y += y_increment;
			bottom_right_x += x_increment * 2;
			bottom_right_y += y_increment * 2;
		break;
	}
	var return_coords = [top_left_x,top_left_y,bottom_right_x,bottom_right_y];
	return return_coords
}

function player_detect_interactions(target_entities){
	var return_target
	var rect_coords = get_interact_shape(direction)
	if(is_null(target_entities)){
		return_target = return_collision(rect_coords)
	}else{
		return_target = return_collision(rect_coords,target_entities)
	}
	return return_target;
}

function player_read_interaction_collision(){
	//Determine the type of interaction based on player state.
	//check if the target position is occupied
	var can_put = struct.state_machine.IsInState("hold") ? true : false
	var can_pick = !struct.state_machine.IsInState("hold") ? true : false;
	
	//1. check for environment
	var environment_target = detect_interactions(obj_environment_game);
	if(not_null(environment_target)){
		//Environment entity is blocking interaction
		return;
	}
	// 2. check for structure
	var structure_target = detect_interactions(obj_structure_game);
	if(not_null(structure_target)){
		can_put = structure_target.struct.can_put_item();
		if(can_put and not_null(held_item)){
			structure_target.struct.insert_item(held_item);
			held_item.struct.drop(structure_target.x,structure_target.y);
			struct.state_machine.ChangeState("idle");
			held_item = "";
			return;
		}
		var can_take = structure_target.struct.can_take_item();
		if(can_take and is_null(held_item)){
			var taken_item = structure_target.struct.remove_item();
			if(not_null(taken_item)){
				pick_up_item(taken_item)
				return;
			}			
		}
	}
	var item_target = detect_interactions(obj_item_game);
	if(not_null(item_target) and can_pick){
		pick_up_item(item_target)
	}else if(not_null(held_item) and can_put){
		drop_item(held_item)
	}
}

function player_pick_up_item(target_item){
	if(is_struct(target_item.struct)){
		target_item.struct.pick_up()
		held_item = target_item;
		if(not_null(held_item)){struct.state_machine.ChangeState("hold")}
	}
}

function player_drop_item(){
	if(not_null(held_item)){
		var item_target = detect_interactions(obj_item_game);
		var coords = get_interact_shape(direction)
		if(not_null(item_target)){
			//If collisions exist then we cant place an item
			return
		}
		var x_pos = (coords[0] + coords[2])/2
		var y_pos = (coords[1] + coords[3])/2
		held_item.struct.drop(x + x_pos,y + y_pos);
		held_item = "";
	}
}

function player_throw_item(){
	var strength = struct.stats.throw_strength
	var dir = direction
	with(held_item){
		motion_add(dir,strength);
	}
	held_item.struct.throw_item();
	held_item = "";
	if(is_null(held_item)){struct.state_machine.ChangeState("idle")}
}

function player_read_structure_collision(){
	//Attempt to assemble/deploy a structure
	//check if the target position is occupied
	var can_assemble = struct.state_machine.IsInState("hold") ? false : true
	var can_deploy = struct.state_machine.IsInState("hold") ? true : false
	
	//1. check for environment
	var environment_target = detect_interactions(obj_environment_game);
	if(not_null(environment_target)){
		//Environment entity is blocking interaction
		return;
	}
	// 2. check for structure
	var structure_target = detect_interactions(obj_structure_game);
	// 2a. if found then try to assemble/pick up
	if(not_null(structure_target)){
		can_assemble = structure_target.struct.can_assemble();
		if(can_assemble and is_null(held_structure)){
			assemble_structure(structure_target);
			return;
		}
	}
	// 3. check for item
	// 3a. if true then structure cannot be deployed
	var item_target = detect_interactions(obj_item_game);
	if(is_null(item_target) and can_deploy){
		if(deploy_structure()){
			struct.state_machine.ChangeState("idle");
		}
	}

}

function player_deploy_structure(){
	if(not_null(held_structure)){
		var collisions = ds_list_create()
		var coords = get_interact_shape(direction);
		var targets = [obj_item_game,obj_structure_game]
		with(held_structure){

			collision_rectangle_list(x+coords[0],
									y+coords[1],
									x+coords[2],
									y+coords[3],
									targets,
									true,
									true,
									collisions,
									true
									)
		}
		var total_collisions = ds_list_size(collisions)
		if(total_collisions > 0){
			//If collisions exist then we cant place an item
			return false
		}
		var x_pos = ((coords[0] + x) + (coords[2] + x))/2 
		var y_pos = ((coords[1] + y) + (coords[3] + y))/2
		x_pos /= struct.grid.cell_width
		y_pos /= struct.grid.cell_height
		x_pos = floor(x_pos)
		y_pos = floor(y_pos)
		held_structure.struct.deploy(x_pos,y_pos);
		held_structure = "";
		return true
	}
		
}

function player_assemble_structure(target_structure){
	var coords = get_interact_shape(direction);
	if(is_struct(target_structure.struct)){
		var x_pos = ((coords[0] + x) + (coords[2] + x))/2 
		var y_pos = ((coords[1] + y) + (coords[3] + y))/2
		x_pos /= struct.grid.cell_width
		y_pos /= struct.grid.cell_height
		x_pos = floor(x_pos)
		y_pos = floor(y_pos)
		var x1 = floor(x_pos * struct.grid.cell_width)
		var y1 = floor(y_pos * struct.grid.cell_height)
		target_structure.struct.assemble(x1,y1)
		held_structure = target_structure;
		if(not_null(target_structure)){struct.state_machine.ChangeState("hold")}
	}
}

function player_handle_movement(){
	if(x_speed != 0 or y_speed != 0){
		direction = InputDirection(0,INPUT_CLUSTER.NAVIGATION,struct.player_number);
		if(!movement_locked){
			move_and_collide(x_speed,y_speed,collision_targets,3);
		}
	}else{
		move_and_collide(0,0,collision_targets,3);
	}
	//handle_jumping()
}

function player_apply_knockback(){
	var x_change = lengthdir_x(struct.knockback_amount,struct.knockback_direction);
	var y_change = lengthdir_y(struct.knockback_amount,struct.knockback_direction);
    if(not_null(struct.knockback_amount)){
		move_and_collide(x_change,y_change,collision_targets);
		show_debug_message(struct.knockback_amount)
	}
	if(struct.knockback_amount > .5){
		struct.knockback_amount *= friction_amount
	}else{
		struct.knockback_amount = 0;
	}
}

function player_jump(){
	jumping = true;
}

function player_handle_holding(){
	if(not_null(held_item)){
		held_item.x = x;
		held_item.y = y;
	}
	if(not_null(held_structure)){
		var coords = get_interact_shape(direction);
		var x_pos = x + (coords[0] + coords[2])/2
		var y_pos = y + (coords[1] + coords[3])/2
		held_structure.x = x_pos;
		held_structure.y = y_pos;
	}
	if(is_null(held_item) and is_null(held_structure)){change_state("idle")}
}

function player_handle_jumping(){
	if(jumping){
		if(z_position <= max_height){
			var collisions = move_and_collide(x_speed,y_speed - jump_speed,collision_targets,3)
			if(array_length(collisions) <= 0){
				z_position -= jump_speed;
				move_and_collide(x_speed,y_speed - jump_speed,collision_targets,3)
			}
		}
		if(z_position >= max_height){
			jumping = false;
			falling = true;
			z_position = max_height
		}
	}
	if(falling){
		if(z_position >= 0){

			var collisions = move_and_collide(x_speed,y_speed + fall_speed,collision_targets,3)
			if(array_length(collisions) <= 0){
				z_position += fall_speed;
				move_and_collide(x_speed,y_speed + fall_speed,collision_targets,3)
			}
		}
		if(z_position <= 0){
			falling = false;
			z_position = 0
		}
	}
}

function player_attack_collision(){
	var coords = get_interact_shape(direction,struct.stats.attack_range)
	var collisions = return_multiple_collisions(coords);
	if(not_null(collisions)){
		return collisions
	}
}

function player_reset_input(){
	up_input = 0;
	down_input = 0;
	left_input = 0;
	right_input = 0;
}
	
function player_reset_speed(){
	x_speed = 0;
	y_speed = 0;
}