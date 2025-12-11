if(iframes == false && other.cleared == false && (other.sprite_index != other.removal_sprite && other.sprite_index != other.creation_sprite)){ //once it changes sprites, it wont deal anymore damage
	if(shield_bramble > 0){
		shield_bramble--;
		other.sprite_index = other.cleared_sprite;
		other.cleared = true;
		other.damage_amount = 0;
		return;
	}
	take_damage(other);
} else if round_ended == true && effect_reset == true {
	effect_reset = false
	damage_timer = 10; // 80 frames of effect
	alarm[7] = damage_timer;
}