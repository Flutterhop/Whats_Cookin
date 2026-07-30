event_inherited()

//INPUT
up_input = 0;
down_input = 0;
left_input = 0;
right_input = 0;

//HOLDING
held_item = "";
held_structure = "";

//Throwing
throw_charge = 60;
throw_strength = 10;
movement_locked = false

//COLLISION
collision_targets  = struct.grid.fetch_collision_array();

//DRAWING
visual_speed = 1;//Speed the image should run at.


function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddEnter(function(){
			with(owner){
				image_index = 0
				determine_sprite(struct.equipment);
			}
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				//if(not_null(held_item) or not_null(held_structure)){struct.state_machine.ChangeState("hold")}
				handle_holding();
				
				image_speed = 0;
				if(x_speed != 0) or (y_speed != 0){
					struct.state_machine.ChangeState("move")
				}
				reset_input();
				reset_speed();
			}
			
		})
		.AddDraw(function(){
			with(owner){
				scribble(direction).draw(x - 50,y - 50);
				scribble(direction_facing).draw(x + 50,y - 50);
			}
	});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){

		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				if(x_speed != 0) or (y_speed != 0){
					image_speed = visual_speed;
				}else{
					image_speed = 0;
					struct.state_machine.ChangeState("idle")
				}
				handle_holding();
				reset_input();
				reset_speed();
			}
		})
		.AddDraw(function(){
			with(owner){
				//scribble(string_concat(x-xprevious,"",y-yprevious)).draw(x - 50,y - 50)
				scribble(direction).draw(x - 50,y - 50)
				scribble(direction_facing).draw(x + 50,y - 50);
			}


	});
	var hold_state = new StatementState(struct.state_machine,"hold")
		.AddUpdate(function(){
			with(owner){
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
			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(direction).draw(x - 50,y - 50)
				scribble(direction_facing).draw(x + 50,y - 50);
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
				interpret_player_controls();
				handle_movement();
				move_wrap(true,true,100);
				handle_holding();
				reset_input();
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
			
	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	.AddState(hold_state)
	.AddState(throw_state)
	.AddState(interact_state)

	struct.state_machine.ChangeState("idle")
}