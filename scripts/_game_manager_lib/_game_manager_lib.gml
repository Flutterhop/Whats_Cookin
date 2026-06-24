
enum GameMode{
	Default,
	Arena,
	Adventure
}

#macro round_BigGrub 4
#macro round_Queen 9


	
function game_manager_end_match(){
	
	ds_list_clear(global.enemy_list);
	if(!shop_listener.debug_sandbox){
		enable_priority();
		set_priority_enforcement(true);
		visible = false;
		if(!set_next_round()){
			
			while(instance_number(obj_medkit) != 0){
				instance_destroy(obj_medkit);
			}
			while(instance_number(obj_bomb) != 0){
				instance_destroy(instance_find(obj_bomb,0),false);

			}
			room_goto(rm_end);
			return;
		}
		enable_shop();
		activate_medkit = false;
		while(instance_number(obj_medkit) != 0){
			instance_destroy(obj_medkit);
		}
		while(instance_number(obj_bomb) != 0){
			instance_destroy(instance_find(obj_bomb,0),false);

		}
	}
}

function game_manager_set_next_round(){
	if(game_round = 0){
		game_round = 1;
		return true;
	}else{
		game_round++;	
	}
	if(game_round > round_Queen){
		return false;
		
	}else{
		return true;
	}	
}

function game_manager_init_items(){

	for(var i = 0; i < TOTAL_ITEMS;i++){
		switch(i){
			case 0:	//health up
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([300,300,350,350],"health_up","",spr_health_up_icon,,,10,4,0,1,"Increase starting health by 5.");//these will have to be edited to fit the games exact parameters.
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
				
			break;
			
			case 1:	//medkit
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([150,300],"medkit","",spr_healthkit_icon,,,,2,0,2,"Medkits will spawn randomly during matches.");
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 2:	//explosion shield
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([100,100],"shield","explosion",spr_armor_explosion_icon,,,,2,0,3,"Shield from explosive damage once per purchase total.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);				
					ds_list_insert(global.item_list,i,new_item);
			}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
		
			case 3://bullet shield
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([100,100],"shield","bullet",spr_armor_bullet_icon,,,,2,0,4,"Shield from bullets once per purchase total.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 4://fire rate up
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([150,250],"staff","firerate",spr_staff_firerate_icon,,,2,2,0,5,"Increase fire rate.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 5://shot power
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([400,400],"staff","power",spr_staff_shotpower_icon,,,3,2,0,6,"Increase shot power.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 6://split shot
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350,350],"staff","split",spr_staff_splitshot_icon,,,,2,0,7,"Fire multiple shots at once.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 7://ricochet shot
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350,250],"staff","ricochet",spr_staff_ricochet_icon,,,,2,0,8,"Bullets bounce off walls.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 8://knockback shot
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([200],"staff","knockback",spr_staff_knockback_icon,,,,1,0,9,"Bullets have more knockback.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 9://mirror
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([600,300],"mirror","",spr_drone_icon,,,,2,0,10,"A clone mimics the wizards movement and actions. Limited health.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 10://bramble shield
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([150,150],"shield","bramble",spr_armor_bramble_icon,,,,2,0,11,"Shield from bramble once per purchase total.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 11://dash
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350],"dash","",spr_dash_icon,,,,1,0,12,"Press action button to dash, deals damage to enemies and prevents damage on wizard.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 12://bomb up
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([100,100,150,200],"bomb","max_up",spr_bomb_up_icon,,,1,4,0,13,"Increase maximum bomb total.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 13://remote bomb
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([300],"bomb","remote",spr_bomb_remote_icon,,,,1,0,14,"Bombs can now be remotely detonated.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 14://bomb shrapnel
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([100,200],"bomb","shrapnel",spr_bomb_shrapnel_icon,,,,2,0,15,"Bombs now fire shrapnel upon explosion.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			
			case 15://bomb lure
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350],"bomb","lure",spr_bomb_lure_icon,,,,1,0,16,"Bombs now lure in enemies before explosion.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			case 16:
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350],"dagger","power",spr_staff_shotpower_icon,,,,1,0,17,"Increase dagger power.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			case 17:
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350],"dagger","knockback",spr_staff_knockback_icon,,,,1,0,18,"Increase dagger knockback.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
			case 18:
				if(ds_list_size(global.item_list) <= i){
					var new_item = new item_struct([350],"dagger","backstep",spr_dash_icon,,,,1,0,19,"Allows dagger users to swiftly backstep to escape danger. Press both action buttons simultaneously to use it.");
					new_item.set_progress(new_item.limit,new_item.number_purchased);
					ds_list_insert(global.item_list,i,new_item);
				}else{
					var returning_item = ds_list_find_value(global.item_list,i);
				}
			break;
		}

	}
}
	
function game_manager_reset_arena(){
	recall_bramble();
	round_ended = false;
	game_manager_clear_players();
	game_round = 1;
	change_game_state(active_game);
	obj_audio_manager.end_music();
	start_music = time_source_create(time_source_game, 73, time_source_units_frames, obj_audio_manager.play_music, [Buggin_Out_Fight_Music, true, 0]);
	time_source_start(start_music)
	//time_source_destroy(start_music)
	//obj_audio_manager.play_music(small_byte, true, 0, false)

	var blackout = instance_find(obj_blackout,0);
	if(blackout != 0 && blackout != noone){
		blackout.fade_out();
	}
	var spawner_instance = instance_find(obj_spawn_manager,0);
	if(spawner_instance != 0){
		spawner_instance.clear_enemies();
		spawner_instance.init_round();
	}
	disable_priority();
	init_items();
	load_items();
}

function game_manager_quit_adventure(){
	if(show_retry){
		show_retry = false;
		ui_target = "";
		instance_destroy(ui_quit);
		instance_destroy(ui_retry);
		instance_destroy(ui_arrow);
	}
	
	recall_bramble();
	round_ended = false;
	game_manager_clear_players();
	game_round = 1;
	change_game_state(menu);
	bet_value = 100;
	var blackout = instance_find(obj_blackout,0);
	if(blackout != 0 && blackout != noone){
		blackout.fade_out();
	}
	var spawner_instance = instance_find(obj_arena_spawn_manager,0);
	if(spawner_instance != 0){
		spawner_instance.clear_enemies();
	}
	obj_audio_manager.end_music();
	disable_priority();
	room_goto(rm_Start);
}

function game_manager_quit_default(){
	
	recall_bramble();
	round_ended = false;
	game_manager_clear_players();
	game_round = 1;
	change_game_state(menu);
	bet_value = 100;
	var blackout = instance_find(obj_blackout,0);
	if(blackout != 0 && blackout != noone){
		blackout.fade_out();
	}
	var spawner_instance = instance_find(obj_spawn_manager,0);
	if(spawner_instance != 0){
		spawner_instance.clear_enemies();
	}
	obj_audio_manager.end_music();
	disable_priority();
	room_goto(rm_Start);
}

function game_determine_boss_round(game_round){
	var is_boss_round = false;
	switch(game_round){
		case round_BigGrub:
			is_boss_round = true;
		break;
		case round_Queen:
			is_boss_round = true;
		break;
	}
	
	return is_boss_round; 
}

function game_manager_clear_players(){
	for(var i = 0; i < array_length(global.players);i++){
		var _player = global.players[i];
		if(not_null(_player)){
			if(not_null(_player.player_instance)){
				if(not_null(_player.player_instance.mirror_instance)){
					instance_destroy(_player.player_instance.mirror_instance);
				}
			}
			_player.player_instance = 0;
		}
	}
}

function game_manager_reset(){
	var _manager = instance_find(obj_game_manager,0);
	if(not_null(_manager) && instance_exists(_manager)){
		_manager.game_round = 1;
		_manager.active_spawn_manager = "";
		_manager.bet_value = 100;
	}
}
	
function retrieve_item_at_index(index = 1){
	var return_item
	switch(index){
		case 1:	//health up
			var new_item = new item_struct([300,300,350,350],"health_up","",spr_health_up_icon,,,10,4,0,1,"Increase starting health by 5.");//these will have to be edited to fit the games exact parameters.
			return_item = new_item;
		break;
			
		case 2:	//medkit
			var new_item = new item_struct([150,300],"medkit","",spr_healthkit_icon,,,,2,0,2,"Medkits will spawn randomly during matches.");
			return_item = new_item;
		break;
			
		case 3:	//explosion shield
			var new_item = new item_struct([100,100],"shield","explosion",spr_armor_explosion_icon,,,,2,0,3,"Shield from explosive damage once per purchase total.");
			return_item = new_item;
		break;
		
		case 4://bullet shield
			var new_item = new item_struct([100,100],"shield","bullet",spr_armor_bullet_icon,,,,2,0,4,"Shield from bullets once per purchase total.");
			return_item = new_item;		
		break;
			
		case 5://fire rate up
			var new_item = new item_struct([150,250],"staff","firerate",spr_staff_firerate_icon,,,2,2,0,5,"Increase fire rate.");
			return_item = new_item;
				
		break;
			
		case 6://shot power
			var new_item = new item_struct([400,400],"staff","power",spr_staff_shotpower_icon,,,3,2,0,6,"Increase shot power.");
			return_item = new_item;
				
		break;
			
		case 7://split shot
			var new_item = new item_struct([350,350],"staff","split",spr_staff_splitshot_icon,,,,2,0,7,"Fire multiple shots at once.");
			return_item = new_item;
				
		break;
			
		case 8://ricochet shot
			var new_item = new item_struct([350,250],"staff","ricochet",spr_staff_ricochet_icon,,,,2,0,8,"Bullets bounce off walls.");
			return_item = new_item;
				
		break;
			
		case 9://knockback shot
			var new_item = new item_struct([200],"staff","knockback",spr_staff_knockback_icon,,,,1,0,9,"Bullets have more knockback.");
			return_item = new_item;
		break;
			
		case 10://mirror
			var new_item = new item_struct([600,300],"mirror","",spr_drone_icon,,,,2,0,10,"A clone mimics the wizards movement and actions. Limited health.");
			return_item = new_item;
		break;
			
		case 11://bramble shield
			var new_item = new item_struct([150,150],"shield","bramble",spr_armor_bramble_icon,,,,2,0,11,"Shield from bramble once per purchase total.");
			return_item = new_item;
		break;
			
		case 12://dash
			var new_item = new item_struct([350],"dash","",spr_dash_icon,,,,1,0,12,"Press action button to dash, deals damage to enemies and prevents damage on wizard.");
			return_item = new_item;
		break;
			
		case 13://bomb up
			var new_item = new item_struct([100,100,150,200],"bomb","max_up",spr_bomb_up_icon,,,1,4,0,13,"Increase maximum bomb total.");
			return_item = new_item;
		break;

		case 14://remote bomb
			var new_item = new item_struct([300],"bomb","remote",spr_bomb_remote_icon,,,,1,0,14,"Bombs can now be remotely detonated.");
			return_item = new_item;
		break;
			
		case 15://bomb shrapnel
			var new_item = new item_struct([100,200],"bomb","shrapnel",spr_bomb_shrapnel_icon,,,,2,0,15,"Bombs now fire shrapnel upon explosion.");
			return_item = new_item;
		break;
			
		case 16://bomb lure
			var new_item = new item_struct([350],"bomb","lure",spr_bomb_lure_icon,,,,1,0,16,"Bombs now lure in enemies before explosion.");
			return_item = new_item;
		break;
	}
		
	return return_item;
}