function builder_input_right_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to next piece
			get_next_column_piece();
			break;
		case "placement_state":
			//moves the piece right, camera follows the piece.
			handle_piece_movement(1,0);
			break;
	}
}

function builder_input_left_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//go to previous piece
			get_previous_column_piece();
			break;
		case "placement_state":
			//moves the piece left, camera follows the piece.
			handle_piece_movement(-1,0);
			break;
	}
}

function builder_input_up_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			// if the current column has more options then increment to the next one
			get_next_row_piece();
			break;
		case "placement_state":
			//moves the piece up, camera follows the piece.
			handle_piece_movement(0,-1);
			break;
	}
}

function builder_input_down_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			// if the current column has more options then increment to the previous one
			get_previous_row_piece();
			break;
		case "placement_state":
			//moves the piece down, camera follows the piece.
			handle_piece_movement(0,1);
			break;
	}

}

function builder_input_action_1_pressed(player){
	var current_state = struct.state_machine.GetStateName();
	switch(current_state){
		case "piece_select":
			//select piece and enter placement state
			
		break;
		case "placement_state":
			
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
	