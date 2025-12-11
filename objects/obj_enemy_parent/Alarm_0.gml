try{
	change_state(enemy_state,"decide_movement","Idle timer is up, changing to movement decision.");
	idle_timer_set = false;
}catch(_exception){
	show_debug_message(_exception.message);
	show_debug_message(_exception.longMessage);
	show_debug_message(_exception.script);
	show_debug_message(_exception.stacktrace);
}