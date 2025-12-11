enum grid_direction{
	up,
	down,
	left,
	right
}


function get_screen_center_x(){
	var width = camera_get_view_x(view_camera) * 2 + camera_get_view_width(view_camera);
	var menu_center_x = width / 2;

	
	return menu_center_x;
}

function get_screen_center_y(){
	var height = camera_get_view_y(view_camera) * 2 + camera_get_view_height(view_camera);
	var menu_center_y = height / 2; ///to bring it up to the top of the window.

	
	return menu_center_y;
}

function not_null(item_to_check){
	if(item_to_check != undefined && item_to_check != noone && item_to_check != 0 && item_to_check != ""){
		return true;
	}else{
		return false;
	}
}
	
///@Params any : Item_to_check
function is_null(item_to_check){
	if(item_to_check != undefined && item_to_check != noone && item_to_check != 0 && item_to_check != "" && item_to_check != -1){
		return false;
	}else{
		return true;
	}
}

function core_disable_game_layers(){
	instance_deactivate_object(obj_entity);
	instance_deactivate_object(_obj_manager_parent);
	instance_deactivate_object(obj_ui_element);
}

function core_enable_game_layers(){
	instance_activate_object(obj_entity);
	instance_activate_object(_obj_manager_parent);
	instance_activate_object(obj_ui_element);
}

function core_adjust_2d_grid_position(_grid,_direction,current_x,current_y){
	switch(_direction){
		case grid_direction.up:
			current_y--;
		break;
		case grid_direction.down:
			current_y++;
		break;
		case grid_direction.left:
			current_x--;
		break;
		case grid_direction.right:
			current_x++;
		break;
	
	}
	var return_coords = array_create(current_x,current_y);
	return_coords = core_2d_grid_check_menu_bounds(_grid,return_coords);
	
	return return_coords;
}

function core_adjust_2d_array_position(_grid,_direction,current_x,current_y){
	switch(_direction){
		case grid_direction.up:
			current_y--;
		break;
		case grid_direction.down:
			current_y++;
		break;
		case grid_direction.left:
			current_x--;
		break;
		case grid_direction.right:
			current_x++;
		break;
	
	}
	var return_coords = [current_x,current_y];
	return_coords = core_2d_array_check_menu_bounds(_grid,return_coords,_direction);
	
	return return_coords;
}

function core_2d_grid_check_menu_bounds(_grid,_return_coords){
	if(_return_coords[0] !=""){
		if(_return_coords[0] >= ds_grid_width(_grid)){
			_return_coords[0] = 0;
		}else if(_return_coords[0] < 0){
			_return_coords[0] = ds_grid_width(_grid) - 1;
		}			
	}
	if(_return_coords[1] != ""){
		if(_return_coords[1] >= ds_grid_height(_grid)){
			_return_coords[1] = 0;
		}else if(_return_coords[1] < 0){
			_return_coords[1] = ds_grid_height(_grid) - 1;
		}				
	}
	return _return_coords;
}

function core_2d_array_check_menu_bounds(_array,_return_coords,_direction){
	var y_changed = false;
	if(_return_coords[1] != ""){
		if(_return_coords[1] >= array_length(_array)){
			_return_coords[1] = 0;
		}else if(_return_coords[1] < 0){
			_return_coords[1] = array_length(_array) - 1;
		}				
	}
	if(_return_coords[0] !=""){
		if(_return_coords[0] >= array_length(_array[_return_coords[1]]) && y_changed){
			_return_coords[0] = array_length(_array[_return_coords[1]]) - 1;
		}else if(_return_coords[0] >= array_length(_array[_return_coords[1]]) && !y_changed){
			_return_coords[0] = 0;
		}else if(_return_coords[0] < 0){
			_return_coords[0] = array_length(_array[_return_coords[1]]) - 1;
		}			
	}
	return _return_coords;
}

function core_draw_highlight(target,scale,x_pos_01 = 0,y_pos_01 = 0,x_pos_02 = 0,y_pos_02 = 0){
	if(live_call())return live_result;
	if(not_null(target)){
		switch(typeof(target)){
			case "string":

				draw_sprite_ext(spr_corner_highlight,0,x_pos_01,y_pos_01,scale,scale,0,c_white,1);
				draw_sprite_ext(spr_corner_highlight,0,x_pos_02,y_pos_01,scale,scale,270,c_white,1);
				draw_sprite_ext(spr_corner_highlight,0,x_pos_01,y_pos_02,scale,scale,90,c_white,1);
				draw_sprite_ext(spr_corner_highlight,0,x_pos_02,y_pos_02,scale,scale,180,c_white,1);			
			break;
			case "ref":
				
			break;
			default:
				///Nothing i can do with this target
			break;
		}
	}else if(target == "0"){
		switch(typeof(target)){
			case "string":

				draw_sprite_ext(spr_corner_highlight,0,x_pos_01,y_pos_01,scale,scale,0,c_white,1);
				draw_sprite_ext(spr_corner_highlight,0,x_pos_02,y_pos_01,scale,scale,270,c_white,1);
				draw_sprite_ext(spr_corner_highlight,0,x_pos_01,y_pos_02,scale,scale,90,c_white,1);
				draw_sprite_ext(spr_corner_highlight,0,x_pos_02,y_pos_02,scale,scale,180,c_white,1);			
			break;
			case "ref":
				
			break;
			default:
				///Nothing i can do with this target
			break;
		}
	}
}

function quit_game(){
	input_enable_all_input();
	global.game_state = paused_menu;
	handle_pause();
	core_disable_all_priority();
	audio_group_stop_all(audiogroup_music);
	audio_group_stop_all(audiogroup_sfx);
	obj_audio_manager.end_music();
	shop_reset();
	game_manager_reset();
	room_goto(rm_Start);

}

function create_if_none(_obj,_layer,x_pos = 0,y_pos = 0){
	var objects = instance_number(_obj);
	var existing_objects;
	if(objects <= 0){
		return instance_create_layer(x_pos,y_pos,_layer,_obj);
	}else if(objects > 1){
		show_debug_message("Extra object of type found. Unable to return.");
	}else{
		existing_objects = instance_find(_obj,0);
	}
	return existing_objects;
}