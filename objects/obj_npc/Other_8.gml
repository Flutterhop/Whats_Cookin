// When path ends we check if the current state is the active state.
// If it is then we return to default which will then move to active -
// based on an idle timer

var in_active = struct.state_machine.IsInState(active_state) ? true : false
var is_timer_active = time_source_get_state(idle_timer) == time_source_state_active

if(in_active and !is_timer_active){
	struct.state_machine.ChangeState(default_state);
}else{
	return;
}