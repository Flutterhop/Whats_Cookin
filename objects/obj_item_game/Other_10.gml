
// Inherit the parent event
event_inherited();

idle_template = "";
hold_template = "";


function init_state_machine(){
	init_state_machine_templates()
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	struct.state_machine.AddStateTemplate(idle_template)
	struct.state_machine.AddStateTemplate(hold_template)
	struct.state_machine.QueueState(default_state)
}


function init_state_machine_templates(){
	struct.state_machine = new Statement(self);
	draw_template = function(){
		if(not_null(struct.state_machine)){
			draw_sprite_ext(struct.item_sprite,image_index,x,y,1,1,0,c_white,1);
		}
		if(global.debug and global.debug_setting == debug_type.item_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
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