enum entity_type{
	EN_Generic = 10,
	EN_Character = 20,//20s
	EN_Environment = 30,//30s
	EN_Item = 40,//40s
	EN_Menu = 50,//50s
	EN_Structure = 60//60s
}

function Cookin_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity) constructor{
	name		= new_name;
	entity_id	= 0;
	type		= new_type;
	hp			= new_health;
	invincible	= new_invincible;
	object_reference = new_object_reference;
	instance	= "";
	state_machine = "";
	iframes = false;
	target_objects = [];
	
	static spawn_entity = function(x_pos,y_pos,new_layer){
		var new_struct = self
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		call_later(30,time_source_units_frames,call_state_machine)
	}
	
	static take_damage = function(source,amount){
		if(!iframes and !invincible){
			hp -= amount;
			var event_message = string_concat(name," took ",amount," damage from ",source.struct.name, "!");
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
			var death_message = string_concat(name," was killed by ",source.struct.name, "!");
			global.event_handler.create_event(ev_type.combat,death_message,ev_priority.high);
			instance_destroy(instance,true);
		}
	}
	call_state_machine = function(){
		if(is_method(instance.init_state_machine())){
			instance.init_state_machine()
		}
	}
}

function Item_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder)
		: Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference) constructor {
	item_type	= new_item_type;
	item_sprite = new_item_sprite;
	item_icon	= new_item_icon;
	held		= false;
	
	static pick_up = function(){
		if(!held){
			held = true;
		}else{
			if(global.debug){
				show_debug_message("Item already held, cannot pick up.")
			}
		}	
	};
	static drop = function(x_pos = 0, y_pos = 0){
		if(not_null(x_pos) or not_null(y_pos)){
			instance.x += x_pos;
			instance.y += y_pos;
		}
		if(held){
			held = false;
		}else{
			if(global.debug){
				show_debug_message("Item not held, something must have gone wrong.")
			}
		}	
	};
	static set_item_sprite = function(new_sprite){
		item_sprite = new_sprite;
	}
	static set_item_icon = function(new_icon){
		item_icon = new_icon;
	}
	
}

function Item_Food(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"])
: Item_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_item_type,new_item_sprite,new_item_icon) constructor {
	value = new_value;
	flavors = new_flavors;
}

function Item_Ingredient(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"],is_raw = false,new_cost = 1)
: Item_Food(new_name,new_type,new_health,new_invincible,new_object_reference,new_item_type,new_item_sprite,new_item_icon,new_value,new_flavors) constructor {
	raw = is_raw
	cost = new_cost
}

////@description Main Character struct. Facilitates taking damage, as well as creating instances. Data handling.
////@function Character
function Character_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_move_speed = 1)
: Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference) constructor{
	
	move_speed = new_move_speed

	////INSTANCE CONTEXT VARS
	stun_amount = 0;
	knockback_amount = 0;
	
	
}

function Player_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_move_speed = 1,new_player_number = 0)
: Character_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_move_speed) constructor{
	player_number = new_player_number;
	face = dir_face.south / 45;
	direction_facing = get_direction(face);
	player_state = "idle"		
}

function NPC_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference,new_move_speed,new_size = npc_size.medium,new_grid = "")
: Character_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_move_speed) constructor{

	size = new_size;
	
	////npc_path represents the variable which holds the path asset created in code when finding a path.
	////This should only contain a path object when the npc is instanced in a room.
	grid = new_grid;
	npc_path = ""; 
	
	static spawn_npc = function(x_pos,y_pos,layer_to_spawn){
		//Find NPC in global map
		//var entity = ds_map_find_value(global.character_entities,name)
		var new_struct = self
		instance = instance_create_layer(x_pos,y_pos,layer_to_spawn,object_reference,{struct : new_struct});
		call_later(30,time_source_units_frames,call_state_machine)
		instance.path = path_add();
		instance.struct = self;
	}
	
	static detect_target = function(_target){
		
	}
	
	static kill_npc = function(){
		instance_destroy(instance,true);
	}
	
}

function Enemy_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference,new_move_speed,new_size = npc_size.medium,new_grid = "",new_enemy_type,new_enemy_traits = [enemy_trait.Standard])
: NPC_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_move_speed,new_size,new_grid) constructor{
	en_type = new_enemy_type
	enemy_traits = new_enemy_traits
	target_objects = [obj_player];
}

function Item_Equipment(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"])
: Item_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_item_type,new_item_sprite,new_item_icon) constructor {
	value = new_value;
	flavors = new_flavors;
}

function Cookin_Structure(new_name,new_type,new_health,new_invincible,new_object_reference)
: Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference) constructor{


}

function Defense_Structure(new_name,new_type,new_health,new_invincible,new_object_reference)
: Cookin_Structure(new_name,new_type,new_health,new_invincible,new_object_reference) constructor{
	target_objects = [obj_enemy_npc];
	
	
	
}

function Kitchen_Structure(new_name,new_type,new_health,new_invincible,new_object_reference,new_inventory)
: Cookin_Structure(new_name,new_type,new_health,new_invincible,new_object_reference) constructor{
	inventory = new_inventory;

}