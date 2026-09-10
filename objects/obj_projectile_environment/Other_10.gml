// Inherit the parent event
event_inherited();

max_height_reached = false;

function init_state_machine(){
	
	if(is_null(struct.state_machine)){struct.state_machine = new Statement(self)}
	draw_template = function(){
		if(global.debug and global.debug_setting == debug_type.structure_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}
		if(not_null(struct.stats)){
			draw_sprite_ext(struct.stats.projectile_sprite,image_index,x,y - struct.z_pos,1,1,0,c_white,1);
		}
	}
	active_template = new StatementStateTemplate("active")
		.AddUpdate(function(){
			// While active follow the path shape and read for collision.
			
		});
	active_template.AddDraw(draw_template);
	inactive_template = new StatementStateTemplate("inactive")
		.AddUpdate(function(){
			// this is where an additional effect could kick off or some visual indication of the end of the projectile.
		});
	inactive_template.AddDraw(draw_template)
	
	struct.state_machine.AddStateTemplate(active_template)
	struct.state_machine.AddStateTemplate(inactive_template)
}