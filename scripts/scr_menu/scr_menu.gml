enum Menu_Item_Type{
	Image,
	Text,
	Text_Button,
	Expand_Button,
	Image_Button,
	Textbox,
	Dropdown
}

enum Menu_Orientation{
	Horizontal_List,
	Vertical_List,
	Grid
	
}


function Menu_Element(new_name,new_orientation) constructor{
	name = new_name;
	menu_orientation = new_orientation;
	switch(menu_orientation){
		case Menu_Orientation.Grid:
				menu_orientation = ds_grid_create(0,0);
			break;
		case Menu_Orientation.Horizontal_List:
			break;
		case Menu_Orientation.Vertical_List:
			break;
	}
	menu_items = "";
	x_origin = 0;
	y_origin = 0;
	
}

function Menu_Item(new_name) constructor{
	name = new_name;
	active = false;
	selectable = true;
	display_text = "";
	subtext = "";
	item_sprite = spr_item_placeholder;
	x_pos = 0;
	y_pos = 0;
	action_method = [];
	action_args = "";
	
	static call_action = function(){
		if(not_null(action_method)){
			if(array_length(action_args) > 0){
				action_method[0](action_args);
				return true;
			}else{
				action_method[0]();
				return true;
			}
		}
	}
}