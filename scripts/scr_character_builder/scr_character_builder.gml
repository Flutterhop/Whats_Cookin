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

function Character_Builder(new_name,new_object_reference,new_grid,has_sm)  : System_Entity(new_name,new_object_reference,new_grid,has_sm) constructor {
	
}

function Character_Sprite(new_builder,new_character,new_action,_direction) constructor {
	builder 			= new_builder
	character 			= new_character
	direction_facing 	= _direction
	action 				= new_action;
	items				= new Sprite_Part(self,"items",1,14);
	sleeves				= new Sprite_Part(self,"sleeves",1,13);
	arms				= new Sprite_Part(self,"arms",1,12);
	bangs				= new Sprite_Part(self,"bangs",1,11);
	eyes				= new Sprite_Part(self,"eyes",1,10);
	face				= new Sprite_Part(self,"face",1,9);
	head				= new Sprite_Part(self,"head",1,8);
	hair				= new Sprite_Part(self,"hair",1,7);
	feet				= new Sprite_Part(self,"feet",1,6);
	bottom				= new Sprite_Part(self,"bottom",1,5);
	legs				= new Sprite_Part(self,"legs",1,4);
	top					= new Sprite_Part(self,"top",1,3);
	torso				= new Sprite_Part(self,"torso",1,2);
	shadow				= new Sprite_Part(self,"shadow",1,1);
	outline				= new Sprite_Part(self,"outline",1,0);
	
	draw_sprites 		= [];
	
	static set_character_sprites = function(){
		//	Setting minus one to skip item sprite.
		var variables = variable_struct_get_names(self);
		var filtered_variables = get_sprite_variables();
		var sprite_count = array_length(filtered_variables);
		if(sprite_count > 0){
			for(var i = 0;i < sprite_count;i++){
				var part_val = variable_instance_get(self,filtered_variables[i]);
				part_val.set_sprite()
				draw_sprites[part_val.order] = part_val;
			}
		}
	}
	
	static get_sprite_variables = function(){
		function sprite_filter(element,index){
			var filter_this = element == "draw_sprites" or
			 					element == "character" or
								element == "direction_facing" or
								element == "items" or
								element == "builder" or
								element == "sprite_filter" or
								element == "action"
			return !filter_this;
		}
		var variables = variable_struct_get_names(self);
		var filtered_variables = array_filter(variables,sprite_filter);
		return filtered_variables;
	}
	
	static set_next_part = function(part_to_cycle,increment){
		var part_exists = variable_struct_exists(self,part_to_cycle);
		if(!part_exists){return;}
		var target_part = variable_struct_get(self,part_to_cycle);
		var next_index = target_part.index + increment;
		if(next_index <= 0){
			target_part.index = target_part.total_parts;
		}else if(next_index >= target_part.total_parts){
			target_part.index = 1;
		}else{
			target_part.index = next_index;
		}
		target_part.set_sprite()
		draw_sprites[target_part.order] = target_part;
	}
	
	set_character_sprites()
}

function Sprite_Part(new_character_sprite,new_part_name,new_index,new_order) constructor {
	character_sprite 	= new_character_sprite;
	part_name 			= new_part_name;
	order 				= new_order;
	index 				= new_index;
	sprite 				= ""
	total_parts			= array_length(tag_get_asset_ids(string_concat("part_",part_name),asset_sprite)) / 3;
	
	
	static set_sprite = function(){
		if(not_null(character_sprite) and is_instanceof(character_sprite,Character_Sprite)){
			var asset_string = string_concat("spr_",part_name,"_",character_sprite.action,"_",character_sprite.direction_facing,"_",index);
			var asset = asset_get_index(asset_string);
			if(not_null(asset)){
				sprite = asset;
			}else{
				EchoDebug(string_concat("Sprite_Part.set_sprite() failed. Sprite asset not found. String to call was: ",asset_string));
			}
		}
	}
}