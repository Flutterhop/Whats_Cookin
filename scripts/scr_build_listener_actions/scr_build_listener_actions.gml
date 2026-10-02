function build_listen_input_action_4(player){
	
}

function build_listen_action_4_pressed(player){
	if(active){
		//maybe show a warning before backing out.
		//also the code in this if could go onto the builder so that all input is handled there
		//once active and the else will remain in order to initialize the builder.
		struct.state_machine.ChangeState("idle");
	}else{
		struct.state_machine.ChangeState("active");
	}
}
function build_listen_action_4_released(player){
	
}