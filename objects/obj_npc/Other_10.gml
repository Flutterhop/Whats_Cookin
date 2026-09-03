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


death_time = 360;
death_effect = "";

//ATTACK PARAMETERS
target_range = 100;
target_x = 0;
target_y = 0;
collision_targets  = struct.grid.fetch_collision_array();
array_push(collision_targets,obj_character_game)

//TEMPLATES
idle_template = "";
move_template = "";
wander_template = "";
chase_template = "";
attack_template = "";
attack_windup_template = "";
stunned_template = "";
dead_template = "";
draw_event_template = ""


function init_state_machine(){
	init_state_machine_templates()
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	struct.state_machine.AddStateTemplate(idle_template)
	struct.state_machine.AddStateTemplate(move_template)
	struct.state_machine.AddStateTemplate(wander_template)
	struct.state_machine.AddStateTemplate(chase_template)
	struct.state_machine.AddStateTemplate(attack_template)
	struct.state_machine.AddStateTemplate(attack_windup_template)
	struct.state_machine.AddStateTemplate(stunned_template)
	struct.state_machine.AddStateTemplate(dead_template)
	struct.state_machine.QueueState(default_state)
}


function init_state_machine_templates(){
	struct.state_machine = new Statement(self);
	draw_template = function(){
		if(global.debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}

	}
	
	idle_template = new StatementStateTemplate("idle")
		.AddEnter(function(){
			determine_sprite();
			image_index = 0;
			image_speed = 0;

		})
		.AddUpdate(function(){
				var state_time = struct.state_machine.GetStateTime()
				if(state_time > idle_time){
					struct.state_machine.ChangeState(active_state)
				}
				if(not_null(target)){
					direction = determine_direction(target)
				}
				
				handle_iframes()
		});
	idle_template.AddDraw(draw_template);
	move_template = new StatementStateTemplate("move")
		.AddEnter(function(){
			determine_sprite(); 
			image_index = 0;
			image_speed = 1;
			})
		.AddUpdate(function(){
			if(not_null(target)){
				direction = determine_direction(target)
			}
			handle_iframes()
			determine_sprite();
			handle_pathfinding();
			manage_movement();
		});
	move_template.AddDraw(draw_template);
	wander_template = new StatementStateTemplate("wander")
		.AddEnter(function(){
				determine_sprite(); 
				image_index = 0;
				image_speed = 1;
		})
		.AddUpdate(function(){
				if(not_null(target)){
					direction = determine_direction(target)
				}
				handle_iframes()
				determine_sprite(); 
				handle_pathfinding();
				manage_movement();

		});
	wander_template.AddDraw(draw_template);
	chase_template = new StatementStateTemplate("chase")
		.AddEnter(function(){
			determine_sprite(); 
			image_index = 0;
			image_speed = 1;
		})
		.AddUpdate(function(){
			if(not_null(target)){
				direction = determine_direction(target)
			}else{
				target = find_priority_target();
			}
			determine_sprite();
			handle_iframes()
			if(is_near_target()){
				struct.state_machine.ChangeState("attackwindup")
				
			}else{
				handle_pathfinding();
				manage_movement();
			}

		});
	chase_template.AddDraw(draw_template);
	attack_windup_template = new StatementStateTemplate("attackwindup")
		.AddEnter(function(){
			determine_sprite();
			image_index = 0;
			image_speed = 1;
			path_end();
		})
		.AddUpdate(function(){
			var state_time = struct.state_machine.GetStateTime();
			if(state_time > struct.stats.attack_windup){
				struct.state_machine.ChangeState("attack")
			}
			if(not_null(target)){
				direction = determine_direction(target)
			}
			handle_iframes()
	});
	chase_template.AddDraw(draw_template);
	attack_template = new StatementStateTemplate("attack")
		.AddEnter(function(){
			determine_sprite();
			image_index = 0;
			image_speed = 1;
		})
		.AddUpdate(function(){
			handle_iframes();
		});	
	stunned_template = new StatementStateTemplate("stunned")
		.AddEnter(function(){ 
			movement_locked = true;
		})
		.AddUpdate(function(){
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
		})
		.AddExit(function(){
			movement_locked = false;
		});
	stunned_template.AddDraw(draw_template);
    dead_template = new StatementStateTemplate("dead")
		.AddEnter(function(){
				determine_sprite();
                
				image_index = 0;
				image_speed = 0;
				handle_iframes();
				spawn_loot();
				death_effect = instance_create_layer(x,y,"effects",obj_death_effect,{source : other})
		})
		.AddUpdate(function(){
			if(is_null(death_effect)){
				death_time--;
				if(death_time <=0){
					instance_destroy(self,true);
				}
			}else{ 
				if(death_time <=0){
					instance_destroy(death_effect)
					instance_destroy(self,true);
				}
			} 
	});
	dead_template.AddDraw(draw_template);
}