

function has_substates(state_name){
	var has_substate = false;
	if(not_null(state_name)){
		var state_separate = string_split(state_name,"_");
		if(array_length(state_separate) > 1){
			has_substate = true;
			return has_substate;
		}else{
			return has_substate;
		}
	}else{
		EchoDebug("Null input cannot determine substates");
		return
	}
	
}

function get_substates(state_name,depth = 1,return_final = false){
	if(not_null(state_name)){
		var state_separate = string_split(state_name,"_");
		if(array_length(state_separate) > 1){
			if(array_length(state_separate) >= (depth + 1)){
				var substate = state_separate[depth];
				if(not_null(substate)){
					return substate
				}else{
					if(return_final){
						substate = state_separate[array_length(state_separate) - 1];
						if(not_null(substate)){
							EchoDebug("Cannot Find substate at this depth, returning final state in chain.")
						}
					}else{
						return "";
					}
				}
			}
		}else{
			return state_name;
		}
	}else{
		EchoDebug("Null input cannot get substates");
		return "";
	}
}