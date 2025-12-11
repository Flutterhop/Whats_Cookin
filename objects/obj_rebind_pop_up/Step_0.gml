
event_inherited();

if(InputDeviceGetRebinding(player.device)){
	if(not_null(InputDeviceGetRebindingResult(player.device))){
		var new_bind = InputDeviceGetRebindingResult(player.device);
		message_struct.input_callbacks[selection](new_bind);
	}
}