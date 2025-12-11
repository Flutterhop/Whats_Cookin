/// @description Insert description here
// You can write your code in this editor
if (shield_explosion > 0 && iframes == false && bomb_timer <= 0){
	shield_explosion--;
	iframes = true;
	alarm[1] = 80;
	
} else {
	if iframes == false  { //once it changes sprites, it wont deal anymore damage
		take_damage("",bombDamageValue,,60);
	} else if round_ended == true && effect_reset == true {
		effect_reset = false
		damage_timer = 10;
		alarm[7] = damage_timer;
	}
}