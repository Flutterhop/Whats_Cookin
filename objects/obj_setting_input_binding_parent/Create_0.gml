event_user(EV_INIT);
event_user(EV_METHOD_BINDING);


function pause_button_action(){
	//InputBinding
	var player = get_input_player();
	bind_alert = new Alert("Press any button to rebind this input.",[],id,obj_rebind_pop_up,[pause_button_rebind]);
	bind_alert.create_alert(player);
	InputDeviceSetRebinding(player.device,true,obj_input_manager.disallowed_binds,);
}

function pause_button_rebind(new_bind){
	var menu_binds = message_struct.source.manager.current_menu.menu_items;
	var player = get_input_player();
	var is_gamepad = InputDeviceIsGamepad(player.device);
	var new_verbs = InputBindingFind(is_gamepad,new_bind,player.player_number);
	var new_verb = "";
	if(array_length(new_verbs) > 0){
		new_verb = new_verbs[0];
	}
	var bind = InputBindingGet(is_gamepad,message_struct.source.icon_index,,player.player_number);
	var verbs = InputBindingFind(is_gamepad,bind,player.player_number);
	var verb = verbs[0];
	
	
	if(bind == new_bind){
		message_struct.source.bind_alert.alert_message = "New Bind is the same as the current bind.";
		InputDeviceSetRebinding(player.device,false);
		message_struct.source.bind_alert.end_alert(120);
		return;
	}
	if(not_null(verbs)){
		if(not_null(new_verb)){
			InputBindingSwap(is_gamepad,new_verb.verbIndex,new_verb.alternate,verb.verbIndex,verb.alternate,player.player_number);
			for(var i = 0;i< array_length(menu_binds);i++){
				var item = menu_binds[i];
				if(variable_instance_exists(item,"verb")){
					if(item.verb[0].verbIndex == new_verb.verbIndex){
						var j = 0;
					}
				}
			}
			message_struct.source.bind_sprite = InputIconGet(verb.verbIndex,verb.alternate,player.player_number);
			InputDeviceSetRebinding(player.device,false);
			message_struct.source.bind_alert.end_alert();
		
		}else{
			var collisions = InputBindingFindCollisions(is_gamepad,
													new_bind,
													verb.verbIndex,
													player.player_number);
			if(array_length(collisions) > 0){
				message_struct.source.bind_alert.alert_message = "Bind is conflicted. Use another button.";
				message_struct.source.bind_alert.end_alert(120);
				return;
			}else{
				var is_bound = InputBindingSetSafe(is_gamepad,verb.verbIndex,new_bind,player.player_number);
				if(is_bound){
					message_struct.source.bind_sprite = InputIconGet(verb.verbIndex,,player.player_number);
					InputDeviceSetRebinding(player.device,false);
					message_struct.source.bind_alert.end_alert();
				}else{
					message_struct.source.bind_alert.alert_message = "Bind could not be set successfully.";
					InputDeviceSetRebinding(player.device,false);
					message_struct.source.bind_alert.end_alert();
				}
			}
		}

	}
}

function bind_button_draw(){
	if(active){
		draw_set_alpha(alpha_value);
		draw_rectangle_color(x - 105,y - text_h /1.8,x + 100,(y + 5) + text_h / 1.8,c_white,c_white,c_white,c_white,false);	
		draw_set_alpha(alpha_max);
	}

	draw_text_ext_transformed_color(x - 100,y,button_text,10,500,text_size_mod,text_size_mod,0,c_white,c_white,c_white,c_white,1);
	if(typeof(bind_sprite) == "ref"){
		draw_sprite_ext(bind_sprite,0,x + 75,y + sprite_get_height(bind_sprite) / 4,icon_size_mod,icon_size_mod,0,c_white,1);
	
	}else{
		draw_text_ext_transformed_color(x + 75,y,bind_sprite,10,500,text_size_mod,text_size_mod,0,c_white,c_white,c_white,c_white,1);
	}

}