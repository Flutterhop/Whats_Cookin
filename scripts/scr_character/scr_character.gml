enum Character_Type{
	CH_NPC = 20,
	CH_ENEMY_NPC = 21,
	CH_PLAYER = 22
}


////@description Main Character struct. Facilitates taking damage, as well as creating instances. Data handling.
////@function Character
////@param {real} new_move_speed Default Character Speed
function Character_Entity(new_move_speed, new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) : Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference) constructor{
	
	move_speed = new_move_speed

	////INSTANCE CONTEXT VARS
	stun_amount = 0;
	knockback_amount = 0;
	target_objects = [obj_npc];
	
	
	static take_damage = function(damage,attack_type = "",new_stun_amount = 0,new_knockback_amount,source = ""){
		if(!iframes){
			hp -= damage;

			if(hp <= 0){
				die(source);
				return;
			}
			if(new_stun_amount > 0){
				if(stun_amount <= 0){
					stun_amount += new_stun_amount;
				}
			}
			if(new_knockback_amount > 0){
				if(knockback_amount <= 0){
					knockback_amount += new_knockback_amount;
				}
			}
		}
	}
	
	static init_states = function(){
		state_machine = new Statement(instance)
		var idle_state = new StatementState(state_machine,"idle")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			if(x_speed > 0 or y_speed > 0){
				state_machine.ChangeState("move")
			}
		});	
		var move_state = new StatementState(state_machine,"move")
			.AddEnter(function(){
			
			})
			.AddUpdate(function(){
				if(path_index == -1){
					if(path_position >= .99 || path_position == 0){
						var target = instance_find(obj_player,0);
						var target_x = target.x;
						var target_y = target.y;
						if(point_distance(target_x,target_y,x,y) > 30){
							if(struct.grid.set_path(path,x,y,target_x,target_y)){
								path_start(path,struct.move_speed,path_action_stop,true);
								//var path_pos = path.path_position;
							}
						}
					}

				}else{
			
					///Check Target_distance
					var target_x = path_get_point_x(path_index,path_get_number(path_index) - 1);
					var target_y = path_get_point_y(path_index,path_get_number(path_index) - 1);
					var target = point_distance(target_x,target_y,obj_player.x,obj_player.y)
					///If too far away then recalculate the path.
					if(target > 150){
						show_debug_message("target too far from end of path. Recalculating...")
						if(struct.grid.set_path(path,x,y,obj_player.x,obj_player.y)){
							path_start(path,struct.move_speed,path_action_stop,true);
							//var path_pos = path.path_position;
						}
					}
				}
			});

		state_machine
		.AddState(idle_state)
		.AddState(move_state)

	}
	init_states()
}