
//Particle_system
global._ps = part_system_create();
part_system_draw_order(global._ps, true);


function effects_init_system(){

	
}

function effects_init_acid_particle(){

	
	
}

function effects_create_particle(_particle,x_pos,y_pos,number_of,part_layer = ""){
	try{
		var particle_to_use = ds_map_find_value(obj_particle_manager.part_map,_particle);
		if(is_null(part_layer)){
			if(not_null(particle_to_use)){
				part_particles_create(global._ps,x_pos,y_pos,particle_to_use,number_of);
			}
		}else{
			var _layer = layer_get_id(part_layer)
			var part_depth = part_system_depth(global._ps,layer_get_depth(_layer))
			if(not_null(particle_to_use)){
				part_particles_create(global._ps,x_pos,y_pos,particle_to_use,number_of);
			}
		}

	}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
	}
}