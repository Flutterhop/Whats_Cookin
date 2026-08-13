if (abs(speed) > 0){
	friction = 0.5;
}else{
	friction = 0;
}

move_and_collide(hspeed,vspeed,collisions,3)