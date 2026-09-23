global.sprite_up = ["bangs",	//	14
					"eyes",		//	13
					"face",		//	12
					"head",		//	11
					"hair",		//	10
					"sleeves",	//	9
					"arms",		//	8
					"feet",		//	7
					"bottom",	//	6
					"legs",		//	5
					"top",		//	4
					"torso",	//	3
					"shadow",	//	2
					"outline",	//	1
					"items"		//	0
]

global.sprite_default = ["items",	//	14
						"sleeves",	//	13
						"arms",		//	12
						"bangs",	//	11
						"eyes",		//	10
						"face",		//	9
						"head",		//	8
						"hair",		//	7
						"feet",		//	6
						"bottom",	//	5
						"legs",		//	4
						"top",		//	3
						"torso",	//	2
						"shadow",	//	1
						"outline"	//	0
]

function Character_Builder(new_name,new_object_reference = "",new_grid = "",has_sm = false,new_character = "")  : System_Entity(new_name,new_object_reference,new_grid,has_sm) constructor {
	character 				= new_character;
	left_character_sprite 	= "";
	down_character_sprite 	= "";
	up_character_sprite 	= "";
	
	static set_action = function(new_action){
		if(left_character_sprite.action != new_action or
			down_character_sprite.action != new_action or
			up_character_sprite.action != new_action){
			
			left_character_sprite.action = new_action;
			down_character_sprite.action = new_action;
			up_character_sprite.action = new_action;
			left_character_sprite.set_character_sprites();
			down_character_sprite.set_character_sprites();
			up_character_sprite.set_character_sprites();
		}
	}
	
	static add_item = function(item_sprite){
		left_character_sprite.assign_item(item_sprite);
		down_character_sprite.assign_item(item_sprite);
		up_character_sprite.assign_item(item_sprite);
	}
	
	static remove_item = function(){
		left_character_sprite.remove_item();
		down_character_sprite.remove_item();
		up_character_sprite.remove_item();
	}
	
	static init_sprites = function(){
		left_character_sprite= new Character_Sprite(self,"idle","left")
		down_character_sprite= new Character_Sprite(self,"idle","down")
		up_character_sprite= new Character_Sprite(self,"idle","up")
		up_character_sprite.assign_order_up_sprite()
	}
	init_sprites();
}

function Character_Sprite(new_builder,new_action,_direction) constructor {
	builder 			= new_builder;
	direction_facing 	= _direction;
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
	
	static assign_item = function(item_sprite){
		if(is_array(item_sprite)){
			var item_count = array_length(item_sprite);
			if(item_count > 1){
				items.multiple_sprites = true;
			}else{
				items.multiple_sprites = false;
			}
		}
		items.sprite = item_sprite;
	}
	static remove_item = function(){
		if(is_array(items.sprite)){
			var item_count = array_length(items.sprite);
			if(item_count > 1){
				items.multiple_sprites = true;
			}else{
				items.multiple_sprites = false;
			}
		}
		items.sprite = "";
	}
	
	static assign_order_up_sprite = function(){
		items.order = 0;outline.order = 1;shadow.order = 2;torso.order = 3;top.order = 4;legs.order = 5;bottom.order = 6;feet.order = 7; hair.order = 8; head.order = 9; face.order = 10; eyes.order = 11; bangs.order = 12; arms.order = 13; sleeves.order = 14;
		draw_sprites[items.order] 	= items;
		draw_sprites[outline.order] = outline;
		draw_sprites[shadow.order] 	= shadow;
		draw_sprites[torso.order] 	= torso;
		draw_sprites[top.order] 	= top;
		draw_sprites[legs.order] 	= legs;
		draw_sprites[bottom.order] 	= bottom;
		draw_sprites[feet.order] 	= feet;
		draw_sprites[hair.order] 	= hair;
		draw_sprites[head.order] 	= head;
		draw_sprites[face.order] 	= face;
		draw_sprites[eyes.order] 	= eyes;
		draw_sprites[bangs.order] 	= bangs;
		draw_sprites[arms.order] 	= arms;
		draw_sprites[sleeves.order] = sleeves;
	}
	
	static assign_order_standard = function(){
		outline.order = 0;shadow.order = 1;torso.order = 2;top.order = 3;legs.order = 4;bottom.order = 5;feet.order = 6; hair.order = 7; head.order = 8; face.order = 9; eyes.order = 10; bangs.order = 11; arms.order = 12; sleeves.order = 13;items.order = 14;
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
	multiple_sprites	= false;
	
	static set_sprite = function(){
		if(multiple_sprites){
			return;
		}
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