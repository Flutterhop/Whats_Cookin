event_inherited();
draw_self();
try{
	switch(direction_facing){
		case "up":
			image_xscale = enemy_scale;
			image_yscale = enemy_scale;
		break;
		case "down":
			image_xscale = enemy_scale;
			image_yscale = enemy_scale;
		break;
		case "left":
			image_xscale = enemy_scale;
			image_yscale = enemy_scale;
		break;
		case "right":
			image_xscale = -enemy_scale;
			image_yscale = enemy_scale;
		break;
	}

	if(global.debug && global.debug_setting == debug_type.enemy_debug){
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_font(fnt_normal);

		draw_text(x - 15, y,string_concat("state: ",enemy_state));
		if(not_null(target_player)){
			draw_text(x - 15, y + 20,string_concat("target_player: ",target_player.player_number));
		}
		draw_text(x - 15, y + 40,string_concat("direction: ",direction_facing));
		draw_text(x - 15, y + 60,string_concat("depth: ",depth));
	
		var w = 64; // width of detection zone
	    var h = 32; // height of detection zone

	    draw_set_alpha(0.3);

	    // Top rectangle (blue)
	    draw_set_color(c_blue);
	    draw_rectangle(x - w/2, y - h, x + w/2, y, false);

	    // Bottom rectangle (red)
	    draw_set_color(c_red);
	    draw_rectangle(x - w/2, y, x + w/2, y + h, false);

	    // Reset
	    draw_set_alpha(1);
	    draw_set_color(c_white);
	}
}catch(_exception){
		show_debug_message(_exception.message);
	    show_debug_message(_exception.longMessage);
	    show_debug_message(_exception.script);
	    show_debug_message(_exception.stacktrace);
}

