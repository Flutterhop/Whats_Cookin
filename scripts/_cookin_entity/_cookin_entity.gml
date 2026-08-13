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
////@description Main Entity constructor
////@param {string} new_name Entity Name
////@param {ref} new_object_reference Reference to object asset
////@param {real} new_grid Map Grid reference that all entities have.
////@param {bool} has_sm whether this entity has the optional State Machine.
function Cookin_Entity(new_name,new_object_reference = _obj_cookin_entity,new_grid,has_sm = true) constructor{
	name		= new_name;
	entity_id	= 0;
	object_reference = new_object_reference;
	instance	= "";
	state_machine = "";
	grid = new_grid;
	has_state_machine = has_sm;
	
	////@description spawns an entity at the provided x and y position on the included layer as a string.
	////@function spawn_entity
	////@param {real} x_pos x position as an integer
	////@param {real} y_pos y position as an integer
	////@param {string} new_layer Layer to spawn on as a string.
	static spawn_entity = function(x_pos,y_pos,new_layer){
		if(x_pos == 0 and y_pos == 0){
			x_pos = grid_x
			y_pos = grid_y
		}
		var new_struct = self
		var spawn_x_pos = (x_pos * grid.cell_width) + grid.cell_width / 2
		var spawn_y_pos = (y_pos * grid.cell_height) + grid.cell_height / 2
		x_coord = floor(x_coord)
		y_coord = floor(y_coord)
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		if(has_state_machine){
			call_later(30,time_source_units_frames,call_state_machine);
		}
	}
	
	////@description spawns an entity at the designated coordinates in the grid map, on the provided layer.
	////@function spawn_grid_entity
	////@param {real} x_coord x coordinate on the map grid as an integer
	////@param {real} y_coord y coordinate on the map grid as an integer
	////@param {string} new_layer Layer to spawn on as a string.
	static spawn_grid_entity = function(x_coord,y_coord,new_layer){
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
		if(has_state_machine){
			call_later(30,time_source_units_frames,call_state_machine);
		}
	}
	
	call_state_machine = function(){
		if(variable_instance_exists(instance,"init_state_machine")){
			instance.init_state_machine()
		}
		if(variable_instance_exists(instance,"set_custom_states")){
			instance.set_custom_states()
		}
	}
}

function System_Entity(new_name,new_object_reference,new_grid,has_sm) : Cookin_Entity(new_name,new_object_reference,new_grid,has_sm) constructor{
	
	
}

function Customer_System(new_name,new_object_reference,new_grid,has_sm) : System_Entity(new_name,new_object_reference,new_grid,has_sm) constructor{
	
	
}
////@description Contains the ds_grid for the game map. Creating a new Map_Grid will create a ds_grid automatically with the dimensions provided.
////@function Map_Grid
////@param {string} Name Grid Name
////@param {real} Width Width of grid as an integer.
////@param {real} Height Height of grid as an integer.
function Game_Entity(new_name,new_object_reference = _obj_cookin_entity,new_grid,has_sm = true,new_invincible = false)
: Cookin_Entity(new_name,new_object_reference,new_grid,has_sm) constructor {
	invincible		= new_invincible;
	iframes			= true;
	iframe_time		= 0;
	knockback_amount= 0;
	knockback_time	= 0;
	knockback_direction = 0;
	stun_amount		= 0;
	
	
	static take_damage = function(source,amount,iframe_amount = 10,_direction = 0,_knockback_amount = 0,_stun_amount = 0){
		var death_state = state_machine.GetStateName("dead");
		if(is_null(death_state)){
			EchoDebug("No death state found in machine. Entity will not be able to die.");
			
		}
		var is_dead = state_machine.IsInState("dead")
		
		//Determine if an entity can take damage.
		if(!iframes and !invincible and !is_dead){
			if(variable_instance_exists(self,"stats")){
				stats.current_hp -= amount;
				var event_message = string_concat(name," took ",amount," damage from ",source.struct.name, "!");
				global.event_handler.create_event(ev_type.combat,event_message,ev_priority.standard);
				if(stats.current_hp <= 0){
					die(source);
					return;
				}
				iframes = true;
				iframe_time = iframe_amount
				if(_knockback_amount > 0){
					knockback_amount = _knockback_amount;
					knockback_time = _knockback_amount;
					knockback_direction = _direction;
				}
				if(_stun_amount > 0){
					stun_amount = _stun_amount;
				}
				if(knockback_amount > 0 or stun_amount > 0){
					if(not_null(state_machine.GetStateName("stunned"))){
						state_machine.ChangeState("stunned")
					}
				}
			}else{
				EchoDebug("No Stats found.")
			}
		}
	}
	
	static heal = function(amount){
		var death_state = state_machine.GetStateName("dead");
		if(is_null(death_state)){
			EchoDebug("No death state found in machine. Entity will not be able to die.");
		}
		var is_dead = state_machine.IsInState("dead")
		//Determine if an entity can be healed
		if(!invincible and !is_dead){
			if(variable_instance_exists(self,"stats")){
				stats.current_hp += amount;
				if(stats.current_hp > stats.max_hp){
					stats.current_hp = stats.max_hp;
				}
				var event_message = string_concat(name," healed ",amount," points.");
				global.event_handler.create_event(ev_type.generic,event_message,ev_priority.standard);
			}
		}
	}
		
	static die = function(source){
		if(not_null(instance)){
			var death_message = string_concat(name," was killed by ",source.struct.name, "!");
			global.event_handler.create_event(ev_type.combat,death_message,ev_priority.high);
			state_machine.ChangeState("dead")
		}
	}
}

function Structure_Entity(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_grid_x,new_grid_y,new_inventory,new_limit,new_stats)
: Game_Entity(new_name,new_object_reference,new_grid,has_sm,new_invincible) constructor{
	grid_x = new_grid_x;
	grid_y = new_grid_y;
	inventory = new_inventory;
	limit = new_limit;
	stats = new_stats;
	
	init_structure = function(x_pos,y_pos,_layer,args = []){
		if(array_length(args) > 0){
			//Idk if this works
			instance = instance_create_layer(x_pos,y_pos,_layer,object_reference,args);
		}else{
			instance = instance_create_layer(x_pos,y_pos,_layer,object_reference);
		}
		instance.struct = self;
	}
	
	////@description spawns an entity at the provided x and y position on the included layer as a string.
	////@function spawn_entity
	////@param {real} x_pos x position as an integer
	////@param {real} y_pos y position as an integer
	////@param {string} new_layer Layer to spawn on as a string.
	static spawn_entity = function(x_pos,y_pos,new_layer){
		if(x_pos == 0 and y_pos == 0){
			x_pos = grid_x
			y_pos = grid_y
		}
		var new_struct = self
		var spawn_x_pos = (x_pos * grid.cell_width) + grid.cell_width / 2
		var spawn_y_pos = (y_pos * grid.cell_height) + grid.cell_height / 2
		x_pos = floor(x_pos)
		y_pos = floor(y_pos)
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		if(has_state_machine){
			call_later(30,time_source_units_frames,call_state_machine);
		}
	}
	
	////@description spawns an entity at the designated coordinates in the grid map, on the provided layer.
	////@function spawn_grid_entity
	////@param {real} x_coord x coordinate on the map grid as an integer
	////@param {real} y_coord y coordinate on the map grid as an integer
	////@param {string} new_layer Layer to spawn on as a string.
	static spawn_grid_entity = function(x_coord,y_coord,new_layer){
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

function Defense_Structure(new_name,new_object_reference,new_grid,has_sm = true,new_invincible,new_grid_x,new_grid_y,new_inventory,new_limit,new_target_objects)
: Structure_Entity(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_grid_x,new_grid_y,new_inventory,new_limit) constructor{
	target_objects = new_target_objects;
}

function Kitchen_Structure(new_name,new_object_reference,new_grid,has_sm = true,new_invincible,new_grid_x,new_grid_y,new_inventory,new_limit)
: Structure_Entity(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_grid_x,new_grid_y,new_inventory,new_limit) constructor{
	
	
}

/**
 * Function Description
 * @param {any*} new_name Description
 * @param {asset.gmobject} new_object_reference Description
 * @param {any*} new_grid Description
 * @param {bool} [has_sm] Description
 * @param {bool} new_invincible Description
 * @param {any*} new_stats Description
 */
function Character_Game(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_stats)
: Game_Entity(new_name,new_object_reference,new_grid,has_sm,new_invincible) constructor{
	
	////INSTANCE CONTEXT VARS
	stun_amount = 0;
	knockback_amount = 0;
    knockback_time = 0;
	knockback_direction = 0;
    friction_amount = .7;
	single_direction = false;
	equipment = "unarmed"
	stats = new_stats;
	
	////@description spawns an entity at the provided x and y position on the included layer as a string.
	////@function spawn_entity
	////@param {real} x_pos x position as an integer
	////@param {real} y_pos y position as an integer
	////@param {string} new_layer Layer to spawn on as a string.
	static spawn_entity = function(x_pos,y_pos,new_layer){
		//Find NPC in global map
		//var entity = ds_map_find_value(global.character_entities,name)
		if(x_pos == 0 and y_pos == 0){
			x_pos = grid_x
			y_coord = grid_y
		}
		var new_struct = self
		var x_position = (x_pos * grid.cell_width) + grid.cell_width / 2
		var y_position = (y_pos * grid.cell_height) + grid.cell_height / 2
		
		var new_struct = self
		instance = instance_create_layer(x_position,y_position,layer_to_spawn,object_reference,{struct : new_struct});
		call_later(30,time_source_units_frames,call_state_machine)
		instance.path = path_add();
		instance.struct = self;
	}
	////@description spawns an entity at the designated coordinates in the grid map, on the provided layer.
	////@function spawn_grid_entity
	////@param {real} x_coord x coordinate on the map grid as an integer
	////@param {real} y_coord y coordinate on the map grid as an integer
	////@param {string} new_layer Layer to spawn on as a string.
	static spawn_grid_entity = function(x_coord,y_coord,new_layer){
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
		instance = instance_create_layer(x_pos,y_pos,new_layer,object_reference,{struct : new_struct});
		call_later(30,time_source_units_frames,call_state_machine)
		instance.path = path_add();
		instance.struct = self;
	}

	static detect_target = function(_target){
		
	}
	
	static kill_npc = function(){
		instance_destroy(instance,true);
	}
	
	static get_damage = function(){
		if(not_null(stats)){
			if(is_instanceof(stats,Game_Stats)){
				var dmg = variable_struct_get(stats,"damage_amount")
				if(not_null(dmg)){
					return dmg;
				}
			}
		}
		EchoDebug("No damage value found. Returning 0.");
		return 0;
	}
	
	static get_stat = function(stat_to_find){
		var return_stat = ""
		if(not_null(stats)){
			if(is_instanceof(stats,Game_Stats)){
				return_stat = variable_struct_get(stats,stat_to_find)
				if(not_null(return_stat)){
					return return_stat;
				}
			}
		}
		EchoDebug(string_concat("Cannot find: ",stat_to_find," stat."));
		return "";
	}
}

function Player_Character(new_name,new_object_reference,new_grid = "",has_sm = true,new_invincible,new_stats,new_character_name = "char",new_player_number = 0)
: Character_Game(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_stats) constructor{
	
	character_name = new_character_name;
	player_number = new_player_number;
	input_allowed = true
	equipment = "unarmed"
	single_direction = false;
	target_objects = [obj_enemy_npc]
	
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
	
	static get_interaction_range = function(){
		if(not_null(stats)){
			if(is_instanceof(stats,Game_Stats)){
				var dmg = variable_struct_get(stats,"interaction_range")
				if(not_null(dmg)){
					return dmg;
				}
			}
		}
		EchoDebug("No damage value found. Returning 0.");
		return 0;
	}
}

function NPC_Character(new_name,new_object_reference = obj_neutral_npc,new_grid = "",has_sm = true,new_invincible,new_stats,new_target_objects = [])
: Character_Game(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_stats) constructor{
	target_objects = new_target_objects
	single_direction = false;
	////npc_path represents the variable which holds the path asset created in code when finding a path.
	////This should only contain a path object when the npc is instanced in a room.
	npc_path = ""; 
}

function NPC_Enemy(new_name,new_object_reference = obj_enemy_npc,new_grid,has_sm,new_invincible,new_stats,new_target_objects)
: NPC_Character(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_stats,new_target_objects) constructor{
	single_direction = false;
}

function NPC_Neutral(new_name,new_object_reference = obj_neutral_npc,new_grid = "",has_sm = true,new_invincible,new_stats,new_target_objects)
: NPC_Character(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_stats,new_target_objects) constructor{
	equipment = "";
	single_direction = false;
}

function Item_Game(new_name,new_object_reference,new_grid,has_sm = true,new_invincible,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_cost = 1)
: Game_Entity(new_name,new_object_reference,new_grid,has_sm,new_invincible) constructor {
	item_sprite	= new_item_sprite;
	item_icon	= new_item_icon;
	cost		= new_cost;
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

function Item_Food(new_name,new_object_reference = _obj_food_item,new_grid = "",has_sm = true,new_invincible,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_cost,new_value = 1,new_flavors = ["plain"])
: Item_Game(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_item_sprite,new_item_icon,new_cost) constructor {
	value = new_value;
	flavors = new_flavors;
}

function Food_Ingredient(new_name,new_object_reference = obj_ingredient_food,new_grid,has_sm = true = 1,new_invincible = false,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_cost = 1,new_value = 1,new_flavors = ["plain"],is_raw = false)
: Item_Food(new_name,new_object_reference,new_grid,has_sm = 1,new_invincible = false,new_item_sprite,new_item_icon,new_cost,new_value,new_flavors) constructor {
	raw = is_raw
	cost = new_cost
}

function Food_Meal(new_name,new_object_reference = obj_meal_food,new_grid,has_sm = true = 1,new_invincible = false,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_cost = 1,new_value = 1,new_flavors = ["plain"],is_raw = false)
: Item_Food(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_item_sprite,new_item_icon,new_cost,new_value,new_flavors) constructor {
	cost = new_cost
}

function Item_Equipment(new_name,new_object_reference = _obj_equipment_item,new_grid,has_sm = true,new_invincible,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_cost = 1,new_value = 1,new_flavors = ["plain"])
: Item_Game(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_item_sprite,new_item_icon,new_cost) constructor {
	value = new_value;
}

function Item_Tool(new_name,new_object_reference,new_grid,has_sm = true,new_invincible,new_item_sprite = spr_item_placeholder,new_item_icon = spr_item_placeholder,new_cost,new_value = 1)
: Item_Game(new_name,new_object_reference,new_grid,has_sm,new_invincible,new_item_sprite,new_item_icon,new_cost) constructor {
	value = new_value;
}

function Game_Stats() constructor {}