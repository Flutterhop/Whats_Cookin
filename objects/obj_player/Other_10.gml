event_inherited()

//INPUT
up_input = 0;
down_input = 0;
left_input = 0;
right_input = 0;

//HOLDING
held_item = "";
held_structure = "";
throw_charge = 60;
throw_strength = 10;

//COLLISION
collision_targets  = struct.grid.fetch_collision_array();


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
				handle_movement();
				move_wrap(true,true,100);
				//if(not_null(held_item) or not_null(held_structure)){struct.state_machine.ChangeState("hold")}
				determine_sprite(); 
				handle_holding();
				reset_input();
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
				handle_movement();
				move_wrap(true,true,100);
				if(speed > 0 && speed < 1){image_speed = 2}else{image_speed = 0;}
				if(speed == 0){
					struct.state_machine.ChangeState("idle")
				}
				determine_sprite();
				handle_holding();
				reset_input();
			}

	});
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				if(speed > 0 && speed < 1){image_speed = 2}else{image_speed = 0;}
				determine_sprite();
				handle_holding();
				reset_input();
			}

	});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	.AddState(hold_state)

	struct.state_machine.ChangeState("idle")
}