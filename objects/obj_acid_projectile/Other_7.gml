if(sprite_index == start_sprite){
	if(not_null(source) && instance_exists(source)){
		direction = point_direction(x,y,target.x,target.y);
		source.change_state(source.enemy_state,"idle","Projectile fired. Returning to idle.");
		sprite_index = idle_sprite;
	}else{
		instance_destroy(id);
	}

}