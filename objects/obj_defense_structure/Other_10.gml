/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//TEMPLATES
idle_template = "";
attack_template = "";
attack_windup_template = "";
stunned_template = "";
dead_template = "";
draw_event_template = ""


function init_state_machine(){
	init_state_machine_templates()
	struct.state_machine.DebugSetErrorBehavior(eStatementErrorBehavior.RETHROW);
	struct.state_machine.AddStateTemplate(idle_template)
	struct.state_machine.AddStateTemplate(attack_template)
	struct.state_machine.AddStateTemplate(attack_windup_template)
	struct.state_machine.AddStateTemplate(stunned_template)
	struct.state_machine.AddStateTemplate(dead_template)
	struct.state_machine.QueueState(default_state)
}


function init_state_machine_templates(){
	struct.state_machine = new Statement(self)
	draw_template = function(){
		if(global.debug and global.debug_setting == debug_type.structure_debug){
			if(not_null(struct.state_machine)){
				scribble(struct.state_machine.GetStateName()).starting_format("pixel_op").draw(x+debug_1_x,y+debug_1_y * 2);
			}
		}
	}
	idle_template = new StatementStateTemplate("idle")
		.AddUpdate(function(){
			firing_timer++;
			if(firing_timer >= struct.stats.firing_speed){
				struct.state_machine.ChangeState("detect_target");	
			}
		});
	idle_template.AddDraw(draw_template);
	attack_template = new StatementStateTemplate("attack")
		.AddUpdate(function(){

			struct.state_machine.ChangeState("idle");
		});
	attack_template.AddDraw(draw_template)
	attack_windup_template = new StatementStateTemplate("attackwindup")
		.AddEnter(function(){
			struct.state_machine.QueueState("attack");
			
		});
	attack_windup_template.AddDraw(draw_template);
	detect_template = new StatementStateTemplate("detect_target")
		.AddUpdate(function(){
			target = "";
			var collisions = ds_list_create();
			///Check for targets
			collision_circle_list(x,y,struct.stats.detection_radius,struct.target_objects,false,true,collisions,true);
			if(not_null(collisions)){
				if(ds_list_size(collisions) > 0){
					target = ds_list_find_value(collisions,0);
				}
			}
			if(not_null(target) && instance_exists(target)){
				struct.state_machine.ChangeState("attackwindup");
			}
		});
	detect_template.AddDraw(draw_template)
	assemble_template = new StatementState(struct.state_machine,"assemble")
		.AddUpdate(function(){
			with(owner){
				
			}
	});
	assemble_template.AddDraw(draw_template);
	stunned_template = new StatementStateTemplate("stunned")
		.AddUpdate(function(){
			var knockback_done = false
			var stun_done = false
			var state_time = struct.state_machine.GetStateTime();
			if(struct.stun_amount > 0){
				struct.stun_amount--;
			}else{
				stun_done = true;
			}
			handle_iframes();
			if(stun_done){
				struct.state_machine.ChangeState("idle");
			}
		})
	stunned_template.AddDraw(draw_template);
    dead_template = new StatementStateTemplate("dead")
		.AddEnter(function(){
				determine_sprite();
                
				image_index = 0;
				image_speed = 0;
				handle_iframes();
				death_effect = instance_create_layer(x,y,"effects",obj_death_effect,{source : other})
		})
		.AddUpdate(function(){
			if(is_null(death_effect)){
				death_time--;
				if(death_time <=0){
					instance_destroy(self,true);
				}
			}else{ 
				if(death_time <=0){
					instance_destroy(death_effect)
					instance_destroy(self,true);
				}
			} 
	});
	dead_template.AddDraw(draw_template);
	struct.state_machine.ChangeState("idle");

}