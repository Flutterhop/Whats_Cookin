/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

idle_template = "";

empty_template = "";

assemble_template = "";

default_state = "empty"

function init_state_machine(){
	init_state_machine_templates()
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	struct.state_machine.AddStateTemplate(idle_template)
	struct.state_machine.AddStateTemplate(empty_template)
	struct.state_machine.AddStateTemplate(assemble_template)
	struct.state_machine.QueueState(default_state)
}


function init_state_machine_templates(){
	struct.state_machine = new Statement(self);
	empty_draw_template = function(){
		if(not_null(struct.state_machine)){
			draw_sprite_ext(struct.item_sprite,image_index,x,y,1,1,0,c_white,1);
		}
		if(global.debug and global.debug_setting == debug_type.item_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}
	}
	idle_draw_template = function(){
		//Draw Self if occupied but not held draw self and inventory item.
		draw_sprite_ext(struct.item_sprite,image_index,x,y,1,1,0,c_white,1);
		//draw item
		if(variable_instance_exists(struct,"inventory")){
			var inventory_size = array_length(struct.inventory);
			if(inventory_size > 0){
				for(var i = 0; i < inventory_size;i++){
					var inventory_item = struct.inventory[i];
					if(is_instanceof(inventory_item.struct,Game_Entity)){
						draw_sprite_ext(inventory_item.struct.item_sprite,image_index,x,y,1,1,0,c_white,1)
					}
				}
			}
		}
	}
	
	idle_template = new StatementStateTemplate("idle")
		.AddEnter(function(){
		})
		.AddUpdate(function(){

		});
	idle_template.AddDraw(idle_draw_template);
	
	empty_template = new StatementStateTemplate("empty")
		.AddEnter(function(){
		})
		.AddUpdate(function(){

		});
	empty_template.AddDraw(empty_draw_template);
	
	assemble_template = new StatementStateTemplate("assemble")
		.AddEnter(function(){
		})
		.AddUpdate(function(){

		});
	assemble_template.AddDraw(empty_draw_template);
}