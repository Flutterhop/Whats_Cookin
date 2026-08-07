
global.item_entities		= ds_map_create(); #macro TOTAL_ITEM_ENTITIES 1
global.structure_entities	= ds_map_create(); #macro TOTAL_STRUCTURE_ENTITIES 1
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
									entity_type.EN_Item,
									5,
									false,
									obj_apple,
									grid,
									item_entity_type.Food,
									spr_item_apple,
									spr_item_apple,
									5,
									[Flavor.Sweet],
									true,
									2
											);
	ds_map_add(global.item_entities,entity.name,entity);
	entity = new Food_Ingredient("chicken",
									entity_type.EN_Item,
									5,
									false,
									obj_chicken,
									grid,
									item_entity_type.Food,
									spr_item_rawchicken,
									spr_item_rawchicken,
									50,
									[Flavor.Salty],
									true,
									20
											);
	ds_map_add(global.item_entities,entity.name,entity);

}

function initialize_character_entities(){
	ds_map_clear(global.character_entities);
	var entity
	///INGREDIENTS
	entity = new NPC_Enemy("hunter",
							entity_type.EN_Character,
							10,
							false,
							obj_npc_hunter,
							grid,
							2,
							npc_size.medium,
							[obj_player],
							15,
							1,
							"chicken",
							Character_Type.CH_ENEMY_NPC,
							[enemy_trait.Standard,enemy_trait.Hunter]
							);
	ds_map_add(global.character_entities,entity.name,entity);
	entity = new NPC_Neutral("inspector",
							entity_type.EN_Character,
							25,
							false,
							obj_npc_inspector,
							grid,
							1,
							npc_size.medium,
							[],
							20
							);
	ds_map_add(global.character_entities,entity.name,entity);
	entity = new NPC_Neutral("squeebie",
							entity_type.EN_Character,
							1,
							true,
							obj_npc_squeebie,
							grid,
							1,
							npc_size.small,
							[],
							100
							);
	ds_map_add(global.character_entities,entity.name,entity);


}

function initialize_structure_entities(){
	ds_map_clear(global.structure_entities);
	var entity
	///Structures
	entity = new Kitchen_Structure("counter",
									entity_type.EN_Structure,
									25,
									false,
									obj_str_counter,
									grid,
									0,
									0,
									[],
									1
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Kitchen_Structure("cuttingboard",
									entity_type.EN_Structure,
									25,
									false,
									obj_str_cuttingboard,
									grid,
									0,
									0,
									[],
									1
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Kitchen_Structure("storage",
									entity_type.EN_Structure,
									25,
									false,
									obj_str_ingredient_storage,
									grid,
									0,
									0,
									[],
									20
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Defense_Structure("turret",
									entity_type.EN_Structure,
									10,
									false,
									obj_str_turret,
									grid,
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