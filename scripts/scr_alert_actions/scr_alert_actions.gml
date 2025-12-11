function pop_up_input_any(player){
	
}


function pop_up_input_right(player){
	if(array_length(message_struct.input_options) > 1){
		selection++;
		if(selection > array_length(message_struct.input_options)-1){
			selection = 0;
		}else if(selection < 0){
			selection = array_length(message_struct.input_options) - 1;
		}
	}
}

function pop_up_input_left(){
	if(array_length(message_struct.input_options) > 1){
		selection--;
		if(selection >= array_length(message_struct.input_options)-1){
			selection = 0;
		}else if(selection < 0){
			selection = array_length(message_struct.input_options) - 1;
		}
	}
}

function pop_up_input_up(player){

}

function pop_up_input_down(player){

}
	
function pop_up_input_action_1(player){
	if(object_get_parent(message_struct.source.object_index) != obj_setting_input_binding_parent){
			message_struct.input_callbacks[selection]();
	}
}
	
function pop_up_input_action_2(player){


}
	
function pop_up_input_action_3(player){

}

function pop_up_input_action_1_released(player){				

}