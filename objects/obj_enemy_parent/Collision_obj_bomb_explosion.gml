if(visible){
	if(!iframes && bomb_timer <= 0){
		if(object_index == obj_enemy_maneater){
			if(enemy_state == "emerge" || enemy_state == "move" || enemy_state == "decide_movement"){
				return;
			}
		}
		take_damage(0,other.damage,,60);
		if (hp <= 0){
			instance_create_depth(x,y,-1000,obj_explosion);
			instance_destroy();
		}
	}
}