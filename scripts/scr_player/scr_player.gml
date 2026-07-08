

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
	sprite_var_name = string_concat(struct.direction_facing,"_sprite");
	var skin_prefix = string_concat("spr_","char");
	if(struct.direction_facing == "right"){
		direction_affix = "left"
	}else{
		direction_affix = struct.direction_facing
	}
	return_sprite = asset_get_index(string_concat(skin_prefix,"_",struct.state_machine.state.name,"_",direction_affix));
	sprite_index = return_sprite
}

function player_determine_direction(){
	switch(direction){
		case dir_face.east:struct.direction_facing = "right";break;
		case dir_face.north_east:struct.direction_facing = "right";break;
		case dir_face.north: struct.direction_facing = "up";break;
		case dir_face.north_west:struct.direction_facing = "left";break;
		case dir_face.west:struct.direction_facing = "left";break;
		case dir_face.south_west:struct.direction_facing = "left"break;
		case dir_face.south:struct.direction_facing = "down"break;
		case dir_face.south_east:struct.direction_facing = "right"break;
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

function player_read_interaction_collision(){
	var target = detect_interaction(obj_item_entity);
	if(not_null(target)){
		pick_up_item(target)
	}
}

function player_pick_up_item(target_item){
	if(is_struct(target_item.struct)){
		target_item.struct.pick_up()
		held_item = target_item;
	}
}

function player_drop_item(){
	if(not_null(held_item)){
		var x_pos = 0
		var y_pos = 0
		var increment = 15
		switch(direction){
			case dir_face.east:x_pos += increment;y_pos += 0;break;
			case dir_face.north_east:x_pos += increment;y_pos -= increment;break;
			case dir_face.north:x_pos += 0;y_pos -= increment;break;
			case dir_face.north_west:x_pos -= increment;y_pos -= increment;break;
			case dir_face.west:x_pos -= increment;y_pos += 0;break;
			case dir_face.south_west:x_pos -= increment;y_pos += increment;break;
			case dir_face.south:x_pos += 0;y_pos += increment;break;
			case dir_face.south_east:x_pos += increment;y_pos += increment;break;
		}
		var collisions = ds_list_create()
		var targets = [obj_item_entity]
		collision_rectangle_list(top_left_x,
								top_left_y,
								bottom_right_x,
								bottom_right_y,
								targets,
								true,
								true,
								collisions,
								true
								)
		var total_collisions = ds_list_size(collisions)
		if(total_collisions > 0){
			var target = ds_list_find_value(collisions,0);
			pick_up_item(target)
		}
			held_item.struct.drop(x_pos,y_pos);
			held_item = "";
		}
}

function player_handle_held_item(){
	if(not_null(held_item)){
		held_item.x = x;
		held_item.y = y;
	}
}

function player_detect_interactions(target_entities){
	var top_left_x
	var top_left_y
	var bottom_right_x
	var bottom_right_y
	var x_increment = 10
	var y_increment = 15
	switch(direction){
		case dir_face.east:x_pos += increment;y_pos += 0;break;
		case dir_face.north_east:x_pos += increment;y_pos -= increment;break;
		case dir_face.north:x_pos += 0;y_pos -= increment;break;
		case dir_face.north_west:x_pos -= increment;y_pos -= increment;break;
		case dir_face.west:x_pos -= increment;y_pos += 0;break;
		case dir_face.south_west:x_pos -= increment;y_pos += increment;break;
		case dir_face.south:x_pos += 0;y_pos += increment;break;
		case dir_face.south_east:x_pos += increment;y_pos += increment;break;
	}
	switch(struct.direction_facing){
		case "up":
			top_left_x = x - x_increment
			top_left_y = y - y_increment
			bottom_right_x = x + x_increment
			bottom_right_y = y
		break;
		case "down":
			top_left_x = x - x_increment
			top_left_y = y
			bottom_right_x = x + x_increment
			bottom_right_y = y + y_increment
		break;
		case "left":
			top_left_x = x - x_increment
			top_left_y = y - y_increment
			bottom_right_x = x
			bottom_right_y = y + y_increment
		break;
		case "right":
			top_left_x = x
			top_left_y = y - y_increment
			bottom_right_x = x + x_increment
			bottom_right_y = y + y_increment
		break;
	}
	var collisions = ds_list_create()
	var targets = target_entities
	collision_rectangle_list(top_left_x,
							top_left_y,
							bottom_right_x,
							bottom_right_y,
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