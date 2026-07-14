///METHODS WITHOUT PLAYER PREFIX ARE USED BY THE PLAYER ENTITY STRUCT
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

function player_determine_sprite(){
	var return_sprite
	var sprite_var_name
	var direction_affix = "left"
	determine_direction();
	sprite_var_name = string_concat(direction_facing,"_sprite");
	var skin_prefix = string_concat("spr_","char");
	if(direction_facing == "right"){
		direction_affix = "left"
	}else{
		direction_affix = direction_facing
	}
	return_sprite = asset_get_index(string_concat(skin_prefix,"_",struct.state_machine.state.name,"_",direction_affix));
	sprite_index = return_sprite
}

function player_determine_direction(){
	switch(direction){
		case dir_face.east:direction_facing = "right";break;
		case dir_face.north_east:direction_facing = "right";break;
		case dir_face.north: direction_facing = "up";break;
		case dir_face.north_west:direction_facing = "left";break;
		case dir_face.west:direction_facing = "left";break;
		case dir_face.south_west:direction_facing = "left"break;
		case dir_face.south:direction_facing = "down"break;
		case dir_face.south_east:direction_facing = "right"break;
	}
}
	
function player_update_sprites(state){
	var skin_prefix = string_concat("spr_","char");
	if(not_null(state)){
		left_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_left"));
		up_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_up"));
		down_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_down"));
	}
}
	
function player_detect_interactions(target_entities){
	var rect_coords = get_interact_shape(direction)
	var collisions = ds_list_create()
	var targets = target_entities
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

function get_interact_shape(query_direction){
	var top_left_x = 0
	var top_left_y = 0
	var bottom_right_x = 0
	var bottom_right_y = 0
	var x_increment = 15
	var y_increment = 15
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

function player_read_interaction_collision(){
	//Determine the type of interaction based on player state.
	//check if the target position is occupied
	var can_put = struct.state_machine.IsInState("hold") ? true : false
	var can_pick = !struct.state_machine.IsInState("hold") ? true : false;
	
	//1. check for environment
	var environment_target = detect_interactions(obj_environment_entity);
	if(not_null(environment_target)){
		//Environment entity is blocking interaction
		return;
	}
	// 2. check for structure
	var structure_target = detect_interactions(obj_structure_entity);
	if(not_null(structure_target)){
		can_put = structure_target.struct.can_put_item();
		if(can_put and not_null(held_item)){
			structure_target.struct.insert_item(held_item);
			struct.state_machine.ChangeState("idle");
			held_item.struct.drop(structure_target.x,structure_target.y);
			held_item = "";
			return;
		}
		var can_take = structure_target.struct.can_take_item();
		if(can_take and is_null(held_item)){
			var taken_item = structure_target.struct.remove_item();
			if(not_null(taken_item)){
				pick_up_item(taken_item)
			}
			
			
		}
	}
	var item_target = detect_interactions(obj_item_entity);
	if(not_null(item_target) and can_pick){
		pick_up_item(item_target)
	}else if(not_null(held_item and can_put)){
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
		var collisions = ds_list_create()
		var coords = get_interact_shape(direction);
		var targets = [obj_item_entity]
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
		var total_collisions = ds_list_size(collisions)
		if(total_collisions > 0){
			//If collisions exist then we cant place an item
			return
		}
		var x_pos = (coords[0] + coords[2])/2 
		var y_pos = (coords[1] + coords[3])/2 
		held_item.struct.drop(x + x_pos,y + y_pos);
		held_item = "";
		if(is_null(held_item)){struct.state_machine.ChangeState("idle")}
	}
		
}

function player_read_structure_collision(){
	//Attempt to assemble/deploy a structure
	//check if the target position is occupied
	var can_assemble = struct.state_machine.IsInState("hold") ? false : true
	var can_deploy = struct.state_machine.IsInState("hold") ? true : false
	
	//1. check for environment
	var environment_target = detect_interactions(obj_environment_entity);
	if(not_null(environment_target)){
		//Environment entity is blocking interaction
		return;
	}
	// 2. check for structure
	var structure_target = detect_interactions(obj_structure_entity);
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
	var item_target = detect_interactions(obj_item_entity);
	if(is_null(item_target) and can_deploy){
		deploy_structure();
		struct.state_machine.ChangeState("idle");
	}

}

function player_deploy_structure(){
	if(not_null(held_structure)){
		var collisions = ds_list_create()
		var coords = get_interact_shape(direction);
		var targets = [obj_item_entity,obj_structure_entity]
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
			return
		}
		var x_pos = (coords[0] + coords[2])/2 
		var y_pos = (coords[1] + coords[3])/2 
		held_structure.struct.deploy(x + x_pos,y + y_pos);
		held_structure = "";
	}
		
}

function player_assemble_structure(target_structure){
	if(is_struct(target_structure.struct)){
		target_structure.struct.assemble()
		held_structure = target_structure;
		if(not_null(target_structure)){struct.state_machine.ChangeState("hold")}
	}
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
}


