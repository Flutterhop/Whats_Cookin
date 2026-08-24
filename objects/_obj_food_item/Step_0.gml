// Inherit the parent event
event_inherited();

if(not_null(struct)){
    if(not_null(struct.state_machine)){
		struct.state_machine.Draw();
    }
}