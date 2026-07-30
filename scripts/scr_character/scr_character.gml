enum Character_Type{
	CH_NPC = 20,
	CH_ENEMY_NPC = 21,
	CH_PLAYER = 22
}


function determine_direction(_direction){
	var direction_to_return = "left"
	var is_right = (_direction <= 45) and (_direction <= 315)
	var is_up = (_direction > 45) and (_direction < 135)
	var is_left = (_direction >= 135) and (_direction <= 225)
	var is_down = (_direction > 225) and (_direction < 315)
	switch(true){
		case is_right: 
			direction_to_return = "right";
		break;
		case is_up: 
			direction_to_return = "up";
		break;
		case is_left: 
			direction_to_return = "left";
		break;
		case is_down: 
			direction_to_return = "down";
		break;
	}
	return direction_to_return
}

function determine_sprite(equipment = "",action = ""){
	var return_sprite
	var state_to_use
	var sprite_var_name
	var direction_affix = "left"
	direction_facing = determine_direction(direction);
	var is_moving = struct.state_machine.state.name == "move" or struct.state_machine.state.name == "wander"
	if(direction_facing == "right"){
		direction_affix = "left";
	}else{
		direction_affix = direction_facing;
	}
	
	sprite_var_name = string_concat(direction_facing,"_sprite");
	var skin_prefix = string_concat("spr_",struct.character_name);
	
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