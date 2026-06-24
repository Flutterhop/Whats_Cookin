event_user(EV_INIT);
event_user(EV_METHOD_BINDING);

function pause_button_action(){

}

function bind_button_draw(){

	draw_text_ext_transformed_color(x - 75,y,button_text,10,500,text_size_mod,text_size_mod,0,c_white,c_white,c_white,c_white,1);
	if(typeof(bind_sprite) == "ref"){
		draw_sprite_ext(bind_sprite,0,x + 75,y + sprite_get_height(bind_sprite) / 4,icon_size_mod,icon_size_mod,0,c_white,1);
	
	}else{
		draw_text_ext_transformed_color(x + 75,y,bind_sprite,10,500,text_size_mod,text_size_mod,0,c_white,c_white,c_white,c_white,1);
	}

}