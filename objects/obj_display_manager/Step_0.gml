/// @description Zoom window
if(zoom != current_zoom)
{
  current_zoom = zoom;
  
	if(zoom>max_zoom){ 
		zoom=1;
	}
	if(zoom == max_zoom){
		window_set_size(ideal_width*zoom,ideal_height*zoom);
		window_set_fullscreen(true);
	}else{
		window_set_fullscreen(false);
		window_set_size(ideal_width*zoom,ideal_height*zoom);
		surface_resize(application_surface,ideal_width*zoom,ideal_height*zoom);
		alarm[0]=1;
	}
  
 
}

if(shake && global.game_state == active_game){
	shake_time -= 1;
	var _xval = choose(-shake_magnitude, shake_magnitude);
	var _yval = choose(-shake_magnitude,shake_magnitude);
	camera_set_view_pos(view_camera, _xval, _yval);
	
	if(shake_time <= 0){
		shake_magnitude -= shake_fade;
		if(shake_magnitude <= 0){
			camera_set_view_pos(view_camera,0,0);
			shake = false;
		}
	}
}


