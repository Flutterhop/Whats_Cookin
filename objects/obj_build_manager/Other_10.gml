event_inherited();

aim_distance = 120;

builder_x_index = 0;
builder_y_index = 0;
builder_z_index = 0;

piece_x_index = 0;
piece_y_index = 0;

spawn_x_pos = 0
spawn_y_pos = 0

current_blueprint = "";
previous_blueprint = "";
next_blueprint = "";

can_place = false;

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var piece_select_state = new StatementState(struct.state_machine,"piece_select")
		.AddEnter(function(){
			with(owner){
				if(not_null(struct.player)){
					struct.player.state_machine.ChangeState("piece_select")
				}
			}
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls()
			} 
		})
		.AddDraw(function(){
			with(owner){
				if(not_null(struct.builder_grid)){
					if(not_null(current_blueprint) and not_null(struct.player)){
						var draw_x = (get_screen_center_x())
						var draw_y = (get_screen_center_y() + (window_get_height() / 10))
						if(not_null(current_blueprint)){
							draw_sprite(current_blueprint.structure_sprite,0,draw_x,draw_y);
						}
						if(not_null(previous_blueprint)){
							draw_sprite(previous_blueprint.structure_sprite,0,draw_x - (sprite_get_width(previous_blueprint.structure_sprite) * 1.2),draw_y);
						}
						if(not_null(next_blueprint)){
							draw_sprite(next_blueprint.structure_sprite,0,draw_x + (sprite_get_width(previous_blueprint.structure_sprite) * 1.2),draw_y);
						}
					}
				}
			}
		});
	var placement_state = new StatementState(struct.state_machine,"placement_state")
		.AddEnter(function(){
			with(owner){
				if(not_null(struct.player)){
					struct.player.state_machine.ChangeState("build")
					aim_distance = struct.player.get_stat("interaction_distance")
				}
			}
		})
		.AddUpdate(function(){
			with(owner){
				interpret_player_controls()
			}
		})
		.AddDraw(function(){
			with(owner){ 
				if(not_null(struct.builder_grid)){
					if(not_null(current_blueprint) and not_null(struct.player)){
						if(can_place()){
							draw_sprite_ext(current_blueprint.structure_sprite,0,spawn_x_pos,spawn_y_pos,1,1,0,c_green,1);
						}else{
							draw_sprite_ext(current_blueprint.structure_sprite,0,spawn_x_pos,spawn_y_pos,1,1,0,c_red,1);
						}
					}
				}
				/*with(struct){ 
					if(not_null(grid)){
						if(not_null(grid.grid_data)){
							for (var i = 0; i < grid.width; i++;){
								for (var j = 0; j < grid.height; j++;){
									var cell = ds_grid_get(grid.grid_data,i,j);
									var tile_bottom_x_pos = (i * grid.cell_width)
									var tile_bottom_y_pos = (j * grid.cell_height)
									var tile_top_x_pos = (i * grid.cell_width) + (grid.cell_width);
									var tile_top_y_pos = (j * grid.cell_height) + (grid.cell_height);
									draw_rectangle_colour(tile_top_x_pos,tile_top_y_pos,tile_bottom_x_pos,tile_bottom_y_pos,c_blue,c_blue,c_blue,c_blue,true);
									//scribble(string_concat(string(cell.cell_content,"occupied"))).starting_format("main_sm").draw(cell.x_pos - 10,cell.y_pos - 20)
									//scribble(string_concat(cell.y_pos)).starting_format("main_sm").draw(cell.x_pos - 10,cell.y_pos - 10)
								}
							}
						}
						draw_set_alpha(0.3);
						mp_grid_draw(grid.mp_grid_data);
						draw_set_alpha(1);
					}
				}*/
			}
		});
	var inactive_state = new StatementState(struct.state_machine,"inactive")
		.AddUpdate(function(){
			with(owner){
				
			}
		});
	
	struct.state_machine
	.AddState(piece_select_state)
	.AddState(placement_state)
	.AddState(inactive_state)

}
