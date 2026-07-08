if(is_method(struct.take_damage)){
	struct.take_damage(other.source,other.damage);
	instance_destroy(other,false);
}