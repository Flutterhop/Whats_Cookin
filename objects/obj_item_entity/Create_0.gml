event_user(EV_INIT)
event_user(EV_METHOD_BINDING)

holdable = true

collisions = ""
if(not_null(struct)){
	collisions = struct.grid.fetch_collision_array()
	}