if(!ready_signal_received && ready()){
	draw_text_scribble(get_screen_center_x(),get_screen_center_y() - 50,"Press [input_icon,4,0] button to begin!");
}


if(timer < 1 || timer > 5){
	draw_sprite(spr_start_timer,0,get_screen_center_x(),get_screen_center_y() - 75);
}else{
	if!(alarm[0] <= 0){
		draw_sprite(spr_start_timer,timer,get_screen_center_x(),get_screen_center_y() - 75);
	}
}