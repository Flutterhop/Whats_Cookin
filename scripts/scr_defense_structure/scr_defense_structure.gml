function Defense_Structure(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) : Cookin_Structure(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) constructor{
	
	static init_state_machine = function(){
		state_machine = new Statement(instance)

		idle_state = new StatementState(state_machine,"idle")
			.AddUpdate(function(){
				firing_timer++;
				if(firing_timer >= firing_speed){
					state_machine.change_state("detect_target");	
				}	
			});
		pursue_state = new StatementState(state_machine,"pursue_state")
			.AddUpdate(function(){
				var dir = point_direction(x,y,target.x,target.y);
				instance_create_layer(x,y,"Bullets",obj_turret_bullet,{speed : bullet_speed,
																		direction : dir,
																		damage : bullet_damage});
				firing_timer = 0;
				state_machine.change_state("idle");
			});
			
					
		detect_state = new StatementState(state_machine,"detect_target")
		.AddUpdate(function(){
		
			target = "";
			var collisions = ds_list_create();
			///Check for targets
			collision_circle_list(x,y,collision_radius,target_objects,false,true,collisions,true);
			if(not_null(collisions)){
				if(ds_list_size(collisions) > 0){
					target = ds_list_find_value(collisions,0);
				}
			}
			if(not_null(target) && instance_exists(target)){
				state_machine.change_state("pursue_target");
			}
		});
	
		state_machine.AddState(idle_state).AddState(pursue_state).AddState(detect_state);;
	}
	
	
}