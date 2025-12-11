/// @description Insert description here
// You can write your code in this editor
if(sprite_index == attack_sprite){
	try{
		if(not_null(target_player)){
			bullet_fired = true;
			var bullet_dir = point_direction(x, y, target_player.x, target_player.y);
			var bullet = instance_create_layer(x,y,"Bullets",obj_enemy_bullet, {damage : damage_amount, direction : bullet_dir});
			change_state(enemy_state,"idle","Bee has completed attack, return to idle.");
			bullet_fired = false;
		}
	}catch(_exception){
		change_state(enemy_state,"idle","Bee failed to attack, returning to idle.");
	}
}