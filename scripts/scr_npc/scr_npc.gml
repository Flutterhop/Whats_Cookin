enum npc_size{
	small,
	medium,
	large,
	biiiiiiiiig
}


////Struct inheritance explanation found here:
////https://stackoverflow.com/questions/72987394/when-using-struct-inheritance-in-gml-how-do-you-make-a-call-to-the-parents-ver
///
////@description Main NPC struct. Facilitates taking damage, as well as creating instances. Data handling.
////@function NPC
function NPC_Entity(new_size = npc_size.medium,new_grid = "",new_move_speed, new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) : Character_Entity(new_move_speed, new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) constructor{

	size = new_size;
	
	////npc_path represents the variable which holds the path asset created in code when finding a path.
	////This should only contain a path object when the npc is instanced in a room.
	grid = new_grid;
	npc_path = ""; 
	
	static spawn_npc = function(x_pos,y_pos,layer_to_spawn){
		//Find NPC in global map
		var entity = ds_map_find_value(global.character_entities,name)
		var obj_reference
		if(not_null(entity)){
			var obj_name = string_concat("obj_","npc_",string_lower(name));
			obj_reference = asset_get_index(obj_name)
		}
		instance = instance_create_layer(x_pos,y_pos,layer_to_spawn,obj_reference);
		instance.path = path_add();
		instance.struct = self;
	}
	
	static detect_target = function(_target){
		
	}
	
	static kill_npc = function(){
		instance_destroy(instance,true);
	}

}
