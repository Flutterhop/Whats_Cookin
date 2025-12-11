if (player_is_dashing) {
    if (!other.iframes && other.dash_timer <= 0) {
        other.take_damage(0,dash_damage,60);
        
        if (other.hp <= 0) {
            instance_create_depth(other.x, other.y, -1000, obj_explosion);
            
            with (other) {
                instance_destroy();
            }
        } else {
            obj_audio_manager.play_sfx(snd_hit_sound)
        }
    }
}

else if (!player_is_dashing && iframes == false) { //once it changes sprites, it wont deal anymore damage
	if(!other.visible){return;}
	if(other.object_index == obj_enemy_maneater){
		if(other.enemy_state == "emerge" || other.enemy_state == "spawn"){
			return
		}
	}
	if(object_get_parent(other.object_index) == obj_enemy_boss){
		if(other.boss_spawning){
			return;
		}
	}
	take_damage(other);
}
