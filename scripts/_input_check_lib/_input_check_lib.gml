
function input_check_init_room(){
	var player_num = INPUT_MAX_PLAYERS;
	for(var i = 0;i < player_num;i++){
		var new_player = array_get(global.players,i){
			if(new_player != 0 && InputPlayerIsConnected(i)){
				var new_button = instance_create_layer(x,y,"Players",obj_player_button,{player_number : i,player : new_player,is_ready : false, active : true});
			}else{
				var new_button = instance_create_layer(x,y,"Players",obj_player_button,{player_number : i,player : new_player,is_ready : false, active : false});
			}
		}
	}
}

function input_check_set_char_and_skin(){
	if(player != 0 && is_active){
		var sprite = get_char_sprite(player);
		var type = asset_get_type(sprite);
		if(type == asset_sprite){
			player_sprite = sprite;
		}
	}
}

function input_check_change_skin(player,increment){
	
	if(increment < 0){
		player.get_prev_palette();
	}else if(increment > 0){
		player.get_next_palette();
	}	
}
function input_check_change_character(player,increment){
	var characters = get_player_bug_characters(player);
	var num_characters = array_length(characters);
	for(var i = 0; i < num_characters;i++){
		var _char = characters[i];
		if(_char.character_name == player.character.character_name){
			i += increment;
			if(i >= num_characters){
				i = 0
			}else if(i < 0){
				i = num_characters - 1;
			}
			player.character = characters[i];
			return;
		}
	}
}

function input_check_get_player_button(player){
	var elements = instance_number(obj_player_button);
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element != 0 && element != noone && element != ""){
			if(element.player_number == player.player_number){
				element.player = player;
				return element;
			}
		}
	}
}
function input_check_get_active_elements(){
	var elements = instance_number(obj_player_button);
	var count = 0
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element != 0 && element != noone && element != ""){
			if(element.is_active == true){
				count++
			}
		}
	}
	return count;
}
function input_check_get_ready_elements(){
	var elements = instance_number(obj_player_button);
	var count = 0
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element != 0 && element != noone && element != ""){
			if(element.is_ready == true){
				count++
			}
		}
	}
	return count;
}
function input_check_ready(){
	var elements = instance_number(obj_player_button);
	var count = 0
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element != 0 && element != noone && element != ""){
			if(element.is_active == true && element.is_ready == true){
				count++
			}
		}
	}
	if(count >= get_active_elements()){
		return true;
	}
	return false;
}
function input_check_check_ready_status(){
	
	if(all_ready()){
		if(alarm[0] <= 0){
			alarm[0] = time_to_start;
		}
		if(alarm[0] >= 0){
			timer = round(alarm[0] / 60);
				
		}
		return;
	}

	if(alarm[0] >= 0){
		timer = round(alarm[0] / 60);
	}
}

function input_check_all_ready(){
	if(InputPartyGetReady()){
		if(ready_signal_received){
			if(ready()){
				return true;
			}
		}
	}
	return false;
}
