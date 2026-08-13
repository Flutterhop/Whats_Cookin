enum structure_type{
	Defense = 61,
	Kitchen = 62
}

function Structure_Stats(new_max_hp = 1,new_current_hp = 1)	:	Game_Stats() constructor {
	max_hp = new_max_hp;
	current_hp = new_current_hp;
	if(current_hp > max_hp){
		current_hp = max_hp;
	}
	upgrades = [];
}

function Defense_Structure_Stats(new_max_hp = 1,new_current_hp = 1,new_move_speed = 1,new_knockback_strength = 2,new_damage_amount = 1,new_attack_speed = 1)
 : Structure_Stats(new_max_hp,new_current_hp)constructor {
	move_speed = new_move_speed
	knockback_strength = new_knockback_strength
	damage_amount = new_damage_amount
	attack_speed = new_attack_speed
	
}

function Kitchen_Structure_Stats(new_process_speed = 1,new_max_hp = 1,new_current_hp = 1)
 : Structure_Stats(new_max_hp,new_current_hp) constructor {
	process_speed = new_process_speed
}

