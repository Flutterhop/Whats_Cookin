/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function npc_init_enemy_states(){
	var attack_state = new StatementState(struct.state_machine,"attack")
			.AddEnter(function(){
				with(owner){
					determine_sprite(struct.equipment); 
					image_index = 0;
					image_speed = 1;
				}
			})
			.AddUpdate(function(){
				with(owner){
					read_attack_collision();
				}
		});
	struct.state_machine
	.AddState(attack_state)
}