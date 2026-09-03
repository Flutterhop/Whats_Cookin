
function build_character_map(){
	
	//Create all maps and add them to the main character map.
	ds_map_clear(character_map);
	var sleeves_map = ds_map_create();
	var arms_map = ds_map_create();
	var bangs_map = ds_map_create();
	var eyes_map = ds_map_create();
	var face_map = ds_map_create();
	var head_map = ds_map_create();
	var hair_map = ds_map_create();
	var feet_map = ds_map_create();
	var bottom_map = ds_map_create();
	var legs_map = ds_map_create();
	var top_map = ds_map_create();
	var torso_map = ds_map_create();
	var shadow_map = ds_map_create();
	var outline_map = ds_map_create();
	ds_map_add_map(character_map,"sleeves",sleeves_map)
	ds_map_add_map(character_map,"arms",arms_map)
	ds_map_add_map(character_map,"bangs",bangs_map)
	ds_map_add_map(character_map,"eyes",eyes_map)
	ds_map_add_map(character_map,"face",face_map)
	ds_map_add_map(character_map,"head",head_map)
	ds_map_add_map(character_map,"hair",hair_map)
	ds_map_add_map(character_map,"feet",feet_map)
	ds_map_add_map(character_map,"bottom",bottom_map)
	ds_map_add_map(character_map,"legs",legs_map)
	ds_map_add_map(character_map,"top",top_map)
	ds_map_add_map(character_map,"torso",torso_map)
	ds_map_add_map(character_map,"shadow",shadow_map)
	ds_map_add_map(character_map,"outline",outline_map)
	
	var sleeve_assets = tag_get_asset_ids("part_sleeves",asset_sprite);
	add_asset_array_to_map(sleeves_map,sleeve_assets);
	var arm_assets = tag_get_asset_ids("part_arms",asset_sprite);
	add_asset_array_to_map(arms_map,arm_assets);
	var bang_assets = tag_get_asset_ids("part_bangs",asset_sprite);
	add_asset_array_to_map(bangs_map,bang_assets);
	var eye_assets = tag_get_asset_ids("part_eyes",asset_sprite);
	add_asset_array_to_map(eyes_map,eye_assets);
	var face_assets = tag_get_asset_ids("part_face",asset_sprite);
	add_asset_array_to_map(face_map,face_assets);
	var head_assets = tag_get_asset_ids("part_head",asset_sprite);
	add_asset_array_to_map(head_map,head_assets);
	var hair_assets = tag_get_asset_ids("part_hair",asset_sprite);
	add_asset_array_to_map(hair_map,hair_assets);
	var feet_assets = tag_get_asset_ids("part_feet",asset_sprite);
	add_asset_array_to_map(feet_map,feet_assets);
	var bottom_assets = tag_get_asset_ids("part_bottom",asset_sprite);
	add_asset_array_to_map(bottom_map,bottom_assets);
	var legs_assets = tag_get_asset_ids("part_legs",asset_sprite);
	add_asset_array_to_map(legs_map,legs_assets);
	var top_assets = tag_get_asset_ids("part_top",asset_sprite);
	add_asset_array_to_map(top_map,top_assets);
	var torso_assets = tag_get_asset_ids("part_torso",asset_sprite);
	add_asset_array_to_map(torso_map,torso_assets);	
	var shadow_assets = tag_get_asset_ids("part_shadow",asset_sprite);
	add_asset_array_to_map(shadow_map,shadow_assets);	
	var outline_assets = tag_get_asset_ids("part_outline",asset_sprite);
	add_asset_array_to_map(outline_map,outline_assets);
	save_map(character_map)
	
}

function save_character_map(target_map){
	character_buffer = buffer_create(1024,buffer_grow,1);
	ds_map_secure_save_buffer(target_map,character_buffer);
	compressed_buffer = buffer_compress(character_buffer,0,buffer_tell(character_buffer))
	ds_map_destroy(target_map);
	buffer_delete(character_buffer);
	
}

function load_character_map(target_map,load_buffer){
	character_buffer = buffer_decompress(load_buffer);
	target_map = ds_map_secure_load_buffer(character_buffer);
	buffer_delete(character_buffer);
	buffer_delete(load_buffer);
	return target_map
	
}

function init_character_builder(){
	character_map = load_map(character_map,compressed_buffer)
	ready_for_input = true;
	struct.state_machine.ChangeState("characterbuilder");
}

function end_character_builder(){
	ready_for_input = false;
	struct.state_machine.ChangeState("inactive");
	save_map(character_map);
}

function add_asset_array_to_map(target_map,asset_array){
	var asset_number = array_length(asset_array)
	if(asset_number > 0){
		for(var i = 0; i < asset_number;i++){
			var new_asset = asset_array[i];
			if(not_null(new_asset)){
				var asset_name = sprite_get_name(new_asset);
				var asset_strings = string_split(asset_name,"_",true);
				var action = asset_strings[2];
				var _direction = asset_strings[3];
				var asset_key = string_concat(action,"_",_direction,"_",i + 1);
				ds_map_add(target_map,asset_key,new_asset)
			}
		}
	}
}

function fetch_character_part(target_part,target_index,action,_direction){
	var return_part = "";
	var target_map = ds_map_find_value(character_map,target_part)
	if(not_null(target_map)){
		var asset_key = string_concat(action,"_",_direction,"_",target_index);
		return_part = ds_map_find(target_map,asset_key);
		if(typeof(return_part) == asset_sprite){
			return return_part;
		}
	}
}

function get_next_character_part(target_part,current_index,action,_direction){
	var return_part = "";
	var target_map = ds_map_find_value(character_map,target_part)
	if(not_null(target_map)){
		var number_of_parts = ds_map_size(target_map);
		number_of_parts = number_of_parts / 3;
		var next_index = current_index + 1;
		if(next_index > number_of_parts){
			current_index = 0;
		}
		return_part = fetch_part(target_part,current_index,action,_direction);
	}
	return return_part;
}

function get_previous_character_part(target_part,current_index,action,_direction){
	var return_part = "";
	var target_map = ds_map_find_value(character_map,target_part)
	if(not_null(target_map)){
		var number_of_parts = ds_map_size(target_map);
		number_of_parts = number_of_parts / 3;
		var next_index = current_index - 1;
		if(next_index < 0){
			current_index = number_of_parts;
		}
		return_part = fetch_part(target_part,current_index,action,_direction);
	}
	return return_part;
	
}