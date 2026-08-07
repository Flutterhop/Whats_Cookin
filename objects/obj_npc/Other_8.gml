// When path ends we check if the current state is the active state.
// If it is then we return to default which will then move to active -
// based on an idle timer

var in_active = struct.state_machine.IsInState(active_state) ? true : false
var any_timers_active = get_active_timers() > 0 ? true : false

if(in_active and !any_timers_active){
	struct.state_machine.ChangeState(default_state);
	show_debug_message("Path Ended with no timers active returning to default state.")
}else{
	return;
}