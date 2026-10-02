
function projectile_detect_collisions(rect_coords,targets = "",x_pos = 0,y_pos = 0){
	var collisions = ds_list_create();
	if(is_null(targets)){
		targets = struct.stats.collision_targets;
	}
	if(x_pos == 0){
		x_pos = x
	}
	if(y_pos == 0){
		y_pos = y
	}
	collision_rectangle_list(x_pos+rect_coords[0],
							y_pos+rect_coords[1],
							x_pos+rect_coords[2],
							y_pos+rect_coords[3],
							targets,
							true,
							true,
							collisions,
							true
							)
	var total_collisions = ds_list_size(collisions);
	if(total_collisions > 0){
		var collision_array = []
		for(var i = 0;i < total_collisions;i++){
			var list_item = ds_list_find_value(collisions,i);
			if(not_null(list_item)){
				array_push(collision_array,list_item);
			}
		}
		return collision_array;
	}else{
		return "";
	}
	
}

function get_projectile_collision_shape(){
	var range_mod = 6
	var top_left_x = 0
	var top_left_y = 0
	var bottom_right_x = 0
	var bottom_right_y = 0
	var x_increment = range_mod
	var y_increment = range_mod
	top_left_x -= x_increment * image_xscale;
	top_left_y -= y_increment * image_yscale;
	bottom_right_x += x_increment * image_xscale;
	bottom_right_y += y_increment * image_yscale;
	var return_coords = [top_left_x,top_left_y,bottom_right_x,bottom_right_y];
	return return_coords
}