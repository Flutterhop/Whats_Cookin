event_inherited()

//INPUT
up_input = 0;
down_input = 0;
left_input = 0;
right_input = 0;

//HOLDING
held_item = "";
held_structure = "";

movement_locked = false

//Jumping
jump_speed = 3;
fall_speed = 2;
max_height = 30;
jumping = false;
falling = false;

//COLLISION
collision_targets  = struct.grid.fetch_collision_array();

struct.equipment = "pan"
equipment_sprite = "";
friction_amount = .7;

//DRAWING
visual_speed = 1;//Speed the image should run at.
stun_index = 0;//used to animate stun effect


function init_state_machine(){
	struct.state_machine = new Statement(self)
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				image_index = 0
				image_speed = 0;
			}
		})
		.AddUpdate(function(){
			with(owner){
				determine_sprite();
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				//if(not_null(held_item) or not_null(held_structure)){struct.state_machine.ChangeState("hold")}
				handle_holding();
				
				if(x_speed != 0) or (y_speed != 0){
					struct.state_machine.ChangeState("move")
				}
				reset_input();
				reset_speed();
				handle_iframes();
			}
			
		})
		.AddExit(function(){
			with(owner){
				reset_timers()
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

		})
		.AddUpdate(function(){
			with(owner){
				determine_sprite();
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				if(x_speed != 0) or (y_speed != 0){
					image_speed = visual_speed;
				}else{
					struct.state_machine.ChangeState("idle")
				}
				handle_holding();
				reset_input();
				reset_speed();
				handle_iframes();
			}
		})
		.AddExit(function(){
			with(owner){
				reset_timers()
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}


	});
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddUpdate(function(){
			with(owner){
				determine_sprite("","hold")
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				if(x_speed != 0) or (y_speed != 0){
					image_speed = visual_speed;
				}else{
					image_speed = 0;
				}
				handle_holding();
				reset_input();
				reset_speed();
				handle_iframes();
			}
		})
		.AddExit(function(){
			with(owner){
				reset_timers()
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}

	});
	var throw_state = new StatementState(struct.state_machine,"throw")
		.AddEnter(function(){
			with(owner){
				movement_locked = true;	
				image_speed = 0;
			}
		})
		.AddUpdate(function(){
			with(owner){
				determine_sprite("","hold")
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				handle_holding();
				reset_input();
				handle_iframes();
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
		})
		.AddExit(function(){
			with(owner){
				movement_locked = false;
			}
		

	});
	var interact_state = new StatementState(struct.state_machine,"interact")
		.AddEnter(function(){
			with(owner){
				determine_sprite("","interact");
				image_index = 0
				time_source_create(time_source_game,30,time_source_units_frames,end_interact);
			}
		});	
	var attack_state = new StatementState(struct.state_machine,"attack")
		.AddEnter(function(){
			with(owner){
				movement_locked = true;
                determine_sprite("pan","slash")
				attack_time = .5
				time_source_reset(attack_timer)
				time_source_reconfigure(attack_timer,attack_time,time_source_units_seconds,attack_complete);
				time_source_start(attack_timer)
                image_index = 0;
				image_speed = 1;
			}
		})
		.AddUpdate(function(){
			with(owner){
                var attack_target = attack_collision()
				if(not_null(attack_target)){
                    if(is_instanceof(attack_target.struct,Character_Game)){
						if(!attack_target.struct.state_machine.IsInState("dead")){
							attack_target.struct.take_damage(self,struct.get_damage(),20,direction,20,10)
						}
					}
                    
                }
				handle_iframes();
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
				var interact_coord = get_interact_shape(direction);
				var x_pos = ((interact_coord[0] + x) + (interact_coord[2] + x))/2
				var y_pos = ((interact_coord[1] + y) + (interact_coord[3] + y))/2
				draw_rectangle_colour(x + interact_coord[0],y + interact_coord[1],x + interact_coord[2],y + interact_coord[3],c_red,c_red,c_red,c_red,true)
			}
		})
        .AddExit(function(){
            with(owner){
                movement_locked = false;
				equipment_sprite = "";
				reset_timers()
            }
        });
    var stunned_state = new StatementState(struct.state_machine,"stunned")
		.AddEnter(function(){
			with(owner){
                movement_locked = true;
				if(struct.knockback_time > 0){
					time_source_reconfigure(knockback_timer,struct.knockback_time,time_source_units_frames,knockback_complete)
					time_source_start(knockback_timer);
				}
				if(struct.stun_amount > 0){
					time_source_reconfigure(stun_timer,struct.stun_amount,time_source_units_frames,stun_complete)
					time_source_start(stun_timer);
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
				handle_iframes();
			}
		})
		.AddExit(function(){
			with(owner){
				stun_index = 0;
                movement_locked = false;
				reset_timers()
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
				if(struct.stun_amount > 0){
					draw_sprite_ext(spr_effect_stun,stun_index,x,y,1,1,0,c_white,1);
				}
			}
		});
    var dead_state = new StatementState(struct.state_machine,"dead")
		.AddEnter(function(){
			with(owner){
				reset_timers()
				movement_locked = true;
                determine_sprite()
                image_index = 0;
				image_speed = 0;
                struct.iframes = true;
			}
		})
		.AddUpdate(function(){
			with(owner){
                
			}
        })
            .AddExit(function(){
			with(owner){
				movement_locked = true;
                determine_sprite()
                image_index = 0;
				image_speed = 1;
                struct.iframes = false;
			}
		});
    
			
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