global.sprite_up = ["bangs", 
					"eyes", 
					"face",  
					"head",  
					"hair",  
					"sleeves",  
					"arms",
					"feet",
					"bottom",
					"legs",
					"top",
					"torso",
					"shadow",
					"outline",
					"items"
]

global.sprite_default = ["items", 
						"sleeves", 
						"arms",  
						"bangs",  
						"eyes",  
						"face",  
						"head",
						"hair",
						"feet",
						"bottom",
						"legs",
						"top",
						"torso",
						"shadow",
						"outline"
]

function Character_Sprite(new_builder,new_character,new_action,_direction = "left") constructor {
	builder = new_builder
	character = new_character
	direction_facing = _direction
	action = new_action;
	items		="";
	sleeves		="";
	arms		="";
	bangs		="";
	eyes		="";
	face		="";
	head		="";
	hair		="";
	feet		="";
	bottom		="";
	legs		="";
	top			="";
	torso		="";
	shadow		="";
	outline		="";
	sprites 	= [outline,shadow,torso,top,legs,bottom,feet,hair,head,face,eyes,bangs,arms,sleeves,items];
		
	static assign_sprite_array = function(){
		var is_up = direction_facing = "up";
		if(is_up){
			sprites = [ 
				items,
				outline, 
				shadow,
				torso, 
				top,
				legs,
				bottom,
				feet, 
				arms,
				sleeves,
				hair,
				head,
				face,
				eyes,
				bangs
			];
		}else{
			sprites = [
				outline,
				shadow,
				torso,
				top,
				legs, 
				bottom,
				items, 
				feet,
				hair,
				head,
				face, 
				eyes, 
				bangs,   
				arms, 
				sleeves
			];
		}

	}
	
	static init_character_sprite = function(){
		//	Setting minus one to skip item sprite.
		var variables = variable_struct_get_names(self);
		var is_up = direction_facing = "up";

		var filtered_variables = get_sprite_variables();
		var sprite_count = array_length(filtered_variables);
		if(sprite_count > 0){
			for(var i = 0;i < sprite_count;i++){
				set_sprite(filtered_variables[i],1,action)
				if(is_up){
					var part_val = variable_instance_get(self,filtered_variables[i]);
					array_set(sprites,i,part_val);
				}else{
					var inst_var = global.sprite_default[i]
					var part_val = variable_instance_get(self,filtered_variables[i]);
					array_set(sprites,i,part_val);
				}
			}
			assign_sprite_array()
		}
	}
	
	static set_sprite = function(_part_name,target_sprite_index){
		//	Construct the part string to find the sprite asset.
		var direction_to_use = direction_facing
		if(direction_facing == "right"){
			direction_to_use = "left"
		}
		var asset_string = string_concat("spr_",_part_name,"_",action,"_",direction_to_use,"_",target_sprite_index)
		var asset = asset_get_index(asset_string);
		var part_exists = variable_struct_exists(self,_part_name);
		//	if asset is found and the part variable exists then we set the sprite on that var.
		if(not_null(asset) and part_exists){
			variable_struct_set(self,_part_name,asset);
		}
	}
	
	static get_sprite_variables = function(){
		function sprite_filter(element,index){
			var filter_this = element == "sprites" or
			 					element == "character" or 
								element == "direction_facing" or 
								element == "items" or 
								element == "builder" or 
								element == "sprite_filter"
			return !filter_this;
		}
		var variables = variable_struct_get_names(self);
		var filtered_variables = array_filter(variables,sprite_filter);
		return filtered_variables;
	}
	
	static set_next_part = function(part_to_cycle,increment){
		var part_exists = variable_struct_exists(self,part_to_cycle);
		var target_part = [];
		if(!part_exists){return;}
		var current_index = get_sprite_index(part_to_cycle);
		if(increment > 0){
			target_part = builder.get_next_part(part_to_cycle,current_index,action,direction_facing);
		}
		if(increment < 0){
			target_part = builder.get_previous_part(part_to_cycle,current_index,action,direction_facing);
		}
		if(asset_get_type(target_part) == asset_sprite){
			return target_part;
		}
	}
	static get_sprite_index = function(part){
		var part_string_array = string_split(part,"_",true)
		var index_string = part_string_array[array_length(part_string_array) - 1]
		var index = real(index_string)
		if(typeof(index) == "number"){
			return index;
		}
		return "";
	}
	
	
	init_character_sprite()
}