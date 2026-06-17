function player_determine_sprite(){
	update_sprites()
	
	//Using the face we determine which sprite to use
	switch(face){
	    case 0:
			sprite_index = left_sprite;
			direction_facing = "right";
		break;
    
	    case 1:
			direction_facing = "right";
			sprite_index = left_sprite;
		break;

	    case 2:
			direction_facing = "up";
			sprite_index = up_sprite;
		break;
    
	    case 3:
			direction_facing = "left";
			sprite_index = left_sprite;
		break;

    
	    case 4:
			direction_facing = "left";
			sprite_index = left_sprite;
		break;
    
	    case 5:
			direction_facing = "left";
			sprite_index = left_sprite;

		break;
    
	    case 6:
			direction_facing = "down";
			sprite_index = down_sprite;
		break;
    
	    case 7:
			direction_facing = "right";
			sprite_index = left_sprite;
		break;
	}
}

function player_update_sprites(){
	var skin_prefix = string_concat("spr_","char");
	if(not_null(held_object) and ){
		idle_sprite = asset_get_index(string_concat(skin_prefix,"_idle","_left_unarmed"));
		idle_up_sprite = asset_get_index(string_concat(skin_prefix,"_idle_up","_unarmed"));
		idle_down_sprite = asset_get_index(string_concat(skin_prefix,"_idle_down","_unarmed"));
	}

	
}

function player_pick_up_item(target_item){
	
}

function player_read_interaction_collision(){
	//If weapon is active, create a collision box to read for valid hits
	var top_left_x
	var top_left_y
	var bottom_right_x
	var bottom_right_y
	switch(direction_facing){
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