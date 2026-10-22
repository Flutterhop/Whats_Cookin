
function player_input_right(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "piece_select":
			//nothing at the moment, just blocking input
			return;
		break;
		default:
			right_input = clamp(InputX(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,1);
			if(not_null(right_input)){
				x_speed = clamp(x_speed + right_input,0,1); 
			}else{
				x_speed = 0;
			}
		break;
	}
}

function player_input_left(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "piece_select":
			//nothing at the moment, just blocking input
			return;
		break;
		default:
			left_input = clamp(InputX(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,-1);
			if(not_null(left_input)){
				x_speed = clamp(x_speed + left_input,0,-1);
			}else{
				x_speed = 0;
			}
		break;
	}
}

function player_input_up(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "piece_select":
			//nothing at the moment, just blocking input
			return;
		break;
		default:
			up_input = clamp(InputY(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,-1);
			if(not_null(up_input)){
				y_speed = clamp(y_speed + up_input,0,-1)
			}else{
				y_speed = 0;
			}
		break;
	}
}

function player_input_down(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "piece_select":
			//nothing at the moment, just blocking input
			return;
		break;
		default:
			down_input = clamp(InputY(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,1);
			if(not_null(down_input)){
				y_speed = clamp(y_speed + down_input,0,1)
			}else{
				y_speed = 0;
			}
		break;
	}

}
	
function player_input_action_1(player){
	
}

function player_input_action_1_pressed(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "piece_select":
			//nothing at the moment, just blocking input
			return;
		break;
		case "build":
			return;
		break;
		case "throw":
			return;
		break;
		case "stunned":
			return;
		break;
		default:
			read_interaction_1_collision();
		break;
	}
}	

function player_input_action_1_released(player){

}	
	
function player_input_action_2(_player){
	
}

function player_input_action_2_pressed(_player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "hold": 
			return;
		break;
		case "build":
			return;
		break; 
		case "piece_select":
			return;
		break;
		default:
			if(struct.has_equipment()){
				queue_state("attack");
			}else{
				EchoDebug("No Equipment on player, cannot attack.")
			}
		break;
	}
}
	
function player_input_action_3(player){
}

function player_input_action_3_pressed(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "hold": 
			if(not_null(struct.held_entity) and is_instanceof(struct.held_entity.struct,Item_Game)){
				struct.state_machine.ChangeState("throw");
			}
			if(not_null(struct.held_entity) and is_instanceof(struct.held_entity.struct,Structure_Game)){
				read_structure_collision();
			}
			return;
		break;
		case "build":
			return;
			//nothing at the moment, just blocking input
		break;
		default:
			read_structure_collision();
		break;
	}
}
function player_input_action_3_released(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "hold": 
			if(not_null(struct.held_entity) and is_instanceof(struct.held_entity.struct,Item_Game)){
				struct.state_machine.ChangeState("throw");
			}
			return;
		break;
		case "build":
			return;
			//nothing at the moment, just blocking input
		break;
		case "throw":
			if(struct.state_machine.GetStateTime() > struct.stats.throw_charge){
				throw_item(); 
			}
		default:
			
		break;
	}
}

function player_input_action_4(player){
	
}

function player_input_action_4_pressed(player){
	var state = struct.state_machine.GetStateName()
	switch(state){
		case "hold": 
			return;
		break;
		case "build":
			return;
		break;
		case "throw":
			return;
		break;
		default:
			read_interaction_2_collision();
		break;
	}
}
function player_input_action_4_released(player){

}