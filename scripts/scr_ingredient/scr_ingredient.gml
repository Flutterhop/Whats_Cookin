

function Item_Ingredient(is_raw = true,new_cost,new_value,new_flavors,new_item_type,new_name,new_type,new_instance) : Item_Food(new_value,new_flavors,new_item_type,new_name,new_type,new_instance) constructor {
	raw = is_raw
	cost = new_cost
}