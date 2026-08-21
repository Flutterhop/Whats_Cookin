enum structure_type{
	Defense = 61,
	Kitchen = 62
}
enum process_type{
	cut = 1,
	knead = 2,
	mix = 3,
	blend = 4,
	peel = 5
}

function Structure_Stats(new_name,new_max_hp = 1,new_current_hp = 1,new_has_interaction = false,new_minigame_reference = "")	:Game_Stats() constructor {
	name = new_name;
	max_hp = new_max_hp;
	current_hp = new_current_hp;
	if(current_hp > max_hp){
		current_hp = max_hp;
	}
	upgrades = [];
    has_interaction = new_has_interaction;
	minigame_reference = new_minigame_reference;
}

function Defense_Structure_Stats(new_name,new_max_hp = 1,new_current_hp = 1,new_has_interaction = false,new_minigame_reference = "",new_move_speed = 1,new_knockback_strength = 2,new_damage_amount = 1,new_attack_speed = 1)
 : Structure_Stats(new_name,new_max_hp,new_current_hp,new_has_interaction,new_minigame_reference)constructor {
	move_speed = new_move_speed
	knockback_strength = new_knockback_strength
	damage_amount = new_damage_amount
	attack_speed = new_attack_speed
	
}

function Kitchen_Structure_Stats(new_name,new_max_hp = 1,new_current_hp = 1,new_has_interaction = false,new_minigame_reference = "",new_process_speed = 1,new_process_type = process_type.cut)
 : Structure_Stats(new_name,new_max_hp,new_current_hp,new_has_interaction,new_minigame_reference) constructor {
	process_speed = new_process_speed;
	str_process_type = new_process_type;
	
	static can_process = function(process_target){
		
	}
}


