function pause_input_right_pressed(player){
	if(variable_instance_exists(self,"active_element") and instance_exists(obj_pause_menu)){
		handle_h_increment(1);
	}
}

function pause_input_left_pressed(){
	if(variable_instance_exists(self,"active_element") and instance_exists(obj_pause_menu)){
		handle_h_increment(-1);
	}
}

function pause_input_up_pressed(player){
	if(variable_instance_exists(self,"active_element") and instance_exists(obj_pause_menu)){
		if(not_null(active_element)){
			handle_v_increment(-1);
		}
	}
}

function pause_input_down_pressed(player){
	if(variable_instance_exists(self,"active_element") and instance_exists(obj_pause_menu)){
		if(not_null(active_element)){
			handle_v_increment(1);
		}
	}
}
	
function pause_input_action_1_pressed(player){
	if(variable_instance_exists(self,"active_element") and instance_exists(obj_pause_menu)){
		if(variable_instance_exists(active_element,"pause_button_action")){
			active_element.pause_button_action();
		}
	}
}
	
function pause_input_action_2_pressed(player){
	if(instance_exists(obj_pause_menu)){
		var size = array_length(current_states);
		if(size > 1){
			var target = current_states[size - 2];
			if(not_null(current_menu.menu_exit_function)){
				current_menu.exit_menu();
			}
			change_state(target);

		}
	}

}

function pause_input_pause_pressed(player){
	handle_pause(player)
}