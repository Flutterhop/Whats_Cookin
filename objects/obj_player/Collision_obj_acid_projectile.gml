/// @description Insert description here
// You can write your code in this editor

if(shield_bullet > 0 && iframes == false){
	shield_bullet--;
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