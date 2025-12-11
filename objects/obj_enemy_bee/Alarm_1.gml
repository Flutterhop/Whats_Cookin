/// @description Ranged Attack Timer
move_timer_set = false;
var shoot_or_move = irandom_range(1,100);
if(shoot_or_move > shoot_chance){
	change_state(enemy_state,"begin_firing","Bee has succeeded ranged attack roll, changing to begin firing state.");
}else{
	change_state(enemy_state,"idle","Bee has failed ranged attack roll, changing to begin firing state.");
}
