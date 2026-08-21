// Inherit the parent event
event_inherited();

interpret_player_controls 	= method(id,input_interpret_controls);

input_up_pressed			= method(id,process_input_up_pressed);
input_down_pressed			= method(id,process_input_down_pressed);
input_right_pressed			= method(id,process_input_right_pressed);
input_left_pressed			= method(id,process_input_left_pressed);
input_action_1				= method(id,process_input_action_1);
input_action_1_pressed		= method(id,process_input_action_1_pressed);
input_action_1_released		= method(id,process_input_action_1_released);
input_action_2				= method(id,process_input_action_2);
input_action_2_pressed		= method(id,process_input_action_2_pressed);
input_action_3				= method(id,process_input_action_3);
input_action_3_pressed		= method(id,process_input_action_3_pressed);
input_action_3_released		= method(id,process_input_action_3_released);