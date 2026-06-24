/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if(is_null(struct)){
	struct = new NPC_Entity(npc_size.small,"",1,"Turret",structure_type.Defense,5,false,self);
}
if(is_null(struct)){
	call_later(120,time_source_units_frames,init_idle_state)
}else{
	struct.state_machine.ChangeState("idle")

}

function init_idle_state(){
	struct.state_machine.ChangeState("idle")
}
path = path_index
index = "";
target = "";
