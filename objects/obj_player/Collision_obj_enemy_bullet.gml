/// @description Insert description here
// You can write your code in this editor

if(shield_bullet > 0 && iframes == false){
	shield_bullet--;
	var temp_bullet_sprite = bullet_sprite;
	if(bullets_upgraded){
		temp_bullet_sprite = bullet_power_sprite;
	}
	var reflect_bullet = instance_create_layer(other.x,other.y,"Bullets",obj_bullet,
																					{
																						player : id,
																						bullet_power : shot_power,
																						direction : other.direction + 180,
																						speed : 5,
																						bounce_number : shot_ricochet_number,
																						sprite_index : temp_bullet_sprite
																					});
	draw_bullet_reflect();
	instance_destroy(other);
}else{
	if iframes == false  { 
		take_damage(other);		
	} else if round_ended == true && effect_reset == true {
		effect_reset = false
		damage_timer = 10;
		alarm[7] = damage_timer;
	}
	instance_destroy(other);
}



