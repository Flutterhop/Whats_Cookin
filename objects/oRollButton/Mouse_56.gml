/// @description Button Release GUI
#macro ActiveDice oDiceBag.activeDie.diceObjectInstance

event_inherited();

if(position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){
	if(oGameManager.isGameOver){
		show_debug_message("Game Over, reset the game to roll again.");
		path_speed = 0;
		exit;
	}
	if(oDiceBag.activeDie != 0){
		ActiveDice.rollPressed();
		oPlayerPathFollower.rollPressed();
		oGameManager.rollPressed();
		show_debug_message("Global Roll Pressed");
	
	}
	
}

