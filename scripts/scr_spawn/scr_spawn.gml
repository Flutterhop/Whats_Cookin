function Spawner() constructor{
	current_payload = "";
	payloads = [];
	instance = "";
	
	static add_payload = function(new_payload){
		//When adding payloads we need to combine the new one with any already existing payloads.
		var payload_num = array_length(payloads);
		for(var i = 0;i < payload_num;i++){
			var current_pl = payloads[i];
			if(not_null(current_pl)){
				if(is_instanceof(new_payload,Spawner_Payload)){
					if(current_pl.wave == new_payload.wave){
						array_concat(new_payload.entities,current_pl.entities);
						return;
					}
				}
			}
		}
	}

	static request_payload = function(wave_num){
		var return_payload = "";
		var payload_num = array_length(payloads);
		if(payload_num < wave_num){
			return "";
		}
		for(var i = 0;i < payload_num;i++){
			var current_pl = payloads[i];
			if(not_null(current_pl)){
				if(current_pl.wave == wave_num){
					return_payload = current_pl;
					return;
				}
			}
		}
		return return_payload;
	}
	
	static spawn_next = function(){
		var spawn_size = array_length(current_payload.entities);
		if(spawn_size > 0){
			var next_spawn = current_payload.entities[0];
			if(is_instanceof(next_spawn,Character_Game)){
				next_spawn.spawn_entity()
				
			}
		}
	}
}


function Spawner_Payload(new_wave, new_entities) constructor{
	wave = new_wave
	entities = new_entities
}

