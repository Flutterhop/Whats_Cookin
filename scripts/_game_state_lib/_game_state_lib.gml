#macro menu "menu"
#macro active_game "active_game"
#macro shop "shop"
#macro game_over "game_over"
#macro paused_game "paused_game"
#macro paused_menu "paused_menu"
#macro paused_shop "paused_shop"



#macro game_context (global.game_state == active_game || global.game_state == shop)
#macro non_game_context (global.game_state == menu || global.game_state == shop || global.game_state == paused_menu || global.game_state == paused_game || global.game_state == paused_shop)
#macro paused_context (global.game_state == paused_game || global.game_state == paused_menu || global.game_state == paused_shop)
#macro max_rounds  9
global.game_state = "";
global.debug = false;
global.display_shop = false;

function handle_pause(player = ""){
	switch(global.game_state){
		case active_game:
			if(not_null(player)){obj_input_manager.player = player;}
			obj_audio_manager.pause_music();
			global.game_state = paused_game;
			obj_input_manager.disable_instances();
		break;
		case paused_game:
			if(not_null(obj_input_manager.player)){obj_input_manager.player = "";}
			obj_audio_manager.resume_music();
			global.game_state = active_game;
			obj_input_manager.enable_instances();
		break;
		case shop:
			if(not_null(player)){obj_input_manager.player = player;}
			obj_audio_manager.pause_music();
			global.game_state = paused_shop;
			obj_input_manager.disable_instances();
		break;
		case paused_shop:
			if(not_null(obj_input_manager.player)){obj_input_manager.player = "";}
			obj_audio_manager.resume_music();
			global.game_state = shop;
			obj_input_manager.enable_instances();
		break;
		case menu:
			if(not_null(player)){obj_input_manager.player = player;}
			obj_audio_manager.pause_music();
			global.game_state = paused_menu;
			obj_input_manager.disable_instances();
		break;
		case paused_menu:
			if(not_null(obj_input_manager.player)){obj_input_manager.player = "";}
			obj_audio_manager.resume_music();
			global.game_state = menu;
			obj_input_manager.enable_instances();
		break;
	}
}

function change_game_state(new_state){
	if(global.game_state == new_state){
		show_debug_message("State already set to: " + string(new_state) );
		return;
	}else{
		if(new_state == paused_context && global.game_state != paused_context){
			global.game_state = new_state;
			show_debug_message("Setting state to: " + string(new_state));
			handle_pause();
			return;
		}else if(new_state != paused_context && global.game_state == paused_context){
			global.game_state = new_state;
			show_debug_message("Setting state to: " + string(new_state));
			handle_pause();
			return;
		}
		global.game_state = new_state;
		show_debug_message("Setting state to: " + string(new_state));
	}
	if(global.game_state == ""){
		global.game_state = new_state;
		show_debug_message("Setting state to: " + string(new_state));
	}
}

function state_check_player_status(){
	var still_alive = true;
	var player_count = 0;
	var death_count = 0;
	for(var i = 0;i<array_length(global.players);i++){
		var _player = array_get(global.players,i);
		if(_player != 0){
			var user_type = typeof(_player);
			if(user_type == "struct"){
				if(_player.is_active){
					player_count++;
					if(not_null(_player.player_instance) && instance_exists(_player.player_instance)){
						var instance_type = typeof(_player.player_instance);
						if(instance_exists(_player.player_instance)){
							if(_player.player_instance.dead){
								death_count++;
							}
						}
					}
				}
			}
		}
	}
	if(player_count == death_count){
		still_alive = false;
	}
	return still_alive;
}

function state_toggle_shop(){
	global.display_shop = !global.display_shop;
	if(global.display_shop){
		global.game_state = shop;
	}

}

function state_enable_shop(){
	audio_group_stop_all(audiogroup_music)
	obj_audio_manager.play_music(shop_music, true)
	global.display_shop = true;
	global.game_state = shop;
}

function state_disable_shop(){
	global.display_shop = false;
	global.game_state = active_game;
	audio_group_stop_all(audiogroup_music)
}

