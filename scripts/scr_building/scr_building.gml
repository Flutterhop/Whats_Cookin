
function build_init_builder(player){
	if(is_null(listener_instance)){
		var builder_entity = retrieve_entity("buildersystem",global.system_entities)
		builder_entity.spawn_entity(0,0,"System");
		array_push(listener_instances,builder_entity.instance)
		builder_entity.player = player;
		
	}
}

function build_listener_enter_build_mode(player){
	var builder_count = array_length(listener_instances);
	if(builder_count > 0){
		for(var i = 0; i < builder_count;i++){
			var current_builder = listener_instances[i];
			if(not_null(current_builder)){
				if(current_builder.struct.state_machine.IsInState("inactive")){
					current_builder.struct.state_machine.ChangeState("piece_select");
				}
				if(is_null(current_builder.struct.player)){
					current_builder.struct.player = player;
				}
			}
		}
	}else{
		init_builder(player);
		EchoDebug("No Builder Instance Found. Initializing Builder")
	}
}

function build_listener_exit_build_mode(player){
	var builder_count = array_length(listener_instances);
	if(builder_count > 0){
		for(var i = 0; i < builder_count;i++){
			var current_builder = listener_instances[i];
			if(not_null(current_builder)){
				if(!current_builder.struct.state_machine.IsInState("inactive")){
					current_builder.struct.state_machine.ChangeState("inactive");
				}
			}
		}
	}else{
		EchoDebug("No Builder Instance Found. Build mode cannot be exited. How did you get here?")
	}
}

function listener_remove_builder_player(player){
	var player_count = array_length(active_players);
	if(player_count > 0){
		for(var i = 0; i < player_count;i++){
			var current_player = active_players[i];
			if(current_player.player_number == player.player_number){
				current_player.state_machine.ChangeState("idle");
				array_delete(active_players,i,1);
				var updated_count = array_length(active_players)
				if(updated_count <= 0){
					end_builder();
				}else{
					return;
				}
			}
		}
	}
}

function listener_add_builder_player(player){
	var player_count = array_length(active_players);
	var player_found = false;
	if(player_count > 0){
		for(var i = 0; i < player_count;i++){
			var current_player = active_players[i];
			if(current_player.player_number == player.player_number){
				player_found = true;
			}
		}
	}else{
		array_push(active_players,player);
		return;
	}
	
	if(!player_found){
		array_push(active_players,player);
	}
}

function build_load_builder_grid(){
	var kitchen_structures = retrieve_filtered_structs(global.structure_entities,Kitchen_Structure);
	var kitchen_struct_count = array_length(kitchen_structures);
	if(ds_grid_width(struct.builder_grid) <= 0){
		ds_grid_resize(struct.builder_grid,2,ds_grid_height(struct.builder_grid));
	}
	if(ds_grid_height(struct.builder_grid) <= kitchen_struct_count){
		ds_grid_resize(struct.builder_grid,ds_grid_width(struct.builder_grid),kitchen_struct_count);
	}
	for(var i = 0;i < kitchen_struct_count; i++){
		ds_grid_add(struct.builder_grid,0,i,kitchen_structures[i]);
	}
	var defense_structures = retrieve_filtered_structs(global.structure_entities,Defense_Structure);
	var defense_struct_count = array_length(defense_structures);
	for(var j = 0;j < defense_struct_count; j++){
		ds_grid_add(struct.builder_grid,1,j,defense_structures[j]);
	}
	current_blueprint 	= ds_grid_get(struct.builder_grid,0,0);
	previous_blueprint 	= ds_grid_get(struct.builder_grid,ds_grid_width(struct.builder_grid) - 1,0);
	next_blueprint 		= ds_grid_get(struct.builder_grid,1,0);
}


function builder_handle_builder_movement(x_increment,y_increment){
	var width = ds_grid_width(struct.builder_grid);
	var height = ds_grid_height(struct.builder_grid);
	var prev_coords = [builder_x_index,builder_y_index]
	var temp_coords = [builder_x_index + x_increment,builder_y_index + y_increment]
	if(temp_coords[0] >= width){
		//x_value is too high
		temp_coords[0] = 0
	}else if(temp_coords[0] < 0){
		//x_value is below 0
		temp_coords[0] = width - 1;
	}
	if(temp_coords[1] >= height){
		//y_value is too high
		temp_coords[1] = 0;
	}else if(temp_coords[1] < 0){
		//y_value is below 0
		temp_coords[1] = height - 1;
	}

	builder_x_index = temp_coords[0];
	builder_y_index = temp_coords[1];
	EchoDebug("==========================================")
	//EchoDebug(string_concat("builder_index: ","x - ",builder_x_index,","," y - ",builder_y_index))
	var new_blueprint = ds_grid_get(struct.builder_grid,builder_x_index,builder_y_index);
	if(not_null(new_blueprint)){
		//EchoDebug(string_concat("current_blueprint_coords: ",temp_coords[0],",",temp_coords[1]))
		EchoDebug(string_concat("current_blueprint: ",new_blueprint.name))
		previous_blueprint = set_adjacent_blueprint(-1);
		current_blueprint = new_blueprint;
		next_blueprint = set_adjacent_blueprint(1);
	}else{
		handle_builder_movement(x_increment,y_increment);
	}
}

function builder_set_adjacent_blueprint(x_increment,attempt_num = 0){
	if(attempt_num > ds_grid_width(struct.builder_grid)){
		return;
	}
	var blueprint_to_set = "";
	var width = ds_grid_width(struct.builder_grid);
	var height = ds_grid_height(struct.builder_grid);
	var temp_coords = [builder_x_index + x_increment,builder_y_index]
	if(temp_coords[0] >= width){
		//x_value is too high
		temp_coords[0] = 0
	}else if(temp_coords[0] < 0){
		//x_value is below 0
		temp_coords[0] = width - 1;
	}
	if(temp_coords[1] > height){
		//y_value is too high
		temp_coords[1] = 0;
	}else if(temp_coords[1] < 0){
		//y_value is below 0
		temp_coords[1] = height - 1;
	}
	var adjacent_structure = ds_grid_get(struct.builder_grid,temp_coords[0],temp_coords[1]);
	if(not_null(adjacent_structure)){
		blueprint_to_set = adjacent_structure;
		//EchoDebug(string_concat("adjacent_structure_coords: ",temp_coords[0],",",temp_coords[1]))
		EchoDebug(string_concat("adjacent_structure ",blueprint_to_set.name))
		return blueprint_to_set;
	}else{
		blueprint_to_set = set_adjacent_blueprint(x_increment + x_increment,attempt_num + 1);
	}
}


function build_end_builder(){
	var builder_count = array_length(listener_instances);
	if(builder_count > 0){
		for(var i = 0; i < builder_count;i++){
			var current_builder = listener_instances[i];
			if(not_null(current_builder)){
				array_delete(listener_instances,i,1);
				instance_destroy(current_builder);
			}
		}
	}
}

function builder_place_piece(){
	if(not_null(current_blueprint)){

		var collisions = ds_list_create()
		var coords = 0;
		var targets = [obj_item_game,obj_structure_game]
		var x_pos
		var y_pos
		with(struct.player.instance){
			var range = interact_dist;
			var dist = interact_range;
			coords = get_interact_shape(direction,range,dist);
			
			x_pos = ((coords[0] + x) + (coords[2] + x))/2 
			y_pos = ((coords[1] + y) + (coords[3] + y))/2
			
		}
		var is_interior = struct.grid.is_interior(x_pos,y_pos)
		if(is_interior and !current_blueprint.stats.allow_interior){
			return false;
		}
		if(!is_interior and !current_blueprint.stats.allow_exterior){
			return false;
		}
		x_pos /= struct.grid.cell_width
		y_pos /= struct.grid.cell_height
		x_pos = floor(x_pos)
		y_pos = floor(y_pos)
		
		var new_structure = variable_clone(current_blueprint);
		current_blueprint = new_structure;
		new_structure.spawn_entity(x_pos,y_pos,"Structures");
		
	}
}

function builder_exit_placement(){
	struct.state_machine.ChangeState("piece_select");
}

function builder_find_spawn_cell(){
	var x_pos = 0;
	var y_pos = 0;
	with(struct.player.instance){
		var range = interact_dist;
		var dist = interact_range;
		var draw_coords = get_interact_shape(direction,range,dist);
		x_pos = ((draw_coords[0] + x) + (draw_coords[2] + x))/2 
		y_pos = ((draw_coords[1] + y) + (draw_coords[3] + y))/2
		x_pos /= struct.grid.cell_width
		y_pos /= struct.grid.cell_height
		x_pos = round(x_pos)
		y_pos = round(y_pos)
	}
	spawn_x_pos = (x_pos * struct.grid.cell_width) + struct.grid.cell_width / 2
	spawn_y_pos = (y_pos * struct.grid.cell_height) + struct.grid.cell_height / 2	
	
}

function builder_can_place(){
	with(struct.player.instance){
		var collisions = ds_list_create()
		var range = interact_dist;
		var dist = interact_range;
		var targets = [obj_character_game]
		var coords = get_interact_shape(direction,range,dist);
		var x_pos = ((coords[0] + x) + (coords[2] + x))/2 
		var y_pos = ((coords[1] + y) + (coords[3] + y))/2
		var is_interior = struct.grid.is_interior(x_pos,y_pos)
		if(is_interior and !other.current_blueprint.stats.allow_interior){
			return false;
		}
		if(!is_interior and !other.current_blueprint.stats.allow_exterior){
			return false;
		}
		x_pos /= struct.grid.cell_width
		y_pos /= struct.grid.cell_height
		x_pos = floor(x_pos)
		y_pos = floor(y_pos)
		other.spawn_x_pos = (x_pos * struct.grid.cell_width) + struct.grid.cell_width / 2
		other.spawn_y_pos = (y_pos * struct.grid.cell_height) + struct.grid.cell_height / 2	
		collision_rectangle_list(x+coords[0],
							y+coords[1],
							x+coords[2],
							y+coords[3],
							targets,
							true,
							true,
							collisions,
							true
							)
		
		var total_collisions = ds_list_size(collisions)
		if(total_collisions > 0){
			//If collisions exist then we cant place an item
			return false;
		}
		var current_cell = struct.grid.get_cell(x_pos,y_pos)
		if(current_cell.is_occupied){
			return false;
		}

	}
	
	return true;
}
