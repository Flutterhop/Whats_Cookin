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
idle_time = 120; // default one second of idle when entering the state.
movement_locked = false;
friction_amount = .2;
direction_facing = "left";


//ATTACK PARAMETERS
target_range = 100;
target_x = 0;
target_y = 0;
collision_targets  = struct.grid.fetch_collision_array();
array_push(collision_targets,obj_character_game)

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
				var state_time = struct.state_machine.GetStateTime()
				if(state_time > idle_time){
					struct.state_machine.ChangeState(active_state)
				}
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
				path_end();
			}
		})
		.AddUpdate(function(){
			with(owner){
				var state_time = struct.state_machine.GetStateTime();
				if(state_time > struct.stats.attack_windup){
					struct.state_machine.ChangeState("attack")
				}
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
				image_index = 0;
				image_speed = 1;
			}
		})
		.AddUpdate(function(){
			with(owner){
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
	var stunned_state = new StatementState(struct.state_machine,"stunned")
		.AddEnter(function(){
			with(owner){
                movement_locked = true;
			}
		})
		.AddUpdate(function(){
			with(owner){
				var knockback_done = false
				var stun_done = false
				var state_time = struct.state_machine.GetStateTime();
				if(struct.knockback_amount > 0){
					apply_knockback();
				}else{
					knockback_done = true;
				}
				if(struct.stun_amount > 0){
					struct.stun_amount--;
				}else{
					stun_done = true;
				}
				handle_iframes();
				if(knockback_done and stun_done){
					struct.state_machine.ChangeState("idle");
				}
			}
		})
		.AddExit(function(){
			with(owner){
				movement_locked = false;

			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
				if(struct.stun_amount > 0){
					draw_sprite_ext(spr_effect_stun,image_index,x,y,1,1,0,c_white,1);
				}
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