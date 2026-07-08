/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var empty_state = new StatementState(struct.state_machine,"empty_state")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
	var occupied_state = new StatementState(struct.state_machine,"occupied_state")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
	
	struct.state_machine
	.AddState(empty_state)
	.AddState(occupied_state);
	
	struct.state_machine.ChangeState("empty_state")

}