/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddUpdate(function(){
			with(owner){
				if(struct.is_empty()){
					struct.state_machine.ChangeState("empty");
				}
				if(struct.has_inventory()){
					struct.state_machine.ChangeState("occupied");
				}
			}
		});
	var empty_state = new StatementState(struct.state_machine,"empty")
		.AddUpdate(function(){
			with(owner){
				if(struct.has_inventory()){
					struct.state_machine.ChangeState("occupied");
				}
			}
		});
	var occupied_state = new StatementState(struct.state_machine,"occupied")
		.AddUpdate(function(){
			with(owner){
				if(struct.is_empty()){
					struct.state_machine.ChangeState("empty");
				}
			}
		});
	var assemble_state = new StatementState(struct.state_machine,"assemble")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
	
	struct.state_machine
	.AddState(idle_state)
	.AddState(empty_state)
	.AddState(occupied_state)
	.AddState(assemble_state);

	
	struct.state_machine.ChangeState("empty");

}