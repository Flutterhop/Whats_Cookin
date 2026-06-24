function Player_Entity(new_player_number = 0,new_move_speed, new_name,new_type,new_health,new_invincible,new_object_reference) : Character_Entity (new_move_speed, new_name,new_type,new_health,new_invincible,new_object_reference) constructor {
	player_number = new_player_number;
	face = dir_face.south / 45;
	direction_facing = get_direction(face);
	player_state = "idle"


	static init_state_machine = function(){
		state_machine = new Statement(instance)
		var idle_state = new StatementState(state_machine,"idle")
			.AddEnter(function(){
				image_index = 0
			})
			.AddUpdate(function(){
				direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION,player_number);
				motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0) * move_speed);
				determine_sprite();
				handle_held_item();
	
				if(speed > 0){
					state_machine.ChangeState("move")
				}
		});	
		var move_state = new StatementState(state_machine,"move")
			.AddEnter(function(){
			
			})
			.AddUpdate(function(){
				direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION,player_number);
				motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0) * move_speed);
				move_wrap(true,true,sprite_width);
				if(speed > 0 && speed < 1){image_index++}else{image_speed = speed;}
				if(speed == 0){
					state_machine.ChangeState("idle")
				}
				determine_sprite();
				handle_held_item();
				update_sprites();

		});

		state_machine
		.AddState(idle_state)
		.AddState(move_state)

		state_machine.ChangeState("idle")

	}
}

///METHODS WITHOUT PLAYER PREFIX ARE USED BY THE PLAYER ENTITY STRUCT
function get_direction(face_num){
	if(face_num == 0 or face_num == 1 or face_num == 7){direction_facing = "right";}
	else if(face_num == 3 or face_num == 4 or face_num == 5){direction_facing = "left";}
	else if(face_num == 2){direction_facing = "up";}
	else if(face_num == 6){direction_facing = "down";}
}

function player_determine_sprite(){
	update_sprites(player_state)
	
	var return_sprite
	var sprite_var_name
	
	sprite_var_name = string_concat(struct.direction_facing,"_sprite");
	return_sprite = variable_instance_get(self,sprite_var_name);
}


function player_update_sprites(state){
	var skin_prefix = string_concat("spr_","char");
	if(not_null(held_item)){
		left_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_left"));
		up_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_up"));
		down_sprite = asset_get_index(string_concat(skin_prefix,"_",state,"_down"));
	}
}

function player_read_interaction_collision(){
	//If weapon is active, create a collision box to read for valid hits
	var top_left_x
	var top_left_y
	var bottom_right_x
	var bottom_right_y
	switch(struct.direction_facing){
		case "up":
			top_left_x = x - 7
			top_left_y = y - 25
			bottom_right_x = x + 7 
			top_left_x = x - 10
			top_left_y = y - 40
			bottom_right_x = x + 10 
			bottom_right_y = y
		break;
		case "down":
			top_left_x = x - 7
			top_left_x = x - 10
			top_left_y = y
			bottom_right_x = x + 7
			bottom_right_y = y + 25
			bottom_right_x = x + 10
			bottom_right_y = y + 40
		break;
		case "left":
			top_left_x = x - 25
			top_left_y = y - 7
			top_left_x = x - 40
			top_left_y = y - 10
			bottom_right_x = x
			bottom_right_y = y + 7 
			bottom_right_y = y + 10 
		break;
		case "right":
			top_left_x = x
			top_left_y = y - 7
			bottom_right_x = x + 25
			bottom_right_y = y + 7
			top_left_y = y - 10
			bottom_right_x = x + 40
			bottom_right_y = y + 10
		break;
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
}

function player_pick_up_item(target_item){
	if(is_struct(target_item.item_struct)){
		target_item.item_struct.pick_up()
		held_item = target_item;
	}
}

function player_drop_item(){
	if(not_null(held_item)){
		held_item.item_struct.drop();
		held_item = "";
	}
}

function player_handle_held_item(){
	if(not_null(held_item)){
		held_item.x = x;
		held_item.y = y;
	}
}