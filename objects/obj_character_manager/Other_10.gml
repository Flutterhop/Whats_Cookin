
event_inherited();

character_map = ds_map_create();

character_buffer = "";

compressed_buffer = "";

ready_for_input = false;



function init_state_machine(){
	struct.state_machine = new Statement(self)
	
	var active_state = new StatementState(struct.state_machine,"active")
		
		.AddEnter(function(){
			with(owner){
				init_builder()
			}
		})
	var character_builder_state = new StatementState(struct.state_machine,"characterbuilder")
		.AddUpdate(function(){
			with(owner){
				if(ready_for_input){
					interpret_controls();
				}
			}
		})
	var inactive_state = new StatementState(struct.state_machine,"inactive")
		.AddEnter(function(){
			with(owner){
				end_builder();
			}
		})
		.AddUpdate(function(){
			with(owner){
				return;
			}
		});
	
	struct.state_machine
	.AddState(active_state)
	.AddState(character_builder_state)
	.AddState(inactive_state)
	
	struct.state_machine.ChangeState("active");

}