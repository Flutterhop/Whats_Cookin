/// @description Insert description here
// You can write your code in this editor

event_inherited();
change_state		 = method(id,core_change_state);
find_target			 = method(id,find_target_player);
set_direction		 = method(id,core_set_direction);
set_attack_direction = method(id,core_set_attack_direction);
init_sprites		 = method(id,init_enemy_sprites);
determine_chase		 = method(id,get_chase_odds);
check_bounds		 = method(id,core_check_bounds);
enable_knockback	 = method(id,core_enable_knockback);
spawn_entity		 = method(id,core_spawn_entity);
check_collision		 = method(id,core_check_collision);
check_iframes		 = method(id,core_check_iframes);
find_lure_bombs		 = method(id,core_find_lure_bombs);