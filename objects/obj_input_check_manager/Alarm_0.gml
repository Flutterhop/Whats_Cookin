
//Maybe play a sound or jingle
var elements = instance_number(obj_player_button);
	for(var i = 0; i < elements;i++){
		var element = instance_find(obj_player_button,i);
		if(element != 0 && element != noone && element != ""){
			if(element.player != 0 && element.player != ""){
				if(element.is_active && element.is_ready){
					element.player.is_active = true;
				}else{
					element.player.is_active = false;
				}
			}
		}
	}
InputPartySetJoin(false);
room_goto(rm_loading);