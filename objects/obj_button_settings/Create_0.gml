event_user(EV_INIT);
event_user(EV_METHOD_BINDING);

function pause_button_action(){
	///This is called when action_1 is used on a button.
	manager.change_state(pause_state.settings_menu);
	show_debug_message("Button Pressed!");
}
