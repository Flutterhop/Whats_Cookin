
event_inherited();
collision_radius = 40;
firing_speed = 120;
bullet_speed = 3;
bullet_damage = 1;
firing_timer = 0;
target = "";
direction_facing = "left"

function set_custom_states(){
	draw_template = function(){
		if(global.debug and global.debug_setting == debug_type.structure_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}

	
	}
	attack_template = new StatementStateTemplate("attack")
		.AddUpdate(function(){
			if(not_null(target)){
				if(not_null(struct.stats.projectile)){
					var dir = point_direction(x,y,target.x,target.y);
					struct.launch_projectile(x,y,"Instances",dir)
					
				}
			}
			firing_timer = 0;
			struct.state_machine.ChangeState("idle");
		});
	attack_template.AddDraw(draw_template)
	struct.state_machine.AddStateTemplate(attack_template)
}
