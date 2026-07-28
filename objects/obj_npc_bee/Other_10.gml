// Inherit the parent event
event_inherited();
mp_potential_settings(20, 10, 10, false)



function init_state_machine(){
	struct.state_machine = new Statement(self)
	var idle_state = new StatementState(struct.state_machine,"idle")
	.AddEnter(function(){
			
	})
	.AddUpdate(function(){
		if(x_speed > 0 or y_speed > 0){
			struct.state_machine.ChangeState("move")
		}
	});	
	var move_state = new StatementState(struct.state_machine,"move")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			with(owner){
				try{
					if(path_index == -1){
						if(path_position >= .99 || path_position == 0){
							var target = instance_find(obj_player,0);
							var target_x = target.x;
							var target_y = target.y;
							if(point_distance(target_x,target_y,x,y) > 30){
								if(struct.grid.set_path(path,x,y,target_x,target_y,struct.move_speed)){
									path_start(path,struct.move_speed,path_action_stop,true);
									//var path_pos = path.path_position;
								}
							}
						}

					}else{
						//move_and_collide(hspeed,vspeed,obj_enemy_npc,3);
						///Check Target_distance
						var target_x = path_get_point_x(path_index,path_get_number(path_index) - 1);
						var target_y = path_get_point_y(path_index,path_get_number(path_index) - 1);
						var target = point_distance(target_x,target_y,obj_player.x,obj_player.y)
						///If too far away then recalculate the path.
						if(target > 150){
							show_debug_message("target too far from end of path. Recalculating...")
							if(struct.grid.set_path(path,x,y,obj_player.x,obj_player.y,struct.move_speed)){
								path_start(path,struct.move_speed,path_action_stop,true);
								//var path_pos = path.path_position;
							}
						}
					}
				}catch(_exception){
					show_debug_message(_exception.message);
					show_debug_message(_exception.longMessage);
					show_debug_message(_exception.script);
					show_debug_message(_exception.stacktrace);
				}
			}
		});

	struct.state_machine
	.AddState(idle_state)
	.AddState(move_state)
	
	struct.state_machine.ChangeState("move")
}
