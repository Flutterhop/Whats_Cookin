////@description Contains the ds_grid for the game map. Creating a new Map_Grid will create a ds_grid automatically with the dimensions provided.
////@function Map_Grid
////@param {string} Name Grid Name
////@param {real} Width Width of grid as an integer.
////@param {real} Height Height of grid as an integer.
function Map_Grid(_new_name,_new_width,_new_height,_new_mp_width,_new_mp_height) constructor{
	grid_name = _new_name;
	width = _new_width;
	height = _new_height;
	mp_cell_width = _new_mp_width;
	mp_cell_height = _new_mp_height;
	grid_data = "";
	mp_grid_data = "";
	cell_width = 32;
	cell_height = 32;
	starting_x = 32;
	starting_y = 128;
	allow_diagonal = true;
	is_precise = false;
	
	if(is_null(grid_data)){
		//This may need to default to width = 15, height = 9
		//bc 480 / 32 = 15 && 270 / 30 = 9
		//32 does not divide evenly into 32, so it either needs to increase or decrease.
		grid_data = ds_grid_create(width,height);
		//cell width and height may change depending on how we want entities to navigate the space.
		//the number of vertical and horizontal cells is determined by the space alloted in the 
		//given room. in our case a room of size 544x544 gives us a clean 32x32 cell count.
		mp_grid_data = mp_grid_create(starting_x,starting_y,cell_width,cell_height,mp_cell_width,mp_cell_height);
		
	}
	////@description Add objects for avoidance in the mp_grid
	////@function add_obstacles
	////@param {array} items_to_add array of items to add as obstacles.
	static add_obstacles = function(items_to_add){
		var num_of = array_length(items_to_add);
		for(var i = 0; i < num_of;i++){
			var item = items_to_add[i];
			if(not_null(item)){
				mp_grid_add_instances(mp_grid_data,item,is_precise);
				show_debug_message("Item added to obstacle list.");
			}
		}
	}
	////@description Attempts to remove objects from obstacle list.
	////@function remove_obstacle
	////@param {string} x_pos x position
	////@param {string} y_pos y position
	////@param {string} removal_object Object or instance to remove.
	static remove_obstacle = function(x_pos,y_pos,removal_object){
		var result = mp_grid_clear_cell(mp_grid_data,floor(x_pos / mp_cell_width),floor(y_pos / mp_cell_height));
		if(result){
			show_debug_message("Removing item as obstacle.");
		}else{
			show_debug_message("Failed to remove item.");
		}
	}
	
	////@description Attemps to insert a structure at the coordinate provided.
	////@function insert_item_at
	////@param {string} x_coord x_coordinate
	////@param {string} y_coord y_coordinate
	////@param {string} item_to_insert Structure to insert into the Grid Cell at the coordinate.
	static insert_item_at = function(x_coord,y_coord,item_to_insert){
		var cell = ds_grid_get(grid_data,x_coord,y_coord);
		if(is_instanceof(cell,Grid_Cell)){
			var contents = struct_get(cell,"cell_content");
			// if contents are null and not an instance, we can place the item.
			if(is_null(contents) && !instance_exists(contents)){
				//place item here.
				ds_grid_set(grid_data,x_coord,y_coord,item_to_insert);
			}
		}
	}
	
	////@description Attemps to insert a structure at the coordinate provided.
	////@function insert_item_at
	////@param {string} x_coord x_coordinate
	////@param {string} y_coord y_coordinate
	////@param {string} item_to_insert Structure to insert into the Grid Cell at the coordinate.
	static get_cell = function(x_coord,y_coord){
		var cell = ds_grid_get(grid_data,x_coord,y_coord);
		if(not_null(cell)){
			return cell;
		}
	}
	
	static set_path = function(_path,start_x,start_y,target_x,target_y){
		try{
			var result = mp_grid_path(mp_grid_data,_path,start_x,start_y,target_x,target_y,allow_diagonal);		
			if(result){
				show_debug_message("Path found, updating data...");
			}else{
				show_debug_message("Path cannot be found...");
			}
		}catch(_exception){
			show_debug_message(_exception.message);
		    show_debug_message(_exception.longMessage);
		    show_debug_message(_exception.script);
		    show_debug_message(_exception.stacktrace);
		}
	}
}

function Grid_Cell(new_x_pos,new_y_pos) constructor{
	x_pos = new_x_pos;
	y_pos = new_y_pos;
	cell_content = "";
	
	static set_content = function(item_to_set){
		if(not_null(item_to_set)){
			//Warn if cell is occupied.
			if(is_null(cell_content)){
				cell_content = item_to_set;
			}else{
				show_debug_message("Cell already occupied, overwriting with new content.")
			}
		}

	}
	static get_content = function(){
		if(not_null(cell_content)){
			return cell_content;
		}else{
			show_debug_message("No content in this cell. Returning blank.");
			return "";
		}

	}

}

