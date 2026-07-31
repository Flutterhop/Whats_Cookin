enum entity_type{
	EN_Generic = 10,
	EN_Character = 20,//20s
	EN_Environment = 30,//30s
	EN_Item = 40,//40s
	EN_Menu = 50,//50s
	EN_Structure = 60//60s
}

enum dir_face{
	north = 90,
	north_east = 45,
	east = 0,
	south_east = 315,
	south = 270,
	south_west = 225,
	west = 180,
	north_west = 135
}

function Cookin_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_grid = "") constructor{
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
	grid = new_grid;
	
	static spawn_entity = function(x_coord,y_coord,new_layer){
		if(x_coord == 0 and y_coord == 0){
			x_coord = grid_x
			y_coord = grid_y
		}
		var new_struct = self
		var x_pos = (x_coord * grid.cell_width) + grid.cell_width / 2
		var y_pos = (y_coord * grid.cell_height) + grid.cell_height / 2
		x_coord = floor(x_coord)
		y_coord = floor(y_coord)
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

function Structure_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid = "",new_grid_x,new_grid_y,new_inventory = [],new_limit = 1)
: Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid) constructor{
	grid_x = new_grid_x;
	grid_y = new_grid_y;
	inventory = new_inventory;
	limit = new_limit;
		
	init_structure = function(x_pos,y_pos,_layer,args = []){
		if(array_length(args) > 0){
			//Idk if this works
			instance = instance_create_layer(x_pos,y_pos,_layer,object_reference,args);
		}else{
			instance = instance_create_layer(x_pos,y_pos,_layer,object_reference);
		}
		instance.struct = self;
	}
	
	static spawn_entity = function(x_coord = 0,y_coord = 0,new_layer){
		if(x_coord == 0 and y_coord == 0){
			x_coord = grid_x
			y_coord = grid_y
		}
		var new_struct = self
		var x_pos = (x_coord * grid.cell_width) + grid.cell_width / 2
		var y_pos = (y_coord * grid.cell_height) + grid.cell_height / 2
		x_coord = floor(x_coord)
		y_coord = floor(y_coord)
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		call_later(30,time_source_units_frames,call_state_machine)
	}
	
	static can_put_item = function(){
		if(array_length(inventory) < limit){
			return true;
		}else{
			return false;
		}
	}
	static can_take_item = function(){
		if(array_length(inventory) <= limit){
			return true;
		}else{
			return false;
		}
	}
	static insert_item = function(target_item){
		array_push(inventory,target_item)
	}
	static remove_item = function(){
		if(array_length(inventory) > 0){
			return array_pop(inventory);
		}
		return;
	}
	static is_empty = function(){
		return array_length(inventory) > 0 ? false : true;
	}
	static has_inventory = function(){
		return array_length(inventory) > 0 ? true : false;
	}
	static can_assemble = function(){
		if(state_machine.IsInState("assemble")){
			return false;
		}
		return true
	}
	static can_deploy = function(){
		if(state_machine.IsInState("assemble")){
			return true;
		}
		return false
	}
	static assemble = function(x1,y1){
		if(not_null(state_machine.GetState("assemble"))){
			grid.remove_multiple_obstacles(x1,y1,self)
			state_machine.ChangeState("assemble");
		}
	}
	static deploy = function(x_pos,y_pos){
		var grid_cell = ds_grid_get(grid.grid_data,x_pos,y_pos);
		if(not_null(grid_cell)){
			if(not_null(state_machine.GetState("idle"))){
				state_machine.QueueState("idle");
				grid.insert_item_at(x_pos,y_pos,self)
			}
		}
	}
}

function Item_Entity(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_grid = "",new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder)
		: Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid) constructor {
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
			instance.x = x_pos;
			instance.y = y_pos;
		}
		if(held){
			held = false;
		}else{
			if(global.debug){
				show_debug_message("Item not held, something must have gone wrong.")
			}
		}	
	};
	static throw_item = function(){
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

function Character_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid = "",new_move_speed = 1,new_size = npc_size.medium)
: Cookin_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid) constructor{
	
	move_speed = new_move_speed
	////INSTANCE CONTEXT VARS
	stun_amount = 0;
	knockback_amount = 0;
	size = new_size;
	single_direction = false;
	equipment = "unarmed"
	
	
	////npc_path represents the variable which holds the path asset created in code when finding a path.
	////This should only contain a path object when the npc is instanced in a room.
	grid = new_grid;
	npc_path = ""; 
	
	static spawn_entity = function(x_coord,y_coord,layer_to_spawn){
		//Find NPC in global map
		//var entity = ds_map_find_value(global.character_entities,name)
		if(x_coord == 0 and y_coord == 0){
			x_coord = grid_x
			y_coord = grid_y
		}
		var new_struct = self
		var x_pos = (x_coord * grid.cell_width) + grid.cell_width / 2
		var y_pos = (y_coord * grid.cell_height) + grid.cell_height / 2
		
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

function Player_Character(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid = "",new_move_speed = 1,new_character_name = "char",new_player_number = 0)
: Character_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_move_speed) constructor{
	
	character_name = new_character_name;
	player_number = new_player_number;
	input_allowed = true
	equipment = "unarmed"
	single_direction = false;
	
	///INPUT CONTROL
	input_allowed = true;
	input_ready = true;
	input_delay = 10;
	input_timer = 0;
	
	static spawn_entity = function(x_coord,y_coord,new_layer){
		if(x_coord == 0 and y_coord == 0){
			x_coord = grid_x
			y_coord = grid_y
		}
		var new_struct = self
		var x_pos = (x_coord * grid.cell_width) + grid.cell_width / 2
		var y_pos = (y_coord * grid.cell_height) + grid.cell_height / 2
		x_coord = floor(x_coord)
		y_coord = floor(y_coord)
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		input_add_player(self)
		call_later(30,time_source_units_frames,call_state_machine)
		
	}
}

function NPC_Character(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = obj_neutral_npc,new_grid = "",new_move_speed,new_size = npc_size.medium,new_target_objects = [],new_attack_range = 10)
: Character_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_move_speed,new_size = npc_size.medium) constructor{
	target_objects = new_target_objects
	attack_range = new_attack_range
	equipment = ""
	single_direction = false;
}

function NPC_Enemy(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = obj_enemy_npc,new_grid = "",new_move_speed,new_size = npc_size.medium,new_target_objects,new_attack_range = 10,new_enemy_type,new_enemy_traits = [enemy_trait.Standard])
: NPC_Character(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_move_speed,new_size = npc_size.medium,new_target_objects,new_attack_range) constructor{
	en_type = new_enemy_type
	enemy_traits = new_enemy_traits
	target_objects = new_target_objects;
	equipment = ""
	single_direction = false;
}

function NPC_Neutral(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = obj_enemy_npc,new_grid = "",new_move_speed,new_size = npc_size.medium,new_target_objects,new_attack_range = 10)
: NPC_Character(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_move_speed,new_size = npc_size.medium,new_target_objects,new_attack_range) constructor{
	target_objects = new_target_objects;
	equipment = ""
	single_direction = false;
}

function Item_Food(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_food_item,new_grid = "",new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"])
: Item_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_item_type,new_item_sprite,new_item_icon) constructor {
	value = new_value;
	flavors = new_flavors;
}

function Food_Ingredient(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = obj_ingredient_food,new_grid = "",new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"],is_raw = false,new_cost = 1)
: Item_Food(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_item_type,new_item_sprite,new_item_icon,new_value,new_flavors) constructor {
	raw = is_raw
	cost = new_cost
}

function Food_Meal(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = obj_meal_food,new_grid = "",new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"],is_raw = false,new_cost = 1)
: Item_Food(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_item_type,new_item_sprite,new_item_icon,new_value,new_flavors) constructor {
	raw = is_raw
	cost = new_cost
}

function Item_Equipment(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_equipment_item,new_grid = "",new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"])
: Item_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_item_type,new_item_sprite,new_item_icon) constructor {
	value = new_value;
	flavors = new_flavors;
}

function Item_Tool(new_name,new_type,new_health = 1,new_invincible = false,new_object_reference = _obj_cookin_entity,new_grid = "",new_item_type = item_entity_type.Food,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_value = 1,new_flavors = ["plain"])
: Item_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_item_type,new_item_sprite,new_item_icon) constructor {
	value = new_value;
	flavors = new_flavors;
}

function Defense_Structure(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid = "",new_grid_x,new_grid_y,new_inventory = [],new_limit,new_target_objects)
: Structure_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_grid_x,new_grid_y,new_inventory,new_limit) constructor{
	target_objects = new_target_objects;
}

function Kitchen_Structure(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid = "",new_grid_x,new_grid_y,new_inventory = [],new_limit)
: Structure_Entity(new_name,new_type,new_health,new_invincible,new_object_reference,new_grid,new_grid_x,new_grid_y,new_inventory,new_limit) constructor{
	
	
}