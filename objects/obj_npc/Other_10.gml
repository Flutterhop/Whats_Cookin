/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
path = path_index
index = "";
target = "";

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				determine_sprite(struct.equipment); 
				image_index = 0
			}
		})
		.AddUpdate(function(){
			with(owner){
				if(x_speed > 0 or y_speed > 0){
					struct.state_machine.ChangeState("move")
				}
			}
			
		});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)

	struct.state_machine.ChangeState("idle")
}