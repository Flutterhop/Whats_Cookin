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