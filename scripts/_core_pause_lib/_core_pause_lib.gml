enum pause_state{
	main_menu = 0,
	settings_menu = 1,
	game_control_menu = 2,
	keyboard_menu = 3,
	controller_menu = 4,
	video_menu = 5,
	audio_menu = 6
}


function Pause_Menu(new_menu_name,new_menu_assets,new_depth,new_background_asset = "",new_button_distance_multi = 0,new_menu_exit_function = "") constructor {
	menu_name = new_menu_name;
	menu_assets = new_menu_assets;
	menu_depth = new_depth;
	menu_background_asset = new_background_asset;
	
	menu_background = "";
	menu_background_depth = -490;
	button_distance_multi = new_button_distance_multi;
	menu_items = array_create(0);
	menu_exit_function = new_menu_exit_function;
	menu_settings = "";
	
	
	
	function spawn_menu(starting_pos_x,starting_pos_y){
		try{
			var _menu_item_sort = function(current,next){
				////SORT BY BUTTON_INDEX LOCAL VARIABLE
				if(typeof(current) == "ref" && typeof(next) == "ref"){
					return current.button_index - next.button_index;
				}
			}
			///Spawn Background
			if(button_distance_multi == 0){button_distance_multi = 40;}
			if(not_null(menu_background_asset)){
				menu_background = instance_create_layer(starting_pos_x,starting_pos_y,"System",menu_background_asset);
				menu_background.depth = menu_background_depth;
			}
			//Spawn items to start.
			var num_items = array_length(menu_assets);
			for(var i = 0;i < num_items;i++){
				var new_item = instance_create_layer(starting_pos_x,starting_pos_y,"System",menu_assets[i],{manager : other.id});
				new_item.depth = menu_depth - (i + 1);
				array_push(menu_items,new_item);
			}
			///Make sure the items are ordered correctly.
			array_sort(menu_items,_menu_item_sort);
			num_items = array_length(menu_items);
			for(var i = 0;i < num_items;i++){
				///adjust position after spawning.
				menu_items[i].x = starting_pos_x;
				menu_items[i].y = (starting_pos_y - 75) + (i * button_distance_multi);
			}
			show_debug_message(menu_items);		
		}catch(_exception){
			show_debug_message(_exception.message);
		    show_debug_message(_exception.longMessage);
		    show_debug_message(_exception.script);
		    show_debug_message(_exception.stacktrace);
		}
	}
	
	function refresh_menu(){
	
	}
	function enter_menu(){
		
	}
	function exit_menu(){
		menu_exit_function();
	}
	function hide_menu(){
		for(var i = 0;i < array_length(menu_items);i++){
			var item = menu_items[i];
			item.visible = false;
		}
		menu_background.visible = false;

	}
	function show_menu(){
		for(var i = 0;i < array_length(menu_items);i++){
			
			var item = menu_items[i];
			item.visible = true;
		}
		menu_background.visible = true;
	}
}

function pause_change_state(target_state){
	///THIS FUNCTION NEEDS TO ACCOUNT FOR MENUS WITHIN MENUS. 
	///CURRENT REC IS TO ADD PREVIOUS STATES TO AN ARRAY AND
	///THEN POP THEM WHEN ATTEMPTING TO GO TO A STATE EQUAL
	///TO THE PREVIOUS STATE.
	if(array_length(current_states) <= 0){
		array_push(current_states,target_state);
	}
	
	var target_found = false;
	for(var i = 0; i < array_length(current_states);i++){
		var current = current_states[i];
		if(target_found){
			array_pop(current_states);
			break;
		}
		if(current == target_state){
			target_found = true;
		}
		
	}
	if(target_found == false){
		array_push(current_states,target_state);
	}
	previous_state = pause_menu_state;
	current_menu.hide_menu();

	current_menu = array_of_pause_menus[target_state];
	current_menu.show_menu();
	max_elements = array_length(current_menu.menu_items);
	pause_menu_state = target_state;
	
	set_pause_highlight(0);
	show_debug_message("Pause menu state updated from: " + string(previous_state) + " to " + string(target_state));
}	
	
function pause_enable_instances(){
	clean_up_menus();
	core_enable_game_layers();

}	
	
function pause_disable_instances(){
	if(global.debug){toggle_debug();}
	core_disable_game_layers();
	audio_group_stop_all(audiogroup_sfx);
	init_main_menus();


}
	
function pause_init_main_menus(){
	///INIT CONSTANTS
	var button_distance_multi = 40;
	var window = instance_create_layer(get_screen_center_x(),get_screen_center_y(),"System",obj_pause_window);
	array_push(menu_constants,window);
	var title = instance_create_layer(get_screen_center_x(),get_screen_center_y() - 120,"System",obj_pause_title);
	array_push(menu_constants,title);
	window.depth = -501;
	title.depth = -502;
	///INIT MAIN MENUS
	var main_assets = tag_get_asset_ids("pause_menu_main",asset_object);
	if(not_null(main_assets)){
		array_of_pause_menus[0] = new Pause_Menu("main_menu",main_assets,-510,obj_pause_menu);
		array_of_pause_menus[0].spawn_menu(get_screen_center_x(),get_screen_center_y());
	}
	var settings_assets = tag_get_asset_ids("pause_menu_settings",asset_object);
	if(not_null(settings_assets)){
		array_of_pause_menus[1] = new Pause_Menu("settings_menu",settings_assets,-510,obj_pause_settings_menu);
		array_of_pause_menus[1].spawn_menu(get_screen_center_x(),get_screen_center_y());
		array_of_pause_menus[1].hide_menu();
	}
	pause_menu_state = pause_state.main_menu;
	array_push(current_states,pause_menu_state);
	///Init main menu state
	current_menu = array_of_pause_menus[pause_state.main_menu];
	//set active element along with highlight.
	set_pause_highlight(0);
	//set state, which will set the max elements, hide prev menu, and show current menu.
	change_state(pause_state.main_menu);
	///NEED TO INIT GAME CONTROLS HERE AT SOME POINT.
	init_settings_menus();
}

function pause_init_settings_menus(){
	///INIT SETTINGS MENUS
	///Keyboard menu
	var keyboard_assets = tag_get_asset_ids("pause_setting_kb",asset_object);///Grab the assets associated to the tag
	if(not_null(keyboard_assets)){
		array_of_pause_menus[pause_state.keyboard_menu] = new Pause_Menu("keyboard_menu",
																		keyboard_assets,
																		-515,
																		obj_pause_settings_menu,
																		17,
																		pause_exit_kb_menu);///init the menu using the assets
		
		array_of_pause_menus[pause_state.keyboard_menu].spawn_menu(get_screen_center_x(),get_screen_center_y()); ///now spawn the assets in order.
		array_of_pause_menus[pause_state.keyboard_menu].hide_menu();
	}
	///Controller Menu
	var gamepad_assets = tag_get_asset_ids("pause_setting_gp",asset_object);
	if(not_null(gamepad_assets)){
		array_of_pause_menus[pause_state.controller_menu] = new Pause_Menu("controller_menu",gamepad_assets,-515,obj_pause_settings_menu,17,pause_exit_gp_menu);
		array_of_pause_menus[pause_state.controller_menu].spawn_menu(get_screen_center_x(),get_screen_center_y());
		array_of_pause_menus[pause_state.controller_menu].hide_menu();		
	}
	///Video Menu
	var video_assets = tag_get_asset_ids("pause_setting_video",asset_object);
	if(not_null(video_assets)){
		array_of_pause_menus[pause_state.video_menu] = new Pause_Menu("video_menu",video_assets,-515,obj_pause_settings_menu,40,pause_exit_vid_menu);
		array_of_pause_menus[pause_state.video_menu].spawn_menu(get_screen_center_x(),get_screen_center_y());
		array_of_pause_menus[pause_state.video_menu].hide_menu();
	}
	///Audio Menu
	var audio_assets = tag_get_asset_ids("pause_setting_audio",asset_object);
	if(not_null(audio_assets)){
		array_of_pause_menus[pause_state.audio_menu] = new Pause_Menu("audio_menu",audio_assets,-515,obj_pause_settings_menu,40,pause_exit_aud_menu);
		array_of_pause_menus[pause_state.audio_menu].spawn_menu(get_screen_center_x(),get_screen_center_y());
		array_of_pause_menus[pause_state.audio_menu].hide_menu();
	}
}

function pause_exit_kb_menu(){
	var current_player = get_input_player();
	var current_user = find_player_user(current_player);
	current_user.save_user_binding();
}

function pause_exit_gp_menu(){
	var current_player = get_input_player();
	var current_user = find_player_user(current_player);
	current_user.save_user_binding();
}
function pause_exit_vid_menu(){
	save_game_settings("video");
}	


function pause_exit_aud_menu(){
	save_game_settings("audio");
}

	
	
function pause_set_pause_highlight(index){
	highlighted = index;
	if(is_null(active_element)){active_element = current_menu.menu_items[0];}
	active_element.active = false;
	active_element = current_menu.menu_items[index];
	active_element.active = true;
}
	
function pause_handle_v_increment(increment){
	highlighted += increment;	
	check_v_bounds();
	set_pause_highlight(highlighted);
	obj_audio_manager.play_sfx(menu_blip);
	
}
	
function pause_handle_h_increment(increment){
	var parent = object_get_parent(active_element.object_index)
	if(parent == obj_setting_button_parent){
		active_element.setting += increment;
		check_h_bounds();
		obj_audio_manager.play_sfx(menu_blip);
	}else if(parent == obj_setting_input_player_select_parent){
		if(active_element.object_index == obj_button_KB_player_select || active_element.object_index == obj_button_GP_player_select){
			active_element.setting += increment;
			check_h_bounds();
			active_element.pause_button_action();
			obj_audio_manager.play_sfx(menu_blip);
		}
	
	}

}

function pause_check_v_bounds(){
	if(highlighted >= max_elements){
		highlighted = 0;
	}else if(highlighted < 0){
		highlighted = max_elements - 1;
	}
}
	
function pause_check_h_bounds(){
	if(active_element.setting > active_element.setting_max){
		active_element.setting = active_element.setting_min;
	}else if(active_element.setting < active_element.setting_min){
		active_element.setting = active_element.setting_max;
	}
}
	
function pause_fetch_arrows(){
	var return_arrows = array_create(0);
	if(array_length(menu_constants) > 0){
		for(var i = 0;i < array_length(menu_constants);i++){
			var current_constant = array_get(menu_constants,i);
			if(current_constant.object_index == obj_arrow){
				array_push(return_arrows,current_constant);
			}
		}
	}
	return return_arrows;
}

function pause_center_arrows(){

	///I THINK THIS CAN BE HANDLED ON THE ARROW SIDE BUT IT WILL STAY FOR NOW.
	var arrows = fetch_arrows();
	var pause_arrow_1 = arrows[0];
	var pause_arrow_2 = arrows[1];
	adjust_arrows();
	switch(current_menu.menu_name){
		case "main_menu":
			pause_arrow_1.x = active_element.x - pause_arrow_1.sprite_width * 3;
			pause_arrow_1.y = active_element.y;
			pause_arrow_2.x = active_element.x + pause_arrow_2.sprite_width * 3;
			pause_arrow_2.y = active_element.y + 2;
		break;
		case "settings_menu":
			pause_arrow_1.x = active_element.x - active_element.text_w / 1.8;
			pause_arrow_1.y = active_element.y + 2;
			pause_arrow_2.x = active_element.x + active_element.text_w / 1.8;
			pause_arrow_2.y = active_element.y + 4;
		break;
		case "game_control_menu":
			pause_arrow_1.x = active_element.x - pause_arrow_1.sprite_width;
			pause_arrow_1.y = active_element.y;
			pause_arrow_2.x = active_element.x + active_element.sprite_width + pause_arrow_2.sprite_width;
			pause_arrow_2.y = active_element.y + pause_arrow_2.sprite_height;
		break;
		case "keyboard_menu":
			pause_arrow_1.x = active_element.x - pause_arrow_1.sprite_width;
			pause_arrow_1.y = active_element.y;
			pause_arrow_2.x = active_element.x + active_element.sprite_width + pause_arrow_2.sprite_width;
			pause_arrow_2.y = active_element.y + pause_arrow_2.sprite_height;
		break;
		case "controller_menu":
			pause_arrow_1.x = active_element.x - pause_arrow_1.sprite_width;
			pause_arrow_1.y = active_element.y;
			pause_arrow_2.x = active_element.x + active_element.sprite_width + pause_arrow_2.sprite_width;
			pause_arrow_2.y = active_element.y + pause_arrow_2.sprite_height;
		break;
		case "video_menu":
			pause_arrow_1.x = active_element.x - pause_arrow_1.sprite_width;
			pause_arrow_1.y = active_element.y;
			pause_arrow_2.x = active_element.x + active_element.sprite_width + pause_arrow_2.sprite_width;
			pause_arrow_2.y = active_element.y + pause_arrow_2.sprite_height;
		break;
		case "audio_menu":
			pause_arrow_1.x = active_element.x - pause_arrow_1.sprite_width;
			pause_arrow_1.y = active_element.y - 5;
			pause_arrow_2.x = active_element.x + active_element.sprite_width + pause_arrow_2.sprite_width;
			pause_arrow_2.y = active_element.y + (pause_arrow_2.sprite_height) - 5;
		break;
	}
	
	///RESET ARROW BLINK
	pause_arrow_1.image_index = 0;
	pause_arrow_2.image_index = 0;
	active_element.blink_timer = 90;
	
}
	
function pause_adjust_arrows(){
	var arrows = array_create(2);
	arrows = fetch_arrows();
	if(pause_menu_state == pause_state.main_menu){
		if(arrows[0].sprite_index != spr_arrow){arrows[0].sprite_index = spr_arrow;}
		if(arrows[1].sprite_index != spr_arrow){arrows[1].sprite_index = spr_arrow;}		
	}
	///THIS SHOULD COVER ANY STATE OUTSIDE OF THE MAIN MENUS
	if(pause_menu_state != pause_state.main_menu && pause_menu_state != pause_state.settings_menu){

		arrows[0].sprite_index = spr_arrow_small_right;
		arrows[0].image_angle += 180;

		arrows[1].sprite_index = spr_arrow_small_right;
		arrows[1].image_angle += 180;
	}
}
	
function pause_clean_up_menus(){
	if(global.debug){toggle_debug();}
	var num_menus = array_length(array_of_pause_menus);
	for(var i = 0;i<num_menus;i++){
		var current_menu = array_of_pause_menus[i];
		if(is_null(current_menu)){continue;}
		var num_menu_items = array_length(current_menu.menu_items);
		if(num_menu_items <= 0){continue;}
		for(var j = 0;j < num_menu_items;j++){
			var current_item = current_menu.menu_items[j];
			if(not_null(current_item)){
				
				instance_destroy(current_menu.menu_items[j].id);
			}
		}
		var background = current_menu.menu_background;
		if(not_null(background)){
			instance_destroy(current_menu.menu_background);
		}
		array_of_pause_menus[i] = 0;
	}
	var num_consts = array_length(menu_constants);
	if(num_consts > 0){
		for(var i = 0;i < num_consts;i++){
			var current_constant = menu_constants[i];
			if(is_null(current_constant)){continue;}
			instance_destroy(menu_constants[i]);
		}
	}
	reset_manager();
	
}

function pause_reset_manager(){
	pause_menu_state = "";
	previous_state = "";
	active_element = "";
	array_of_pause_menus = array_create(0);
	menu_constants = array_create(0);
	current_states = array_create(0);
	current_menu = "";
	highlighted = 0;
}