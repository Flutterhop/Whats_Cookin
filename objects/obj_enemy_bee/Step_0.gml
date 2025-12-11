event_inherited();

try{
	switch(enemy_state){
		case "idle":
			idle();
			enable_knockback();
			check_collision();
		break;
		case "decide_movement":
			bee_decide_movement();
			enable_knockback();
			check_collision();
		break;
		case "move":
			move();
			enable_knockback();
			check_collision();
		break;
		case "begin_firing":
			bee_begin_firing();
			enable_knockback();
			check_collision();
		break;
		case "fire":
			bee_fire();
			enable_knockback();
			check_collision();
		break;

	}
}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
}

