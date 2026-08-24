/// @description Insert description here

event_inherited();

active_minigame = "";
interaction_source = "";

function interaction(source){
	//Figure out if the item on the processing structure can be processed by this station.
	if(not_null(struct.inventory)){
		var inventory_space = array_length(struct.inventory);
		if(inventory_space <= 0){
			source.struct.state_machine.ChangeState("idle");
			return
		}
		var process_target = struct.inventory[0];
		if(not_null(process_target)){
			if(process_target.struct.can_process(id)){
				interaction_source = source;
				struct.state_machine.ChangeState("process")
				active_minigame = struct.spawn_minigame();
			}
		}
	}
}

function finish_process_item(){
	//Figure out if the item on the processing structure can be processed by this station.
	if(not_null(struct.inventory)){
		var inventory_space = array_length(struct.inventory);
		if(inventory_space <= 0){
			return
		}
		var process_target = struct.inventory[0];
		if(not_null(process_target)){
			if(process_target.struct.can_process(id)){
				process_target.struct.process_item(struct.stats.str_process_type)
				active_minigame.struct.state_machine.ChangeState("idle")
				interaction_source.struct.end_interaction(); 
				struct.end_minigame();
				active_minigame = "";
				struct.state_machine.ChangeState("occupied");
			}
		}
	}
}

function set_custom_states(){

	var process_state = new StatementState(struct.state_machine,"process")
    .AddEnter(function(){
			with(owner){
                
			}
		})
    .AddUpdate(function(){
			with(owner){
				if(not_null(active_minigame)){
					if(not_null(active_minigame.struct.state_machine)){
						//Minigame completed
						if(active_minigame.struct.state_machine.IsInState("success")){
							finish_process_item();
						}
					}
				}
			}
		});
    var occupied_state = new StatementState(struct.state_machine,"occupied")
		.AddUpdate(function(){
			with(owner){
				if(struct.is_empty()){
					struct.state_machine.ChangeState("empty");
				}
			}
		});
	
	struct.state_machine
	.AddState(process_state)
    .AddState(occupied_state)

}
