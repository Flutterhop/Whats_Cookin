/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
mp_potential_settings(20, 10, 20, false)

path = path_index
index = "";
target = "";
wander_distance = 50;
default_state = "idle";
active_state = "move";
idle_time = 3; // default one second of idle when entering the state.
direction_facing = "left";


function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				sprite_index = determine_sprite("","unarmed"); 
				image_index = 0;
				image_speed = 0;

			}
		})
		.AddUpdate(function(){
			with(owner){
				var inactive_timer = (time_source_get_state(idle_timer) == time_source_state_initial) or (time_source_get_state(idle_timer) == time_source_state_stopped) or (time_source_get_state(idle_timer) == time_source_state_paused)
				if(inactive_timer){
					time_source_start(idle_timer)
				}
			}
			
		});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){
				with(owner){
					image_speed = 1;
				}
			})
		.AddUpdate(function(){
			with(owner){
				sprite_index = determine_sprite("","unarmed");
				handle_pathfinding();
				manage_movement();
			}
		});
	var wander_state = new StatementState(struct.state_machine,"wander")
		.AddEnter(function(){
			with(owner){
				image_speed = 1;
			}
		})
		.AddUpdate(function(){
			with(owner){
				sprite_index = determine_sprite("","unarmed"); 
				handle_pathfinding();
				manage_movement();
			}
	});
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	.AddState(wander_state)


	struct.state_machine.QueueState(default_state)
}