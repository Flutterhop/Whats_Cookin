global.players = array_create(4);

#macro EV_INIT 0
#macro EV_METHOD_BINDING 1
#macro EV_CONTROL_BINDING 10

function input_load_bind_rules(){
	array_push(disallowed_binds,
				vk_alt,
				vk_capslock,
				vk_printscreen,
				vk_escape,
				vk_pageup,
				vk_pagedown,
				vk_printscreen,
				vk_multiply,
				vk_divide,
				vk_subtract,
				vk_decimal,
				gp_select,
				gp_start);
	
	array_push(allowed_binds,
				gp_face1,
				gp_face2,
				gp_face3,
				gp_face4,
				gp_shoulderl,
				gp_shoulderlb
				);
}

function input_get_number_active_players(){
	var active_player_count = 0;
	for(var i  = 0; i < array_length(global.players);i++){
		var player = array_get(global.players,i);
		if(player != 0){
			if(player.player_instance != 0){
				if(player.is_active){
					active_player_count++;
				}
			}
		}
	}
	
	return active_player_count;
}

function input_get_number_standby_players(){
	var standby_player_count = 0;
	for(var i  = 0; i < array_length(global.players);i++){
		var player = array_get(global.players,i);
		if(player != 0){
			standby_player_count++;
		}
	}
	return standby_player_count;
}

function input_read_all(){
	for(var i = 0;i < INPUT_MAX_PLAYERS; i++){
		if(InputPlayerIsConnected(i)){
			var player = global.players[i];
			input_read(global.game_state,player);
			input_read_debug_inputs(global.game_state,player);
		}
	}
}
	
function input_interpret_controls(){
	
	if(object_index == _obj_manager_parent){return;}
	var temp_player = 0;
	for(var i = 0;i < array_length(global.players); i++){
		temp_player = array_get(global.players,i);
		if(temp_player != 0){
			if(temp_player.input_allowed){
				determine_priority();
				if(global.priority_enforced && has_priority){
					var _input = instance_find(obj_input_manager,0);
					var target = "";
					for(var j = 0; j < array_length(_input.priority_targets);j++){
						target = _input.priority_targets[j];
						if(temp_player.up){input_up(temp_player);}
						if(temp_player.down){input_down(temp_player);}
						if(temp_player.left){input_left(temp_player);}
						if(temp_player.right){input_right(temp_player);}
						if(temp_player.action_1){
							input_action_1(temp_player);
							}
						if(temp_player.action_2){input_action_2(temp_player);}
						if(temp_player.action_3){input_action_3(temp_player);}
						if(temp_player.action_1_released){input_action_1_released(temp_player);}
						if(not_null(target)){
							if(target.consume_input){
								input_reset_input(temp_player);
								return;
							}
						}
					}
				}else if(global.priority_enforced && !has_priority){
					//No input for you!
				}else if(!global.priority_enforced){
					if(temp_player.up){
						input_up(temp_player);}
					if(temp_player.down){input_down(temp_player);}
					if(temp_player.left){input_left(temp_player);}
					if(temp_player.right){input_right(temp_player);}
					if(temp_player.action_1){input_action_1(temp_player);}
					if(temp_player.action_2){
						input_action_2(temp_player);}
					if(temp_player.action_3){input_action_3(temp_player);}
					if(temp_player.action_1_released){input_action_1_released(temp_player);}
				}else{
					show_debug_message("Priority check went weird with it. [_user_input ln.103]");
				}
			}
		}			
	}	
}

function input_interpret_player_controls(){
	
	if(object_index == _obj_manager_parent){return;}
	var temp_player = 0;
	for(var i = 0;i < array_length(global.players); i++){
		temp_player = array_get(global.players,i);
		if(temp_player != 0){	
			if(temp_player.player_instance != 0){
				if(temp_player.input_allowed && !temp_player.player_instance.is_shopping){
					determine_priority();
					if(global.priority_enforced){
			
					}else if(!global.priority_enforced){
						if(temp_player.up){input_up(temp_player);}
						if(temp_player.down){input_down(temp_player);}
						if(temp_player.left){input_left(temp_player);}
						if(temp_player.right){input_right(temp_player);}
						if(temp_player.action_1){input_action_1(temp_player);}else{ if(temp_player.player_instance != 0){temp_player.player_instance.holdDirection = false;}}
						if(temp_player.action_2){input_action_2(temp_player);}
						if(temp_player.action_3){input_action_3(temp_player);}
						if(temp_player.action_1_released){input_action_1_released(temp_player);}
					}
				}
			}
		}			
	}	
}
	
function input_determine_priority(){
	///if(!global.priority_enforced){return;}
	var priority_count = 0; 
	var priority_targets = array_create(0);
	////SEARCH FOR MANAGER OBJECTS TO GIVE PRIORITY TO.
	var managers = tag_get_asset_ids("manager_object",asset_object);
	for(var i = 0;i < array_length(managers);i++){
		var manager_to_find = array_get(managers,i);
		var manager = instance_find(manager_to_find,0);
		if(manager != 0 && manager != noone){
			if(manager.has_priority){
				priority_count++;
				array_push(priority_targets,manager);
			}
		}
	}
	////SEARCH FOR UI ALERT OBJECTS TO GIVE PRIORITY TO
	var ui_alerts = tag_get_asset_ids("alert_object",asset_object);
	
	for(var i = 0;i < array_length(ui_alerts);i++){
		var ui_to_find = array_get(ui_alerts,i);
		var ui_element = instance_find(ui_to_find,0);
		if(ui_element != 0 && ui_element != noone){
			if(ui_element.has_priority){
				array_push(priority_targets,ui_element);
				priority_count++;
			}
		}
	}
	if(priority_count < 1 && global.priority_enforced){
		set_priority_enforcement(false);
	}else if(priority_count > 0){
		set_priority_enforcement(true);
		var sort = function(prio_01,prio_02){
			var obj_01 = prio_01.object_index;
			var obj_02 = prio_02.object_index;
			var is_priority_01 = object_get_parent(obj_01) == _obj_alert_message_parent;
			var is_priority_02 = object_get_parent(obj_02) == _obj_alert_message_parent;
			if(is_priority_01 && is_priority_02){
				return 0
			}else if(is_priority_01 && !is_priority_02){
				return -1;
			}else if(!is_priority_01 && is_priority_02){
				return 1;
			}else if(!is_priority_01 && !is_priority_02){
				return 0;
			}
		
		}
		array_sort(priority_targets,sort);
		array_unique(priority_targets);
		obj_input_manager.priority_targets = priority_targets;
	}
}
	
function input_reset_input(player){
	player.up = false;
	player.down = false;
	player.left = false;
	player.right = false;
	player.action_1 = false;
	player.action_2 = false;
	player.action_3 = false;
	player.action_1_released = false;
}
	
function input_add_player(_pad){
	if(global.game_state != active_game){
		for(var i = 0; i < array_length(global.players);i++){
			var current_player = global.players[i];
			if(is_null(current_player)){
				var user = new Player(i,);
				array_set(global.players,i,user);
			}
		}
	}
}

function input_remove_player(_pad){
	if(global.game_state != active_game){
		if(is_null(_pad)){
			return;
		}
		var player = array_get(global.players,_pad);
		if(not_null(player)){
			global.players[_pad] = 0;
		}
		if(array_get(global.players,0) == 0){
			add_player("");
		}
	}
}

function input_read(game_state,player){
	reset_globals();
	player.device = InputPlayerGetDevice(player.player_number)
	if(!InputPlayerGetBlocked(player.player_number)){
		with(player){
			//switch(InputPlayerGetDevice(player.player_number)){}
			if(InputPressed(INPUT_VERB.DEBUG,player.player_number) && GM_build_type == "run"){
				toggle_debug();
			}
		
			action_3_released = false;
			action_2_released = false;
			action_1_released = false;
			
			if(InputCheck(INPUT_VERB.ACCEPT,player.player_number)&& (game_state == active_game || game_state == game_over)){
				action_1 = true;
			}else if(InputPressed(INPUT_VERB.ACCEPT,player.player_number)&& non_game_context){
				action_1 = true;
			}else{
				action_1 = false;
			}
			if(InputPressed(INPUT_VERB.CANCEL,player.player_number)&& game_state == active_game){
				action_2 = true;
			}else if(InputPressed(INPUT_VERB.CANCEL,player.player_number)&& non_game_context){
				action_2 = true;
			}else{
				action_2 = false;
			}
			if(InputCheck(INPUT_VERB.SPECIAL,player.player_number)&& game_state == active_game){
				action_3 = true;
			}else if(InputPressed(INPUT_VERB.SPECIAL,player.player_number)&& non_game_context){
				action_3 = true;
			}else{
				action_3 = false;
			}
			if(InputReleased(INPUT_VERB.ACCEPT,player.player_number)){
				action_1_released = true;						
			}
			if(InputReleased(INPUT_VERB.CANCEL,player.player_number)){
				action_2_released = true;						
			}
			if(InputReleased(INPUT_VERB.SPECIAL,player.player_number)){
				action_3_released = true;						
			}
			
			if(InputCheck(INPUT_VERB.UP,player.player_number)&& game_state == active_game){
				up = true;
			}else if(InputPressed(INPUT_VERB.UP,player.player_number)&&  non_game_context){
				up = true;
			}else{
				up = false;
			}
			if(InputCheck(INPUT_VERB.DOWN,player.player_number)&& game_state == active_game){
				down = true;
			}else if(InputPressed(INPUT_VERB.DOWN,player.player_number) &&  non_game_context){
				down = true;
			}else{
				down = false;
			}
			if(InputCheck(INPUT_VERB.LEFT,player.player_number) && game_state == active_game){
				left = true;
			}else if(InputPressed(INPUT_VERB.LEFT,player.player_number) &&  non_game_context){
				left = true;
			}else{
				left = false;
			}
			if(InputCheck(INPUT_VERB.RIGHT,player.player_number)&& game_state == active_game){
				right = true;
			}else if(InputPressed(INPUT_VERB.RIGHT,player.player_number) && non_game_context){
				right = true;
			}else{
				right = false;
			}
			if(InputPressed(INPUT_VERB.PAUSE,player.player_number)){
				start = true;
				handle_pause(player);
			}else{
				start = false;
			}
		}
	}
}

function input_read_debug_inputs(game_state,player){
	if(player != 0){
		with(player){
			if(keyboard_check_pressed(vk_f1)){
				f1 = true;
			}else{
				f1 = false;
			}
			if(keyboard_check_pressed(vk_f2)){
				f2 = true;
			}else{
				f2 = false;
			}
			if(keyboard_check_pressed(vk_f3)){
				f3 = true;
			}else{
				f3 = false;
			}
			if(keyboard_check_pressed(vk_f4)){
				f4 = true;
			}else{
				f4 = false;
			}
			if(keyboard_check_pressed(vk_f5)){
				f5 = true;
			}else{
				f5 = false;
			}
			if(keyboard_check_pressed(vk_f6)){
				f6 = true;
			}else{
				f6 = false;
			}
			if(keyboard_check_pressed(vk_f7)){
				f7 = true;
			}else{
				f7 = false;
			}
			if(keyboard_check_pressed(vk_f8)){
				f8 = true;
			}else{
				f8 = false;
			}
			if(keyboard_check_pressed(vk_f9)){
				f9 = true;
			}else{
				f9 = false;
			}
		}
	}
}

function reset_globals(){
	global.up = false;
	global.down = false;
	global.left = false;
	global.right = false;
	global.horizontal_axis = 0;
	global.vertical_axis = 0;
	global.action_1 = false;
	global.action_2 = false;
	global.action_3 = false;
	global.action_1_released = false;
	global.action_2_released = false;
	global.action_3_released = false;
	global.start = false;

}
	
function input_activate_delay(player,delay_multiplier,input_action){
	var input = variable_instance_get(player,input_action);
	variable_instance_set(player,input_action,false);
	player.input_ready = false;
	player.input_timer = player.input_delay * delay_multiplier;
}

function input_delay_all(delay_multiplier){
	var player_num = array_length(global.players);
	for(var i = 0;i<player_num;i++){
		var player = array_get(global.players,i);
		if(not_null(player)){
			player.input_ready = false;
			player.input_timer = player.input_delay * delay_multiplier;
		}
	}
}	
	
function input_enable_all_input(){
	var player_num = array_length(global.players);
	for(var i = 0;i<player_num;i++){
		var player = array_get(global.players,i);
		if(player != 0){
			player.input_allowed = true;
		}
	}
}

function input_disable_all_input(){
	var player_num = array_length(global.players);
	for(var i = 0;i<player_num;i++){
		var player = array_get(global.players,i);
		if(player != 0){
			player.input_allowed = false;
		}

	}
}

function input_focus_first_player(){
	var player_num = array_length(global.players);
	for(var i = 0;i<player_num;i++){
		var player = array_get(global.players,i);
		if(player != 0){
			if(player.player_number != 0){
				player.input_allowed = false;
			}
			if(player.player_number == 0){
				player.input_allowed = true;
			}
		}
	}
}

function input_focus_input(player){
	var player_num = array_length(global.players);
	for(var i = 0;i<player_num;i++){
		var current_player = array_get(global.players,i);
		if(current_player != 0){
			if(current_player.player_number != player.player_number){
				current_player.input_allowed = false;
			}
			if(current_player.player_number == player.player_number){
				current_player.input_allowed = true;
			}
		}
	}
}

function get_input_player(){
	return obj_input_manager.player;
}
	
function set_input_player(player){
	obj_input_manager.player = player;
}

function check_hotswap(){
	InputSetHotswap(false);
}
/// Checks for active players missing a device. When found assigns a device to the player.
/// Keyboard is automatically assigned to first player when no devices are found.
function input_listen_for_input(){
	var devices = InputDeviceEnumerate(false);
	if(array_length(devices) > 0){
		for(var i = 0;i < INPUT_MAX_PLAYERS;i++){
			var current_player = global.players[i];
			var user = find_player_user(current_player);
			var gamepad_check = InputDeviceIsGamepad(current_player.device);
			if(!InputPlayerHasDevice(current_player.player_number)){
				if(user.is_guest == false){
					if(array_length(devices) > 0){
						if(InputDeviceIsAvailable(devices[i])){
							InputPlayerSetDevice(devices[i],current_player.player_number);
							input_player_set_config(current_player);

						}
					}else{
						var active_device = InputDeviceGetNewActivity();
						if(InputDeviceIsAvailable(active_device)){
							InputPlayerSetDevice(active_device,current_player.player_number);
							input_player_set_config(current_player);

						}
					}
				}
			}else{
				if(InputPlayerGetInactive(5000,current_player.player_number)){
					var active_device = InputDeviceGetNewActivity();
					if(InputDeviceIsAvailable(active_device)){
						InputPlayerSetDevice(active_device,current_player.player_number);
						input_player_set_config(current_player);
					}
				}
			}
		}
	}else{
		
		var player = get_input_player();
		bind_alert = new Alert("No Devices Detected, waiting for input...",[],id,obj_pop_up,[input_player_return]);
		bind_alert.create_alert(player);
	}
}

function input_player_return(){
	
}
function input_player_set_config(_player){
	var user = find_player_user(_player);
	var gamepad_check = InputDeviceIsGamepad(_player.device);
	if(struct_exists(user,"input_config")){
		if(gamepad_check){
			user.input_config = user.gp_input_config;
		}else{
			user.input_config = user.kb_input_config;
		}
	}
}
	