
event_inherited();

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
	
	struct.state_machine
	.AddState(idle_state)

	
	struct.state_machine.ChangeState("idle");

}