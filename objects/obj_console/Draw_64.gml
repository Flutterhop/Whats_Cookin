
draw_set_alpha(box_alpha)
draw_rectangle_colour(bbox_left,bbox_top,bbox_right,bbox_bottom,c_black,c_black,c_black,c_black,false);
draw_set_alpha(1);
draw_self();
if(not_null(scribble_object)){
	list_size = ds_list_size(event_list);
	for(var i = 0;i < list_size;i++){
		var event = ds_list_find_value(event_list,i);
		var is_event = is_instanceof(event,Event);
		if(not_null(event)){	
			scribble_object = scribble(event.event_message);
			var height = string_height_scribble(event.event_message);
			scribble_object.scale(text_scale);
			scribble_object.wrap(sprite_width,sprite_height,false);
			scribble_object.padding(10,10,0,0);
			scribble_object.starting_format("main",event.get_message_color());
			scribble_object.draw(bbox_left,bbox_top + ( height * (i)));
		}
	}
	
}
