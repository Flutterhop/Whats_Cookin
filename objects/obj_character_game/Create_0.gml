
event_inherited();

time_sources = [];
knockback_timer = time_source_create(time_source_game,struct.knockback_time,time_source_units_seconds,knockback_complete);
stun_timer = time_source_create(time_source_game,struct.stun_amount,time_source_units_seconds,stun_complete);

array_push(time_sources,knockback_timer,stun_timer);

