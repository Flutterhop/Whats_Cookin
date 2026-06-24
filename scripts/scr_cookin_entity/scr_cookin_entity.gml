enum entity_type{
	EN_Generic = 10,
	EN_Character = 20,//20s
	EN_Environment = 30,//30s
	EN_Item = 40,//40s
	EN_Menu = 50,//50s
	EN_Structure = 60//60s
}

function Cookin_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) constructor{
	name		= new_name;
	entity_id	= 0;
	type		= new_type;
	hp			= new_health;
	invincible	= new_invincible;
	object_reference = new_object_reference;
	instance	= "";
	state_machine = "";
	iframes = false;
	
	static spawn_entity = function(x_pos,y_pos,new_layer){
		var new_struct = self
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		init_state_machine()
	}
	static init_state_machine = function(){
		state_machine = new Statement(instance)
		var idle_state = new StatementState(state_machine,"idle")
		.AddEnter(function(){
			
		})
		.AddUpdate(function(){
			
		});
		state_machine.AddState(idle_state);
		
	}
	
	static take_damage = function(source,amount){
		if(!iframes and !invincible){
			hp -= amount;
			var event_message = string_concat(name," took ",amount," damage from ",source.name, "!");
			global.event_handler.create_event(ev_type.combat,event_message,ev_priority.standard);
			if(hp <= 0){
				die(source);
			}
		}
	}
	static heal = function(amount){
		if(!invincible){
			hp += amount;
			var event_message = string_concat(name," healed ",amount," points.");
			global.event_handler.create_event(ev_type.generic,event_message,ev_priority.standard);
		}
	}
	static die = function(source){
		if(not_null(instance)){
			var death_message = string_concat(name," was killed by ",source.name, "!");
			global.event_handler.create_event(ev_type.combat,death_message,ev_priority.high);
			instance_destroy(instance,true);
		}
	}
}
