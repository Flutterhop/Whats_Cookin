event_inherited();

range--;

if(range <= 0){
	switch(projectile_type){
		case projectile_effect.bullet_hitscan:
		break;
		case projectile_effect.bullet_projectile:
		break;
		case projectile_effect.bullet_splash:
		break;
		case projectile_effect.spawner:
			spawn_effect_activate(source.projectile_struct);
			instance_destroy(self);
		break;	
	}

}