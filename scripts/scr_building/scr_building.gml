
function build_init_builder(){
	if(is_null(listener_instance)){
		var builder_entity = retrieve_entity("buildersystem",global.system_entities)
		builder_entity.spawn_entity(0,0,"System");
		listener_instance = builder_entity.instance
	}
}

function build_listener_enter_build_mode(){
	if(not_null(listener_instance)){
		listener_instance.struct.state_machine.ChangeState("piece_select");
	}else{
		EchoDebug("No Builder Instance Found. Build mode cannot be entered.")
	}
}

function build_listener_exit_build_mode(){
	if(not_null(listener_instance)){
		listener_instance.struct.state_machine.ChangeState("inactive");
	}else{
		EchoDebug("No Builder Instance Found. Build mode cannot be exited. How did you get here?")
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
}

function handle_piece_movement(x_increment,y_increment){
	var grid_limits = [];
	core_2d_grid_check_menu_bounds(struct.grid,grid_limits);
	var temp_coords = [piece_x_index + x_increment,piece_y_index + y_increment]
	if(temp_coords[0] > grid_limits[0]){
		//x_value is too high
		temp_coords[0] = 0
	}else if(temp_coords[0] < 0){
		//x_value is below 0
		temp_coords[0] = grid_limits[0];
	}
	
	if(temp_coords[1] > grid_limits[1]){
		//y_value is too high
		temp_coords[1] = 0;
	}else if(temp_coords[1] < 1){
		//y_value is below 0
		temp_coords[1] = grid_limits[1];
	}
	
	piece_x_index = temp_coords[0];
	piece_y_index = temp_coords[1];
}

function builder_get_next_column_piece(){
	var grid_limits = [];
	core_2d_grid_check_menu_bounds(struct.grid,grid_limits);
	var temp_coords = builder_x_index + 1
	if(temp_coords[0] > grid_limits[0]){
		//x_value is too high
		temp_coords[0] = 0
	}else if(temp_coords[0] < 0){
		//x_value is below 0
		temp_coords[0] = grid_limits[0];
	}
}


function builder_get_previous_column_piece(){
	var grid_limits = [];
	core_2d_grid_check_menu_bounds(struct.grid,grid_limits);
	var temp_coords = [piece_x_index + x_increment,piece_y_index + y_increment]
	if(temp_coords[0] > grid_limits[0]){
		//x_value is too high
		temp_coords[0] = 0
	}else if(temp_coords[0] < 0){
		//x_value is below 0
		temp_coords[0] = grid_limits[0];
	}
}

function builder_get_next_row_piece(){
	
}

function builder_get_previous_row_piece(){
	
}