event_inherited();

try{
	switch(enemy_state){
		case "idle":
			idle();
			
			check_collision();
		break;
		case "decide_movement":
			bee_decide_movement();
			
			check_collision();
		break;
		case "move":
			move();
			
			check_collision();
		break;
		case "begin_firing":
			bee_begin_firing();
			
			check_collision();
		break;
		case "fire":
			bee_fire();
			
			check_collision();
		break;

	}
}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
}

