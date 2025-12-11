/// @description bullet impact

if(id.visible){
	if(!iframes){
		if(object_index == obj_enemy_frog){
			if(is_jumping){
				exit;
			}
		}
		if(object_index == obj_enemy_maneater){
			if(enemy_state == "emerge" || enemy_state == "spawn" || enemy_state == "move" || enemy_state == "decide_movement"){
				return;
			}
		}
		take_damage(0,other.bullet_power);
		// Knockback logic
		knockback_timer = 10;  // Duration of knockback (optional)
		dir = other.dir;
		if (hp <= 0){
			instance_create_depth(x,y,-1000,obj_explosion);
			instance_destroy();
			/*if (instance_exists(obj_spawn_manager) && object_index != obj_enemy_baby_fly) {
				obj_spawn_manager.enemies_remaining -= 1;
			}*/
		}else{obj_audio_manager.play_sfx(snd_hit_sound);} 
	}
}



