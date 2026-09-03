function determine_direction_facing(_direction){
	var direction_to_return = "left"
	var is_right = ((_direction >= 315) and (_direction <= 360)) or ((_direction <= 45) and (_direction >= 0))
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
	
function determine_direction(_target){
	var direction_to_return = 0;
	if(not_null(_target)){
		direction_to_return = point_direction(x,y,_target.x,_target.y);
	}
	return direction_to_return
}


function determine_sprite(equipment = "",action = ""){
	// Determining the sprite for every type of character entity is tough.
	// Let's take this one step at a time.
	var return_sprite
	var state_to_use
	var sprite_var_name
	var direction_affix = "left"
	
	// Movement states require use of the "move" sprites that characters have.
	// However we do not want to use the strings for every type of movement state.
	// Since move_state, chase_state, and wander_state are different but call for the same sprite,
	// there needs to be a clause to catch this info and use the move sprite if any of them match.
	var is_moving = is_movement_state(struct.state_machine.state.name);
	// Attack sprites for npcs will sometimes have no direction applied to them. Having a var
	// to track whether the current state is attack will help for checks later.
	var is_attacking = struct.state_machine.state.name == "attack" or struct.state_machine.state.name == "attackwindup"
	// Idle sprite is sometimes the only sprite an NPC needs! Tracking it with a var will be used later.
	var is_idle = struct.state_machine.state.name == "idle"
    
    var is_dead = struct.state_machine.state.name == "dead"
	// Distinctions between players and npcs is important as this is meant to be a universal character
	// sprite determination method.
	var is_player = is_instanceof(struct,Player_Character);
	direction_facing = determine_direction_facing(direction);
	
	// When an npc has only one direction to face then we should not be adding an affix including direction.
	// This is respresented by a struct var but can also be represented with certain attack animations.
	if(struct.single_direction or (is_attacking and !is_player) or is_dead){
		// This assumes there is one sprite to represent this entity. This could be wrong in some contexts.
		// NPCs may have directional attack sprites in the future and this will need to be revisited.
		direction_affix = "";
        if(is_dead){
            var random_death = irandom_range(1,2);
            direction_affix = string_concat("",random_death);
            
        }
	}else{
		direction_affix = direction_facing;
		// When the direction facing is "right" we use "left" as the affix but do not change the direction facing.
		// This is because we only use one sprite to represent left and right sprites/
		if(direction_facing == "right"){
			direction_affix = "left";
		}else{
			direction_affix = direction_facing;
		}
	}
    
	var skin_prefix = "";
	// Applying to Players, character names help the algorithm pull the correct sprite.
	// if the struct var does not exist then we default to the name. Applying mostly to NPCs. 
	if(struct_exists(struct,"character_name")){
		skin_prefix = string_concat("spr_",struct.character_name);
	}else{
		skin_prefix = string_concat("spr_",struct.name);
	}
	// Equipment is going to be fleshed out later but certain sprites need to be drawn when using 
	// animations including other objects beside the character. For example the player can wield
	// different equipment/weapons and those are drawn separately from the player.
	if(not_null(equipment)){
        var eq_sprite_name = string_concat("spr_",equipment,"_",struct.state_machine.state.name,"_",action,"_",direction_affix);
        var eq_sprite = asset_get_index(eq_sprite_name);
        if(not_null(eq_sprite)){
            equipment_sprite = eq_sprite
        }
		//direction_affix = string_concat(equipment,"_",direction_affix);
	}
	if(not_null(action)){
		direction_affix = string_concat(action,"_",direction_affix);
	}
	if(is_moving){
		state_to_use = "move";
	}else{
		state_to_use = struct.state_machine.state.name
	}
	var asset_name = "";
	if(struct.single_direction or is_null(direction_affix)){
		asset_name = string_concat(skin_prefix,"_",state_to_use);
	}else{
		asset_name = string_concat(skin_prefix,"_",state_to_use,"_",direction_affix);
	}
	return_sprite = asset_get_index(asset_name);
	if(not_null(return_sprite)){
		sprite_index = return_sprite
	}else{
		sprite_index = spr_item_placeholder
	}
	
	// The final structure goes as follows:
	// spr_"character/npc name"_"state"_"optional action"_"optional equipment"_"optional direction"
}
	
function is_movement_state(_state){
	var is_movement_state = ((_state == "move")or(_state == "chase")or(_state == "wander"))
	return is_movement_state;
}
	
function handle_iframes(){
	with(struct){
		if(iframes){
			if(iframe_time > 0){
				iframe_time--;
			}
			if(iframe_time <= 0){
				iframes = false;
				iframe_time = 0;
			}
		}
	}
}
