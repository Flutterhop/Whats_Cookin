event_inherited()

///INPUT FUNCTION///
determine_priority			= method(id,input_determine_priority);
interpret_controls			= method(id,input_interpret_controls);
interpret_player_controls	= method(id,input_interpret_player_controls);
scan_inputs					= method(id,input_scan_inputs);
reset_input					= method(id, player_reset_input);

/////////////////////////////////////////STATE MACHINE METHODS////////////////////////////////////////////////////////
change_state 				= method(id,player_change_state);
queue_state 				= method(id,player_queue_state);

/////////////////////////////////////////COLLISION METHODS///////////////////////////////////////////////////////////
detect_interactions			= method(id,player_detect_interactions);
read_structure_collision	= method(id,player_read_structure_collision);
attack_collision            = method(id,player_attack_collision);
read_interaction_collision	= method(id,player_read_interaction_collision);
read_interaction_1_collision	= method(id,player_read_interaction_1_collision);
read_interaction_2_collision	= method(id,player_read_interaction_2_collision);
return_collision 			= method(id,player_return_collision);
return_multiple_collisions 	= method(id,player_return_multiple_collisions);

/////////////////////////////////////////PLAYER FUNCTION/////////////////////////////////////////////////////////////
update_sprites				= method(id,player_update_sprites);
pick_up_item				= method(id,player_pick_up_item);
drop_item					= method(id,player_drop_item);
throw_item 					= method(id,player_throw_item);
handle_interaction 			= method(id,player_handle_interaction);

/////////////////////////////////////////BUILDING METHODS////////////////////////////////////////////////////////////
handle_holding				= method(id,player_handle_holding);
deploy_structure			= method(id,player_deploy_structure);
assemble_structure			= method(id,player_assemble_structure);

///////////////////////////////////////////MOVEMENT METHODS//////////////////////////////////////////////////////////
jump						= method(id,player_jump);
handle_jumping				= method(id,player_handle_jumping);
handle_movement				= method(id,player_handle_movement);
reset_speed					= method(id,player_reset_speed);
apply_knockback				= method(id,player_apply_knockback);

///////////////////////////////////////////ATTACK METHODS////////////////////////////////////////////////////////////


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
input_action_4				= method(id,player_input_action_4);
input_action_4_pressed		= method(id,player_input_action_4_pressed);
input_action_4_released		= method(id,player_input_action_4_released);