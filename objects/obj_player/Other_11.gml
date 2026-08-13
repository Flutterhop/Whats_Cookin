event_inherited()

///INPUT FUNCTION///
determine_priority			= method(id,input_determine_priority);
interpret_controls			= method(id,input_interpret_controls);
interpret_player_controls	= method(id,input_interpret_player_controls);
scan_inputs					= method(id,input_scan_inputs);
reset_input					= method(id, player_reset_input);

///PLAYER FUNCTION///
update_sprites				= method(id,player_update_sprites);
read_interaction_collision	= method(id,player_read_interaction_collision);
pick_up_item				= method(id,player_pick_up_item);
drop_item					= method(id,player_drop_item);

/////////////////////////////////////////BUILDING METHODS////////////////////////////////////////////////////////////
handle_holding				= method(id,player_handle_holding);
detect_interactions			= method(id,player_detect_interactions);
read_structure_collision	= method(id,player_read_structure_collision);
deploy_structure			= method(id,player_deploy_structure);
assemble_structure			= method(id,player_assemble_structure);
end_interact				= method(id,player_end_interact);

///////////////////////////////////////////MOVEMENT METHODS//////////////////////////////////////////////////////////
jump						= method(id,player_jump);
handle_jumping				= method(id,player_handle_jumping);
handle_movement				= method(id,player_handle_movement);
reset_speed					= method(id,player_reset_speed);
apply_knockback				= method(id,player_apply_knockback);

///////////////////////////////////////////ATTACK METHODS////////////////////////////////////////////////////////////
attack_collision            = method(id,player_attack_collision);
attack                      = method(id,player_attack);

///////////////////////////////////////////TIMER METHODS/////////////////////////////////////////////////////////////
attack_complete				= method(id,player_attack_complete);
knockback_complete			= method(id,player_knockback_complete);
throw_item					= method(id,player_throw_item);
stun_complete				= method(id,player_stun_complete);

///////////////////////////////////////////INPUT METHODS/////////////////////////////////////////////////////////////
input_up					= method(id,player_input_up);
input_down					= method(id,player_input_down);
input_right					= method(id,player_input_right);
input_left					= method(id,player_input_left);
input_action_1				= method(id,player_input_action_1);
input_action_1_pressed		= method(id,player_input_action_1_pressed);
input_action_1_released		= method(id,player_input_action_1_released);
input_action_2				= method(id,player_input_action_2);
input_action_2_pressed		= method(id,player_input_action_2_pressed);
input_action_3				= method(id,player_input_action_3);
input_action_3_pressed		= method(id,player_input_action_3_pressed);
input_action_3_released		= method(id,player_input_action_3_released);