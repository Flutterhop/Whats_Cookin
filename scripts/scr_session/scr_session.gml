
global.item_entities		= ds_map_create(); #macro TOTAL_ITEM_ENTITIES 1
global.structure_entities	= ds_map_create(); #macro TOTAL_STRUCTURE_ENTITIES 1
global.character_stats		= ds_map_create(); #macro TOTAL_CHARACTER_STATS 1
global.character_entities	= ds_map_create(); #macro TOTAL_CHARACTER_ENTITIES 1
global.environment_entities = ds_map_create(); #macro TOTAL_ENVIRONMENT_ENTITIES 1

function set_camera_follow(target){
	if(not_null(target)){
		cam = view_get_camera(view_current);
		cam_target = target;
	}
}

function initialize_item_entities(){
	ds_map_clear(global.item_entities);
	var entity
	///INGREDIENTS
	entity = new Food_Ingredient("apple",
									obj_apple,
									grid,
									true,
									false,
									spr_item_apple,
									spr_item_apple,
									2, 
									5,
									[Flavor.Sweet],
									true
											);
	ds_map_add(global.item_entities,entity.name,entity);
	entity = new Food_Ingredient("chicken",
									obj_chicken,
									grid,
									true,
									false,
									spr_item_rawchicken,
									spr_item_rawchicken,
									20,
									50,
									[Flavor.Salty],
									true
											);
	ds_map_add(global.item_entities,entity.name,entity);

}

function initialize_character_stats(){
	ds_map_clear(global.character_stats);
	var stats
	///STATS
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
	ds_map_add(global.character_stats,stats.name,stats);
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
							"hunter",
							60
							);
	ds_map_add(global.character_stats,stats.name,stats);
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
	ds_map_add(global.character_stats,stats.name,stats);
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
	ds_map_add(global.character_stats,stats.name,stats);
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
	ds_map_add(global.character_stats,stats.name,stats);
	
}

function initialize_character_entities(){
	ds_map_clear(global.character_entities);
	var entity
	///CHARACTERS
	entity = new NPC_Enemy("hunter",
							obj_npc_hunter,
							grid,
							true,
							false,
							retrieve_stats("hunter"),
							[obj_player]
							);
	ds_map_add(global.character_entities,entity.name,entity);
	entity = new NPC_Neutral("inspector",
							obj_npc_inspector,
							grid,
							true,
							false,
							retrieve_stats("inspector"),
							[]
							);
	ds_map_add(global.character_entities,entity.name,entity);
	entity = new NPC_Neutral("squeebie",
							obj_npc_squeebie,
							grid,
							true,
							retrieve_stats("squeebie"),
							[]
							);
	ds_map_add(global.character_entities,entity.name,entity);
}


function initialize_structure_entities(){
	ds_map_clear(global.structure_entities);
	var entity
	///Structures
	entity = new Kitchen_Structure("counter",
									obj_str_counter,
									grid,
									true,
									false,
									0,
									0,
									[],
									1
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Kitchen_Structure("cuttingboard",
									obj_str_cuttingboard, 
									grid,
									true,
									false,
									0,
									0,
									[],
									1
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Kitchen_Structure("storage",
									obj_str_ingredient_storage,
									grid,
									true,
									false,
									0,
									0,
									[],
									20
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Defense_Structure("turret",
									obj_str_turret,
									grid,
									true,
									false,
									0,
									0,
									[],
									0,
									[obj_enemy_npc]
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);

}

function retrieve_entity(entity_key,target_map){
	var key = string_lower(entity_key)
	var result = ds_map_find_value(target_map,key);
	if(is_struct(result)){
		var return_struct = variable_clone(result);
		return return_struct;
	}
}

function retrieve_stats(entity_key){
	var key = string_lower(entity_key)
	var result = ds_map_find_value(global.character_stats,key);
	if(is_struct(result)){
		var return_struct = variable_clone(result);
		return return_struct;
	}
}