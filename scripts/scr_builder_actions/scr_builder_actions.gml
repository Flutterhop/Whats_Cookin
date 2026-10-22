function builder_input_right_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to next piece
			handle_builder_movement(1,0);
			break;
		case "placement_state":
			
			//moves the piece right, camera follows the piece.
			
			break;
	}
}

function builder_input_right(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to next piece

			break;
		case "placement_state":
			can_place();
		break;
	}
}


function builder_input_left_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to previous piece
			handle_builder_movement(-1,0)
			break;
		case "placement_state":
			//moves the piece left, camera follows the piece.
			
			break;
	}
}

function builder_input_left(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to next piece
			break;
		case "placement_state":
			find_spawn_cell();
			can_place();
			break;
	}
}

function builder_input_up_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			// if the current column has more options then increment to the next one
			handle_builder_movement(0,-1);
			break;
		case "placement_state":
			break;
	}
}

function builder_input_up(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to next piece
			break;
		case "placement_state":
			find_spawn_cell();
			can_place();
			break;
	}
}

function builder_input_down_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			// if the current column has more options then increment to the previous one
			handle_builder_movement(0,1);
			break;
		case "placement_state":
			break;
	}

}

function builder_input_down(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to next piece
			break;
		case "placement_state":
			find_spawn_cell();
			can_place();
			break;
	}
}
function builder_input_action_1_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//select piece and enter placement state
			struct.state_machine.ChangeState("placement_state")
		break;
		case "placement_state":
			place_piece();
		break;
	}
}

function builder_input_action_2_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//maybe back out of build mode?
		break;
		case "placement_state":
			// return to piece select
			exit_placement();
		break;
	}
}



//These inputs will be left for when i need other context inputs.
function builder_input_action_3_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//maybe rotation?
			break;
		case "placement_state":
			break;
	}

}

function builder_input_action_4_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			break;
		case "placement_state":
			break;
	}
}
	