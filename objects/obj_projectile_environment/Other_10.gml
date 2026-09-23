// Inherit the parent event
event_inherited();

max_height_reached = false;
shape_coords = "";

function init_state_machine(){
	
	if(is_null(struct.state_machine)){struct.state_machine = new Statement(self)}
	draw_template = function(){
		if(global.debug and global.debug_setting == debug_type.structure_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}
		if(not_null(struct.stats)){
			if(struct.z_pos != 0){
				draw_sprite_ext(spr_shadow_idle_left_1,0,x,y - sprite_get_height(spr_shadow_idle_left_1) / 2,1,2,0,c_white,1);
			}
			draw_sprite_ext(struct.stats.projectile_sprite,image_index,x,y - struct.z_pos,1,1,0,c_white,1);
			
			if(not_null(shape_coords)){
				draw_rectangle(x+shape_coords[0],y+shape_coords[1],x+shape_coords[2],y+shape_coords[3],true)
			}
		}
	}
	active_template = new StatementStateTemplate("active")
		.AddEnter(function(){
			shape_coords = get_pr_collision_shape()
			
		})
		.AddUpdate(function(){
			// While active follow the path shape and read for collision.
			if(is_method(struct.path)){
				
				struct.path(x,y,direction,max_height_reached);
				
				var collisions = detect_collisions(shape_coords);
				var num_collisions = array_length(collisions)
				if(num_collisions > 0){
					for(var i = 0; i < num_collisions;i++){
						var target_collision = collisions[i];
						if(is_instanceof(target_collision.struct,NPC_Character)){
							target_collision.struct.take_damage(self,struct.stats.projectile_damage,30,direction,struct.stats.knockback_power)
							struct.impact();
						}
					}
				}
			}
		});//path_arc = function(x_pos,y_pos,_direction,height_reached){
	active_template.AddDraw(draw_template);
	inactive_template = new StatementStateTemplate("inactive")
		.AddUpdate(function(){
			// this is where an additional effect could kick off or some visual indication of the end of the projectile.
			instance_destroy(self);
		});
	inactive_template.AddDraw(draw_template)
	
	struct.state_machine.AddStateTemplate(active_template)
	struct.state_machine.AddStateTemplate(inactive_template)
}