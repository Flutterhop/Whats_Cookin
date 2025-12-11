/// @description Insert description here
// You can write your code in this editor
if(global.action_1 || global.action_2){
	room_goto_next();
	audio_stop_all();
	audio_play_sound(bug_fight_16, 1, true);
	global.game_state = active_game;
}