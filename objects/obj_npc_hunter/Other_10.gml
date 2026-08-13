/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
default_state = "idle";
active_state = "chase";

function set_custom_states(){
	var attack_state = new StatementState(struct.state_machine,"attack")
		.AddEnter(function(){
			with(owner){
				determine_sprite();
				var attack_cooldown = (time_source_get_state(attack_timer) == time_source_state_initial) or (time_source_get_state(attack_timer) == time_source_state_stopped) or (time_source_get_state(attack_timer) == time_source_state_paused)
				if(attack_cooldown){
					time_source_start(attack_timer);
					set_target();
				}
				image_index = 0;
				image_speed = 1;
			}
		})
		.AddUpdate(function(){
			with(owner){
				launch_attack();
				var attack_target = read_attack_collision()
				if(not_null(attack_target)){
					if(is_instanceof(attack_target.struct,Character_Game)){
						attack_target.struct.take_damage(self,struct.damage_amount,20,direction,20,30)
					}
				}
			}
		})
		.AddExit(function(){
			with(owner){

			}
		})
		.AddDraw(function(){
			with(owner){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
				scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
			}
	});
	struct.state_machine
	.AddState(attack_state);
}
