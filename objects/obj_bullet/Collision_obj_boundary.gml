/// @description Insert description here
// You can write your code in this editor
if(bounce_number > 0){
	move_bounce_solid(false);
	bounce_number--;
}else{
	speed = 0;	
	impact = true;
	instance_destroy(id);
}

