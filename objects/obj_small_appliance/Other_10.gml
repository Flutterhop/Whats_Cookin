/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

hold_empty_template = ""
hold_occupied_template = ""
struct.default_state = "hold_empty"



function init_state_machine(){
	struct.state_machine = new Statement(self);
	
	hold_empty_template = new StatementState(struct.state_machine,"hold_empty")
		.AddEnter(function(){
			with(owner){
				EchoDebug(string_concat("entering ",struct.state_machine.GetStateName()))
			}
		})
		.AddUpdate(function(){
			with(owner){
				handle_inventory();
			}
		})
		.AddDraw(function(){
			with(owner){
				/*
				if(variable_instance_exists(struct,"inventory")){
					var inventory_size = array_length(struct.inventory);
					if(inventory_size > 0){
						for(var i = 0; i < inventory_size;i++){
							var inventory_item = struct.inventory[i];
							if(is_instanceof(inventory_item.struct,Item_Game)){
								draw_sprite_ext(inventory_item.struct.item_sprite,image_index,x,y,1,1,0,c_white,1)
							}
						}
					}
				}
				 */
			}
		});
		
	hold_occupied_template = new StatementState(struct.state_machine,"hold_occupied")
		.AddEnter(function(){
			with(owner){
				EchoDebug(string_concat("entering ",struct.state_machine.GetStateName()))
			}
		})
		.AddUpdate(function(){
			with(owner){
				handle_inventory();
			}
		})
		.AddDraw(function(){
			/*
			//Draw Self if occupied but not held draw self and inventory item.
			draw_sprite_ext(struct.structure_sprite,image_index,x,y,1,1,0,c_white,1);
			//draw item
			if(variable_instance_exists(struct,"inventory")){
				var inventory_size = array_length(struct.inventory);
				if(inventory_size > 0){
					for(var i = 0; i < inventory_size;i++){
						var inventory_item = struct.inventory[i];
						if(is_instanceof(inventory_item.struct,Item_Game)){
							draw_sprite_ext(inventory_item.struct.item_sprite,image_index,x,y,1,1,0,c_white,1)
						}
					}
				}
			}
			 */
		})
	
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
	var packed_state = new StatementState(struct.state_machine,"packed")
    .AddEnter(function(){
			with(owner){
                
			}
		})
    .AddUpdate(function(){
			with(owner){
				
			}
		})
	.AddDraw(function(){
		with(owner){
			draw_sprite_ext(spr_packing_box,image_index,x,y,1,1,0,c_white,1);	
		}
	});
	var assemble_state = new StatementState(struct.state_machine,"assemble")
    .AddEnter(function(){
			with(owner){
                
			}
		})
    .AddUpdate(function(){
			with(owner){
				
			}
		})
	.AddDraw(function(){
		with(owner){
			draw_sprite_ext(struct.structure_sprite,image_index,x,y,1,1,0,c_white,1);
		}
	});
	
	struct.state_machine
	.AddState(hold_empty_template)
	.AddState(hold_occupied_template)
	.AddState(process_state)
	.AddState(packed_state)	
	.AddState(assemble_state)
}

function interaction(source){
	var sucessful_interaction = false;
	//Figure out if the item on the processing structure can be processed by this station.
	if(not_null(struct.inventory)){
		var inventory_space = array_length(struct.inventory);
		if(inventory_space <= 0){
			source.struct.state_machine.ChangeState("hold_empty");
			return
		}
		var process_target = struct.inventory[0];
		if(not_null(process_target)){
			if(variable_instance_exists(process_target.struct,"can_process")){
				if(process_target.struct.can_process(id)){
					sucessful_interaction = true
					interaction_source = source;
					struct.state_machine.ChangeState("process")
					active_minigame = struct.spawn_minigame();
				}
			}else{
				sucessful_interspecial = false;
				EchoDebug("item cannot process.")
			}
		}
	}
	return sucessful_interaction;
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
				struct.state_machine.ChangeState("hold_occupied");
			}
		}
	}
}
