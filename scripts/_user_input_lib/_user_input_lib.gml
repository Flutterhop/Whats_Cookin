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

function insert_new_player(new_player){
	array_push(global.players,new_player)
}

function input_get_number_active_players(){
	var active_player_count = 0;
	for(var i  = 0; i < array_length(global.players);i++){
		var player = array_get(global.players,i);
		if(player != 0){
			if(player.instance != 0){
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
			scan_inputs(player);
			input_read_debug_inputs(global.game_state,player);
		}
	}
}

function input_interpret_player_controls(){
	if(object_index == _obj_manager_parent){return;}
	var temp_player = 0;
	for(var i = 0;i < array_length(global.players); i++){
		temp_player = array_get(global.players,i);
		if(not_null(temp_player)){	
			if(not_null(temp_player.instance)){
				if(temp_player.input_allowed){
					determine_priority();
					if(global.priority_enforced){
			
					}else if(!global.priority_enforced){
						scan_inputs(temp_player)
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
			var is_priority_01 = object_get_parent(obj_01) == _obj_alert_message_parent or object_get_parent(obj_01) == obj_menu_system;
			var is_priority_02 = object_get_parent(obj_02) == _obj_alert_message_parent or object_get_parent(obj_02) == obj_menu_system;
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
	InputVerbConsumeAll(player.player_number)
}
	
function input_add_player(player){
	for(var i = 0; i < array_length(global.players);i++){
		var current_player = global.players[i];
		if(is_null(current_player)){
			array_set(global.players,i,player);
			return
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
	
function input_interpret_controls(){
	
	if(object_index == _obj_manager_parent){return;}
	var temp_player = 0;
	for(var i = 0;i < array_length(global.players); i++){
		temp_player = array_get(global.players,i);
		if(not_null(temp_player)){
			if(temp_player.input_allowed){
				determine_priority();
				if(global.priority_enforced && has_priority){
					var _input = instance_find(obj_input_manager,0);
					var target = "";
					scan_inputs(temp_player)
					for(var j = 0; j < array_length(_input.priority_targets);j++){
						target = _input.priority_targets[j];
						

					}
				}else if(global.priority_enforced && !has_priority){
					//No input for you!
				}else if(!global.priority_enforced){
					scan_inputs(temp_player)
				}

			}
		}			
	}	
}

function input_scan_inputs(temp_player){

	if(!InputPlayerGetBlocked(temp_player.player_number)){
		//if(!InputCheckMany(-1,temp_player.player_number)){exit;}
		if(InputPressed(INPUT_VERB.DEBUG,temp_player.player_number) && GM_build_type == "run"){
			toggle_debug();
		}
		//Up
		if(InputCheck(INPUT_VERB.UP,temp_player.player_number)){if(variable_instance_exists(self,"input_up")){input_up(temp_player);}}
		if(InputPressed(INPUT_VERB.UP,temp_player.player_number)){if(variable_instance_exists(self,"input_up_pressed")){input_up_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.UP,temp_player.player_number)){if(variable_instance_exists(self,"input_up_released")){input_up_released(temp_player);}}	
		//Down
		if(InputCheck(INPUT_VERB.DOWN,temp_player.player_number)){if(variable_instance_exists(self,"input_down")){input_down(temp_player);}}
		if(InputPressed(INPUT_VERB.DOWN,temp_player.player_number)){if(variable_instance_exists(self,"input_down_pressed")){input_down_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.DOWN,temp_player.player_number)){if(variable_instance_exists(self,"input_down_released")){input_down_released(temp_player);}}	
		//Left
		if(InputCheck(INPUT_VERB.LEFT,temp_player.player_number)){if(variable_instance_exists(self,"input_left")){input_left(temp_player);}}
		if(InputPressed(INPUT_VERB.LEFT,temp_player.player_number)){if(variable_instance_exists(self,"input_left_pressed")){input_left_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.LEFT,temp_player.player_number)){if(variable_instance_exists(self,"input_left_released")){input_left_released(temp_player);}}	
		//Right
		if(InputCheck(INPUT_VERB.RIGHT,temp_player.player_number)){if(variable_instance_exists(self,"input_right")){input_right(temp_player);}}
		if(InputPressed(INPUT_VERB.RIGHT,temp_player.player_number)){if(variable_instance_exists(self,"input_right_pressed")){input_right_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.RIGHT,temp_player.player_number)){if(variable_instance_exists(self,"input_right_released")){input_right_released(temp_player);}}
		//Action 1 //Reading Released first to manage hold direction logic.
		if(InputReleased(INPUT_VERB.ACTION_1,temp_player.player_number)){if(variable_instance_exists(self,"input_action_1_released")){input_action_1_released(temp_player);}}
		if(InputCheck(INPUT_VERB.ACTION_1,temp_player.player_number)){if(variable_instance_exists(self,"input_action_1")){input_action_1(temp_player);}}
		if(InputPressed(INPUT_VERB.ACTION_1,temp_player.player_number)){if(variable_instance_exists(self,"input_action_1_pressed")){input_action_1_pressed(temp_player);}}
		//Action 2
		if(InputCheck(INPUT_VERB.ACTION_2,temp_player.player_number)){if(variable_instance_exists(self,"input_action_2")){input_action_2(temp_player);}}
		if(InputPressed(INPUT_VERB.ACTION_2,temp_player.player_number)){if(variable_instance_exists(self,"input_action_2_pressed")){input_action_2_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.ACTION_2,temp_player.player_number)){if(variable_instance_exists(self,"input_action_2_released")){input_action_2_released(temp_player);}}
		//Action 3
		if(InputCheck(INPUT_VERB.ACTION_3,temp_player.player_number)){if(variable_instance_exists(self,"input_action_3")){input_action_3(temp_player);}}
		if(InputPressed(INPUT_VERB.ACTION_3,temp_player.player_number)){ if(variable_instance_exists(self,"input_action_3_pressed")){ input_action_3_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.ACTION_3,temp_player.player_number)){if(variable_instance_exists(self,"input_action_3_released")){input_action_3_released(temp_player);}}
		//Action 4
		if(InputCheck(INPUT_VERB.ACTION_4,temp_player.player_number)){if(variable_instance_exists(self,"input_action_4")){input_action_4(temp_player);}}
		if(InputPressed(INPUT_VERB.ACTION_4,temp_player.player_number)){ if(variable_instance_exists(self,"input_action_4_pressed")){ input_action_4_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.ACTION_4,temp_player.player_number)){if(variable_instance_exists(self,"input_action_4_released")){input_action_4_released(temp_player);}}
		//PAUSE
		if(InputCheck(INPUT_VERB.PAUSE,temp_player.player_number)){if(variable_instance_exists(self,"input_pause")){input_pause(temp_player);}}
		if(InputPressed(INPUT_VERB.PAUSE,temp_player.player_number)){if(variable_instance_exists(self,"input_pause_pressed")){input_pause_pressed(temp_player);}}
		if(InputReleased(INPUT_VERB.PAUSE,temp_player.player_number)){if(variable_instance_exists(self,"input_pause_released")){input_pause_released(temp_player);}}
	}else{
		if(global.debug){
			show_debug_message("Input scan blocked.")
		}
	}
}