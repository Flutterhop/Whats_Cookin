if(is_struct(item_struct)){
	if(not_null(item_struct.item_sprite)){
		if(item_struct.held){
			
		}else{
			draw_sprite_ext(item_struct.item_sprite,0,x,y,1,1,0,c_white,1);
		}
	}
}else{
	draw_self()
}