
function input_check_input_right(player){
	var player_num = player.player_number;
	var elements = instance_number(obj_player_button);
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element.player_number == player_num){
			if(!element.is_ready){
				change_skin(player,1);

			}
			break;
		}
	}
}

function input_check_input_left(player){		
	var player_num = player.player_number;
	var elements = instance_number(obj_player_button);
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element.player_number == player_num){
			if(!element.is_ready){
				change_skin(player,-1);
			}
			break;
		}
	}
}

function input_check_input_up(player){		
	var player_num = player.player_number;
	var elements = instance_number(obj_player_button);
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element.player_number == player_num){
			if(!element.is_ready){
				change_character(player,-1);
			}
			break;
		}
	}
}

function input_check_input_down(player){
	var player_num = player.player_number;
	var elements = instance_number(obj_player_button);
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element.player_number == player_num){
			change_character(player,1);
		}
		break;
	}
}
function input_check_input_action_1(player){
	var button = get_player_button(player);
	if(button.is_active == false){
		//party joined but not ready
		if(alarm[0] > 0){
			alarm[0] = -1;
		}
		button.is_active = true;
		button.set_char_and_skin();
	}else if(button.is_active == true and button.is_ready == false){
		button.is_ready = true;
	}else if(button.is_active == true and button.is_ready == true){
		var num_of_active = get_active_elements();
		var num_of_ready = get_ready_elements();
		if(num_of_active == num_of_ready){
			ready_signal_received = true;
			if(alarm[0] > 60){
				alarm[0] -= 60;
			}
		}
	}
	activate_delay(player,4,"action_1");
}
	
function input_check_input_action_2(player){
	var button = get_player_button(player);
	if(not_null(button)){
		if(player.player_number == 0 && !button.is_ready){
			var num_ready = get_ready_elements();
			if(num_ready == 0){
				InputPartySetJoin(false);
				room_goto(rm_Start);
			}else{
				alarm[0] = -1;
				return;
			}

		}
		if(button.is_active && !button.is_ready){
			button.is_active = false;
			activate_delay(player,4,"action_1");
		}else if(button.is_active && button.is_ready){
			button.is_ready = false;
			ready_signal_received = false;
			activate_delay(player,4,"action_1");
		}
	}
	var num_of_active = get_active_elements();
	if(num_of_active == 0){
		InputPartySetJoin(false);
		room_goto(rm_Start);
	}
	alarm[0] = -1;
	

}

function input_check_input_action_3(player){}	

function input_check_input_action_1_released(player){}
