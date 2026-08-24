enum Item_Game_type{
	Equipment	= 41,
	Food		= 42,
	Tool		= 43
}


function Item_Stats(new_name,new_cost)	:Game_Stats() constructor {
	name = new_name;
	cost = new_cost;
}

function Food_Stats(new_name,new_cost,new_value,new_flavors)
 : Item_Stats(new_name,new_cost)constructor {
	flavors = new_flavors;
	
}

function Ingredient_Stats(new_name,new_cost,new_value,new_flavors,new_process_speed,new_process_types,new_processed_version)
 : Food_Stats(new_name,new_cost,new_value,new_flavors)constructor {
	process_speed = new_process_speed;
	item_process_types = new_process_types;
	processed_version = new_processed_version;

}

function Meal_Stats(new_name,new_cost,new_value,new_flavors)
 : Food_Stats(new_name,new_cost,new_value,new_flavors)constructor {

	
}

function Equipment_Stats(new_name,new_cost)
 : Item_Stats(new_name,new_cost) constructor {

}

function Tool_Stats(new_name,new_cost)
 : Item_Stats(new_name,new_cost) constructor {

}
