if(other.speed > 5){
	struct.take_damage(other,1);
	with(other){motion_add(direction + 180,15);friction = 1;}
}