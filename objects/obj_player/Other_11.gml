event_inherited()

///INPUT FUNCTION///
determine_priority			= method(id,input_determine_priority);
interpret_controls			= method(id,input_interpret_controls);
interpret_player_controls	= method(id,input_interpret_player_controls);
scan_inputs					= method(id,input_scan_inputs);

///PLAYER FUNCTION///

determine_sprite			= method(id,player_determine_sprite)
determine_direction			= method(id,player_determine_direction);
update_sprites				= method(id,player_update_sprites);
read_interaction_collision	= method(id,player_read_interaction_collision);
pick_up_item				= method(id,player_pick_up_item);
drop_item					= method(id,player_drop_item);
handle_holding				= method(id,player_handle_holding);
detect_interactions			= method(id,player_detect_interactions);
read_structure_collision	= method(id,player_read_structure_collision);
deploy_structure			= method(id,player_deploy_structure);
assemble_structure			= method(id,player_assemble_structure);
handle_movement				= method(id,player_handle_movement);
reset_input					= method(id,player_reset_input);
throw_item					= method(id,player_throw_item);


input_up					= method(id,player_input_up);
input_down					= method(id,player_input_down);
input_right					= method(id,player_input_right);
input_left					= method(id,player_input_left);
input_action_1				= method(id,player_input_action_1);
input_action_1_pressed		= method(id,player_input_action_1_pressed);
input_action_1_released		= method(id,player_input_action_1_released);
input_action_2				= method(id,player_input_action_2);
input_action_3				= method(id,player_input_action_3);
input_action_3_pressed		= method(id,player_input_action_3_pressed);
