event_user(EV_INIT);
event_user(EV_METHOD_BINDING);

function pause_button_action(){
	///This is called when action_1 is used on a button.
	show_debug_message("Quit Pressed. Check game state for behavior");
	switch(global.game_state){
		case paused_game:
			quit_game();
		break;
		case paused_shop:
			quit_game();
		break;
		default:
			game_end();
			break;
	}
	
}