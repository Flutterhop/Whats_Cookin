/// @description Insert description here
// You can write your code in this editor
bulletSpeed = 5;
speed = bulletSpeed;
prev_x = x;
prev_y = y;
impact = false;
display_width=display_get_gui_width();
display_height=display_get_gui_height();
collision_triggered = false; // Tracks if the collision has occurred

if (player.bullets_upgraded){
	sprite_index = player.bullet_power_sprite;
}else{
	sprite_index = player.bullet_sprite;
}

function bounce(){
	move_bounce_solid(false);
}