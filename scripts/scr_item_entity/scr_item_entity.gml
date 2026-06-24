enum item_entity_type{
	Equipment	= 41,
	Food		= 42,
	Tool		= 43
}

function Item_Entity(new_item_type,new_name,new_type,new_instance) : Cookin_Entity(new_name,new_type,new_instance) constructor {
	item_type	= new_item_type;
	item_sprite = spr_item_placeholder;
	item_icon	= spr_item_placeholder;
	held		= false;
	
	static pick_up = function(){
		if(!held){
			held = true;
		}else{
			if(global.debug){
				show_debug_message("Item already held, cannot pick up.")
			}
		}	
	};
	static drop = function(){
		if(held){
			held = false;
		}else{
			if(global.debug){
				show_debug_message("Item not held, something must have gone wrong.")
			}
		}	
	};
	static set_item_sprite = function(new_sprite){
		item_sprite = new_sprite;
	}
	static set_item_icon = function(new_icon){
		item_icon = new_icon;
	}
	
}

function initialize_item(){
	
}