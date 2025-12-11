/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

interact = function(){
	layer_destroy("Instances");
	obj_gameManager.alarm[0] = -1;
	obj_Timer.currentMinute = 0;
	obj_Timer.currentSecond = 0;
	obj_Timer.currentMilisecond = 0;
	global.paused = false;
	room_goto(rm_MenuMain);

}