enum Tool_Type{
	Default = 47
}

function item_handle_inventory(){
	if(variable_instance_exists(struct,"inventory")){
		var inventory_size = array_length(struct.inventory);
		if(inventory_size > 0){
			for(var i = 0; i < inventory_size;i++){
				var inventory_item = struct.inventory[i];
				if(is_instanceof(inventory_item.struct,Item_Game)){
					var instance = inventory_item;
					instance.x = x;
					instance.y = y;
				}
			}
		}
	}
	
}