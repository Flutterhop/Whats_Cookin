// Inherit the parent event
event_inherited();

if(global.debug){
	if(not_null(struct)){
		if(not_null(struct.state_machine)){
			scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y)
			if(not_null(sprite_index)){
				scribble(sprite_get_name(sprite_index)).starting_format("pixel_op").draw(x+debug_2_x,y+debug_2_y)
			}
			if(not_null(direction_facing)){
				scribble(direction_facing).starting_format("pixel_op").draw(x+debug_2_x,y+debug_2_y * 1.5)
			}
		}
	}
}
