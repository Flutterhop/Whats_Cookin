/// @description Insert description here
// You can write your code in this editor
speed = 1.5;
isMoving = true;
deathBullet = false
alarm[0] = 240;

move_x = lengthdir_x(speed, direction);
move_y = lengthdir_y(speed, direction);
trail_x = lengthdir_x(speed - 4, direction);
trail_y = lengthdir_y(speed - 4, direction);
trail_x_2 = lengthdir_x(speed - 8, direction);
trail_y_2 = lengthdir_y(speed - 8, direction);

function bounce(){
	move_bounce_solid(false);
}