
function debug_input_f1(player){
	toggle_debug_mode();
}

function debug_input_f2(player){	
	var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			if(not_null(player.player_instance)){
				player.player_instance.debug_iframes = !player.player_instance.debug_iframes;
				player.player_instance.iframes = player.player_instance.debug_iframes;
			}
		break;
		case debug_type.enemy_debug:
			change_debug_selection(-1);	
		break;
	}
}

function debug_input_f3(player){				
	var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			var listener = instance_find(obj_shop_listener,0)
			if(not_null(listener)){
				listener.debug_sandbox = true;
			}
		break;
		case debug_type.enemy_debug:
			change_debug_selection(1);
		break;
	}
}

function debug_input_f4(player){				
	var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			player.player_instance.credits += 100;
		break;
		case debug_type.enemy_debug:
			spawn_debug_entity(ds_list_find_value(enemies,debug_menu_index));
		break;
	}
}

function debug_input_f5(player){				
		var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			if(not_null(player.player_instance)){
				player.player_instance.hp_current += 100;
			}
		break;
		case debug_type.enemy_debug:
			display_spawn_menu = !display_spawn_menu;
		break;
	}
}

function debug_input_f6(player){				
	var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			if(is_null(obj_input_manager.typer)){
				obj_input_manager.typer = instance_create_layer(get_screen_center_x(),get_screen_center_x(),"System",obj_screen_typer);
				obj_input_manager.typer.enable_priority();
				core_set_priority_enforcement(true);
			}
		break;
		case debug_type.enemy_debug:
			///spawn_debug_entity(ds_list_find_value(enemies,5));
		break;
	}
}

function debug_input_f7(player){	

	switch(global.debug_setting){
		case debug_type.player_debug:
			room_goto(rm_end);
			player.f7 = false;
		break;
		case debug_type.enemy_debug:

		break;
	}
}

function debug_input_f8(player){				
		var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			
		break;
		case debug_type.enemy_debug:
			///spawn_debug_entity(ds_list_find_value(enemies,6));
		break;
	}
}

function debug_input_f9(player){
		var enemies = global.enemy_structs;
	switch(global.debug_setting){
		case debug_type.player_debug:
			
		break;
		case debug_type.enemy_debug:
			///spawn_debug_entity(ds_list_find_value(enemies,8));
		break;
	}
}
