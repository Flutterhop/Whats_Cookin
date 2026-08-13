// Inherit the parent event
event_inherited();

//PATHFINDING
handle_pathfinding		= method(id,npc_handle_pathfinding);
find_priority_target	= method(id,npc_find_priority_target);
manage_movement			= method(id,npc_manage_movement);
apply_knockback			= method(id,npc_apply_knockback);

//COLLISION


//TIMERS
get_active_timers		= method(id,npc_get_active_timers);
idle_complete			= method(id,npc_idle_complete);
attack_windup_complete	= method(id,npc_attack_windup_complete);
attack_complete			= method(id,npc_attack_complete);
knockback_complete		= method(id,npc_knockback_complete);
stun_complete			= method(id,npc_stun_complete);
