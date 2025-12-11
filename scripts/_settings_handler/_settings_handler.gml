// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
randomize();


function load_settings(){
	//load settings
///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
	try{
		ds_list_clear(global.enemy_structs);
	
		ini_open("settings.ini");
		var enemies = tag_get_asset_ids("enemy",asset_object);
		for(var i = 0;i<array_length(enemies);i++){
			var current_enemy = enemies[i];
			if(current_enemy != ""){
				var enemy_name = object_get_name(current_enemy);
				var preview_sprite = "";
				switch(current_enemy){
					case obj_bramble_hazard:
						enemy_name = string_replace(enemy_name,"obj_","");
						enemy_name = string_replace(enemy_name,"_hazard","");
						var included_string = string_insert("include_",enemy_name,0);
						var exclusion = ini_read_string(enemy_name,included_string,"true");
						var uses_spawner = ini_read_string(enemy_name,"uses_spawner","false");
					break;
					case obj_enemy_maneater:
						enemy_name = string_replace(enemy_name,"obj_enemy_","");
						var included_string = string_insert("include_",enemy_name,0);
						var exclusion = ini_read_string(enemy_name,included_string,"true");
						var uses_spawner = ini_read_string(enemy_name,"uses_spawner","false");
					break;
					case obj_enemy_big_grub:
						enemy_name = string_replace(enemy_name,"obj_enemy_","");
						var included_string = string_insert("include_",enemy_name,0);
						var exclusion = ini_read_string(enemy_name,included_string,"true");
						var uses_spawner = ini_read_string(enemy_name,"uses_spawner","false");
					break;
					default:
						enemy_name = string_replace(enemy_name,"obj_enemy_","");
						var included_string = string_insert("include_",enemy_name,0);
						var exclusion = ini_read_string(enemy_name,included_string,"true");
						var uses_spawner = ini_read_string(enemy_name,"uses_spawner","true");
						preview_sprite = ini_read_string(enemy_name,"preview_sprite","");
					break;
				}
				if (asset_has_tags(current_enemy,"minion")){exclusion = "false";}
				if(asset_has_tags(current_enemy,"boss")){exclusion = "false";}
			
				var is_included = true;

				if(exclusion == "false"){
					is_included = false;
				}else{
					is_included = true;	
				}

				var number_of = ini_read_real(enemy_name,"number_of",1);
				var enemy_health = ini_read_real(enemy_name,"health",1);
				var struct = new enemy_struct(current_enemy,number_of,enemy_health,is_included,,uses_spawner,preview_sprite);
				ds_list_add(global.enemy_structs,struct);
			}

		}	
	}catch(_exception){
			show_debug_message(_exception.message);
		    show_debug_message(_exception.longMessage);
		    show_debug_message(_exception.script);
		    show_debug_message(_exception.stacktrace);
	}

	
	
///////////////////////////////////////////////////////////////////////////////////////////////
	
///////////////////////////////////////////////////////////////////////////////////////////////
	
	ini_close();
	
	update_enemy_pool();
		
}
	
function save_settings(){
	try{
		ini_open("settings.ini");
	
		for(var i = 0;i < ds_list_size(global.enemy_structs); i++){
			var temp_struct = ds_list_find_value(global.enemy_structs,i);
			if(temp_struct != noone){
				var enemy_name = object_get_name(temp_struct.asset);
				var sprite_prefix = "spr_";
				var enemy_hp = 5;
				var enemy_number_of = 4;
				var preview_afix = "_preview";
				var exclusion = temp_struct.is_included;
			
				switch(temp_struct.asset){
					case obj_enemy_maneater:
						enemy_name = string_replace(enemy_name,"obj_enemy_","");
						if(exclusion == true){
							exclusion = "true";
						}else{
							exclusion = "false";
						}
						ini_write_string(enemy_name,"uses_spawner","false");
					
					break;
					case obj_bramble_hazard:
						enemy_name = string_replace(enemy_name,"obj_","");
						enemy_name = string_replace(enemy_name,"_hazard","");
						if(exclusion == true){
							exclusion = "true";
						}else{
							exclusion = "false";
						}
						ini_write_string(enemy_name,"uses_spawner","false");	
					break;
					default:
						enemy_name = string_replace(enemy_name,"obj_enemy_","");
						if(exclusion == true){
							exclusion = "true";
						}else{
							exclusion = "false";
						}
						var preview_string = string_concat(sprite_prefix,enemy_name,preview_afix);
						ini_write_string(enemy_name,"uses_spawner","true");
						ini_write_string(enemy_name,"preview_sprite",preview_string);
					break;
				}
				if (asset_has_tags(temp_struct.asset,"minion",asset_object) || asset_has_tags(temp_struct.asset,"boss",asset_object)){
					ini_write_string(enemy_name,"uses_spawner","false");
					exclusion = false;
				}
				var included_string = string_insert("include_",enemy_name,0);
				ini_write_string(enemy_name,included_string,exclusion);
				ini_write_string(enemy_name,"number_of",temp_struct.number_of);
				ini_write_string(enemy_name,"health",temp_struct.enemy_health);
			}
		}
	}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
	
	
	
	ini_close();
	
	update_enemy_pool();
}

function set_default_settings(){
	try{
		ini_open("settings.ini");
	
		for(var i = 0;i < ds_list_size(global.enemy_structs); i++){
			var temp_struct = ds_list_find_value(global.enemy_structs,i);
			if(temp_struct != noone){
				var enemy_name = object_get_name(temp_struct.asset);
				var sprite_prefix = "spr_";
				var enemy_hp = 5;
				var enemy_number_of = 4;
				var preview_afix = "_preview";
				var uses_spawner = "true";
				var exclusion = temp_struct.is_included;
			
				switch(temp_struct.asset){
					case obj_enemy_bee:
						enemy_hp = 7;
						enemy_number_of = 4;
						exclusion = "true";
						uses_spawner = "true";
					break;
					case obj_enemy_big_grub:
						enemy_hp = 50;
						enemy_number_of = 1;
						exclusion = "false";
						uses_spawner = "false";
					break;
					case obj_enemy_queen:
						enemy_hp = 100;
						enemy_number_of = 1;
						exclusion = "false";
						uses_spawner = "false";
					break;
					case obj_enemy_drone:
						enemy_hp = 3;
						enemy_number_of = 1;
						exclusion = "false";
						uses_spawner = "false";
					break;
					case obj_enemy_expant:
						enemy_hp = 3;
						enemy_number_of = 4;
						exclusion = "true";
						uses_spawner = "true";
					break;
					case obj_enemy_fly:
						enemy_hp = 4;
						enemy_number_of = 5;
						exclusion = "true";
						uses_spawner = "true";
					break;
					case obj_enemy_baby_fly:
						enemy_hp = 1;
						enemy_number_of = 1;
						exclusion = "false";
						uses_spawner = "true";
					break;
					case obj_enemy_frog:
						enemy_hp = 10;
						enemy_number_of = 4;
						exclusion = "true";
						uses_spawner = "true";
					break;
					case obj_enemy_grub:
						enemy_hp = 1;
						enemy_number_of = 9;
						exclusion = "true";
						uses_spawner = "true";
					break;
					case obj_enemy_maneater:
						enemy_hp = 10;
						enemy_number_of = 4;
						exclusion = "true";
						uses_spawner = "false";
					break;
					case obj_enemy_mantis:
						enemy_hp = 11;
						enemy_number_of = 6;
						exclusion = "true";
						uses_spawner = "true";
					break;
					case obj_bramble_hazard:
						enemy_hp = 0;
						enemy_number_of = 2;
						exclusion = "true";
						uses_spawner = "false";
					break;
					default:
						enemy_name = string_replace(enemy_name,"obj_enemy_","");
						if(exclusion == true){
							exclusion = "true";
						}else{
							exclusion = "false";
						}
						var preview_string = string_concat(sprite_prefix,enemy_name,preview_afix);
						ini_write_string(enemy_name,"preview_sprite",preview_string);
					break;
				}
				if (asset_has_tags(temp_struct.asset,"minion",asset_object) || asset_has_tags(temp_struct.asset,"boss",asset_object)){
					ini_write_string(enemy_name,"uses_spawner","false");
					exclusion = false;
				}
				temp_struct.is_included = exclusion;
				temp_struct.number_of = enemy_number_of;
				temp_struct.enemy_health = enemy_hp;
				temp_struct.uses_spawner = uses_spawner;
				var included_string = string_insert("include_",enemy_name,0);
				ini_write_string(enemy_name,included_string,exclusion);
				ini_write_string(enemy_name,"number_of",enemy_number_of);
				ini_write_string(enemy_name,"health",enemy_hp);
				ini_write_string(enemy_name,"uses_spawner",uses_spawner);
			}
		}
	}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
	
	
	
	ini_close();
	
	update_enemy_pool();
}

function update_enemy_pool(){
	ds_list_clear(global.enemy_pool);
	
	if(ds_list_size(global.enemy_structs) > 0){
		for(var i = 0; i < ds_list_size(global.enemy_structs); i++){
			var item = ds_list_find_value(global.enemy_structs,i);
			if(item.is_included == true){
				var pool_enemy = new enemy_struct(item.asset,item.number_of,item.enemy_health,true,,item.uses_spawner,item.preview_sprite);
				ds_list_add(global.enemy_pool,pool_enemy);
			}
		}
	}else{
		show_debug_message("No enemies loaded in global struct list. What have you done?!");
	}
}

function load_game_settings(){
	//load settings
	ini_open("settings.ini");
	var screen_size = ini_read_real("video","screen_size",1.0);
	obj_display_manager.zoom = screen_size;
	var music_volume = ini_read_real("audio","music_volume",1.0);
	obj_audio_manager.musicVolume = music_volume;
	obj_audio_manager.update_music_volume();
	var sfx_volume = ini_read_real("audio","sfx_volume",1.0);
	obj_audio_manager.sfxVolume = sfx_volume;
	obj_audio_manager.update_sfx_volume();
	ini_close();


}

function set_default_game_settings(){
	//load settings
	ini_open("settings.ini");
	if(!ini_section_exists("audio")){	
		ini_write_real("audio","music_volume",4);
		ini_write_real("audio","sfx_volume",4);
	}else{
		if(!ini_key_exists("audio","music_volume")){
			ini_write_real("audio","music_volume",4);
		}
		if(!ini_key_exists("audio","sfx_volume")){
			ini_write_real("audio","sfx_volume",4);
		}
	}
	if(!ini_section_exists("video")){
		ini_write_real("video","screen_size",3);
	}else{
		if(!ini_key_exists("video","screen_size")){
			ini_write_real("video","screen_size",3);
		}

	}


	ini_close();
	
}
function save_game_settings(context){
	ini_open("settings.ini");
	switch(context){
		case "video":
			ini_write_real("video","screen_size",obj_display_manager.zoom);
		break;
		case "audio":
			ini_write_real("audio","music_volume",obj_audio_manager.musicVolume);
			ini_write_real("audio","sfx_volume",obj_audio_manager.sfxVolume);
		break;
	}
	ini_close();
}