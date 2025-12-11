
interpret_player_controls();

event_inherited();

// Only emit if moving
if (abs(hspeed) > 0.2 || abs(vspeed) > 0.2) {
    var rate = 1; // how many particles per step
	effects_create_particle("dust",x,y + sprite_height/2,rate)
}


if(hp_current < 1 && !dead){
	set_game_over();
}else if(!dead){
	apply_movement();
	check_collision();
	determine_face();
	handle_dash_effect();
	handle_damage_timer();
	up_num = 0;
	down_num = 0;
	left_num = 0;
	right_num = 0;
}
if(instance_exists(obj_shop_entity)){
	bomb_bar.visible = false;
	health_bar.visible = false;
}else{
	bomb_bar.visible = true;
	health_bar.visible = true;
}