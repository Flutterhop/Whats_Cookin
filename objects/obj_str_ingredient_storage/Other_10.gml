// Inherit the parent event
event_inherited();


function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){

		})
		.AddUpdate(function(){
			with(owner){
				if(struct.is_empty()){
					struct.state_machine.ChangeState("empty")
				}
			}
	});	
	var empty_state = new StatementState(struct.state_machine,"empty")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				if(struct.has_inventory()){
					struct.state_machine.ChangeState("idle")
				}
			}

	});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(empty_state)

	struct.state_machine.ChangeState("idle")

}