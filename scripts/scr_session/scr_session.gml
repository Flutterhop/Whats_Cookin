
global.item_stats			= ds_map_create(); #macro TOTAL_ITEM_STATS 1
global.item_entities		= ds_map_create(); #macro TOTAL_ITEM_ENTITIES 1
global.structure_stats		= ds_map_create(); #macro TOTAL_STRUCTURE_STATS 1
global.structure_entities	= ds_map_create(); #macro TOTAL_STRUCTURE_ENTITIES 1
global.character_stats		= ds_map_create(); #macro TOTAL_CHARACTER_STATS 1
global.character_entities	= ds_map_create(); #macro TOTAL_CHARACTER_ENTITIES 1
global.system_entities		= ds_map_create(); #macro TOTAL_SYSTEM_ENTITIES 1
global.environment_entities = ds_map_create(); #macro TOTAL_ENVIRONMENT_ENTITIES 1

function set_camera_follow(target){
	if(not_null(target)){
		cam = view_get_camera(view_current);
		cam_target = target;
	}
}

function initialize_item_stats(){

	var entity
	var target_map = global.item_stats;
	ds_map_clear(target_map);
	//Apple
	entity = new Ingredient_Stats("apple",
									2,
									5,
									[Flavor.Sweet],
									1,
									[process_type.cut],
									process_type.unprocessed
	);
	ds_map_add(target_map,string_lower(entity.name),entity);
	///Chicken
	entity = new Ingredient_Stats("chicken",
									5,
									8, 
									[Flavor.Salty],
									1,
									[process_type.cut],
									process_type.unprocessed
	);
	ds_map_add(target_map,string_lower(entity.name),entity);
	///Plate
	entity = new Tool_Stats("plate", 
							5
	);
	ds_map_add(target_map,string_lower(entity.name),entity);
}

function initialize_item_entities(){

	var entity
	var target_stat_map = global.item_stats;
	var target_map = global.item_entities;
	ds_map_clear(target_map);
	///INGREDIENTS
	entity = new Food_Ingredient("apple",
									obj_ing_apple,
									grid,
									true,
									false,
									spr_item_apple,
									spr_item_apple,
									retrieve_stats("apple",target_stat_map)
											);
	ds_map_add(target_map,entity.name,entity);
	entity = new Food_Ingredient("chicken",
									obj_ing_chicken,
									grid,
									true,
									false,
									spr_item_chicken,
									spr_item_chicken,
									retrieve_stats("chicken",target_stat_map)
											);
	ds_map_add(target_map,entity.name,entity);
	entity = new Item_Tool("plate", 
							obj_tool_plate,
									grid,
									true,
									false,
									spr_tool_plate,
									spr_tool_plate,
									retrieve_stats("plate",target_stat_map)
											);
	ds_map_add(target_map,entity.name,entity);
	

}

function initialize_character_stats(){
	var stats
	var target_map = global.character_stats;
	ds_map_clear(target_map);
	stats = new Player_Stats("player",
							15,
							15,
							1,
							2,
							1,
							30,
							10,
							15
							);
	ds_map_add(target_map,stats.name,stats);
	stats = new Enemy_Stats("hunter",
							15,
							15,
							2,
							1,
							2,
							6,
							10,
							15,
							120,
							0,
							npc_size.medium,
							"chicken",
							60
							);
	ds_map_add(target_map,stats.name,stats);
	stats = new Enemy_Stats("rat",
							2,
							2,
							2.5,
							0,
							1,
							3,
							5,
							10,
							60,
							0,
							npc_size.small,
							"rat",
							60
							);
	ds_map_add(target_map,stats.name,stats);
	stats = new NPC_Stats("inspector",
							15,
							15,
							1,
							2,
							1,
							1,
							10,
							15,
							0,
							npc_size.medium,
							"inspector",
							60,
							60
							);
	ds_map_add(target_map,stats.name,stats);
	stats = new NPC_Stats("squeebie",
							10000,
							10000,
							1,
							1,
							1,
							1,
							5,
							15,
							60,
							10000,
							npc_size.small,
							"squeebie",
							60
							);
	ds_map_add(target_map,stats.name,stats);
	
}

function initialize_character_entities(){
	var entity
	var target_stat_map = global.character_stats;
	var target_map = global.character_entities;
	ds_map_clear(target_map);
	///CHARACTERS
	entity = new NPC_Enemy("hunter",
							obj_npc_hunter,
							grid,
							true,
							false,
							retrieve_stats("hunter",target_stat_map),
							[obj_player]
							);
	ds_map_add(target_map,entity.name,entity);
	entity = new NPC_Neutral("inspector",
							obj_npc_inspector,
							grid,
							true,
							false,
							retrieve_stats("inspector",target_stat_map),
							[]
							);
	ds_map_add(target_map,entity.name,entity);
	entity = new NPC_Neutral("squeebie",
							obj_npc_squeebie,
							grid,
							true,
							retrieve_stats("squeebie",target_stat_map),
							[]
							);
	ds_map_add(target_map,entity.name,entity);
}

function initialize_structure_stats(){
	var entity
	var target_stat_map = global.system_entities
	var target_map = global.structure_stats
	ds_map_clear(global.structure_stats);
	///Structures
	///Counter
	entity = new Kitchen_Structure_Stats("counter",
									25,
									25,
									false,
									"",
									1 
	);
	ds_map_add(target_map,string_lower(entity.name),entity);
	///Cutting board
	entity = new Kitchen_Structure_Stats("cuttingboard", 
											25,
											25,
											true,
											retrieve_entity("choppinggame",target_stat_map),
											1,
											process_type.cut
	);
	ds_map_add(target_map,string_lower(entity.name),entity);
	//Storage
	entity = new Kitchen_Structure_Stats("storage",
										25,
										25,
										true,
										"",
										0 
	);
	ds_map_add(target_map,string_lower(entity.name),entity);
	//Turret
	entity = new Defense_Structure_Stats("turret", 
										50,
										50,
										false,
										"",
										1,
										1,
										1,
										1
	);
	ds_map_add(target_map,string_lower(entity.name),entity);

}

function initialize_structure_entities(){
	var entity
	var target_stat_map = global.structure_stats
	var target_map = global.structure_entities
	ds_map_clear(target_map);
	///Structures
	entity = new Kitchen_Structure("counter",
									obj_str_counter,
									grid,
									true,
									false,
									0,
									0,
									[],
									1,
									retrieve_stats("counter",target_stat_map)
											);
	ds_map_add(target_map,string_lower(entity.name),entity);
	entity = new Kitchen_Structure("cuttingboard",
									obj_str_cuttingboard, 
									grid,
									true,
									false,
									0,
									0,
									[],
									1,
									retrieve_stats("cuttingboard",target_stat_map)
											);
	ds_map_add(target_map,string_lower(entity.name),entity);
	entity = new Kitchen_Structure("storage",
									obj_str_ingredient_storage,
									grid,
									true,
									false,
									0,
									0,
									[],
									20, 
									retrieve_stats("storage",target_stat_map)
											);
	ds_map_add(target_map,string_lower(entity.name),entity);
	entity = new Defense_Structure("turret",
									obj_str_turret,
									grid,
									true,
									false,
									0,
									0,
									[],
									0,
									retrieve_stats("turret",target_stat_map),
									[obj_enemy_npc]
											);
	ds_map_add(target_map,string_lower(entity.name),entity);

}

function initialize_system_entities(){
	var entity
	var target_map = global.system_entities
	ds_map_clear(target_map);
	entity = new Minigame_System("choppinggame",
									obj_mini_chopping,
									grid,
									true);
	ds_map_add(target_map,string_lower(entity.name),entity);
	
}

function retrieve_entity(entity_key,target_map){
	var key = string_lower(entity_key)
	var result = ds_map_find_value(target_map,key);
	if(is_struct(result)){
		var return_struct = variable_clone(result);
		return_struct.grid = global.grid
		return return_struct;
	}
}

function retrieve_stats(entity_key,target_map){
	var key = string_lower(entity_key)
	var result = ds_map_find_value(target_map,key);
	if(is_struct(result)){
		var return_struct = variable_clone(result);
		return return_struct;
	}

}

function retrieve_ingredient(entity_key,prc_type){
	
	
}