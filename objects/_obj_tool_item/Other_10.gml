/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

idle_template = "";
hold_template = "";
default_state = "idle_empty"

function init_state_machine(){
	//	Testing something out, sub-states can help us with more complex behavior.
	//	These sub-states are underscore delimited, so understanding the naming is key.
	init_state_machine_templates()
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	struct.state_machine.AddStateTemplate(idle_template,{},"idle_empty")
	struct.state_machine.AddStateTemplate(idle_template,{},"idle_occupied")
	struct.state_machine.AddStateTemplate(hold_template,{},"hold_empty")
	struct.state_machine.AddStateTemplate(hold_template,{},"hold_occupied")
	struct.state_machine.QueueState(default_state)
}


function init_state_machine_templates(){
	struct.state_machine = new Statement(self);
	draw_template = function(){
		if(get_substates(struct.state_machine.GetStateName(),1,true) == "hold"){
			
		}else{
			draw_sprite_ext(struct.item_sprite,image_index,x,y,1,1,0,c_white,1);
		}
		if(global.debug and global.debug_setting == debug_type.item_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}
		if(struct.state_machine.GetStateName() == "idle_occupied"){
			draw_sprite_ext(struct.inventory[0].struct.item_sprite,image_index,x,y - 5,1,1,0,c_white,1);
		}
	}
	
	idle_template = new StatementStateTemplate("idle")
		.AddEnter(function(){
		})
		.AddUpdate(function(){

		});
	idle_template.AddDraw(draw_template);
	
	hold_template = new StatementStateTemplate("hold")
		.AddEnter(function(){
		})
		.AddUpdate(function(){
		});
	hold_template.AddDraw(draw_template);
}