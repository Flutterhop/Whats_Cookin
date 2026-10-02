/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

listener_object = obj_build_manager;

listener_instance = "";

function init_state_machine(){
	struct.state_machine = new Statement(self)
	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
			}
		});
	var active_state = new StatementState(struct.state_machine,"active")
		.AddEnter(function(){
			with(owner){
				active = true;
				enter_build_mode();	
			}

		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
			}
		})
		.AddExit(function(){
			with(owner){
				active = false;
				exit_build_mode();
			}

		});
	
	struct.state_machine
	.AddState(idle_state)
	.AddState(active_state)

}