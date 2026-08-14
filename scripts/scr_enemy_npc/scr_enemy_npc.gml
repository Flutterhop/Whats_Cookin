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

function hunter_npc_set_target(){
	if(not_null(target)){
		target_x = target.x;
		target_y = target.y;
	}else{
		return;
	}
}

function hunter_npc_launch_attack(){
	var _attack_speed = struct.stats.attack_speed 
	var distance_to_target = point_distance(x,y,target_x,target_y);
	var target_direction = point_direction(x,y,target_x,target_y);
	var move_x = clamp(lengthdir_x(distance_to_target,target_direction),-_attack_speed,_attack_speed);
	var move_y = clamp(lengthdir_y(distance_to_target,target_direction),-_attack_speed,_attack_speed);
	if(distance_to_target > 20){
		move_and_collide(move_x,move_y,collision_targets);
	}else{
		struct.state_machine.ChangeState(default_state);
	}
}