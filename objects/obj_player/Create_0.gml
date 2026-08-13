// Inherit the parent event
event_inherited();

//Instantiate timer after method definition.
throw_timer = time_source_create(time_source_game,struct.stats.throw_charge,time_source_units_frames,throw_item);
attack_timer = time_source_create(time_source_game,struct.stats.attack_time,time_source_units_seconds,attack_complete);

array_push(time_sources,throw_timer,attack_timer);