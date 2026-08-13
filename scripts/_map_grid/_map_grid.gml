
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
	cell_width = 32;
	cell_height = 32;
	starting_x = 0;
	starting_y = 0;
	allow_diagonal = true;
	is_precise = false;
	obstacle_tiles_to_check = ["rocks"];
	structure_tiles_to_check = ["kitchen_structures"];
	instances_to_check = [obj_structure_game];
	
	
	//This may need to default to width = 15, height = 9
	//bc 480 / 32 = 15 && 270 / 30 = 9
	//32 does not divide evenly into 32, so it either needs to increase or decrease.
	grid_data = ds_grid_create(width,height);
	//cell width and height may change depending on how we want entities to navigate the space.
	//the number of vertical and horizontal cells is determined by the space alloted in the 
	//given room. in our case a room of size 544x544 gives us a clean 32x32 cell count.
	mp_grid_data = mp_grid_create(0,0,room_width / mp_cell_width,room_height / mp_cell_height,mp_cell_width,mp_cell_height);
	
	static init_grid_data = function(){
		for (var i = 0; i < width; i++;){
			for (var j = 0; j < height; j++;){
				var cell = ds_grid_get(grid_data,i,j);
				if(is_null(cell)){
					var tile_x_pos = (i * cell_width) + (cell_width / 2);
					var tile_y_pos = (j * cell_height) + (cell_height / 2);
					cell = new Grid_Cell(i,j,"");
					ds_grid_set(grid_data,i,j,cell);
				}
			}
	    }
	}
		
	static init_mp_grid_data = function(){
		////INIT TILE PATHING DATA BASED ON EXISTING TILEMAP DATA
		var _w = room_width / mp_cell_width;
		var _h = room_height / mp_cell_height;
		for (var i = 0; i < _w; i++;){
			for (var j = 0; j < _h; j++;){
				//Check All Tile Layers
				var tile_layer_counter = array_length(obstacle_tiles_to_check)
				for(var k = 0; k < tile_layer_counter; k++){
					var o_tile_x_pos = (i * mp_cell_width) + (mp_cell_width / 2);
					var o_tile_y_pos = (j * mp_cell_height) + (mp_cell_height / 2);
					var tiles = layer_tilemap_get_id(obstacle_tiles_to_check[k])
					var tile = tilemap_get_at_pixel(tiles,o_tile_x_pos ,o_tile_y_pos )
					var result = (tile != -1) && (tile != 0);
			        if(result){ // Gets the center position of the tile cell
						mp_grid_add_cell(mp_grid_data, i, j);
					}
				}
				//check structure layers to spawn instances
				var structure_tile_counter = array_length(structure_tiles_to_check);
				for(var l = 0; l < structure_tile_counter; l++){
					 // Gets the center position of the tile cell
					var tile_x_pos = (i * cell_width) + (cell_width / 2);
					var tile_y_pos = (j * cell_width) + (cell_width / 2);
					var tiles = layer_tilemap_get_id(structure_tiles_to_check[l])
					var tile = tilemap_get_at_pixel(tiles,tile_x_pos ,tile_y_pos )
					var result = (tile != -1) && (tile != 0);
					//If structure tile is found we need to spawn it.
			        if(result){
						//get the current tileset, retrieve its name, and check against the tileset name
						var tileset = tilemap_get_tileset(tiles)
						var tileset_name = tileset_get_name(tileset);
						//This removes the tls_ part of the tileset.
						tileset_name = string_delete(tileset_name,0,4);
						var entity = retrieve_entity(tileset_name,global.structure_entities);
						entity.spawn_entity(tile_x_pos,tile_y_pos,"Structures");
						tilemap_set(tiles,0,i,j);
						mp_grid_clear_cell(mp_grid_data,i,j);
					}
				}
				//Check Instances
				var instance_x_pos = (i * mp_cell_width) + (mp_cell_width / 2);
				var instance_y_pos = (j * mp_cell_height) + (mp_cell_height / 2);
				var _instances = ds_list_create()
				instance_position_list(instance_x_pos,instance_y_pos,instances_to_check,_instances,true);
				if(ds_list_size(_instances) > 0){
					var is_occupied = mp_grid_get_cell(mp_grid_data,instance_x_pos,instance_y_pos);
					if(is_occupied == -1){
						mp_grid_add_instances(mp_grid_data,ds_list_find_value(_instances,0),true);
					}
				}
			}
	    }
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
		
	static add_cell_obstacles = function(x_pos,y_pos){
		var x1_pos = x_pos - (cell_width / 2)
		var y1_pos = y_pos - (cell_height / 2)
		var x2_pos = x_pos
		var y2_pos = y_pos
		mp_grid_add_rectangle(mp_grid_data,x1_pos,y1_pos,x2_pos,y2_pos);

	}
	////@description Attempts to remove objects from obstacle list.
	////@function remove_obstacle
	////@param {string} x_pos x position
	////@param {string} y_pos y position
	////@param {string} removal_object Object or instance to remove.
	static remove_obstacle = function(x_pos,y_pos,removal_object){
		var x_coord = floor(x_pos / mp_cell_width)
		var y_coord = floor(y_pos / mp_cell_height)
		var result = mp_grid_clear_cell(mp_grid_data,x_coord,y_coord);
		if(result){
			show_debug_message("Removing item as obstacle.");
		}else{
			show_debug_message("Failed to remove item.");
		}
	}
		
	static remove_multiple_obstacles = function(x_pos,y_pos,removal_object){
		var x1_pos = x_pos - (cell_width / 2)
		var y1_pos = y_pos - (cell_height / 2)
		var x2_pos = x_pos + (cell_width / 2)
		var y2_pos = y_pos + (cell_height / 2)
		var result = mp_grid_clear_rectangle(mp_grid_data,x1_pos,y1_pos,x2_pos,y2_pos);
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
			//place item here.
			cell.cell_content = item_to_insert
			var tile_x_pos = (x_coord * cell_width) + (cell_width / 2);
			var tile_y_pos = (y_coord * cell_height) + (cell_height / 2);
			if(is_null(cell.cell_content.instance)){
				
				//Check if structure
				var struct_type = instanceof(cell.cell_content)
				if(struct_type == "Defense_Structure" or struct_type == "Kitchen_Structure"){
					cell.cell_content.init_structure(tile_x_pos,tile_y_pos,"Instances")
				}
			}else{
				cell.cell_content.instance.x = tile_x_pos;
				cell.cell_content.instance.y = tile_y_pos;
			}

			add_cell_obstacles(tile_x_pos,tile_y_pos);
			
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
		
	////@function set_path
	////@description Tries to find a path to target provided.
	////@param {ref} path asset
	////@param {real} start_x starting x position
	////@param {real} start_y starting y position
	////@param {real} target_x target x position
	////@param {real} target_y target y position
	static set_path = function(_path,start_x,start_y,target_x,target_y,_speed){
		try{
			with(other){
				var result_1 = mp_potential_path_object(_path,target_x,target_y,_speed,4,obj_character_game)
			}
			return true
		}catch(_exception){
			show_debug_message(_exception.message);
		    show_debug_message(_exception.longMessage);
		    show_debug_message(_exception.script);
		    show_debug_message(_exception.stacktrace);
		}
	}
	
	static draw_grid = function(){
	
	}
		
	static fetch_collision_array = function(){
		var return_array = array_create(0)
		var obstacle_layer_counter = array_length(obstacle_tiles_to_check);
		var structure_layer_counter = array_length(structure_tiles_to_check);
		var instance_counter = array_length(instances_to_check);
		for(var i = 0; i < obstacle_layer_counter; i++){
			array_insert(return_array,i,layer_tilemap_get_id(obstacle_tiles_to_check[i]))
		}
		for(var j = 0; j < structure_layer_counter; j++){
			array_insert(return_array,i,layer_tilemap_get_id(structure_tiles_to_check[j]))
		}
		for(var k = 0; k < instance_counter; k++){
			array_insert(return_array,i,instances_to_check[k])
		}
		
		return return_array;
	}
		
	init_grid_data();
}

function Grid_Cell(new_x_pos,new_y_pos,new_content = "") constructor{
	x_pos = new_x_pos;
	y_pos = new_y_pos;
	cell_content = new_content;
	
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

function Grid_Cell_Content(new_structure_content = 0) constructor{

	structure_content = new_structure_content;
	
	static set_content = function(item_to_set){
		if(not_null(item_to_set)){
			//Warn if cell is occupied.
			if(is_null(cell_content)){
				cell_content = item_to_set;
			}else{
				show_debug_message("Structure already occupied, overwriting with new content.")
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

