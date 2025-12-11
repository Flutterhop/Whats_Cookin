if(global.debug){
	draw_set_font(fnt_Retro_small);
	draw_set_valign(fa_top);
	draw_set_halign(fa_center);
	draw_text_ext_transformed_color(get_screen_center_x(), get_screen_center_y() + 100,"Debug mode: " + string(global.debug_setting),200,200,.6,.6,0,c_white,c_white,c_white,c_white,1);
	draw_text_ext_transformed_color(get_screen_center_x(), get_screen_center_y() + 120,"Home - Disable Debug ",200,200,.6,.6,0,c_white,c_white,c_white,c_white,1);	
	
	if(global.debug_setting == debug_type.player_debug){
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 1,"F1 - Toggle Debug Mode",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 2,"F2 - Toggle Iframes",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 3,"F3 - Toggle Sandbox",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 4,"F4 - Give Credits",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 5,"F5 - Give Health",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 6,"F6 - ",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 7,"F7 - Go to rm_end",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);

	}
	
	if(global.debug_setting == debug_type.enemy_debug){
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 1,"F1 - Toggle Debug Mode",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 2,"F2 - Selection Back",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 3,"F3 - Selection Forward",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 4,"F4 - Spawn Enemy",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
		draw_text_ext_transformed_color(get_screen_center_x() * 1.8,20 * 5,"F5 - Hide/Show Menu",20,150,.5,.5,0,c_white,c_white,c_white,c_white,1);
	}
}