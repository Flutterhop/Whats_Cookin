event_inherited();

builder_x_index = 0;
builder_y_index = 0;
builder_z_index = 0;

piece_x_index = 0;
piece_y_index = 0;

current_blueprint = "";


function init_state_machine(){
	struct.state_machine = new Statement(self)

	var piece_select_state = new StatementState(struct.state_machine,"piece_select")
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls()
			}
		});
	var placement_state = new StatementState(struct.state_machine,"placement_state")
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls()
			}
		});
	var inactive_state = new StatementState(struct.state_machine,"inactive")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
	
	struct.state_machine
	.AddState(piece_select_state)
	.AddState(placement_state)
	.AddState(inactive_state)

}
