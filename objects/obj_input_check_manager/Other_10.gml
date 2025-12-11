event_inherited();

time_to_start = 325;
timer = round(time_to_start / 60);

character_index = 0;
skin_index = 0;

element_ready_count = 0;

ready_signal_received = false;

/////DEFINE SCRIBBLE MACROS
scribble_add_macro("input_icon",function(verb_index,player_index){
	var _string = "";
	var number_verb_index = real(verb_index);
	var number_player_index = real(player_index);
	var icon = InputIconGet(number_verb_index,0,number_player_index);
	if(is_string(icon)){
		
		_string = string_concat("[",icon,"]");
	}else{
		var sprite_name = sprite_get_name(icon);
		_string = string_concat("[",string(sprite_name),"]");
	}


	return _string;
});