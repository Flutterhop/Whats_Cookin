global.priority_enforced = false;
global.priority_count = 0;

function core_generate_medkit(){
	//generate medkit
	area_width_min = 50; // just grabbed these values as the minimum based on the position next to the -> top left spawner.
	area_height_min = 60;
	area_width_max = 430;
	area_height_max = 205;
	
	var horizontal_position = irandom_range(area_width_min,area_width_max);
	var vertical_position = irandom_range(area_height_min,area_height_max);
	if(!position_meeting(horizontal_position,vertical_position,obj_hazard_parent) && !position_meeting(horizontal_position,vertical_position,obj_player_entity) && !position_meeting(horizontal_position,vertical_position,obj_spawner)){
		instance_create_layer(horizontal_position,vertical_position,"Terrain",obj_medkit);
		//here
		show_debug_message("spawning medkit");
	}else{
		show_debug_message("That space is occupied by something. looping again...");
	}
}

function core_check_player_medkit(){
	for(var i = 0; i  < array_length(global.players);i++){
		var _player = array_get(global.players,i);
		var type = typeof(_player);
		if(type == "struct"){
			if(_player.is_active){
				var current_list = _player.player_instance.item_list;
				var list_size = ds_list_size(current_list);
				if(list_size > 0){
					for(var j = 0;j < list_size;j++){
						var item = ds_list_find_value(current_list,j);
						var item_type = item.type;
						if(item_type == "medkit"){
							if(item.number_purchased > 0){
								if(time_to_spawn_medkit != _player.player_instance.medkit_time){
									time_to_spawn_medkit = _player.player_instance.medkit_time;///Set to whatever player has i.e. 30 or 15
								}else if(is_null(time_to_spawn_medkit)){
									time_to_spawn_medkit = 30;////Base value
								}
								activate_medkit = true
								return;
							}else{
								activate_medkit = false;
							}

						}
					}
				}
			}
		}
	}
}

function core_load_items(){
	var len = array_length(global.players);
	var temp_manager = create_if_none(obj_game_manager,"System",0,0);
	for(var i = 0; i < len; i++){
		var player_struct = array_get(global.players,i);
		var player = 0
		if(is_null(player_struct)){
			break;
		}else{
			player = player_struct.player_instance;
			if(is_null(player)){
				break;
			}else if(!instance_exists(player)){
				break;
			}
		}

			if(ds_list_size(player.item_list) > 0){
				var items = player.item_list;
				for(var j = 0;j < ds_list_size(player.item_list);j++){
					var current_item = ds_list_find_value(items,j);
					if(current_item.number_purchased > 0){
						switch(current_item.type){
							case "health_up":
								player.hp_start = player.base_hp + player.hp_increment * current_item.number_purchased; //this can be altered to whatever increment we want.
								player.hp_current = player.hp_start
							break;
			
							case "medkit":	//medkit
								player.medkit_time = 30 / current_item.number_purchased;
							break;
			
							case "shield":
								switch(current_item.subtype){
									case "explosion":
										if(!player.shield_explosion > 0){
											player.shield_explosion = 1 * current_item.number_purchased;
										}else{
											if(current_item.number_purchased > player.shield_explosion){
												player.shield_explosion = 1 * current_item.number_purchased;
											}else if(current_item.number_purchased == player.shield_explosion){
												break;
											}
										}
									break;
									case "bullet":
										if(!player.shield_bullet > 0){
											player.shield_bullet = 1 * current_item.number_purchased;
										}else{
											if(current_item.number_purchased > player.shield_bullet){
												player.shield_bullet = 1 * current_item.number_purchased;
											}else if(current_item.number_purchased == player.shield_bullet){
												break;
											}
										}

									break;
									case "bramble":
										if(!player.shield_bramble > 0){
											player.shield_bramble = 1 * current_item.number_purchased;
										}else{
											if(current_item.number_purchased > player.shield_bramble){
												player.bramble_shield = 1 * current_item.number_purchased;
											}else if(current_item.number_purchased == player.shield_bramble){
												break;
											}
										}
									break;
								}			
							case "staff"://fire rate up
								switch(current_item.subtype){
									case "firerate":
										player.shot_speed = 20 - ( 2 * current_item.number_purchased);
									break;
									case "power":
										player.bullets_upgraded = true;
										player.shot_power = 1 * current_item.number_purchased;
									break;
									case "split":
										player.shot_split = true;
										player.num_bullets = 1 + current_item.number_purchased;
									break;
									case "ricochet":
										player.shot_ricochet = true;
										player.shot_ricochet_number = current_item.number_purchased;
									break;
									case "knockback":
										//knockback increase
										player.add_knockback = true;
										player.knockback_strength = 2 + current_item.number_purchased;
									break;			
								}
							break;
							case "mirror":
								player.mirror = true;
								if(is_null(player.mirror_instance)){
									player.mirror_instance = instance_create_layer(player.x + 25, player.y, "Spawns", obj_mirror_entity);
								}
								if(!instance_exists(player.mirror_instance)){
									player.mirror_instance = instance_create_layer(player.x + 25, player.y, "Spawns", obj_mirror_entity);
								}
								player.mirror_instance.player_instance = player;
								player.mirror_instance.hp_start = 20 * current_item.number_purchased;
								player.mirror_instance.hp_current = player.mirror_instance.hp_start;
								
							break;
			
							case "dash":
								player.dash = true;
							break;
			
							case "bomb":
								switch(current_item.subtype){
								case "remote":
									player.bomb_remote = true;
								break;
								case "max_up":
									player.bomb_start = 3 + (3 * current_item.number_purchased);
									player.bomb_current = player.bomb_start;
									player.bomb_bar.bomb_previous = player.bomb_start;									
								break;
								case "shrapnel":
									player.bomb_shrapnel = true;
									if current_item.number_purchased == 2{
										player.shrapnel_upgraded = true;
									}
								break;
								case "lure":
									player.bomb_lure = true;
								break;
							}
						break;			
					}
				}else if(temp_manager.game_round == 1){
					current_item.number_purchased = 0;
				}
			}
		}else{
			player.item_list = ds_list_create();
		}

	}
}

function core_find_item(_item_index){
	var return_item;
	if(ds_list_size(global.item_list) > 0){
		return_item = ds_list_find_value(global.item_list,_item_index - 1);
		if(return_item.index == _item_index){
			show_debug_message("Item matches indexes, returning...");
		}else{
			show_debug_message("Indexes do not match, returning item but it may not be correct.");
		}
		
		return return_item;
	}else{
		show_debug_message("Global Item List is empty, initialize it first before accessing.");
	}
}

function core_find_player_item(_player,_item_index){
	var items = ds_list_size(_player.item_list);
	if(items > 0){
		for(var i = 0;i < items;i++){
			var current_item = ds_list_find(_player.item_list);
			if(current_item.index == _item_index){
				return current_item;
			}
		}
	}
}

function core_upgrade_item(_player,_item){

	_item.number_purchased++;
	if(ds_list_size(_player.item_list) > 0){
		if(_item.number_purchased > 0 && _item.number_purchased < _item.limit){
			switch(_item.index){
				case 0://HP UP
					_player.hp_start += obj_game_manager.starting_hp_increment * _item.number_purchased; //this can be altered to whatever increment we want.
					_player.hp_current += obj_game_manager.starting_hp_increment * _item.number_purchased;
					_player.health_bar.hp_previous = _player.hp_current;
				break;
			
				case 1:	//medkit
					///Can't be upgraded.
					show_debug_message("Medkit cannot be upgraded");
				break;
				case 2://SHIELDS
					_player.shield_explosion += 1 * _item.number_purchased;
				break;
				case 3:
					_player.shield_bullet += 1 * _item.number_purchased;
				break;
				case 4:
					_player.shield_bramble += 1 * _item.number_purchased;
				break;		
				case 5:
					_player.shot_speed -= 2 * _item.number_purchased;
				break;
				case 6:
					_player.shot_power += 1 * _item.number_purchased;
				break;
				case 7:
					_player.num_bullets = 1 + _item.number_purchased;
				break;
				case 8:
					_player.shot_ricochet_number = _item.number_purchased;
				break;
				case 9:
					_player.knockback_strength += _item.number_purchased;
				break;			
				case 10:
					_player.mirror_hp_start = 20 * _item.number_purchased;
					_player.mirror_hp_current = 20 * _item.number_purchased;
				break;
				case 11:
					///cant be upgraded.
					show_debug_message("Dash cannot be upgraded.");
				break;
				case 12:
					show_debug_message("Remote bomb cannot be upgraded.");
				break;
				case 13:
					_player.bomb_start += 3 * _item.number_purchased;
					_player.bomb_current = _player.bomb_start;
					_player.bomb_bar.bomb_previous = _player.bomb_start;
				break;
				case 14:
					if _item.number_purchased == 2{
						_player.shrapnel_upgraded = true;
					}
				break;
				case 15:
					show_debug_message("Bomb Lure cannot be upgraded.");
				break;
			}
		}
	}else{
		show_debug_message("Player item list is empty. Add an item before it can be upgraded.");
	}
}

function core_acquire_item(_player,_item){
	switch(_item.index){
		case 1://HP UP
			_player.hp_start += obj_game_manager.starting_hp_increment;
			_player.hp_current += obj_game_manager.starting_hp_increment;
			_player.health_bar.hp_previous = _player.hp_current;
		break;
		case 2:	//medkit
			_player.medkit = true;
		break;
		case 3://explosion shield
			_player.shield_explosion += 1;
		break;
		case 4://Bullet Shield
			_player.shield_bullet += 1;
		break;
		case 5:
			_player.shot_speed -= 2;
		break;
		case 6:
			_player.shot_power += 1;
		break;
		case 7:
			_player.num_bullets = 2;
		break;
		case 8:
			_player.shot_ricochet_number = 1;
		break;
		case 9:
			_player.knockback_strength += 1;
		break;	
		case 10:
			_player.mirror = true;
			_player.mirror_hp_start = 20;
			_player.mirror_hp_current = 20;
		break;
		case 11://bramble shield
			_player.shield_bramble += 1;
		break;		
		case 12:
			_player.dash = true;
		break;
		case 13:
			_player.bomb_start += 3;
			_player.bomb_current = _player.bomb_start;
			_player.bomb_bar.bomb_previous = _player.bomb_start;
		break;
		case 14:
			_player.bomb_remote = true;
		break;
		case 15:
			_player.bomb_shrapnel = true;
		break;
		case 16:
			_player.bomb_lure = true;
		break;
	}

}

function core_spawn_players(){

	for(var i = 0; i  < array_length(global.players);i++){
		var _player = array_get(global.players,i);
		var type = typeof(_player);
		if(type == "struct"){
			if(_player.is_active && (is_null(_player.player_instance) || !instance_exists(_player.player_instance))){
				_player.player_instance = instance_create_layer(room_width / 2 + i * 20,room_height / 2,"Spawns",obj_player_entity,{
																																	player : _player,
																																	player_number : _player.player_number,
																																	face : 0,
																																	holdDirection : false,
																																	}
																																	);	
				_player.player_instance.init_skins();
			}
			
		}
		
	}
	load_items();
}
	
function core_start_match(bet){
	show_debug_message("Starting next match at " + string(current_time));

	obj_game_manager.bet_value = bet;
	//apply item effects on start
	if(room != rm_Arena){
		room_goto(rm_Start_input_check);
	}else{
		var players = instance_number(obj_player_entity);
		for(var i = 0; i < players;i++){			
			current_player = instance_find(obj_player_entity,i);
			current_player.start_round();
		}
		change_game_state(active_game)
		recall_bramble();
		enable_grace_period();
		load_items();
		obj_game_manager.disable_shop();
		spawner_instance.init_round();
		obj_game_manager.check_player_medkit();
	}
	show_debug_message("Initialization complete at: " + string(current_time));
}

function core_end_game(){
	
	input_delay_all(10,"action_1");
	alarm[1] = 120;
	visible = true;
	change_game_state(game_over);
	game_manager_clear_players();
	bet_value = 100;
	audio_stop_all();
	if (!instance_exists(obj_blackout)) {
		var blackout = instance_create_layer(0, 0, "Effects", obj_blackout);
		blackout.fade_in();
	}else{
		blackout = instance_find(obj_blackout,0);
		if(blackout != 0){
			blackout.fade_in();
		}
	}
	
	var enemy_number = instance_number(obj_enemy_parent);
	for(var i = 0; i < enemy_number;i++){
		var enemy = instance_find(obj_enemy_parent,0);
		if(not_null(enemy)){
			instance_destroy(enemy,false);
		}
	}
	var bullet_number = instance_number(obj_bullet);
	for(var i = 0; i < bullet_number;i++){
		var bullet = instance_find(obj_bullet,0);
		if(not_null(bullet)){
			instance_destroy(bullet,false);
		}
	}
	var enemy_bullet_number = instance_number(obj_enemy_bullet);
	for(var i = 0; i < enemy_bullet_number;i++){
		var bullet = instance_find(obj_enemy_bullet,0);
		if(not_null(bullet)){
			instance_destroy(bullet,false);
		}
	}
	var bomb_num = instance_number(obj_bomb);
	for(var i = 0; i < bomb_num;i++){
		var bomb = instance_find(obj_bomb,0);
		if(bomb != 0 && bomb != -4){
			instance_destroy(bomb,false);
		}
	}
	instance_destroy(active_spawn_manager);
}
	
function core_set_priority_enforcement(prio = ""){
	if(prio != "" ){
		global.priority_enforced = prio;
	}else{
		global.priority_enforced = !global.priority_enforced;
		show_debug_message("Priority enforced set to: " + string(global.priority_enforced));
	}

}
	
function core_enable_priority(){
	has_priority = true;
	global.priority_count++;
}

function core_disable_priority(){
	has_priority = false;
	global.priority_count--;
}

function core_disable_all_priority(){
	var managers = instance_number(_obj_manager_parent);
	for(var i = 0; i < managers;i++){
		var current_manager = instance_find(_obj_manager_parent,i);
		if(not_null(current_manager)){
			current_manager.has_priority = false;
		}
	
	}
}

function core_recall_bramble(){
	for(var i = 0;i<instance_number(obj_hazard_parent);i++){
		var current_bramble = instance_find(obj_hazard_parent,i);
		if(current_bramble != 0){
			current_bramble.sprite_index = current_bramble.removal_sprite;
		}
	}
}
	
function core_enable_grace_period(){
		
}
	

