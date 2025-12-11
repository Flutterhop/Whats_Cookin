function pause_input_right(player){
	handle_h_increment(1);
}

function pause_input_left(){
	handle_h_increment(-1);
}

function pause_input_up(player){
	handle_v_increment(-1);
}

function pause_input_down(player){
	handle_v_increment(1);
}
	
function pause_input_action_1(player){
	active_element.pause_button_action();
}
	
function pause_input_action_2(player){
	var size = array_length(current_states);
	if(size > 1){
		var target = current_states[size - 2];
		if(not_null(current_menu.menu_exit_function)){
			current_menu.exit_menu();
		}
		change_state(target);

	}

}
	
function pause_input_action_3(player){

}

function pause_input_action_1_released(player){				

}

