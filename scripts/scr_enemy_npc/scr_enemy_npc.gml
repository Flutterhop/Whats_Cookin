enum enemy_type{
	generic
}
enum enemy_trait{
	Standard,
	Flying,
	Healing,
	Armored,
	Quick,
	Heavy,
	Explosive,
	Shaman,
	Hunter
}

function enemy_determine_simple_attack_sprite(){ 
	var return_sprite
	var sprite_var_name
    
	var skin_prefix = "";
	
	skin_prefix = string_concat("spr_",struct.name);
	
	var asset_name = string_concat(skin_prefix,"_","attack");
	
	return_sprite = asset_get_index(asset_name);
	if(not_null(return_sprite)){
		sprite_index = return_sprite
	}else{
		sprite_index = spr_item_placeholder
	}
}

function enemy_read_aoe_collision(current_time){
	var collisions = ds_list_create();
	var min_rad = struct.stats.attack_range / 6
	var targets = struct.target_objects;
	var current_rad = clamp(min_rad + current_time,min_rad,struct.stats.attack_range * 2)
	EchoDebug(string_concat("current radius: ",current_rad))
	collision_circle_list(x,
							y,
							current_rad,
							targets,
							false,
							true,
							collisions,
							false
							)
	var total_collisions = ds_list_size(collisions)
	if(total_collisions > 0){
		return collisions;
	}
}

function hunter_npc_launch_attack(){
	var collisions = ds_list_create();
	collision_line_list(start_x,start_y,target_x,target_y,obj_game_entity,false,true,collisions,false);
	var num_collisions = ds_list_size(collisions);
	if(num_collisions > 0){
		struct.state_machine.ChangeState(default_state);
		return
	}
	var _attack_speed = struct.stats.attack_speed 
	var distance_to_target = point_distance(x,y,target_x,target_y);
	var target_direction = point_direction(x,y,target_x,target_y);
	var move_x = clamp(lengthdir_x(distance_to_target,target_direction),-_attack_speed,_attack_speed);
	var move_y = clamp(lengthdir_y(distance_to_target,target_direction),-_attack_speed,_attack_speed);
	if(distance_to_target > 20){
		EchoDebug(string_concat("target_x: ",target_x,"target_y: ",target_y))
		move_and_collide(move_x,move_y,collision_targets);
	}else{
		struct.state_machine.ChangeState(default_state);
	}
}

