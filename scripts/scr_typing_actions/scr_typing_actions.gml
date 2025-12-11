function type_input_right(player){
	var _coords = core_adjust_2d_array_position(type_grid,grid_direction.right,highlight_index_y,highlight_index_x);
	highlight_index_y = _coords[0];
	highlight_index_x = _coords[1];
}

function type_input_left(){
	var _coords = core_adjust_2d_array_position(type_grid,grid_direction.left,highlight_index_y,highlight_index_x);
	highlight_index_y = _coords[0];
	highlight_index_x = _coords[1];
}

function type_input_up(player){
	var _coords = core_adjust_2d_array_position(type_grid,grid_direction.up,highlight_index_y,highlight_index_x);
	highlight_index_y = _coords[0];
	highlight_index_x = _coords[1];
}

function type_input_down(player){
	var _coords = core_adjust_2d_array_position(type_grid,grid_direction.down,highlight_index_y,highlight_index_x);
	highlight_index_y = _coords[0];
	highlight_index_x = _coords[1];
}
	
function type_input_action_1(player){
	current_character = type_grid[highlight_index_x][highlight_index_y];
	switch(current_character){
		case "Backspace":
			input_string = string_delete(input_string,string_length(input_string),1);
		break;
		case "Space":
			input_string = string_concat(input_string," ");
		break;
		case "Submit":
			if(is_null(pop_up)){
				var options = ["Yes","No"]
				var callback_options = [type_confirm,type_deny]
				pop_up = new Alert("Confirm Name?",options,id,obj_pop_up,callback_options);
				pop_up.create_alert(player);	
			}
		break;
		default:
			input_string = string_concat(input_string,current_character);
		break;
	
	}

}
	
function type_input_action_2(player){


}
	
function type_input_action_3(player){

}

function type_input_action_1_released(player){				

}

