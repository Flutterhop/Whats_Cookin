if(is_struct(struct)){
	if(not_null(struct.item_sprite)){
		if(struct.held){
			
		}else{
			draw_sprite_ext(struct.item_sprite,0,x,y,1,1,0,c_white,1);
		}
	}
}else{
	draw_self()
}