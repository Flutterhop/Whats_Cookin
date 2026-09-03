enum Character_Type{
	CH_NPC = 20,
	CH_ENEMY_NPC = 21,
	CH_PLAYER = 22
}

function Character_Stats(new_name,new_max_hp = 1,new_current_hp = 1,new_move_speed = 1,new_knockback_strength = 2,new_damage_amount = 1,new_attack_speed = 1,new_attack_range = 5,new_interaction_range = 5,new_attack_time)	:	Game_Stats() constructor{
	name = new_name;
	max_hp = new_max_hp
	current_hp = new_current_hp
	if(current_hp > max_hp){
		current_hp = max_hp;
	}
	move_speed = new_move_speed
	knockback_strength = new_knockback_strength
	damage_amount = new_damage_amount
	attack_speed = new_attack_speed
	attack_range = new_attack_range
	interaction_range = new_interaction_range;
	attack_time = new_attack_time
	
}

function Player_Stats(new_name,new_max_hp = 10,new_current_hp = 10,new_move_speed = 1,new_knockback_strength = 2,new_damage_amount = 1,new_attack_speed = 1,new_attack_range = 5,new_interaction_range,new_attack_time) : Character_Stats(new_name,new_max_hp,new_current_hp,new_move_speed,new_knockback_strength,new_damage_amount,new_attack_speed,new_attack_range,new_interaction_range,new_attack_time)constructor{
	
	//Throwing
	throw_charge = 60;
	throw_strength = 10;
}

function NPC_Stats(new_name,new_max_hp = 1,new_current_hp = 1,new_move_speed = 1,new_knockback_strength = 2,new_damage_amount = 1,new_attack_speed = 1,new_attack_range = 5,new_interaction_range = 5,new_attack_time,new_armor = 1,new_size = npc_size.medium,new_loot_key = "default",new_attack_windup = 60)	:	Character_Stats(new_name,new_max_hp,new_current_hp,new_move_speed,new_knockback_strength,new_damage_amount,new_attack_speed,new_attack_range,new_interaction_range,new_attack_time) constructor {
	armor = new_armor
	size = new_size
	loot_key = new_loot_key
	attack_windup = new_attack_windup;
}
function Enemy_Stats(new_name,new_max_hp = 1,new_current_hp = 1,new_move_speed = 1,new_knockback_strength = 2,new_damage_amount = 1,new_attack_speed = 1,new_attack_range = 5,new_interaction_range = 5,new_attack_time,new_armor = 1,new_size = npc_size.medium,new_loot_key = "default",new_attack_windup = 60)	:	NPC_Stats(new_name,new_max_hp,new_current_hp,new_move_speed,new_knockback_strength,new_damage_amount,new_attack_speed,new_attack_range,new_interaction_range,new_attack_time,new_armor,new_size,new_loot_key,new_attack_windup) constructor {
	
}

function draw_character_sprite(){
	switch(direction_facing){
		case "left":
			character_sprite = left_character_sprite
			break;
		case "right":
			character_sprite = left_character_sprite
			break;
		case "up":
			character_sprite = up_character_sprite
			break;
		case "down":
			character_sprite = down_character_sprite
			break;
	}
	var sprite_count = array_length(character_sprite.sprites);
	for(var i = 0; i < sprite_count;i++){
		if(asset_get_type(character_sprite.sprites[i]) == asset_sprite ){
			var current_sprite = character_sprite.sprites[i]
			draw_sprite_ext(current_sprite,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
		}
	}
	
}

function character_draw_health(){
	if(variable_instance_exists(struct.stats,"current_hp")){
		if(struct.stats.current_hp < struct.stats.max_hp){
			var current_percent = struct.stats.current_hp / struct.stats.max_hp
			current_percent = abs(current_percent - 1)
			var current_frame = current_percent * (sprite_get_number(spr_purple_bar) - 1)
			draw_sprite_ext(spr_purple_bar,current_frame,x,y - 15,.8,.8,0,c_white,1)
		}
	}
}