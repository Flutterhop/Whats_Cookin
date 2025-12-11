#macro Buggin_Out "Buggin_Out"
#macro Whats_Cookin "Whats_Cookin"

#macro Buggin_index 100
#macro Cookin_index 200

global.current_game = Buggin_Out;

function Save_Data(_new_game,_user_data,new_game_data = "") constructor{
	game = _new_game;
	user_data = _user_data;
	game_data = new_game_data;

	static init_save_data = function(){
		switch(game){
			case Buggin_Out:
				var game_found = false;
				game_data = new Buggin_Data(user_data);
				var saves = array_length(user_data.saves_data);
				if(saves > 0){
					for(var i = 0;i < saves; i++){
						var current_save = user_data.saves_data[i];
						if(current_save.game == Buggin_Out){
							///Save Data already Exists, exit.
							game_found = true;
						}
					}
					if(!game_found){
						array_push(user_data.saves_data,self);
					}
				}else{
					array_push(user_data.saves_data,self);
				}

			break;
			case Whats_Cookin:
			break;
			default:
				show_debug_message("No Game name found. Cannot assign game data.")
		}
	}
	
	static load_data = function(){
		
	}
	
	static retain_save_data = function(){
		
	}
	
	if(is_null(game_data)){
		init_save_data();
	}
}

function Buggin_Data(_user_data,_characters = "") constructor{
	save_index = Buggin_index;
	user_data = _user_data;
	characters = _characters;
	
	if(is_null(characters)){
		characters = array_create(0);
	}
	load_bug_character_data(characters);
	
	static fill_character_roster = function(){
		var character_assets = tag_get_asset_ids("character",asset_sprite);
		var number_of_characters = array_length(character_assets);
		for(var i = 0; i < number_of_characters;i++){	
			var char_string = string_split(sprite_get_name(character_assets[i]),"_",true,3);
			var character = new Character(char_string[1],character_assets[i]);
			switch(character.character_name){
				case "wiz":
					character.palette = wiz_palette;
				break;
				case "mothie":
					character.palette = mothie_palette;
				break;
			}
			array_set(characters,i,character);
		}
	}
}

function load_bug_character_data(characters){
	
	var number_of_palettes = pal_swap_get_pal_count(wiz_palette);
	var character_assets = tag_get_asset_ids("character",asset_sprite);
	var number_of_characters = array_length(character_assets);
	if(array_length(characters) >= number_of_characters){
		return;
	}else{
		var char_found = false;
		var iterator = 0;
		while(!char_found){
			var temp_char_string = string_split(sprite_get_name(character_assets[iterator]),"_",true,3);
			if(temp_char_string[1] == "wiz"){
				char_found = true;
				characters[0] = new Character(temp_char_string[1],character_assets[iterator]);
				return characters;
			}
			iterator++;
			if(iterator > number_of_characters){
				show_debug_message("Char not found. Returning null.");
				return;
			}
		}
	}
	return characters;
}