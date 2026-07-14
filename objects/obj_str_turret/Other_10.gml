
event_inherited();
collision_radius = 40;
firing_speed = 120;
bullet_speed = 3;
bullet_damage = 1;
firing_timer = 0;

function init_state_machine(){
	struct.state_machine = new Statement(self)

	var idle_state = new StatementState(struct.state_machine,"idle")
		.AddUpdate(function(){
			with(owner){
				firing_timer++;
				if(firing_timer >= firing_speed){
					struct.state_machine.ChangeState("detect_target");	
				}
			}
		});
	var pursue_state = new StatementState(struct.state_machine,"pursue")
		.AddUpdate(function(){
			with(owner){
				var dir = point_direction(x,y,target.x,target.y);
				instance_create_layer(x,y,"Bullets",obj_turret_bullet,{speed : bullet_speed,
																		direction : dir,
																		damage : bullet_damage,
																		source : other});
				firing_timer = 0;
				struct.state_machine.ChangeState("idle");
			}
		});
			
					
	var detect_state = new StatementState(struct.state_machine,"detect_target")
		.AddUpdate(function(){
			with(owner){
				target = "";
				var collisions = ds_list_create();
				///Check for targets
				collision_circle_list(x,y,collision_radius,struct.target_objects,false,true,collisions,true);
				if(not_null(collisions)){
					if(ds_list_size(collisions) > 0){
						target = ds_list_find_value(collisions,0);
					}
				}
				if(not_null(target) && instance_exists(target)){
					struct.state_machine.ChangeState("pursue");
				}
			}
		});
	
	struct.state_machine
	.AddState(idle_state)
	.AddState(pursue_state)
	.AddState(detect_state);
	
	struct.state_machine.ChangeState("idle")

}