global._users = array_create(0);


function User(_user_index,_user_name,new_is_guest, new_player_data = "",new_saves_data = "") constructor{
//this will be used later to load settings for player profiles and such.
	user_index = _user_index;
	player_data = new_player_data;
	user_name = _user_name;
	is_guest = new_is_guest;
	input_config = {};
	gp_input_config = {};
	kb_input_config = {};
	saves_data = new_saves_data;
	if(is_null(saves_data)){saves_data = array_create(0);}

	
	static set_player_data = function(){
		if(is_null(player_data)){
			for(var i = 0; i < INPUT_MAX_PLAYERS;i++){
				if(is_null(global.players[i])){
					player_data = new Player(user_index,i,InputDeviceGetNewActivity());
					global.players[i] = player_data;
				}
			}
		}else{
			var player_found = false;
			for(var i = 0; i < INPUT_MAX_PLAYERS;i++){
				var current_player = global.players[i];
				if(current_player == player_data){
					player_found = true;
				}
			}
			if(player_found == false){
				for(var i = 0; i < INPUT_MAX_PLAYERS;i++){
					var current_player = global.players[i];
					if(is_null(current_player)){
						global.players[i] = player_data;
						return;
					}
				}
			}
		}
	}
	
	static set_user_data = function(){
		var user_found = false;
		for(var i = 0;i < array_length(global._users);i++){
			var current_user = global._users[i];
			if(not_null(current_user)){
				if(current_user.user_index == user_index){
					user_found = true;
				}
			}
		}
		if(!user_found){
			if(array_length(global._users) > 0){
				for(var i = 0; i < array_length(global._users);i++){
					var current_user = global._users[i];
					if(is_null(current_user)){
						global._users[i] = self;
					}
				}
			}else{
				global._users[0] = self;
			}
		}
	}
	
	static set_gamepad = function(_index){
		if(not_null(player_data)){
			player_data.device = _index;
		}
	}
		
	static set_gamepad_next_available = function(){
		var devices = InputDeviceEnumerate(false);
		for(var i = 0;i < array_length(devices);i++){
			if(InputDeviceIsAvailable(devices[i])){
				player_data.device = devices[i];
			}
		}
	}
		
	static set_user_name = function(_name){
		user_name = _name;
		save_users();
	}
		
	static get_user_name = function(){
		return user_name;
	}
		
	static save_user_binding = function(){
		var device_check = InputPlayerGetDevice(player_data.index)
		var for_gamepad = false;
		gp_input_config = InputBindingsExport(true,player_data.player_number);
		kb_input_config = InputBindingsExport(false,player_data.player_number);
		if(InputDeviceIsGamepad(device_check)){
			for_gamepad = true;
			input_config = gp_input_config;
		}else{
			input_config = kb_input_config;
		}

		var file_name = "user_profiles.json";
		var _file = file_text_open_read(file_name);
		if(_file == -1){
			_file = file_text_open_write(file_name);
			file_text_close(_file);
		}
		_file = file_text_open_read(file_name);
		var file_string = file_text_read_string(_file);
		var user_json = json_parse(file_string);
		file_text_close(_file);
	
		for(var i = 0;i < array_length(user_json);i++){
			var current_active_user = user_json[i];
			if(not_null(current_active_user)){
				if(current_active_user.user_index == user_index){
					current_active_user.input_config = input_config;
				}
			}
		}
		var return_data = json_stringify(user_json);
		_file = file_text_open_write(file_name);
		file_text_write_string(_file,return_data);
		file_text_close(_file);
	}
		
	static load_user_binding = function(){
		var file_name = "user_profiles.json"
		var _file = file_text_open_read(file_name);

		if(_file == -1){
			return;
		}
		var file_string = file_text_read_string(_file);
		var user_json = json_parse(file_string);
	
		for(var i = 0;i < array_length(user_json);i++){
			var current_active_user = user_json[i];
			if(not_null(current_active_user)){
				if(current_active_user.user_index == user_index){
					kb_input_config = current_active_user.kb_input_config;
					gp_input_config = current_active_user.gp_input_config;
				}
			}
		}
		file_text_close(_file);
		
		var device_check = InputPlayerGetDevice(player_data.player_number)
		var for_gamepad = false;

		if(struct_exists(kb_input_config,"debug")){
			
		}else{
			InputBindingsReset(false,player_data.player_number);
			kb_input_config = InputBindingsExport(false,player_data.player_number);
		}
		if(struct_exists(gp_input_config,"debug")){
			
		}else{
			InputBindingsReset(true,player_data.player_number);
			gp_input_config = InputBindingsExport(true,player_data.player_number);
		}
		
		if(InputDeviceIsGamepad(device_check)){
			input_config = gp_input_config;
		}else{
			input_config = kb_input_config;
		}
	}
		
	static get_current_save_data = function(){
		for(var i = 0; i < array_length(saves_data);i++){
			var data = saves_data[i];
			if(global.current_game == data.game){
				return data;
			}
		}
	}
	
	set_player_data();
	set_user_data();
	load_user_binding();
}
	
function Player(new_index, new_player_number = 0, new_device = "", new_player_instance = 0) constructor{
	
	///USER GAME INFO
	index = new_index;
	player_number = new_player_number;
	device = new_device;
	player_instance = new_player_instance;
	is_active = false;
	in_game = false;
	///INPUT CONTROL
	input_allowed = true;
	input_ready = true;
	input_delay = 10;
	input_timer = 0;
	
	///INPUT VARIABLES
	up = false;
	down = false;
	left = false;
	right = false;
	wKey = ord("W");
	aKey = ord("A");
	sKey = ord("S");
	dKey = ord("D");
	enterKey = vk_enter;
	spaceKey = vk_space;
	horizontal_axis = 0;
	vertical_axis = 0;
	action_1 = false;
	action_2 = false;
	action_3 = false;
	action_1_released = false;
	action_2_released = false;
	action_3_released = false;
	start = false;
	
	///DEBUG INPUTS
	f1 = false;
	f2 = false;
	f3 = false;
	f4 = false;
	f5 = false;
	f6 = false;
	f7 = false;
	f8 = false;
	f9 = false;
	
	
	static set_palette_index = function(_index){
		palette_index = _index;
	}
	static get_next_palette = function(){
		palette_index = palette_index + 1;
		var colors = pal_swap_get_pal_count(character.palette) - 1;
		if(palette_index > colors){
			palette_index = 0;
		}	
	}
	static get_prev_palette = function(){
		palette_index = palette_index - 1;
		var colors = pal_swap_get_pal_count(character.palette) - 1;
		if(palette_index < 0){
			palette_index = colors;
		}
	}
	static set_character = function(){
		get_player_bug_characters(self);
	}
	character = "";
	palette_index = 0;
	switch(player_number){
		case 1:
			palette_index = 0;
		break;
		case 2:
			palette_index = 1;
		break;
		case 3:
			palette_index = 2;
		break;
		case 4:
			palette_index = 3;
		break;
	}
	
}
	
function load_users(_number_to_load){
	var file_string = "user_profiles.json";
	var _file = file_text_open_read(file_string);

	if(_file == -1){
		insert_first_user();
	}
	_file = file_text_open_read(file_string);
	var _data = file_text_read_string(_file);
	var _json_data = json_parse(_data);
	
	for(var i = 0;i < _number_to_load;i++){
		if(i >= array_length(_json_data)){
			global._users[i] = new User(i * 10,string_concat("Guest ",string(i)),true, new Player(i * 10,i,InputPlayerGetDevice(i)));
		}else{
			var current_user = _json_data[i];
			if(not_null(current_user)){
				var current_active_user = 0;
				if(array_length(global._users) > 0){
					current_active_user = global._users[i];
				}
				
				if(is_null(current_active_user) || current_active_user.user_index == current_user.user_index){
					var new_user_obj = new User(current_user.user_index,current_user.user_name,false, new Player(current_user.player_data.index,i,InputPlayerGetDevice(i)));
					new_user_obj.saves_data = current_user.saves_data;
					new_user_obj.input_config = current_user.input_config;
					InputBindingsImport(InputDeviceIsGamepad(new_user_obj.player_data.device),new_user_obj.input_config,new_user_obj.player_data.player_number);
					global._users[i] = new_user_obj;
					new_user_obj.player_data.set_character();
				}
			}else{
				global._users[i] = new User(i * 10,string_concat("Guest ",string(i)),true, new Player(i * 10,i,InputPlayerGetDevice(i)));
			}
		}
	}
	file_text_close(_file);
}

function save_users(){
	var file_string = "user_profiles.json"
	var _file = file_text_open_write(file_string);
	
	var array_json = array_create(0);
	for(var i = 0;i < array_length(global._users);i++){
		var current_active_user = global._users[i];
		if(not_null(current_active_user)){
			if(!current_active_user.is_guest){
				array_push(array_json,current_active_user);
			}
		}
	}
	var return_data = json_stringify(array_json,false);
	file_text_write_string(_file,return_data);
	file_text_close(_file);
}

function insert_first_user(){
	InputPlayerSetDevice(INPUT_KBM,0);
	var user = new User(0,"Default",false,new Player(0,0,InputPlayerGetDevice(0)));
	array_push(user.saves_data);
	user.set_user_data();
	var file_string = string_concat(working_directory,"user_profiles.json");
	var _file = file_text_open_write(file_string);
	var user_json = json_stringify(global._users,false);
	file_text_write_string(_file,user_json);
	file_text_close(_file);
	user.save_user_binding();
}

function find_player_user(_player){
	for(var i = 0;i < array_length(global._users);i++){
		var current_user = global._users[i];
		if(current_user.user_index == _player.index){
			return current_user;
		}
	}
}

function Character(new_name,new_character_sprite,new_palette = wiz_palette) constructor{
	character_name = new_name;
	character_sprite = new_character_sprite;
	palette = new_palette;
}
	
function get_player_bug_characters(player){
	var user = find_player_user(player);
	if(not_null(user.saves_data)){
		var saves = array_length(user.saves_data);
		if(saves > 0){
			for(var i = 0; i < saves; i++){
				if(user.saves_data[i].game == Buggin_Out){
					///Game found, get characters.
					var save_data = user.saves_data[i];
					if(not_null(save_data)){
						return save_data.game_data.characters;
					}else{
						///Save data Null. Will need initialization.
						show_debug_message("Save data Null. Will need initialization.");
						return;
					}
				}
			}
		}else{
			var new_save = new Save_Data(Buggin_Out,user)
			return new_save.game_data.characters;
		}
	}
}
	
function get_char_sprite(player){
	var user = find_player_user(player);
	var chars = get_player_bug_characters(player);
	player.character = chars[0];
}
