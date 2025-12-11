event_inherited();

read_all_input				= method(id,input_read_all);
add_player					= method(id,input_add_player);
remove_player				= method(id,input_remove_player);
focus_first_player			= method(id,input_focus_first_player);
load_bind_rules				= method(id,input_load_bind_rules);
listen_for_input			= method(id,input_listen_for_input);

///PAUSE FUNCTION///
handle_v_increment			= method(id,pause_handle_v_increment);	
handle_h_increment			= method(id,pause_handle_h_increment);	
enable_instances			= method(id,pause_enable_instances);	
disable_instances			= method(id,pause_disable_instances);
init_main_menus				= method(id,pause_init_main_menus);
init_settings_menus			= method(id,pause_init_settings_menus);
clean_up_menus				= method(id,pause_clean_up_menus);
reset_manager				= method(id,pause_reset_manager);


change_state				= method(id,pause_change_state);
check_v_bounds				= method(id,pause_check_v_bounds)	
check_h_bounds				= method(id,pause_check_h_bounds)
set_pause_highlight			= method(id,pause_set_pause_highlight);
fetch_arrows				= method(id,pause_fetch_arrows);
center_arrows				= method(id,pause_center_arrows);	
adjust_arrows				= method(id,pause_adjust_arrows);	




///INPUT FUNCTION///
input_up = method(id,pause_input_up);
input_down = method(id,pause_input_down);
input_right = method(id,pause_input_right);
input_left = method(id,pause_input_left);
input_action_1 = method(id,pause_input_action_1);
input_action_2 = method(id,pause_input_action_2);
input_action_3 = method(id,pause_input_action_3);
input_action_1_released = method(id,pause_input_action_1_released);



