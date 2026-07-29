// Inherit the parent event
event_inherited();
mp_potential_settings(20, 10, 10, false)



function init_state_machine(){
	struct.state_machine = new Statement(self)
	var idle_state = new StatementState(struct.state_machine,"idle")
	.AddEnter(function(){
			
	})
	.AddUpdate(function(){
		if(x_speed > 0 or y_speed > 0){
			struct.state_machine.ChangeState("move")
		}
	});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				handle_pathfinding();
			}
		});

	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	
	struct.state_machine.ChangeState("move")
}
