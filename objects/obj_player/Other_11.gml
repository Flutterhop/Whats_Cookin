event_inherited();
///PLAYER FUNCTION///
init_player_objects			= method(id,player_init_player_objects);
apply_movement				= method(id,player_apply_movement);
check_bounds				= method(id,player_check_bounds);
determine_face				= method(id,player_determine_face);
handle_dash_effect			= method(id,player_handle_dash_effect);
check_collision				= method(id,player_check_collision);
handle_damage_timer			= method(id,player_handle_damage_timer);
toggle_input_allowance		= method(id,player_toggle_input_allowance);
draw_bullet_reflect			= method(id,player_draw_bullet_reflect);
disable_input				= method(id,player_disable_input);
enable_input				= method(id,player_enable_input);
init_skins					= method(id,player_init_skins);
start_round					= method(id,player_start_round);
end_round					= method(id,player_end_round);
set_game_over				= method(id,player_game_over);
respawn						= method(id,player_respawn);
collect_reward				= method(id,player_collect_reward);


///CORE FUNCTION///
set_priority_enforcement	= method(id,core_set_priority_enforcement);
enable_priority				= method(id,core_enable_priority);
disable_priority			= method(id,core_disable_priority);

///ITEM FUNCTION///
generate_reward_item_list	= method(id,item_generate_reward_item_list);
generate_item				= method(id,item_generate_item);
///STATE FUNCTIUON///
toggle_shop					= method(id,state_toggle_shop);
check_player_status			= method(id,state_check_player_status);

///INPUT FUNCTION///
player_input_read			= method(id,input_read);
determine_priority			= method(id,input_determine_priority);
interpret_controls			= method(id,input_interpret_controls);
interpret_player_controls	= method(id,input_interpret_player_controls);

input_up					= method(id,player_input_up);
input_down					= method(id,player_input_down);
input_right					= method(id,player_input_right);
input_left					= method(id,player_input_left);
input_action_1				= method(id,player_input_action_1);
input_action_1_released		= method(id,player_input_action_1_released);
input_action_2				= method(id,player_input_action_2);
input_action_3				= method(id,player_input_action_3);