event_inherited()

held_item = "";
held_structure = "";

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				determine_sprite(); 
				image_index = 0
			}
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
				direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION,struct.player_number);
				motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0));
				if(not_null(held_item) or not_null(held_structure)){struct.state_machine.ChangeState("hold")}
				determine_sprite(); 
				handle_holding();
				image_speed = 0;
				if(speed > 0){
					struct.state_machine.ChangeState("move")
				}
			}
	});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
				direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION,struct.player_number);
				motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0));
				move_wrap(true,true,100);
				if(speed > 0 && speed < 1){image_speed = 2}else{image_speed = 0;}
				if(speed == 0){
					struct.state_machine.ChangeState("idle")
				}

				determine_sprite();
				handle_holding();
			}

	});
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
				direction = InputDirection(direction,INPUT_CLUSTER.NAVIGATION,struct.player_number);
				motion_set(direction,InputDistance(INPUT_CLUSTER.NAVIGATION,0));
				move_wrap(true,true,100);
				if(speed > 0 && speed < 1){image_speed = 2}else{image_speed = 0;}
				determine_sprite();
				handle_holding();
			}

	});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	.AddState(hold_state)

	struct.state_machine.ChangeState("idle")
}