/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function set_custom_states(){
	attack_windup_template = new StatementStateTemplate("attackwindup")
		.AddEnter(function(){
			path_end();
			determine_simple_attack_sprite();
			image_index = 0;
			image_speed = 1;
		})
		.AddUpdate(function(){
			var state_time = struct.state_machine.GetStateTime();
			if(state_time > struct.stats.attack_windup){
				struct.state_machine.ChangeState("attack")
			}
			handle_iframes()
	});
	attack_template = new StatementStateTemplate("attack")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			var attack_target = read_aoe_collision(struct.state_machine.GetStateTime())
			if(not_null(attack_target)){
				var target_num = ds_list_size(attack_target)
				for(var i = 0; i < target_num;i++){
					var current_target = ds_list_find_value(attack_target,i);
					if(is_instanceof(current_target.struct,Character_Game)){
						current_target.struct.take_damage(self,struct.stats.damage_amount,20,direction,20,30)
					}
				}
			}
			var state_time = struct.state_machine.GetStateTime();
			if(state_time >= struct.stats.attack_time){
				struct.state_machine.ChangeState("idle")
			}
			if(image_index >= image_number - 1){
				struct.state_machine.ChangeState("idle")
			}
	});
	attack_windup_template.AddDraw(draw_event_template);
	attack_template.AddDraw(draw_event_template);
	struct.state_machine.AddStateTemplate(attack_windup_template);
	struct.state_machine.AddStateTemplate(attack_template);
	
}