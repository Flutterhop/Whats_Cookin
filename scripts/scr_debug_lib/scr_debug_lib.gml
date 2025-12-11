enum debug_type{
	player_debug = 0,
	enemy_debug = 1
}
global.debug_setting = debug_type.player_debug;
function toggle_debug(){
	global.debug = !global.debug;
	var center_x = get_screen_center_x();
	var center_y = get_screen_center_y();
	var debug_menu = instance_find(_debug_listener,0);
	if(not_null(debug_menu)){
		switch(global.debug){
			case true:
				debug_menu.squeeb = instance_create_depth(center_x * 1.9,center_y * 1.9,-1000,_squeeb);
				debug_menu.debug_menu_index = 0;
			break;
			case false:
				//Turning debug off.
				if(not_null(obj_input_manager.typer)){
					obj_input_manager.typer.has_priority = false;
					core_disable_priority();
					instance_destroy(obj_input_manager.typer);
				}
				if(not_null(debug_menu.squeeb)){
					instance_destroy(debug_menu.squeeb);
				}
				global.debug_setting = debug_type.player_debug;
				if(not_null(debug_menu.enemy_visual_selection)){
					debug_menu.clear_previews();
				}

			break;
		}
	}
}

function toggle_debug_mode(){
	switch (global.debug_setting) {
		case debug_type.player_debug:
			global.debug_setting = debug_type.enemy_debug;
			debug_menu_index = 0;
			if(not_null(enemy_visual_selection)){
				if(array_length(enemy_visual_selection) >= ds_list_size(global.enemy_structs)){
					break;
				}else{
					init_enemy_selection();
				}
			}else{
				init_enemy_selection();
			}
		break;
		case debug_type.enemy_debug:
			global.debug_setting = debug_type.player_debug;
			if(not_null(enemy_visual_selection)){
				debug_menu_index = 0;
				clear_previews();
			}

		break;
	}
}
	
function spawn_debug_entity(entity){
	
	var center_x = get_screen_center_x();
	var center_y = get_screen_center_y();
	instance_create_layer(center_x,center_y,"Enemies",entity.asset,{hp : entity.enemy_health});
}

function interpret_debug_inputs(){
	if(object_index != _debug_listener){return;}
	if(global.debug){
		var temp_player = 0;
		for(var i = 0;i < array_length(global.players); i++){
			temp_player = array_get(global.players,i);
			if(not_null(temp_player)){
				if(temp_player.input_allowed){
					if(temp_player.f1){input_f1(temp_player);}
					if(temp_player.f2){input_f2(temp_player);}
					if(temp_player.f3){input_f3(temp_player);}
					if(temp_player.f4){input_f4(temp_player);}
					if(temp_player.f5){input_f5(temp_player);}
					if(temp_player.f6){input_f6(temp_player);}
					if(temp_player.f7){
						input_f7(temp_player);}
					if(temp_player.f8){input_f8(temp_player);}
					if(temp_player.f9){input_f9(temp_player);}
				}
			}	
		}
	}

}
	
function debug_init_enemy_selection(){
	try{
		var enemies = global.enemy_structs;
		var num_enemies = ds_list_size(enemies);
		var width = 1;
		var height = 1;
		for(var i = 0; i < num_enemies; i++){
			if(not_null(enemies)){
				var current_enemy = ds_list_find_value(enemies,i);
				var new_preview = instance_create_layer(0 + (width * 40),40 * height ,"UI",obj_enemy_debug_preview,{preview_object : current_enemy.asset,
																															number_of_enemies : i,
																															});
				if(i == 0){array_set(enemy_visual_selection,0,new_preview);new_preview.active = true;}else{array_push(enemy_visual_selection,new_preview);}
				width++;
				if((i / 4) == 1){height++;width = 1;}

			}
		}
	}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
}
	
function debug_clear_previews(){
	try{
		if(not_null(enemy_visual_selection)){
			var preview_num = array_length(enemy_visual_selection);
			for(var i = 0;i < preview_num;i++){
				var item_to_clear = array_pop(enemy_visual_selection);
				if(not_null(item_to_clear)){instance_destroy(item_to_clear);}
			}
		}
	}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
}

function change_debug_selection(increment){
	try{
		var num_enemies_to_select = array_length(enemy_visual_selection);
		var current_item = enemy_visual_selection[debug_menu_index];
		current_item.active = false;
		debug_menu_index += increment;
		if(debug_menu_index < 0){
			debug_menu_index = num_enemies_to_select - 1
		}else if(debug_menu_index > num_enemies_to_select -1){
			debug_menu_index = 0;
		}
		current_item = enemy_visual_selection[debug_menu_index];
		current_item.active = true;
	}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
	
}