/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
default_state = "idle";
active_state = "chase";
start_x = 0;
start_y = 0;

function set_custom_states(){
	attack_template = new StatementStateTemplate("attack")
		.AddEnter(function(){ 
			set_target();
			determine_sprite();
			image_index = 0;
			image_speed = 1;
			start_x = x;
			start_y = y;
		})
		.AddUpdate(function(){
			
			if(struct.state_machine.GetStateTime() > struct.stats.attack_time){
				struct.state_machine.ChangeState(default_state);
				EchoDebug("state time expired. returning to default")
			}
			launch_attack();
			var attack_target = read_attack_collision()
			if(not_null(attack_target)){
				if(is_instanceof(attack_target.struct,Character_Game)){
					attack_target.struct.take_damage(self,struct.stats.damage_amount,20,direction,20,30)
					struct.state_machine.ChangeState(default_state);
				}
			}
		})
		.AddDraw(function(){
			scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2)
			scribble(direction_facing).starting_format("pixel_op").draw(x + debug_1_x,y + debug_1_y * 3);
	});
	struct.state_machine.AddStateTemplate(attack_template);
}
