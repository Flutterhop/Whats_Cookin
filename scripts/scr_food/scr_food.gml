enum Food_Type{
	Ingredient = 45,
	Meal = 46
}
enum Flavor{
	Bitter,
	Salty,
	Sour,
	Spicy,
	Sweet,
	Umami
}

function Item_Food(new_value,new_flavors,new_item_type,new_name,new_type,new_instance) : Item_Entity(new_item_type,new_name,new_type,new_instance) constructor {
	value = new_value;
	flavors = new_flavors;
}