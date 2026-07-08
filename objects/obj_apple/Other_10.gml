
function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){

		})
		.AddUpdate(function(){
			with(owner){
				if(struct.held){
					struct.state_machine.ChangeState("hold")
				}
			}
	});	
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				if(!struct.held){
					struct.state_machine.ChangeState("idle")
				}
			}

	});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(hold_state)

	struct.state_machine.ChangeState("idle")

}