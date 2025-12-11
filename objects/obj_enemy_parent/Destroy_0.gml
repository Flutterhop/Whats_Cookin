
if(not_null(spawner) && instance_exists(spawner)){
	spawner.spawn_manager.active_enemies--;
	spawner.spawn_manager.enemies_remaining--;
}else{
	///attempt to find spawn manager
	var manager = instance_find(obj_spawn_manager,0);
	if(not_null(manager)){
		manager.active_enemies--;
		manager.enemies_remaining--;
	}else{
		var manager = instance_find(obj_arena_spawn_manager,0);
		if(not_null(manager)){
			manager.active_enemies--;
			manager.enemies_remaining--;
		}
	}
}
if(not_null(avoidance)){
	instance_destroy(avoidance);
}