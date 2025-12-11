enum projectile_effect{
	bullet_projectile = 0,
	spawner = 1,
	bullet_hitscan = 2,
	bullet_splash = 3
}

enum dir_face{
	north = 90,
	north_east = 45,
	east = 0,
	south_east = 315,
	south = 270,
	south_west = 225,
	west = 180,
	north_west = 135
}

function projectile(new_type,new_range,new_asset,new_speed = 1,new_damage = 1,new_number_of = 1,new_spawner_asset = "",new_particle_effect = "") constructor{
	
	projectile_type = new_type;
	range = new_range;
	asset = new_asset;
	projectile_speed = new_speed;
	damage = new_damage;
	number_of = new_number_of;
	spawner_asset = new_spawner_asset;
	particle_effect = new_particle_effect;
	
	
	function fire_projectile(position_x,position_y,_target){
		var _direction = point_direction(position_x, position_y, _target.x, _target.y);
		for(var i = 0;i < number_of; i++){
			instance_create_layer(position_x,position_y,"Bullets",asset,{	 source : other.id,
																			 projectile_type : projectile_type,
																			 range : range,
																			 projectile_speed : projectile_speed,
																			 direction : _direction + i * 5,
																			 target : _target
																			 });
			
		}
		
	}
	
	function main_collision_activate(target,effect){
		
	}
	
	function secondary_effect_activate(target,effect){
		
	}

}

function entity_take_damage(damage_source = 0,amount = 0,dash_amount = 0,bomb_amount = 0){
	if(!debug_iframes){
		var parent = object_get_parent(id.object_index)
		var enemy = parent == obj_enemy_parent || parent == obj_enemy_minion || parent == obj_enemy_boss
		var player = object_get_parent(id.object_index) == obj_player;

		if(enemy){
			var damage_amount = 0;
			if(is_null(damage_source)){
				damage_amount = amount;
			}else{
				damage_amount = damage_source.damage_amount;
			}
			hp -= damage_amount;
			if(dash_amount > 0 && dash_timer == 0){
				dash_timer = dash_amount;
				
			}
			if(bomb_amount > 0 && bomb_timer == 0){
				bomb_timer = bomb_amount;	
			}
			if(global.debug){
				if(not_null(damage_source)){
					show_debug_message(entity_name + " took " + string(damage_amount)  + " damage");
					show_debug_message("Damage source is " + damage_source.entity_name);
				}
			}
			damage_timer = 20;
		}
		else if(player){
			iframes = true;
			if(damage_timer <= 0){
				obj_audio_manager.play_sfx(ow);
			}
			damage_timer = 40; // 80 frames of effect
			alarm[1] = damage_timer;
			var damage_amount = 0;
			if(damage_source == ""){
				damage_amount = amount;	
			}else{
				damage_amount = damage_source.damage_amount;
			}
			hp_current = hp_current - damage_amount;

			if(global.debug){
				show_debug_message("Player took " + string(damage_amount)  + " damage");
				if(not_null(damage_source)){
					show_debug_message("Damage source is " + damage_source.entity_name);}
			}
		}
	}
}

function entity_grappled_state(){
	if(grapple_source != ""){



	}else{
		return;
	}
}

function entity_spawn_effect_activate(source){
	instance_create_layer(x,y,"Terrain",source.spawner_asset);

}

