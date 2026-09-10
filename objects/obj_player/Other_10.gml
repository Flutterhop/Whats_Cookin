event_inherited()

move_wrap(true,true,100);
//INPUT
up_input = 0;
down_input = 0;
left_input = 0;
right_input = 0;

movement_locked = false

//Jumping
jump_speed = 3;
fall_speed = 2;
max_height = 30;
jumping = false;
falling = false;

//COLLISION
additional_collisions = []
collision_targets  = struct.grid.fetch_collision_array([additional_collisions]);

struct.equipment = "pan"
equipment_sprite = "";
friction_amount = .7;

//DRAWING
visual_speed = 1;//Speed the image should run at.
stun_index = 0;//used to animate stun effect

function init_state_machine(){
	struct.state_machine = new Statement(self)
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	
	draw_template = function(){
		with(owner){
			if(not_null(equipment_sprite)){
		    	draw_sprite_ext(equipment_sprite,image_index,x,y,image_xscale,image_yscale,0,c_white,1);
			}
			
			var interact_coord = get_interact_shape(direction);
			
			var x_pos = ((interact_coord[0] + x) + (interact_coord[2] + x))/2
			var y_pos = ((interact_coord[1] + y) + (interact_coord[3] + y))/2
			draw_rectangle_colour(x + interact_coord[0],y + interact_coord[1],x + interact_coord[2],y + interact_coord[3],c_black,c_black,c_black,c_black,true)
			draw_circle_colour(x_pos,y_pos,2,c_red,c_red,true)
			
			
			if(struct.stun_amount > 0){
				draw_sprite_ext(spr_effect_stun,image_index,x,y,1,1,0,c_white,1);
			}
			
			
			if(not_null(direction_facing)){
				switch(direction_facing){
					case "up":
						image_xscale = 1;
					break;
					case "down":
						image_xscale = 1;
					break;
					case "left":
						image_xscale = 1;
					break;
					case "right":
						image_xscale = -1;
					break;
				}
			}
			
			draw_character();
			
			//if(not_null(shadow_sprite)){
				//draw_sprite_ext(shadow_sprite,0,x,y+z_position,1,1,0,c_white,1);
			//}
			//if(not_null(sprite_index) and sprite_index != -1){
			//	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,1)
			//}
			
			draw_health()
		}
		
		
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				image_speed = 0;
			}
		})
		.AddUpdate(function(){
			with(owner){
				//determine_sprite();
				direction_facing = determine_direction_facing(direction);
				interpret_player_controls();
				handle_movement();
				reset_input();
				reset_speed();
				handle_iframes();
			}
			
	});
	idle_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){
			with(owner){
				image_speed = visual_speed;
			}
		})
		.AddUpdate(function(){
			with(owner){
				//determine_sprite();
				direction_facing = determine_direction_facing(direction);
				interpret_player_controls();
				handle_movement();
				reset_input();
				reset_speed();
				handle_iframes();
			}

	});
	move_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddUpdate(function(){
			with(owner){
				//determine_sprite("","")
				direction_facing = determine_direction_facing(direction);
				interpret_player_controls();
				handle_movement();
				handle_holding();
				reset_input();
				reset_speed();
				handle_iframes();
			}
		})
		.AddExit(function(){
			with(owner){ }

	});
	hold_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var throw_state = new StatementState(struct.state_machine,"throw")
		.AddEnter(function(){
			with(owner){
				movement_locked = true;	
				image_speed = 0;
			}
		})
		.AddUpdate(function(){
			with(owner){
				//determine_sprite("","")
				direction_facing = determine_direction_facing(direction);
				interpret_player_controls();
				handle_holding();
				reset_input();
				handle_iframes();
			}
		})
		.AddExit(function(){
			with(owner){
				movement_locked = false;
			}
		

	});
	throw_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var interact_state = new StatementState(struct.state_machine,"interact")
		.AddEnter(function(){
			with(owner){
				//determine_sprite("","");
				image_index = 0
				movement_locked = true;
			}
		})
		.AddUpdate(function(){
			with(owner){
				direction_facing = determine_direction_facing(direction);
				handle_interaction();
			}

		})
		.AddExit(function(){
			with(owner){
				movement_locked = false;
			}
		});
	interact_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var attack_state = new StatementState(struct.state_machine,"attack")
		.AddEnter(function(){
			with(owner){
				movement_locked = true;
               // determine_sprite("pan","slash")
                image_index = 0;
				image_speed = 1;
			}
		})
		.AddUpdate(function(){
			with(owner){
				direction_facing = determine_direction_facing(direction);
                var attack_targets = attack_collision();
				if(is_array(attack_targets)){
					var num_targets = array_length(attack_targets)
					for(var i = 0; i < num_targets;i++){
						var current_target = attack_targets[i];
						if(is_instanceof(current_target.struct,Character_Game)){
							if(!current_target.struct.state_machine.IsInState("dead")){
								current_target.struct.take_damage(self,struct.get_stat("damage_amount"),20,direction,20,10)
							}
						}
					}
				}
				var state_time = struct.state_machine.GetStateTime();
				if(state_time > struct.stats.attack_speed){
					change_state("idle");
				}
				handle_iframes();
			}
        });
	attack_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var stunned_state = new StatementState(struct.state_machine,"stunned")
		.AddEnter(function(){
			with(owner){
                movement_locked = true;
			}
		})
		.AddUpdate(function(){
			with(owner){
				direction_facing = determine_direction_facing(direction);
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
		});
	stunned_state.AddDraw(draw_template)
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var dead_state = new StatementState(struct.state_machine,"dead")
		.AddEnter(function(){
			with(owner){
				
				movement_locked = true;
				//determine_sprite()
				image_index = 0;
				image_speed = 0;
				struct.iframes = true;
			}
		})
		.AddUpdate(function(){
			with(owner){
				direction_facing = determine_direction_facing(direction);
			}
			}) 
		.AddExit(function(){
			with(owner){
				movement_locked = true;
				//determine_sprite()
				image_index = 0;
				image_speed = 1;
				struct.iframes = false;
			}
		});
	dead_state.AddDraw(draw_template)
	
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	.AddState(hold_state)
	.AddState(throw_state)
	.AddState(interact_state)
	.AddState(attack_state)
	.AddState(stunned_state)
	.AddState(dead_state)

	struct.state_machine.ChangeState("idle")
}

function init_player_ui(){
	
	
}