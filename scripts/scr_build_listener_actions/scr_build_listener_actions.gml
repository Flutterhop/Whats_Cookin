function build_listen_input_action_4(player){
	
}

function build_listen_action_4_pressed(player){
	/*if(active){
		// maybe show a warning before backing out.
		// Currently exiting builder will do so for all players currently in the active player list.
		// This is unintended and will need attention later.
		remove_builder_player(player);
		exit_build_mode(player);
		struct.state_machine.ChangeState("idle");
	}else{
		add_builder_player(player);
		enter_build_mode(player);
		struct.state_machine.ChangeState("active");
		
	}*/
}
function build_listen_action_4_released(player){
	
}

function build_listen_special_2_pressed(player){
	if(active){
		// maybe show a warning before backing out.
		// Currently exiting builder will do so for all players currently in the active player list.
		// This is unintended and will need attention later.
		remove_builder_player(player);
		exit_build_mode(player);
		struct.state_machine.ChangeState("idle");
	}else{
		add_builder_player(player);
		enter_build_mode(player);
		struct.state_machine.ChangeState("active");
		
	}
}