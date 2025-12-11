///THIS ALLOWS BULLET TO DISSAPEAR WHEN COLLIDING WITH ANY LIVING ENTITY.
/// MUST ACCOUNT FOR INVISIBLE ENTITIES AS WELL.

if((other.object_index) != obj_player_entity && other.object_index != obj_mirror_entity && other.visible){
	instance_destroy(id);
}