
function main_menu_input_up_pressed(player){				
	highlighted--;
	obj_arrow.image_index = 0;
	obj_audio_manager.play_sfx(menu_blip)
}

function main_menu_input_down_pressed(player){
	highlighted++;
	obj_arrow.image_index = 0;
	obj_audio_manager.play_sfx(menu_blip, "low", .8)
}
	
function main_menu_input_action_1_pressed(player){	
	if(not_null(active_element)){
		active_element.execute_action01();
		activate_delay(player,4,"action_1");
	}
}