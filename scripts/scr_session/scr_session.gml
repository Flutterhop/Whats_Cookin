
global.item_entities		= ds_map_create(); #macro TOTAL_ITEM_ENTITIES 1
global.structure_entities	= ds_map_create(); #macro TOTAL_STRUCTURE_ENTITIES 1
global.character_entities	= ds_map_create(); #macro TOTAL_CHARACTER_ENTITIES 1
global.environment_entities = ds_map_create(); #macro TOTAL_ENVIRONMENT_ENTITIES 1

function initialize_item_entities(){
	ds_map_clear(global.item_entities);
	var entity
	///INGREDIENTS
	entity = new Item_Ingredient(false,5,10,[Flavor.Sweet],item_entity_type.Food,
											"Apple",
											entity_type.EN_Item,
											""
											);
	ds_map_add(global.item_entities,entity.name,entity);
	entity = new Item_Ingredient(true,30,100,[Flavor.Salty],item_entity_type.Food,
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
	entity = new Item_(false,5,10,[Flavor.Sweet],item_entity_type.Food,
											"Apple",
											entity_type.EN_Item,
											""
											);
	ds_map_add(global.structure_entities,entity.name,entity);
	entity = new Item_Ingredient(true,30,100,[Flavor.Salty],item_entity_type.Food,
											"Chicken",
											entity_type.EN_Item,
											""
											);
	ds_map_add(global.item_entities,entity.name,entity);

}