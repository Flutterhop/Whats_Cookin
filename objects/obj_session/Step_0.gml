//if(InputPressed(INPUT_VERB.DEBUG)){
		//event_handler.console.toggle_console();
//}
//event_handler.console.print_console();

if(not_null(cam) and not_null(cam_target)){
	camera_set_view_pos(cam,cam_target.x - camera_get_view_width(cam) / 2,cam_target.y - camera_get_view_height(cam) / 2);
}