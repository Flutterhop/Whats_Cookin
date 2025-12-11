try{
	/// @description Ranged Attack Timer
	move_timer_set = false;
	if(ranged_enemy == true){
			var shoot_or_move = irandom_range(1,100);
		if(shoot_or_move < shoot_chance){
			change_state(enemy_state,"begin_firing","Ranged attack chance succeeded, begin firing.");
		}else{
			change_state(enemy_state,"decide_movement","Ranged attack chance failed, return to movement decision.");
		}
	}else{
		change_state(enemy_state,"idle","Enemy not a ranged enemy, returning to idle. (How did you get here?)");
	}
}catch(_exception){
	show_debug_message(_exception.message);
	show_debug_message(_exception.longMessage);
	show_debug_message(_exception.script);
	show_debug_message(_exception.stacktrace);
}