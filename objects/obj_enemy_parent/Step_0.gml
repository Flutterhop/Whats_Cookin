event_inherited();

try{
	if(is_null(layer)){
		if(layer_exists(layer_name)){
			layer = layer_get_id(layer_name);
		}
	}
	//Damage Animation
	if (damage_timer > 0) {
	    damage_timer--;
	    image_blend = c_gray; // Tint
	    image_alpha = (damage_timer mod 4 < 2) ? 0.5 : 1; // Flash
	} else {
		image_blend = c_white;
	    image_alpha = 1;
	}

	
	// Default depth
	depth = 500;

	var w = 64; // width of detection zone
	var h = 32; // height of detection zone

	// Check above (top rectangle)
	if (collision_rectangle(x - w/2, y - h, x + w/2, y, obj_player, false, true)) {
		depth = 499; // behind
	}

	// Check below (bottom rectangle)
	if (collision_rectangle(x - w/2, y, x + w/2, y + h, obj_player, false, true)) {
		depth = 501; // in front
	}
	check_iframes(300);
	if(global.game_state == game_over){
		instance_destroy(id);
	}
}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
}

