enum item_entity_type{
	Equipment	= 50,
	Food		= 60,
	Tool		= 70
}

function Item_Entity(new_name,new_item_type,new_item_info) constructor{
	name = new_name;
	item_type = new_item_type
	item_info = new_item_info
	item_sprite = spr_item_placeholder
}

