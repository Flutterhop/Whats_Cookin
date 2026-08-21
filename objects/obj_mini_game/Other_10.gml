// Inherit the parent event
event_inherited();

required_inputs = [INPUT_VERB.DOWN,INPUT_VERB.ACTION_1,INPUT_VERB.UP];
minigame_frame = 0;


function set_custom_states(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
			}
		})
	var success_state = new StatementState(struct.state_machine,"success")
	.AddEnter(function(){
		with(owner){
			EchoDebug("minigame complete.")
			
		}
	});
	struct.state_machine
	.AddState(idle_state)
	.AddState(success_state);

	
	struct.state_machine.ChangeState("idle");

}