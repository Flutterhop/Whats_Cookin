event_inherited();

input_action_4					= method(id,build_listen_input_action_4);
input_action_4_pressed			= method(id,build_listen_action_4_pressed);
input_action_4_released			= method(id,build_listen_action_4_released);

input_special_2_pressed 		= method(id,build_listen_special_2_pressed)

remove_builder_player 			= method(id,listener_remove_builder_player);
add_builder_player 				= method(id,listener_add_builder_player);

enter_build_mode				= method(id,build_listener_enter_build_mode);
exit_build_mode					= method(id,build_listener_exit_build_mode);

end_builder						= method(id,build_end_builder);