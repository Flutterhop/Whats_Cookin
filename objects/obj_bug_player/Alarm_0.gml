/// @description cooldown alarm

if(player.weapon == weapon_type.staff){
	gunCooldown = true;

}else if(player.weapon == weapon_type.dagger){
	meleeCooldown = true;
	determine_dagger_face();
	show_debug_message("melee cooldown reset")
}