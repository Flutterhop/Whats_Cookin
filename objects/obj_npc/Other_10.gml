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
stun_index = 0;
movement_locked = false;
friction_amount = .7;
direction_facing = "left";


//ATTACK PARAMETERS
target_range = 100;
target_x = 0;
target_y = 0;
attack_speed = 5;
attack_time = 3; // default time to complete an attack that should be replaced by the length of an attack animation.
attack_windup_time = 1;
collision_targets  = struct.grid.fetch_collision_array();
array_push(collision_targets,obj_character_entity)

function init_state_machine(){
	struct.state_machine = new Statement(self)
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				determine_sprite();
				image_index = 0;
				image_speed = 0;

			}
		})
		.AddUpdate(function(){
			with(owner){
				if(not_null(target)){
					direction = determine_direction(target)
				}
				handle_iframes()
				var inactive_timer = (time_source_get_state(idle_timer) == time_source_state_initial) or (time_source_get_state(idle_timer) == time_source_state_stopped) or (time_source_get_state(idle_timer) == time_source_state_paused)
				if(inactive_timer){
					time_source_start(idle_timer)
				}
			}
		})
		.AddExit(function(){
			with(owner){

			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}

		});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){
				with(owner){
					determine_sprite(); 
					image_index = 0;
					image_speed = 1;
				}
			})
		.AddUpdate(function(){
			with(owner){
				if(not_null(target)){
					direction = determine_direction(target)
				}
				handle_iframes()
				determine_sprite();
				handle_pathfinding();
				manage_movement();
				
			}
		})
		.AddExit(function(){
			with(owner){

			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
		});
	var wander_state = new StatementState(struct.state_machine,"wander")
		.AddEnter(function(){
			with(owner){
				determine_sprite(); 
				image_index = 0;
				image_speed = 1;
			}
		})
		.AddUpdate(function(){
			with(owner){
				if(not_null(target)){
					direction = determine_direction(target)
				}
				handle_iframes()
				determine_sprite(); 
				handle_pathfinding();
				manage_movement();
			}
		})
		.AddExit(function(){
			with(owner){

			}
		});
	var chase_state = new StatementState(struct.state_machine,"chase")
		.AddEnter(function(){
			with(owner){
				determine_sprite(); 
				image_index = 0;
				image_speed = 1;
				
			}
		})
		.AddUpdate(function(){
			with(owner){
				if(not_null(target)){
					direction = determine_direction(target)
				}else{
					target = find_priority_target();
				}
				determine_sprite();
				handle_iframes()
				if(is_near_target()){
					struct.state_machine.ChangeState("attack_windup")
					
				}else{
					handle_pathfinding();
					manage_movement();
				}
			}
		})
		.AddExit(function(){
			with(owner){

			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
	});
	var attack_windup_state = new StatementState(struct.state_machine,"attack_windup")
		.AddEnter(function(){
			with(owner){
				determine_sprite();
				image_index = 0;
				image_speed = 1;
				var attack_windup_cooldown = (time_source_get_state(attack_windup_timer) == time_source_state_initial) or (time_source_get_state(attack_windup_timer) == time_source_state_stopped) or (time_source_get_state(attack_windup_timer) == time_source_state_paused)
				if(attack_windup_cooldown){
					time_source_start(attack_windup_timer)
				}
				path_end();
			}
		})
		.AddUpdate(function(){
			with(owner){
				if(not_null(target)){
					direction = determine_direction(target)
				}
				handle_iframes()
			}	
	})
		.AddExit(function(){
			with(owner){

			}
	})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
	});	
	var attack_state = new StatementState(struct.state_machine,"attack")
		.AddEnter(function(){
			with(owner){
				determine_sprite();
				var attack_cooldown = (time_source_get_state(attack_timer) == time_source_state_initial) or (time_source_get_state(attack_timer) == time_source_state_stopped) or (time_source_get_state(attack_timer) == time_source_state_paused)
				if(attack_cooldown){
					time_source_start(attack_timer)
				}
				image_index = 0;
				image_speed = 1;
				handle_iframes()
			}
		})
		.AddUpdate(function(){
			with(owner){
				
			}
		})
		.AddExit(function(){
			with(owner){
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
	});	
    var stunned_state = new StatementState(struct.state_machine,"stunned")
		.AddEnter(function(){
			with(owner){
				//path_end()
                movement_locked = true;
				if(struct.knockback_time > 0){
					if(time_source_get_state(knockback_timer) != time_source_state_active){
						time_source_reconfigure(knockback_timer,struct.knockback_time,time_source_units_seconds,knockback_complete)
						time_source_start(knockback_timer);
					}
				}
				if(struct.stun_amount > 0){
					if(time_source_get_state(stun_timer) != time_source_state_active){
						time_source_reconfigure(stun_timer,struct.stun_amount,time_source_units_seconds,stun_complete)
						time_source_start(stun_timer);
					}
				}
			}
		})
		.AddUpdate(function(){
			with(owner){
				if(struct.knockback_amount > 0){
					apply_knockback();
				}
				if(struct.stun_amount > 0){
					struct.stun_amount--;
					stun_index++;
					if(stun_index > sprite_get_number(spr_effect_stun)){
						stun_index = 0;
					}
				}
				handle_iframes()
			}
		})

		.AddExit(function(){
			with(owner){
				stun_index = 0;
                movement_locked = false;
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
				if(struct.stun_amount > 0){
					draw_sprite_ext(spr_effect_stun,stun_index,x,y,1,1,0,c_white,1);
				}
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
		});
    var dead_state = new StatementState(struct.state_machine,"dead")
		.AddEnter(function(){
			with(owner){
				determine_sprite();
                
				image_index = 0;
				image_speed = 0;
				handle_iframes()
			}
		})
		.AddUpdate(function(){
			with(owner){
				
			}
	});


			
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	.AddState(wander_state)
	.AddState(chase_state)
	.AddState(attack_windup_state)
	.AddState(attack_state)
    .AddState(stunned_state)
    .AddState(dead_state)


	struct.state_machine.QueueState(default_state)
}