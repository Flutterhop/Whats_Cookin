
function player_input_right(player){

	right_input = clamp(InputX(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,1);
	x_speed = clamp(x_speed + right_input,0,1);
}

function player_input_left(player){

	left_input = clamp(InputX(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,-1);
	x_speed = clamp(x_speed + left_input,0,-1);
}
	
function player_input_up(player){

	up_input = clamp(InputY(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,-1);
	if(not_null(up_input)){y_speed = clamp(y_speed + up_input,0,-1)}
}

function player_input_down(player){

	down_input = clamp(InputY(INPUT_CLUSTER.NAVIGATION,struct.player_number),0,1);
	if(not_null(down_input)){y_speed = clamp(y_speed + down_input,0,1)}

}
	
function player_input_action_1(player){
	
}

function player_input_action_1_pressed(player){
	read_interaction_collision();		
}	

function player_input_action_1_released(player){
	//if(!struct.state_machine.IsInState("throw")){
		//read_interaction_collision();
	//}
}	
	
function player_input_action_2(_player){
	
}
	
function player_input_action_3(player){
}

function player_input_action_3_pressed(player){
	if(struct.state_machine.IsInState("hold") and not_null(held_item)){
		struct.state_machine.ChangeState("throw");
	}else{
		read_structure_collision();
	}
}
function player_input_action_3_released(player){
	if(struct.state_machine.IsInState("throw")){
		throw_item();
	}
}