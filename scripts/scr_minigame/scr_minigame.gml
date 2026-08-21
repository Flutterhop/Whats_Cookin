


function interact_minigame_input(input_value){
	var num_inputs = array_length(required_inputs);
	if(num_inputs > 0){
		for(var i = 0; i < num_inputs;i++){
			if(input_value == required_inputs[0]){
				array_shift(required_inputs)
				var remaining_inputs = array_length(required_inputs)
				if(remaining_inputs <= 0){
					struct.state_machine.ChangeState("success");
				}
				image_index++;
				return
			}
		}
	}else{
		struct.state_machine.ChangeState("success");
		return
	}
}
