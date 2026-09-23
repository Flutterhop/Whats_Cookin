enum Item_Game_type{
	Equipment	= 41,
	Food		= 42,
	Tool		= 43
}
enum place_allowed{
	fryingpan = 101,
	pot = 102,
	blender = 103,
	bowl = 104,
	counter = 105,
	oven = 106,
	stove = 107
}
global.place_allowed = ds_map_create()
ds_map_add(global.place_allowed,place_allowed.fryingpan,"fryingpan");
ds_map_add(global.place_allowed,place_allowed.pot,"pot");
ds_map_add(global.place_allowed,place_allowed.blender,"blender");
ds_map_add(global.place_allowed,place_allowed.bowl,"bowl");
ds_map_add(global.place_allowed,place_allowed.counter,"counter");
ds_map_add(global.place_allowed,place_allowed.oven,"oven");
ds_map_add(global.place_allowed,place_allowed.stove,"stove");

function Item_Stats(new_name,new_cost,new_allowed_place)
: Game_Stats() constructor {
	name = new_name;
	cost = new_cost;
	allowed_place = new_allowed_place;
}

function Food_Stats(new_name,new_cost,new_allowed_place,new_value,new_flavors)
 : Item_Stats(new_name,new_cost,new_allowed_place)constructor {
	flavors = new_flavors;
	
}

function Ingredient_Stats(new_name,new_cost,new_allowed_place,new_value,new_flavors,new_process_speed,new_process_types,new_processed_version)
 : Food_Stats(new_name,new_cost,new_allowed_place,new_value,new_flavors)constructor {
	process_speed = new_process_speed;
	item_process_types = new_process_types;
	processed_version = new_processed_version;

}

function Meal_Stats(new_name,new_cost,new_allowed_place,new_value,new_flavors)
 : Food_Stats(new_name,new_cost,new_allowed_place,new_value,new_flavors)constructor {

	
}

function Equipment_Stats(new_name,new_cost,new_allowed_place)
 : Item_Stats(new_name,new_cost,new_allowed_place) constructor {

}

function Tool_Stats(new_name,new_cost,new_allowed_place)
 : Item_Stats(new_name,new_cost,new_allowed_place) constructor {

}


