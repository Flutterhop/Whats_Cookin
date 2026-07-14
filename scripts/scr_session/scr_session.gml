
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
	entity = new Food_Ingredient(false,5,10,[Flavor.Sweet],item_entity_type.Food,
											"Apple",
											entity_type.EN_Item,
											""
											);
	ds_map_add(global.item_entities,entity.name,entity);
	entity = new Food_Ingredient(true,30,100,[Flavor.Salty],item_entity_type.Food,
											"Chicken",
											entity_type.EN_Item,
											""
											);
	ds_map_add(global.item_entities,entity.name,entity);

}

function initialize_character_entities(){
	ds_map_clear(global.character_entities);
	var entity
	///INGREDIENTS
	entity = new Enemy_Entity(enemy_type.generic,
							[enemy_trait.Standard],
							npc_size.medium,
							"",
							5,
							"Bee",
							Character_Type.CH_ENEMY_NPC,
							1,
							false,
							""
							);
	ds_map_add(global.character_entities,entity.name,entity);

}

function initialize_structure_entities(){
	ds_map_clear(global.structure_entities);
	var entity
	///INGREDIENTS
	entity = new Kitchen_Structure("Counter",
									structure_type.Kitchen,
									25,
									false,
									obj_str_counter,
									0,
									0,
									[],
									1
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);
	entity = new Defense_Structure("Turret",
									structure_type.Defense,
									10,
									false,
									obj_str_turret,
									0,
									0
											);
	ds_map_add(global.structure_entities,string_lower(entity.name),entity);

}

function retrieve_entity(entity_key,target_map){
	var result = ds_map_find_value(target_map,entity_key);
	if(is_struct(result)){
		return result;
	}
}