event_user(EV_INIT);
event_user(EV_METHOD_BINDING);


function pause_button_action(){
	//InputBinding
	//var player = get_input_player();
	//bind_alert = new Alert("Press any button to rebind this input.",[],id,[pause_button_rebind]);
	//bind_alert.create_alert(player);
	//InputDeviceSetRebinding(player.device,true);
}

function pause_button_rebind(new_bind){
	var player = get_input_player();
	var is_gamepad = InputDeviceIsGamepad(player.device);
	var bind = InputBindingGet(is_gamepad,message_struct.source.icon_index,,player.player_number)
	var verbs = InputBindingFind(is_gamepad,bind,player.player_number);
	var verb = verbs[0].verbIndex;
	if(bind == new_bind){
		message_struct.source.bind_alert.alert_message = "New Bind is the same as the current bind.";
		InputDeviceSetRebinding(player.device,false);
		message_struct.source.bind_alert.end_alert();
	}
	if(not_null(verbs)){
		
		
		var collisions = InputBindingFindCollisions(is_gamepad,
													new_bind,
													verb,
													player.player_number);
		if(array_length(collisions) > 0){
			message_struct.source.bind_alert.alert_message = "Bind is conflicted. Use another button.";
			message_struct.source.bind_alert.end_alert(120);
			return;
		}else{
			var is_bound = InputBindingSetSafe(is_gamepad,verb,new_bind,player.player_number)
			if(is_bound){
				message_struct.source.bind_sprite = InputIconGet(verb,,player.player_number);
				InputDeviceSetRebinding(player.device,false);
				message_struct.source.bind_alert.end_alert();
			}else{
				message_struct.source.bind_alert.alert_message = "Bind could not be set successfully.";
				InputDeviceSetRebinding(player.device,false);
				message_struct.source.bind_alert.end_alert();
			}

		}
	}else{

	}

}

function bind_button_draw(){
	if(active){
		draw_set_alpha(alpha_value);
		draw_rectangle_color(x - 105,y - text_h /1.8,x + 100,(y + 5) + text_h / 1.8,c_white,c_white,c_white,c_white,false);	
		draw_set_alpha(alpha_max);
	}
	scribble(string_concat("[fnt_arcade]",button_text)).scale(text_size_mod).draw(x - 100,y)
}