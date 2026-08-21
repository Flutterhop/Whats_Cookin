// Inherit the parent event
event_inherited();

interpret_player_controls 	= method(id,input_interpret_controls);

minigame_input 				= method(id,interact_minigame_input);

input_up_pressed			= method(id,minigame_input_up_pressed);
input_down_pressed			= method(id,minigame_input_down_pressed);
input_right_pressed			= method(id,minigame_input_right_pressed);
input_left_pressed			= method(id,minigame_input_left_pressed);
input_action_1_pressed		= method(id,minigame_input_action_1_pressed);
input_action_2_pressed		= method(id,minigame_input_action_2_pressed);
input_action_3_pressed		= method(id,minigame_input_action_3_pressed);
